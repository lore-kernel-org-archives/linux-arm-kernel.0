From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 12:56:10 +0100
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <20100908091113.GB29914@n2100.arm.linux.org.uk>
References: <20100903095504.GC13643@pengutronix.de>
	<1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTi=7+TcOWu_62EWH6pwFUuizMT47tHJraaqzdJgp@mail.gmail.com>
	<20100903190155.GE17152@pengutronix.de>
	<AANLkTin2fEj2kRRoE+RSpBovApMaCKTs+DVz9wvj7M3u@mail.gmail.com>
	<20100903192329.GB29821@pengutronix.de>
	<20100908091113.GB29914@n2100.arm.linux.org.uk>
Message-ID: <20100908115609.GA32659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 08, 2010 at 10:11:13AM +0100, Russell King - ARM Linux wrote:
> On Fri, Sep 03, 2010 at 09:23:29PM +0200, Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Fri, Sep 03, 2010 at 12:19:26PM -0700, Erik Gilling wrote:
> > > On Fri, Sep 3, 2010 at 12:01 PM, Uwe Kleine-K?nig
> > > > (hmm, I thought that patches that touch common files like
> > > > arch/arm/Kconfig should go via rmk?!)
> > > 
> > > I looked and saw that others (specifically samsung) had submitted this
> > > fix directly to Linus.  I'm still learning the ropes here and am happy
> > > to hear some clarification either way.
> >
> > Note that just me wondering if it's right doesn't necessarily means it's
> > not.  Russell, can you comment?  Is it trivial enough and obviously only
> > tegra related that it's OK?
> 
> The problem happens when there's related changes already in others git
> trees which clash or conflict with those changes.
> 
> This whole CONFIG_ZRELADDR thing seems like a step backwards towards a
> situation where we will get conflicts with multiple changes - but without
> gaining anything substantial in moving away from Makefile.boot.
> 
> Unless someone can come up with a real justification for CONFIG_ZRELADDR
> I'm mindful to revert it.  (But - if people have sent these changes to
> Linus already, that's going to make reverting it a lot harder.)

This is what I'm considering committing to sort out this ZRELADDR mess -
it gives people who want AUTO_ZRELADDR their pie, while allowing us to
keep the proven reliability of original method of handling ZRELADDR.

 arch/arm/Kconfig                  |   90 -------------------------------------
 arch/arm/boot/Makefile            |    8 ++-
 arch/arm/boot/compressed/Makefile |    4 ++
 arch/arm/boot/compressed/head.S   |    2 +-
 4 files changed, 10 insertions(+), 94 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7ed21f..553b7cf 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1576,96 +1576,6 @@ config AUTO_ZRELADDR
 	  0xf8000000. This assumes the zImage being placed in the first 128MB
 	  from start of memory.
 
-config ZRELADDR
-	hex "Physical address of the decompressed kernel image"
-	depends on !AUTO_ZRELADDR
-	default 0x00008000 if ARCH_BCMRING ||\
-		ARCH_CNS3XXX ||\
-		ARCH_DOVE ||\
-		ARCH_EBSA110 ||\
-		ARCH_FOOTBRIDGE ||\
-		ARCH_INTEGRATOR ||\
-		ARCH_IOP13XX ||\
-		ARCH_IOP33X ||\
-		ARCH_IXP2000 ||\
-		ARCH_IXP23XX ||\
-		ARCH_IXP4XX ||\
-		ARCH_KIRKWOOD ||\
-		ARCH_KS8695 ||\
-		ARCH_LOKI ||\
-		ARCH_MMP ||\
-		ARCH_MV78XX0 ||\
-		ARCH_NOMADIK ||\
-		ARCH_NUC93X ||\
-		ARCH_NS9XXX ||\
-		ARCH_ORION5X ||\
-		ARCH_SPEAR3XX ||\
-		ARCH_SPEAR6XX ||\
-		ARCH_U8500 ||\
-		ARCH_VERSATILE ||\
-		ARCH_W90X900
-	default 0x08008000 if ARCH_MX1 ||\
-		ARCH_SHARK
-	default 0x10008000 if ARCH_MSM ||\
-		ARCH_OMAP1 ||\
-		ARCH_RPC
-	default 0x20008000 if ARCH_S5P6440 ||\
-		ARCH_S5P6442 ||\
-		ARCH_S5PC100 ||\
-		ARCH_S5PV210
-	default 0x30008000 if ARCH_S3C2410 ||\
-		ARCH_S3C2400 ||\
-		ARCH_S3C2412 ||\
-		ARCH_S3C2416 ||\
-		ARCH_S3C2440 ||\
-		ARCH_S3C2443
-	default 0x40008000 if ARCH_STMP378X ||\
-		ARCH_STMP37XX ||\
-		ARCH_SH7372 ||\
-		ARCH_SH7377 ||\
-		ARCH_S5PV310
-	default 0x50008000 if ARCH_S3C64XX ||\
-		ARCH_SH7367
-	default 0x60008000 if ARCH_VEXPRESS
-	default 0x80008000 if ARCH_MX25 ||\
-		ARCH_MX3 ||\
-		ARCH_NETX ||\
-		ARCH_OMAP2PLUS ||\
-		ARCH_PNX4008
-	default 0x90008000 if ARCH_MX5 ||\
-		ARCH_MX91231
-	default 0xa0008000 if ARCH_IOP32X ||\
-		ARCH_PXA ||\
-		MACH_MX27
-	default 0xc0008000 if ARCH_LH7A40X ||\
-		MACH_MX21
-	default 0xf0008000 if ARCH_AAEC2000 ||\
-		ARCH_L7200
-	default 0xc0028000 if ARCH_CLPS711X
-	default 0x70008000 if ARCH_AT91 && (ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
-	default 0x20008000 if ARCH_AT91 && !(ARCH_AT91CAP9 || ARCH_AT91SAM9G45)
-	default 0xc0008000 if ARCH_DAVINCI && ARCH_DAVINCI_DA8XX
-	default 0x80008000 if ARCH_DAVINCI && !ARCH_DAVINCI_DA8XX
-	default 0x00008000 if ARCH_EP93XX && EP93XX_SDCE3_SYNC_PHYS_OFFSET
-	default 0xc0008000 if ARCH_EP93XX && EP93XX_SDCE0_PHYS_OFFSET
-	default 0xd0008000 if ARCH_EP93XX && EP93XX_SDCE1_PHYS_OFFSET
-	default 0xe0008000 if ARCH_EP93XX && EP93XX_SDCE2_PHYS_OFFSET
-	default 0xf0008000 if ARCH_EP93XX && EP93XX_SDCE3_ASYNC_PHYS_OFFSET
-	default 0x00008000 if ARCH_GEMINI && GEMINI_MEM_SWAP
-	default 0x10008000 if ARCH_GEMINI && !GEMINI_MEM_SWAP
-	default 0x70008000 if ARCH_REALVIEW && REALVIEW_HIGH_PHYS_OFFSET
-	default 0x00008000 if ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET
-	default 0xc0208000 if ARCH_SA1100 && SA1111
-	default 0xc0008000 if ARCH_SA1100 && !SA1111
-	default 0x30108000 if ARCH_S3C2410 && PM_H1940
-	default 0x28E08000 if ARCH_U300 && MACH_U300_SINGLE_RAM
-	default 0x48008000 if ARCH_U300 && !MACH_U300_SINGLE_RAM
-	help
-	  ZRELADDR is the physical address where the decompressed kernel
-	  image will be placed. ZRELADDR has to be specified when the
-	  assumption of AUTO_ZRELADDR is not valid, or when ZBOOT_ROM is
-	  selected.
-
 endmenu
 
 menu "CPU Power Management"
diff --git a/arch/arm/boot/Makefile b/arch/arm/boot/Makefile
index f705213..4a590f4 100644
--- a/arch/arm/boot/Makefile
+++ b/arch/arm/boot/Makefile
@@ -14,16 +14,18 @@
 MKIMAGE         := $(srctree)/scripts/mkuboot.sh
 
 ifneq ($(MACHINE),)
--include $(srctree)/$(MACHINE)/Makefile.boot
+include $(srctree)/$(MACHINE)/Makefile.boot
 endif
 
 # Note: the following conditions must always be true:
+#   ZRELADDR == virt_to_phys(PAGE_OFFSET + TEXT_OFFSET)
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
+ZRELADDR    := $(zreladdr-y)
 PARAMS_PHYS := $(params_phys-y)
 INITRD_PHYS := $(initrd_phys-y)
 
-export INITRD_PHYS PARAMS_PHYS
+export ZRELADDR INITRD_PHYS PARAMS_PHYS
 
 targets := Image zImage xipImage bootpImage uImage
 
@@ -65,7 +67,7 @@ quiet_cmd_uimage = UIMAGE  $@
 ifeq ($(CONFIG_ZBOOT_ROM),y)
 $(obj)/uImage: LOADADDR=$(CONFIG_ZBOOT_ROM_TEXT)
 else
-$(obj)/uImage: LOADADDR=$(CONFIG_ZRELADDR)
+$(obj)/uImage: LOADADDR=$(ZRELADDR)
 endif
 
 ifeq ($(CONFIG_THUMB2_KERNEL),y)
diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
index 68775e3..b23f6bc 100644
--- a/arch/arm/boot/compressed/Makefile
+++ b/arch/arm/boot/compressed/Makefile
@@ -79,6 +79,10 @@ endif
 EXTRA_CFLAGS  := -fpic -fno-builtin
 EXTRA_AFLAGS  := -Wa,-march=all
 
+# Supply ZRELADDR to the decompressor via a linker symbol.
+ifneq ($(CONFIG_AUTO_ZRELADDR),y)
+LDFLAGS_vmlinux := --defsym zreladdr=$(ZRELADDR)
+endif
 ifeq ($(CONFIG_CPU_ENDIAN_BE8),y)
 LDFLAGS_vmlinux += --be8
 endif
diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 6af9907..6825c34 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -177,7 +177,7 @@ not_angel:
 		and	r4, pc, #0xf8000000
 		add	r4, r4, #TEXT_OFFSET
 #else
-		ldr	r4, =CONFIG_ZRELADDR
+		ldr	r4, =zreladdr
 #endif
 		subs	r0, r0, r1		@ calculate the delta offset
 
