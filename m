From: B13634@freescale.com (Zhang Quan-B13634)
Date: Mon, 4 Feb 2013 03:13:40 +0000
Subject: [PATCH 2/2] ARM: imx: set CKO1 parent clock source in imx6q
 sabresd
In-Reply-To: <20130203104636.GB26233@S2101-09.ap.freescale.net>
References: <1359701217-23931-1-git-send-email-b13634@freescale.com>
 <20130203104636.GB26233@S2101-09.ap.freescale.net>
Message-ID: <8D894AC610DA3944965280D4097EAC4603CD2F55@039-SN2MPN1-021.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,
Please see the feedback inline


Best Regards
Gary


>  -----Original Message-----
>  From: Shawn Guo [mailto:shawn.guo at linaro.org]
>  Sent: Sunday, February 03, 2013 18:47
>  To: Zhang Quan-B13634
>  Cc: kernel at pengutronix.de; linux at arm.linux.org.uk; linux-arm-
>  kernel at lists.infradead.org
>  Subject: Re: [PATCH 2/2] ARM: imx: set CKO1 parent clock source in imx6q
>  sabresd
>  
>  On Fri, Feb 01, 2013 at 02:46:57PM +0800, Gary Zhang wrote:
>  > in imx6q sabresd board, set ahb as CKO1 parent clock sourrce
>  >
>  > Signed-off-by: Gary Zhang <b13634@freescale.com>
>  > ---
>  >  arch/arm/mach-imx/mach-imx6q.c |   15 ++++++++++++---
>  >  1 files changed, 12 insertions(+), 3 deletions(-)
>  >
>  > diff --git a/arch/arm/mach-imx/mach-imx6q.c
>  > b/arch/arm/mach-imx/mach-imx6q.c index 4eb1b3a..860e272 100644
>  > --- a/arch/arm/mach-imx/mach-imx6q.c
>  > +++ b/arch/arm/mach-imx/mach-imx6q.c
>  > @@ -119,7 +119,7 @@ static int ksz9021rn_phy_fixup(struct phy_device *phydev)
>  >  	return 0;
>  >  }
>  >
>  > -static void __init imx6q_sabrelite_cko1_setup(void)
>  > +static void __init cko1_setup(unsigned long freq)
>  >  {
>  >  	struct clk *cko1_sel, *ahb, *cko1;
>  >  	unsigned long rate;
>  > @@ -132,8 +132,10 @@ static void __init imx6q_sabrelite_cko1_setup(void)
>  >  		goto put_clk;
>  >  	}
>  >  	clk_set_parent(cko1_sel, ahb);
>  > -	rate = clk_round_rate(cko1, 16000000);
>  > +	rate = clk_round_rate(cko1, freq);
>  >  	clk_set_rate(cko1, rate);
>  > +
>  > +	return;
>  
>  Why does this "return" needs to be added here?
[Gary-b13634] because the codes below may be ignored when execute 'return' ,
Saving cpu consumption.
>  
>  Shawn
>  
>  >  put_clk:
>  >  	if (!IS_ERR(cko1_sel))
>  >  		clk_put(cko1_sel);
>  > @@ -148,7 +150,12 @@ static void __init imx6q_sabrelite_init(void)
>  >  	if (IS_BUILTIN(CONFIG_PHYLIB))
>  >  		phy_register_fixup_for_uid(PHY_ID_KSZ9021, MICREL_PHY_ID_MASK,
>  >  				ksz9021rn_phy_fixup);
>  > -	imx6q_sabrelite_cko1_setup();
>  > +	cko1_setup(16000000);
>  > +}
>  > +
>  > +static void __init imx6q_sabresd_init(void) {
>  > +	cko1_setup(24000000);
>  >  }
>  >
>  >  static void __init imx6q_1588_init(void) @@ -193,6 +200,8 @@ static
>  > void __init imx6q_init_machine(void)  {
>  >  	if (of_machine_is_compatible("fsl,imx6q-sabrelite"))
>  >  		imx6q_sabrelite_init();
>  > +	else if (of_machine_is_compatible("fsl,imx6q-sabresd"))
>  > +		imx6q_sabresd_init();
>  >
>  >  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
>  >
>  > --
>  > 1.7.0.4
>  >
>  >
