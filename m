From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 12 Feb 2012 12:12:54 -0700 (MST)
Subject: OMAP34xx
In-Reply-To: <20120212104132.GA17557@n2100.arm.linux.org.uk>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120212104132.GA17557@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1202121148210.30322@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Sun, 12 Feb 2012, Russell King - ARM Linux wrote:

> The other allnoconfig issue is:
> 
> arch/arm/mach-omap2/built-in.o:(.data+0xa3d0): undefined reference to `omap_i2c_reset'
> 
> which looks like hwmod can't cope with the I2C_OMAP being disabled.
> 
> I don't propose these are fixed for v3.3, but they certainly should be
> fixed for v3.4.

Thanks for the report.  Here's a patch for this for 3.4.  Compile-tested 
only; will boot-test it as part of the v2 of the 3.4 hwmod changes.


- Paul

From: Paul Walmsley <paul@pwsan.com>
Date: Sun, 12 Feb 2012 11:49:34 -0700
Subject: [PATCH] ARM: OMAP2+: I2C: always compile I2C reset code, even if I2C
 driver is not built

During kernel init, we reset all IP blocks on the OMAP that we can,
even if there is no driver compiled for that IP block.  Unlike most IP
blocks, the I2C block requires some extra programming for this to
work.  This reset code is incorrectly omitted when the I2C driver is
deselected.  In this circumstance, the build breaks.  Fix by compiling
the I2C reset code unconditionally.

Problem reported by Russell King <linux@arm.linux.org.uk>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mach-omap2/Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fc9b238..0d5676c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
-	 common.o gpio.o dma.o wd_timer.o display.o
+	 common.o gpio.o dma.o wd_timer.o display.o i2c.o
 
 omap-2-3-common				= irq.o sdrc.o
 hwmod-common				= omap_hwmod.o \
@@ -182,9 +182,6 @@ obj-$(CONFIG_OMAP_IOMMU)		+= iommu2.o
 iommu-$(CONFIG_OMAP_IOMMU)		:= omap-iommu.o
 obj-y					+= $(iommu-m) $(iommu-y)
 
-i2c-omap-$(CONFIG_I2C_OMAP)		:= i2c.o
-obj-y					+= $(i2c-omap-m) $(i2c-omap-y)
-
 ifneq ($(CONFIG_TIDSPBRIDGE),)
 obj-y					+= dsp.o
 endif
-- 
1.7.9
