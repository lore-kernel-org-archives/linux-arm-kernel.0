From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Jul 2013 13:23:00 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726193908.GX24642@n2100.arm.linux.org.uk>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <51F29BFE.8000202@broadcom.com>
 <20130726171153.GN29916@titan.lakedaemon.net>
 <51F2AF2D.1000300@broadcom.com>
 <20130726184702.GW24642@n2100.arm.linux.org.uk>
 <51F2C94F.6020405@broadcom.com>
 <20130726193908.GX24642@n2100.arm.linux.org.uk>
Message-ID: <51F2DAA4.2090903@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-26 12:39 PM, Russell King - ARM Linux wrote:
> On Fri, Jul 26, 2013 at 12:09:03PM -0700, Christian Daudt wrote:
>> On 13-07-26 11:47 AM, Russell King - ARM Linux wrote:
>>> On Fri, Jul 26, 2013 at 10:17:33AM -0700, Christian Daudt wrote:
>>>> Because ARCH_BCM is meant to be used for a number of SoC families. We've
>>>> started upstreaming one (the BCM281XX) but have 2 more internally that
>>>> we're working towards upstreaming. And in the future our plan is to keep
>>>> the Broadcom Mobile SoCs all building under this single ARCH_BCM
>>>> configuration as multiplatform code building a single zImage for them.
>>> 1. We're moving to a single zImage for everything.  Not just Broadcom.
>>> There's no need for Broadcom stuff to be treated any differently.
>>> Participate in the single zImage project and you will get that benefit
>>> without these games.
>> I don't follow what is the game being played.
> I don't really mind what you do, but when you start talking about having
> any ARM build always descend into mach-bcm, then something is very wrong
> with how you're going about it - you don't see anyone else needing that
> in the tree, not even OMAP.
>
> I don't really care if your intention is to decend into mach-bcm and then
> do nothing - that's not the point.  The point is we shouldn't even
> decend into mach-bcm if there's nothing to be built there.
>
Ok, how about creating a ARCH_BROADCOM to select descending into the 
mach-bcm dir, and renaming ARCH_BCM to ARCH_BCMMOBILE, along the lines 
of the attachment ?

  Thanks,
    csd



-------------- next part --------------
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index c0ac0f5..cdb6662 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -145,7 +145,7 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		+= at91
-machine-$(CONFIG_ARCH_BCM)		+= bcm
+machine-$(CONFIG_ARCH_BROADCOM)		+= bcm
 machine-$(CONFIG_ARCH_BCM2835)		+= bcm2835
 machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index f112895..0367f94 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -1,4 +1,11 @@
-config ARCH_BCM
+config ARCH_BROADCOM
+	bool "Broadcom Multiplatform SOCs"
+
+if ARCH_BROADCOM
+
+menu  "Broadcom SoC Family"
+
+config ARCH_BCMMOBILE
 	bool "Broadcom SoC" if ARCH_MULTI_V7
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
@@ -13,7 +20,11 @@ config ARCH_BCM
 	select SPARSE_IRQ
 	select TICK_ONESHOT
 	help
-	  This enables support for system based on Broadcom SoCs.
+	  This enables support for systems based on Broadcom mobile SoCs.
 	  It currently supports the 'BCM281XX' family, which includes
 	  BCM11130, BCM11140, BCM11351, BCM28145 and
 	  BCM28155 variants.
+
+endmenu
+
+endif
diff --git a/arch/arm/mach-bcm/Makefile b/arch/arm/mach-bcm/Makefile
index 6adb6aec..08f9ebe 100644
--- a/arch/arm/mach-bcm/Makefile
+++ b/arch/arm/mach-bcm/Makefile
@@ -10,6 +10,6 @@
 # of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-obj-$(CONFIG_ARCH_BCM)		:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
+obj-$(CONFIG_ARCH_BCMMOBILE)	:= board_bcm.o bcm_kona_smc.o bcm_kona_smc_asm.o
 plus_sec := $(call as-instr,.arch_extension sec,+sec)
 AFLAGS_bcm_kona_smc_asm.o	:=-Wa,-march=armv7-a$(plus_sec)
