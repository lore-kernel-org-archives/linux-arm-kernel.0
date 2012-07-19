From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Jul 2012 14:05:38 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20487.41489.261103.678515@ipc1.ka-ro>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
 <20120715150003.GD2429@S2100-06.ap.freescale.net>
 <20483.48320.888197.282702@ipc1.ka-ro>
 <20120718133624.GA30219@S2100-06.ap.freescale.net>
 <20487.41489.261103.678515@ipc1.ka-ro>
Message-ID: <20120719060534.GA19882@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 19, 2012 at 07:58:41AM +0200, Lothar Wa?mann wrote:
> where 'tx28' is checked out from remotes/origin/mxs/dt/tx28.
> 
Yes, the branch is right.  But the following patch only fixes board
apx4devkit.  What I meant is we probably need to apply the same change
for TX28 board.

Regards,
Shawn

> git-show c46d291
> commit c46d2916f6c03d3c8a2c38148af2e45cdadaf61f
> Author: Lauri Hintsala <lauri.hintsala@bluegiga.com>
> Date:   Thu Jul 5 10:31:36 2012 +0300
> 
>     ARM: apx4devkit: fix FEC enabling PHY clock
>     
>     Ethernet stopped to work after mxs clk framework change.
>     
>     Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
>     Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> 
> diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/mach-apx4devkit.c
> index 5e90b9d..f5f0617 100644
> --- a/arch/arm/mach-mxs/mach-apx4devkit.c
> +++ b/arch/arm/mach-mxs/mach-apx4devkit.c
> @@ -205,6 +205,16 @@ static int apx4devkit_phy_fixup(struct phy_device *phy)
>         return 0;
>  }
>  
> +static void __init apx4devkit_fec_phy_clk_enable(void)
> +{
> +       struct clk *clk;
> +
> +       /* Enable fec phy clock */
> +       clk = clk_get_sys("enet_out", NULL);
> +       if (!IS_ERR(clk))
> +               clk_prepare_enable(clk);
> +}
> +
>  static void __init apx4devkit_init(void)
>  {
>         mx28_soc_init();
> @@ -225,6 +235,7 @@ static void __init apx4devkit_init(void)
>         phy_register_fixup_for_uid(PHY_ID_KS8051, MICREL_PHY_ID_MASK,
>                         apx4devkit_phy_fixup);
>  
> +       apx4devkit_fec_phy_clk_enable();
>         mx28_add_fec(0, &mx28_fec_pdata);
>  
>         mx28_add_mxs_mmc(0, &apx4devkit_mmc_pdata);
> 
> 
> Lothar Wa?mann
> -- 
> ___________________________________________________________
> 
> Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
> Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
> Gesch?ftsf?hrer: Matthias Kaussen
> Handelsregistereintrag: Amtsgericht Aachen, HRB 4996
> 
> www.karo-electronics.de | info at karo-electronics.de
> ___________________________________________________________
