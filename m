From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 4 Mar 2011 22:20:35 +0100
Subject: [PATCH] ARM: imx: move selection between i.MX21 and i.MX27 to
	CPU family choice
In-Reply-To: <20110304081916.GB29521@pengutronix.de>
References: <20110302112559.GC22310@pengutronix.de>
	<1299086585-22707-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110303121153.GJ29521@pengutronix.de>
	<20110303162513.GS22310@pengutronix.de>
	<20110303180026.GC18351@pengutronix.de>
	<20110303201009.GT22310@pengutronix.de>
	<20110304081916.GB29521@pengutronix.de>
Message-ID: <20110304212035.GY22310@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Mar 04, 2011 at 09:19:16AM +0100, Sascha Hauer wrote:
> On Thu, Mar 03, 2011 at 09:10:09PM +0100, Uwe Kleine-K?nig wrote:
> > Right, it's not sensible to do this selection, but the fact that it is
> > possible makes me feel it's ugly. I thought a bit more about that I and
> > another reason for not using SOC_IMXxy for Kconfig is that it might be
> > natural to group i.MX50 and i.MX53 together because they share the same
> > PHYS_OFFSET. So there are three possibilities:
> > 
> >  1) group them using a symbol named SOC_IMX50_IMX53
> >  2) select both SOC_IMX50 and SOC_IMX53 independant of the machines
> >     enabled.
> >  3) don't allow to build both SoCs into a single image without
> >     IMX_MULTI_ARCHITECTURE
> > 
> > 2) is similar to my first suggestion---it might make things more
> > complicated than necessary at runtime. 3) is a limitation that shouldn't
> > be needed. So 1) is the best? Then I prefer to have a completly
> > different naming scheme for the grouping.
> > 
> > Does this make sense?
> 
> Lets give it a try. How does the following look like? Note I also skipped
> The explicit IMX_MULTI_ARCHITECTURE switch and depend on
> ARM_PATCH_PHYS_VIRT && AUTO_ZRELADDR directly instead.
> 
> 8<---------------------------------------
> 
> ARM i.MX: Allow to compile armv4 and armv5 based i.MX SoCs in a single kernel
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/Kconfig |  109 +++++++++++++++++++++++++++++++++++----------
>  arch/arm/plat-mxc/Kconfig |   17 +------
>  2 files changed, 88 insertions(+), 38 deletions(-)

I tested a bit and I noticed this patch breaks defconfigs for mx1, mx21
and mx27. To fix that you might want to squash the following in:

diff --git a/arch/arm/configs/mx1_defconfig b/arch/arm/configs/mx1_defconfig
index b39b5ce..10134da 100644
--- a/arch/arm/configs/mx1_defconfig
+++ b/arch/arm/configs/mx1_defconfig
@@ -12,7 +12,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX1=y
+CONFIG_ARCH_IMX=y
 CONFIG_ARCH_MX1ADS=y
 CONFIG_MACH_SCB9328=y
 CONFIG_MXC_IRQ_PRIOR=y
diff --git a/arch/arm/configs/mx21_defconfig b/arch/arm/configs/mx21_defconfig
index 411f88d..1b31b83 100644
--- a/arch/arm/configs/mx21_defconfig
+++ b/arch/arm/configs/mx21_defconfig
@@ -13,7 +13,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX2=y
+CONFIG_ARCH_IMX=y
+CONFIG_ARCH_IMX_ONLY_IMX21=y
 CONFIG_MACH_MX21ADS=y
 CONFIG_MXC_PWM=y
 CONFIG_NO_HZ=y
diff --git a/arch/arm/configs/mx27_defconfig b/arch/arm/configs/mx27_defconfig
index 9ad4c656..a95b074 100644
--- a/arch/arm/configs/mx27_defconfig
+++ b/arch/arm/configs/mx27_defconfig
@@ -17,8 +17,8 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_DEADLINE is not set
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MXC=y
-CONFIG_ARCH_MX2=y
-CONFIG_MACH_MX27=y
+CONFIG_ARCH_IMX=y
+CONFIG_ARCH_IMX_ONLY_IMX27=y
 CONFIG_MACH_MX27ADS=y
 CONFIG_MACH_PCM038=y
 CONFIG_MACH_CPUIMX27=y

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
