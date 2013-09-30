From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 30 Sep 2013 20:37:46 -0300
Subject: [PATCH 06/10] clk: sunxi: mod0 support
In-Reply-To: <20130930173508.GF5287@lukather>
References: <1380426579-32458-1-git-send-email-emilio@elopez.com.ar>
 <1380426579-32458-7-git-send-email-emilio@elopez.com.ar>
 <20130930173508.GF5287@lukather>
Message-ID: <524A0B4A.8080902@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

El 30/09/13 14:35, Maxime Ripard escribi?:
> Hi Emilio,
>
> Overall, it looks fine, I just have a small question.
>
> On Sun, Sep 29, 2013 at 12:49:35AM -0300, Emilio L?pez wrote:
>> This commit implements support for the "module 0" type of clocks, as
>> used by MMC, IR, NAND, SATA and other components.
>>
>> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
>> ---
>>   Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>>   drivers/clk/sunxi/clk-sunxi.c                     | 57 +++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> index 773f3ae..ff3f61c 100644
>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> @@ -35,6 +35,7 @@ Required properties:
>>   	"allwinner,sun7i-a20-apb1-gates-clk" - for the APB1 gates on A20
>>   	"allwinner,sun6i-a31-apb2-div-clk" - for the APB2 gates on A31
>>   	"allwinner,sun6i-a31-apb2-gates-clk" - for the APB2 gates on A31
>> +	"allwinner,sun4i-mod0-clk" - for the module 0 family of clocks
>>
>>   Required properties for all clocks:
>>   - reg : shall be the control register address for the clock.
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index b1210f3..163a3d8 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -287,6 +287,47 @@ static void sun4i_get_apb1_factors(u32 *freq, u32 parent_rate,
>>
>>
>>   /**
>> + * sun4i_get_mod0_factors() - calculates m, n factors for MOD0-style clocks
>> + * MMC rate is calculated as follows
>> + * rate = (parent_rate >> p) / (m + 1);
>> + */
>> +
>> +static void sun4i_get_mod0_factors(u32 *freq, u32 parent_rate,
>> +				   u8 *n, u8 *k, u8 *m, u8 *p)
>> +{
>> +	u8 div, calcm, calcp;
>> +
>> +	/* These clocks can only divide, so we will never be able to achieve
>> +	 * frequencies higher than the parent frequency */
>> +	if (*freq > parent_rate)
>> +		*freq = parent_rate;
>> +
>> +	div = parent_rate / *freq;
>> +
>> +	if (div < 16)
>> +		calcp = 0;
>> +	else if (div / 2 < 16)
>> +		calcp = 1;
>> +	else if (div / 4 < 16)
>> +		calcp = 2;
>> +	else
>> +		calcp = 3;
>> +
>> +	calcm = DIV_ROUND_UP(div, 1 << calcp);
>> +
>> +	*freq = (parent_rate >> calcp) / calcm;
>> +
>> +	/* we were called to round the frequency, we can now return */
>> +	if (n == NULL)
>> +		return;
>> +
>> +	*m = calcm - 1;
>> +	*p = calcp;
>> +}
>> +
>> +
>> +
>> +/**
>>    * sunxi_factors_clk_setup() - Setup function for factor clocks
>>    */
>>
>> @@ -333,6 +374,14 @@ static struct clk_factors_config sun4i_apb1_config = {
>>   	.pwidth = 2,
>>   };
>>
>> +/* user manual says "n" but it's really "p" */
>> +static struct clk_factors_config sun4i_mod0_config = {
>> +	.mshift = 0,
>> +	.mwidth = 4,
>> +	.pshift = 16,
>> +	.pwidth = 2,
>> +};
>> +
>>   static const struct factors_data sun4i_pll1_data __initconst = {
>>   	.enable = 31,
>>   	.table = &sun4i_pll1_config,
>> @@ -356,6 +405,13 @@ static const struct factors_data sun4i_apb1_data __initconst = {
>>   	.getter = sun4i_get_apb1_factors,
>>   };
>>
>> +static const struct factors_data sun4i_mod0_data __initconst = {
>> +	.enable = 31,
>> +	.mux = 24,
>> +	.table = &sun4i_mod0_config,
>> +	.getter = sun4i_get_mod0_factors,
>> +};
>
> How are the parents handled here for the mux part? Do you expect the
> different parents in a precise order in the device tree, so that you
> have a direct mapping to the value to put in the muxing registers, or do
> you have a smarter way to do it?

Indeed, the parents must be indicated on the DT using the same order as 
on the register. In other words, it works the same as all the other 
muxes we have implemented so far. The clock corresponding to bits 00 
goes first, then the one corresponding to 01, etc.

Cheers,

Emilio
