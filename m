From: jason77.wang@gmail.com (Jason Wang)
Date: Fri, 03 Sep 2010 14:22:08 +0800
Subject: [PATCH 2/6] i.MX5/clock: add eCSPI and CSPI clock definitions
In-Reply-To: <20100902150112.GM14214@pengutronix.de>
References: <1283413924-14210-1-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-2-git-send-email-jason77.wang@gmail.com>
	<1283413924-14210-3-git-send-email-jason77.wang@gmail.com>
	<20100902150112.GM14214@pengutronix.de>
Message-ID: <4C809410.9090602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> On Thu, Sep 02, 2010 at 03:52:00PM +0800, Jason Wang wrote:
>   
>> i.MX51 has two eCSPI and one CSPI controllers, now add clock
>> definitions and registrations for these controllers.
>>
>> Signed-off-by: Jason Wang <jason77.wang@gmail.com>
>> ---
>>  arch/arm/mach-mx5/clock-mx51.c |   79 ++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 79 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-mx5/clock-mx51.c b/arch/arm/mach-mx5/clock-mx51.c
>> index 6af69de..217c3f3 100644
>> --- a/arch/arm/mach-mx5/clock-mx51.c
>> +++ b/arch/arm/mach-mx5/clock-mx51.c
>> @@ -38,6 +38,7 @@ static struct clk periph_apm_clk;
>>  static struct clk ahb_clk;
>>  static struct clk ipg_clk;
>>  static struct clk usboh3_clk;
>> +static struct clk spba_clk;
>>  
>>  #define MAX_DPLL_WAIT_TRIES	1000 /* 1000 * udelay(1) = 1ms */
>>  
>> @@ -52,6 +53,18 @@ static int _clk_ccgr_enable(struct clk *clk)
>>  	return 0;
>>  }
>>  
>> +static int _clk_ccgr_enable_inrun(struct clk *clk)
>> +{
>> +	u32 reg;
>> +
>> +	reg = __raw_readl(clk->enable_reg);
>> +	reg &= ~(MXC_CCM_CCGRx_CG_MASK << clk->enable_shift);
>> +	reg |= MXC_CCM_CCGRx_MOD_IDLE << clk->enable_shift;
>> +	__raw_writel(reg, clk->enable_reg);
>> +
>> +	return 0;
>> +}
>> +
>>     
> imho this should be consolidated in something like:
>
> static int _clk_ccgr_setclk(struct clk *clk, unsigned mode)
> {
> 	...
> }
>
> #define _clk_ccgr_enable(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_ON)
> #define _clk_ccgr_disable(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_OFF)
> #define _clk_ccgr_enable_inrun(clk) _clk_ccgr_setclk(clk, MXC_CCM_CCGRx_MOD_IDLE)
>
>   
It makes  code more concise. On the other hand, too many macros will
add troubles when we use kgdb to perform sourcecode-level debug.

Anyway, i agree your suggestion.
>>  static void _clk_ccgr_disable(struct clk *clk)
>>  {
>>  	u32 reg;
>> @@ -762,6 +775,61 @@ static struct clk kpp_clk = {
>>  	.id = 0,
>>  };
>>  
>> +/* eCSPI */
>> +static unsigned long _clk_ecspi_getrate(struct clk *clk)
>> +{
>> +	u32 reg, prediv, podf;
>> +	unsigned long ret;
>> +
>> +	reg = __raw_readl(MXC_CCM_CSCDR2);
>> +	prediv = ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PRED_MASK) >>
>> +		  MXC_CCM_CSCDR2_CSPI_CLK_PRED_OFFSET) + 1;
>> +	if (prediv == 1)
>> +		BUG();
>> +	podf = ((reg & MXC_CCM_CSCDR2_CSPI_CLK_PODF_MASK) >>
>> +		MXC_CCM_CSCDR2_CSPI_CLK_PODF_OFFSET) + 1;
>> +
>> +	ret = clk_get_rate(clk->parent) / (prediv * podf);
>> +	return ret;
>> +}
>> +
>> +static int _clk_ecspi_set_parent(struct clk *clk, struct clk *parent)
>> +{
>> +	u32 reg, mux;
>> +
>> +	mux = _get_mux(parent, &pll1_sw_clk, &pll2_sw_clk, &pll3_sw_clk,
>> +		       &lp_apm_clk);
>> +	reg = __raw_readl(MXC_CCM_CSCMR1) & ~MXC_CCM_CSCMR1_CSPI_CLK_SEL_MASK;
>> +	reg |= mux << MXC_CCM_CSCMR1_CSPI_CLK_SEL_OFFSET;
>> +	__raw_writel(reg, MXC_CCM_CSCMR1);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct clk ecspi_main_clk = {
>> +	.parent = &pll3_sw_clk,
>> +	.get_rate = _clk_ecspi_getrate,
>> +	.set_parent = _clk_ecspi_set_parent,
>>     
> Sascha didn't implement set_parent
>
>   
ecspi really can change parent root clock.
>> +};
>> +
>> +static struct clk ecspi1_ipg_clk = {
>> +	.parent = &ipg_clk,
>> +	.secondary = &spba_clk,
>> +	.enable_reg = MXC_CCM_CCGR4,
>> +	.enable_shift = MXC_CCM_CCGRx_CG9_OFFSET,
>> +	.enable = _clk_ccgr_enable_inrun,
>> +	.disable = _clk_ccgr_disable,
>> +};
>> +
>> +static struct clk ecspi2_ipg_clk = {
>> +	.parent = &ipg_clk,
>> +	.secondary = &aips_tz2_clk,
>> +	.enable_reg = MXC_CCM_CCGR4,
>> +	.enable_shift = MXC_CCM_CCGRx_CG11_OFFSET,
>> +	.enable = _clk_ccgr_enable_inrun,
>> +	.disable = _clk_ccgr_disable,
>> +};
>> +
>>  #define DEFINE_CLOCK(name, i, er, es, gr, sr, p, s)	\
>>  	static struct clk name = {			\
>>  		.id		= i,			\
>> @@ -814,6 +882,14 @@ DEFINE_CLOCK(hsi2c_clk, 0, MXC_CCM_CCGR1, MXC_CCM_CCGRx_CG11_OFFSET,
>>  DEFINE_CLOCK(fec_clk, 0, MXC_CCM_CCGR2, MXC_CCM_CCGRx_CG12_OFFSET,
>>  	NULL,  NULL, &ipg_clk, NULL);
>>  
>> +/* eCSPI & CSPI */
>> +DEFINE_CLOCK(cspi1_clk, 0, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG10_OFFSET,
>> +	NULL, NULL, &ecspi_main_clk, &ecspi1_ipg_clk);
>> +DEFINE_CLOCK(cspi2_clk, 1, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG12_OFFSET,
>> +	NULL, NULL, &ecspi_main_clk, &ecspi2_ipg_clk);
>> +DEFINE_CLOCK(cspi3_clk, 2, MXC_CCM_CCGR4, MXC_CCM_CCGRx_CG13_OFFSET,
>> +	NULL, NULL, &ipg_clk, NULL);
>> +
>>     
> Maybe use ecspi1_clk, cspi2_clk, cspi_clk here?  I thought about this,
> too, for our code, couldn't really decide.  What do you think?
>
>   
Agree.
>>  #define _REGISTER_CLOCK(d, n, c) \
>>         { \
>>  		.dev_id = d, \
>> @@ -837,6 +913,9 @@ static struct clk_lookup lookups[] = {
>>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb", usboh3_clk)
>>  	_REGISTER_CLOCK("fsl-usb2-udc", "usb_ahb", ahb_clk)
>>  	_REGISTER_CLOCK("imx-keypad.0", NULL, kpp_clk)
>> +	_REGISTER_CLOCK("spi_imx.0", NULL, cspi1_clk)
>> +	_REGISTER_CLOCK("spi_imx.1", NULL, cspi2_clk)
>> +	_REGISTER_CLOCK("spi_imx.2", NULL, cspi3_clk)
>>  };
>>  
>>     
>
> Best regards
> Uwe
>
>   
