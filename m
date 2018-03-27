From: parkch98@gmail.com (Chanho Park)
Date: Tue, 27 Mar 2018 22:47:40 +0900
Subject: [PATCH] pinctrl: samsung: add pin_dbg_show callback for debugfs
In-Reply-To: <CAJKOXPcpb-xFUBCQMXqoTpydwcL2cw+9Omi+3uYxK9fvzxWFhQ@mail.gmail.com>
References: <20180326152711.7780-1-parkch98@gmail.com>
 <CAJKOXPcpb-xFUBCQMXqoTpydwcL2cw+9Omi+3uYxK9fvzxWFhQ@mail.gmail.com>
Message-ID: <7bc686ca-a1e8-07f9-9d70-9909f9930374@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Krzysztof,


First of all, thanks for your review.


On 03/27/2018 04:07 PM, Krzysztof Kozlowski wrote:
> On Mon, Mar 26, 2018 at 5:27 PM, Chanho Park <parkch98@gmail.com> wrote:
>> This patch adds a samsung_pin_dbg_show function to implement the
>> pin_dbg_show callback function which can be used to show pin
>> confuration values. Basically, it can show pin setting values by
>> accessing the "pins" node like below:
>>
>> $ cat pins
>> pin 0 (gpy7-0)  CON(0x0) DAT(0x1) PUD(0x1) DRV(0x0) CON_PDN(0x0) PUD_PDN(0x0)
>>
>> Signed-off-by: Chanho Park <parkch98@gmail.com>
>> ---
>>   drivers/pinctrl/samsung/pinctrl-samsung.c | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
>> index 336e88d7bdb9..bdec0cbd64f1 100644
>> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
>> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
>> @@ -279,6 +279,30 @@ static int samsung_dt_node_to_map(struct pinctrl_dev *pctldev,
>>          return 0;
>>   }
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +/* Forward declaration which can be used by samsung_pin_dbg_show */
>> +static int samsung_pinconf_rw(struct pinctrl_dev *pctldev, unsigned int pin,
>> +                               unsigned long *config, bool set);
>> +static char *reg_names[] = {"CON", "DAT", "PUD", "DRV", "CON_PDN", "PUD_PDN"};
> This should be static const char. Please also add an empty line here.
Okay. I'll fix it and use samsung_pinconf_get forward declaration.
>
>> +static void samsung_pin_dbg_show(struct pinctrl_dev *pctldev,
>> +                               struct seq_file *s, unsigned int pin)
>> +{
>> +       enum pincfg_type cfg_type;
>> +       unsigned long config;
>> +       int ret;
>> +
>> +       for (cfg_type = 0; cfg_type < PINCFG_TYPE_NUM; cfg_type++) {
>> +               config = PINCFG_PACK(cfg_type, 0);
>> +               ret = samsung_pinconf_rw(pctldev, pin, &config, false);
> Use samsung_pinconf_get().
>
>> +               if (ret == -EINVAL)
> if (ret < 0)
Okay. I'll apply this next patch.


Best Regards,
Chanho Park
