From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 19 Jul 2012 07:58:41 +0200
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20120718133624.GA30219@S2100-06.ap.freescale.net>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
 <20120715150003.GD2429@S2100-06.ap.freescale.net>
 <20483.48320.888197.282702@ipc1.ka-ro>
 <20120718133624.GA30219@S2100-06.ap.freescale.net>
Message-ID: <20487.41489.261103.678515@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> On Mon, Jul 16, 2012 at 09:03:28AM +0200, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Shawn Guo writes:
> > > On Sun, Jul 15, 2012 at 10:49:35PM +0800, Shawn Guo wrote:
> > > > below.  But does that mean ethernet PHY does not work even on non-DT
> > > > kernel right now?
> > > > 
> > > So I guess you need something like c46d291 (ARM: apx4devkit: fix FEC
> > > enabling PHY clock) for TX28 too.
> > > 
> > That's already in place.
> > 
> Are you using and talking about the branch I prepared for you?
> I haven't seen it there.
> 
I'm using:
git-remote -v
|origin  git://git.linaro.org/people/shawnguo/linux-2.6.git (fetch)
|origin  git://git.linaro.org/people/shawnguo/linux-2.6.git (push)

 git-branch -a
|  mxs/dt/others
|* tx28
|  remotes/origin/HEAD -> origin/master
|  remotes/origin/clk/mxs-for-3.6
|  remotes/origin/imx/cleanup-for-3.6
|  remotes/origin/imx/dt-for-3.6
|  remotes/origin/imx/irqdomain
|  remotes/origin/imx/sparse-irq
|  remotes/origin/master
|  remotes/origin/mxs/defconfig-for-3.6
|  remotes/origin/mxs/dt-for-3.6
|  remotes/origin/mxs/dt/others
|  remotes/origin/mxs/dt/tx28
|  remotes/origin/mxs/fixes-for-3.5
|  remotes/origin/mxs/fixes-for-3.6
|  remotes/origin/mxs/test
where 'tx28' is checked out from remotes/origin/mxs/dt/tx28.

git-show c46d291
commit c46d2916f6c03d3c8a2c38148af2e45cdadaf61f
Author: Lauri Hintsala <lauri.hintsala@bluegiga.com>
Date:   Thu Jul 5 10:31:36 2012 +0300

    ARM: apx4devkit: fix FEC enabling PHY clock
    
    Ethernet stopped to work after mxs clk framework change.
    
    Signed-off-by: Lauri Hintsala <lauri.hintsala@bluegiga.com>
    Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

diff --git a/arch/arm/mach-mxs/mach-apx4devkit.c b/arch/arm/mach-mxs/mach-apx4devkit.c
index 5e90b9d..f5f0617 100644
--- a/arch/arm/mach-mxs/mach-apx4devkit.c
+++ b/arch/arm/mach-mxs/mach-apx4devkit.c
@@ -205,6 +205,16 @@ static int apx4devkit_phy_fixup(struct phy_device *phy)
        return 0;
 }
 
+static void __init apx4devkit_fec_phy_clk_enable(void)
+{
+       struct clk *clk;
+
+       /* Enable fec phy clock */
+       clk = clk_get_sys("enet_out", NULL);
+       if (!IS_ERR(clk))
+               clk_prepare_enable(clk);
+}
+
 static void __init apx4devkit_init(void)
 {
        mx28_soc_init();
@@ -225,6 +235,7 @@ static void __init apx4devkit_init(void)
        phy_register_fixup_for_uid(PHY_ID_KS8051, MICREL_PHY_ID_MASK,
                        apx4devkit_phy_fixup);
 
+       apx4devkit_fec_phy_clk_enable();
        mx28_add_fec(0, &mx28_fec_pdata);
 
        mx28_add_mxs_mmc(0, &apx4devkit_mmc_pdata);


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
