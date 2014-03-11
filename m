From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Tue, 11 Mar 2014 09:18:08 +0100
Subject: [PATCH v3 2/5] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <20140310091707.GD14976@lee--X1>
References: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
 <1394203251-25361-3-git-send-email-maxime.coquelin@st.com>
 <20140310091707.GD14976@lee--X1>
Message-ID: <531EC6C0.4080202@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/10/2014 10:17 AM, Lee Jones wrote:
>> From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>>
>> This patch adds a new logic inside the st pinctrl to manage
>> an unsupported scenario: some sysconfig are not available!
>>
>> This is the case of STiH407 where, although documented, the
>> following registers from SYSCFG_FLASH have been removed from the SoC.
>>
>> SYSTEM_CONFIG3040
>>     Output Enable pad control for all PIO Alternate Functions
>> and
>> SYSTEM_ CONFIG3050
>>     Pull Up pad control for all PIO Alternate Functions
>>
>> Without managing this condition an imprecise external abort
>> will be detect.
>>
>> To do this the patch also reviews the st_parse_syscfgs
>> and other routines to manipulate the registers only if
>> actually available.
>> In any case, for example the st_parse_syscfgs detected
>> an error condition but no action was made in the
>> st_pctl_probe_dt.
>>
>> Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
>
> These two SOBs need reordering.
Right,
this will be changed here and everywhere else in the series.

>
>> ---
>>   drivers/pinctrl/pinctrl-st.c | 106 +++++++++++++++++++++++++------------------
>>   1 file changed, 61 insertions(+), 45 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
>> index 9fb66aa..1721611 100644
>> --- a/drivers/pinctrl/pinctrl-st.c
>> +++ b/drivers/pinctrl/pinctrl-st.c
>> @@ -410,25 +410,27 @@ static void st_pinconf_set_config(struct st_pio_control *pc,
>>   	unsigned int oe_value, pu_value, od_value;
>>   	unsigned long mask = BIT(pin);
>>
>> -	regmap_field_read(output_enable, &oe_value);
>> -	regmap_field_read(pull_up, &pu_value);
>> -	regmap_field_read(open_drain, &od_value);
>> -
>> -	/* Clear old values */
>> -	oe_value &= ~mask;
>> -	pu_value &= ~mask;
>> -	od_value &= ~mask;
>> -
>> -	if (config & ST_PINCONF_OE)
>> -		oe_value |= mask;
>> -	if (config & ST_PINCONF_PU)
>> -		pu_value |= mask;
>> -	if (config & ST_PINCONF_OD)
>> -		od_value |= mask;
>> -
>> -	regmap_field_write(output_enable, oe_value);
>> -	regmap_field_write(pull_up, pu_value);
>> -	regmap_field_write(open_drain, od_value);
>> +	if (output_enable) {
>> +		regmap_field_read(output_enable, &oe_value);
>> +		oe_value &= ~mask;
>> +		if (config & ST_PINCONF_OE)
>> +			oe_value |= mask;
>> +		regmap_field_write(output_enable, oe_value);
>> +	}
>> +	if (pull_up) {
>> +		regmap_field_read(pull_up, &pu_value);
>> +		pu_value &= ~mask;
>> +		if (config & ST_PINCONF_PU)
>> +			pu_value |= mask;
>> +		regmap_field_write(pull_up, pu_value);
>> +	}
>> +	if (open_drain) {
>> +		regmap_field_read(open_drain, &od_value);
>> +		od_value &= ~mask;
>> +		if (config & ST_PINCONF_OD)
>> +			od_value |= mask;
>> +		regmap_field_write(open_drain, od_value);
>> +	}
>
> Nice change.
>
> Nit: For consistency with the changes below, please consider placing
> new lines between the 3 outer checks.
Done

>
>>   }
>>
>
> <snip>
>
>> -static void st_pinconf_get_direction(struct st_pio_control *pc,
>> -	int pin, unsigned long *config)
>> +static void st_pinconf_get_direction(struct st_pio_control *pc, int pin,
>> +				     unsigned long *config)
>
> Unrelated change?
Yes this is unrelated.
I removed this change. It will be sent later with maybe other cosmetic 
changes.

>
>>   {
>>   	unsigned int oe_value, pu_value, od_value;
>
> Is it worth checking for (!config) here?

That would be better indeed.
But since that lack of safety check was already present before this 
change, it should be handled in a separate patch.

I'll add this in my todo list.

>
>> -	regmap_field_read(pc->oe, &oe_value);
>> -	regmap_field_read(pc->pu, &pu_value);
>> -	regmap_field_read(pc->od, &od_value);
>> +	if (pc->oe) {
>> +		regmap_field_read(pc->oe, &oe_value);
>> +		if (oe_value & BIT(pin))
>> +			ST_PINCONF_PACK_OE(*config);
>> +	}
>>
>> -	if (oe_value & BIT(pin))
>> -		ST_PINCONF_PACK_OE(*config);
>> -	if (pu_value & BIT(pin))
>> -		ST_PINCONF_PACK_PU(*config);
>> -	if (od_value & BIT(pin))
>> -		ST_PINCONF_PACK_OD(*config);
>> +	if (pc->pu) {
>> +		regmap_field_read(pc->pu, &pu_value);
>> +		if (pu_value & BIT(pin))
>> +			ST_PINCONF_PACK_PU(*config);
>> +	}
>>
>> +	if (pc->od) {
>> +		regmap_field_read(pc->od, &od_value);
>> +		if (od_value & BIT(pin))
>> +			ST_PINCONF_PACK_OD(*config);
>> +	}
>>   }
>
> Nice.
>
>>   static int st_pinconf_get_retime_packed(struct st_pinctrl *info,
>> @@ -1105,8 +1116,21 @@ static int st_pctl_dt_setup_retime(struct st_pinctrl *info,
>>   	return -EINVAL;
>>   }
>>
>> -static int st_parse_syscfgs(struct st_pinctrl *info,
>> -		int bank, struct device_node *np)
>> +
>> +static struct regmap_field *st_pc_get_value(struct device *dev,
>> +					    struct regmap *regmap, int bank,
>> +					    int data, int lsb, int msb)
>> +{
>> +	struct reg_field reg = REG_FIELD((data + bank) * 4, lsb, msb);
>> +
>> +	if (data < 0)
>> +		return NULL;
>
> What happens is data < 0 and it's used in REG_FIELD?
Nothing bad, but I agree this is not crystal clear.

>
> Would it make more sense to make this check before calling REG_FIELD?
Yes, it will be done in the v4.

<snip>

Thanks,
Maxime
