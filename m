From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Aug 2011 14:44:58 +0200
Subject: [PATCH 3/3] ARM: allow to detect conflicting zreladdrs
In-Reply-To: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
References: <1312980298-28035-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1312980298-28035-4-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boards used to specify zreladdr in their Makefile.boot with
zreladdr-y := x, so conflicting zreladdrs were silently overwritten.
This patch changes this to zreladdr-y += x, so that we end
up with multiple words in zreladdr in such a case. We can
detect this later and complain if necessary.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-at91/Makefile.boot       |    6 +++---
 arch/arm/mach-bcmring/Makefile.boot    |    2 +-
 arch/arm/mach-clps711x/Makefile.boot   |    2 +-
 arch/arm/mach-cns3xxx/Makefile.boot    |    2 +-
 arch/arm/mach-davinci/Makefile.boot    |    4 ++--
 arch/arm/mach-dove/Makefile.boot       |    2 +-
 arch/arm/mach-ebsa110/Makefile.boot    |    2 +-
 arch/arm/mach-ep93xx/Makefile.boot     |   10 +++++-----
 arch/arm/mach-exynos4/Makefile.boot    |    2 +-
 arch/arm/mach-footbridge/Makefile.boot |    2 +-
 arch/arm/mach-gemini/Makefile.boot     |    4 ++--
 arch/arm/mach-h720x/Makefile.boot      |    2 +-
 arch/arm/mach-imx/Makefile.boot        |   10 +++++-----
 arch/arm/mach-integrator/Makefile.boot |    2 +-
 arch/arm/mach-iop13xx/Makefile.boot    |    2 +-
 arch/arm/mach-iop32x/Makefile.boot     |    2 +-
 arch/arm/mach-iop33x/Makefile.boot     |    2 +-
 arch/arm/mach-ixp2000/Makefile.boot    |    2 +-
 arch/arm/mach-ixp23xx/Makefile.boot    |    2 +-
 arch/arm/mach-ixp4xx/Makefile.boot     |    2 +-
 arch/arm/mach-kirkwood/Makefile.boot   |    2 +-
 arch/arm/mach-ks8695/Makefile.boot     |    2 +-
 arch/arm/mach-lpc32xx/Makefile.boot    |    2 +-
 arch/arm/mach-mmp/Makefile.boot        |    2 +-
 arch/arm/mach-msm/Makefile.boot        |    2 +-
 arch/arm/mach-mv78xx0/Makefile.boot    |    2 +-
 arch/arm/mach-mx5/Makefile.boot        |    6 +++---
 arch/arm/mach-mxs/Makefile.boot        |    2 +-
 arch/arm/mach-netx/Makefile.boot       |    2 +-
 arch/arm/mach-nomadik/Makefile.boot    |    2 +-
 arch/arm/mach-nuc93x/Makefile.boot     |    2 +-
 arch/arm/mach-omap1/Makefile.boot      |    2 +-
 arch/arm/mach-omap2/Makefile.boot      |    2 +-
 arch/arm/mach-orion5x/Makefile.boot    |    2 +-
 arch/arm/mach-pnx4008/Makefile.boot    |    2 +-
 arch/arm/mach-prima2/Makefile.boot     |    2 +-
 arch/arm/mach-pxa/Makefile.boot        |    2 +-
 arch/arm/mach-realview/Makefile.boot   |    4 ++--
 arch/arm/mach-rpc/Makefile.boot        |    2 +-
 arch/arm/mach-s3c2410/Makefile.boot    |    4 ++--
 arch/arm/mach-s3c64xx/Makefile.boot    |    2 +-
 arch/arm/mach-s5p64x0/Makefile.boot    |    2 +-
 arch/arm/mach-s5pc100/Makefile.boot    |    2 +-
 arch/arm/mach-s5pv210/Makefile.boot    |    2 +-
 arch/arm/mach-sa1100/Makefile.boot     |    5 +++--
 arch/arm/mach-shark/Makefile.boot      |    2 +-
 arch/arm/mach-shmobile/Makefile.boot   |    2 +-
 arch/arm/mach-spear3xx/Makefile.boot   |    2 +-
 arch/arm/mach-spear6xx/Makefile.boot   |    2 +-
 arch/arm/mach-tcc8k/Makefile.boot      |    2 +-
 arch/arm/mach-tegra/Makefile.boot      |    2 +-
 arch/arm/mach-u300/Makefile.boot       |    4 ++--
 arch/arm/mach-ux500/Makefile.boot      |    2 +-
 arch/arm/mach-versatile/Makefile.boot  |    2 +-
 arch/arm/mach-vexpress/Makefile.boot   |    2 +-
 arch/arm/mach-vt8500/Makefile.boot     |    2 +-
 arch/arm/mach-w90x900/Makefile.boot    |    2 +-
 arch/arm/mach-zynq/Makefile.boot       |    2 +-
 58 files changed, 77 insertions(+), 76 deletions(-)

diff --git a/arch/arm/mach-at91/Makefile.boot b/arch/arm/mach-at91/Makefile.boot
index 3462b81..9ab5a3e 100644
--- a/arch/arm/mach-at91/Makefile.boot
+++ b/arch/arm/mach-at91/Makefile.boot
@@ -4,15 +4,15 @@
 #   INITRD_PHYS must be in RAM
 
 ifeq ($(CONFIG_ARCH_AT91CAP9),y)
-   zreladdr-y	:= 0x70008000
+   zreladdr-y	+= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70410000
 else ifeq ($(CONFIG_ARCH_AT91SAM9G45),y)
-   zreladdr-y	:= 0x70008000
+   zreladdr-y	+= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70410000
 else
-   zreladdr-y	:= 0x20008000
+   zreladdr-y	+= 0x20008000
 params_phys-y	:= 0x20000100
 initrd_phys-y	:= 0x20410000
 endif
diff --git a/arch/arm/mach-bcmring/Makefile.boot b/arch/arm/mach-bcmring/Makefile.boot
index fb53b28..aef2467 100644
--- a/arch/arm/mach-bcmring/Makefile.boot
+++ b/arch/arm/mach-bcmring/Makefile.boot
@@ -1,6 +1,6 @@
 # Address where decompressor will be written and eventually executed.
 #
 # default to SDRAM
-zreladdr-y      := $(CONFIG_BCM_ZRELADDR)
+zreladdr-y      += $(CONFIG_BCM_ZRELADDR)
 params_phys-y   := 0x00000800
 
diff --git a/arch/arm/mach-clps711x/Makefile.boot b/arch/arm/mach-clps711x/Makefile.boot
index a51fcef..9398e85 100644
--- a/arch/arm/mach-clps711x/Makefile.boot
+++ b/arch/arm/mach-clps711x/Makefile.boot
@@ -1,5 +1,5 @@
 # The standard locations for stuff on CLPS711x type processors
-   zreladdr-y				:= 0xc0028000
+   zreladdr-y				+= 0xc0028000
 params_phys-y				:= 0xc0000100
 # Should probably have some agreement on these...
 initrd_phys-$(CONFIG_ARCH_P720T)	:= 0xc0400000
diff --git a/arch/arm/mach-cns3xxx/Makefile.boot b/arch/arm/mach-cns3xxx/Makefile.boot
index 7770128..d079de0 100644
--- a/arch/arm/mach-cns3xxx/Makefile.boot
+++ b/arch/arm/mach-cns3xxx/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00C00000
diff --git a/arch/arm/mach-davinci/Makefile.boot b/arch/arm/mach-davinci/Makefile.boot
index db97ef2..04a6c4e 100644
--- a/arch/arm/mach-davinci/Makefile.boot
+++ b/arch/arm/mach-davinci/Makefile.boot
@@ -2,12 +2,12 @@ ifeq ($(CONFIG_ARCH_DAVINCI_DA8XX),y)
 ifeq ($(CONFIG_ARCH_DAVINCI_DMx),y)
 $(error Cannot enable DaVinci and DA8XX platforms concurrently)
 else
-   zreladdr-y	:= 0xc0008000
+   zreladdr-y	+= 0xc0008000
 params_phys-y	:= 0xc0000100
 initrd_phys-y	:= 0xc0800000
 endif
 else
-   zreladdr-y	:= 0x80008000
+   zreladdr-y	+= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x80800000
 endif
diff --git a/arch/arm/mach-dove/Makefile.boot b/arch/arm/mach-dove/Makefile.boot
index 67039c3..760a0ef 100644
--- a/arch/arm/mach-dove/Makefile.boot
+++ b/arch/arm/mach-dove/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ebsa110/Makefile.boot b/arch/arm/mach-ebsa110/Makefile.boot
index 2321260..83cf07c 100644
--- a/arch/arm/mach-ebsa110/Makefile.boot
+++ b/arch/arm/mach-ebsa110/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000400
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-ep93xx/Makefile.boot b/arch/arm/mach-ep93xx/Makefile.boot
index 0ad33f1..d3113a7 100644
--- a/arch/arm/mach-ep93xx/Makefile.boot
+++ b/arch/arm/mach-ep93xx/Makefile.boot
@@ -1,14 +1,14 @@
-   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00008000
+   zreladdr-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	+= 0x00008000
 params_phys-$(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)	:= 0x00000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0008000
+   zreladdr-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		+= 0xc0008000
 params_phys-$(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)		:= 0xc0000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0008000
+   zreladdr-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		+= 0xd0008000
 params_phys-$(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)		:= 0xd0000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0008000
+   zreladdr-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		+= 0xe0008000
 params_phys-$(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)		:= 0xe0000100
 
-   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0008000
+   zreladdr-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	+= 0xf0008000
 params_phys-$(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)	:= 0xf0000100
diff --git a/arch/arm/mach-exynos4/Makefile.boot b/arch/arm/mach-exynos4/Makefile.boot
index d65956f..b9862e2 100644
--- a/arch/arm/mach-exynos4/Makefile.boot
+++ b/arch/arm/mach-exynos4/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x40008000
+   zreladdr-y	+= 0x40008000
 params_phys-y	:= 0x40000100
diff --git a/arch/arm/mach-footbridge/Makefile.boot b/arch/arm/mach-footbridge/Makefile.boot
index c7e75ac..ff0a4b5 100644
--- a/arch/arm/mach-footbridge/Makefile.boot
+++ b/arch/arm/mach-footbridge/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-gemini/Makefile.boot b/arch/arm/mach-gemini/Makefile.boot
index 22a52c2..683f52b 100644
--- a/arch/arm/mach-gemini/Makefile.boot
+++ b/arch/arm/mach-gemini/Makefile.boot
@@ -1,9 +1,9 @@
 ifeq ($(CONFIG_GEMINI_MEM_SWAP),y)
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 else
-   zreladdr-y	:= 0x10008000
+   zreladdr-y	+= 0x10008000
 params_phys-y	:= 0x10000100
 initrd_phys-y	:= 0x10800000
 endif
diff --git a/arch/arm/mach-h720x/Makefile.boot b/arch/arm/mach-h720x/Makefile.boot
index 5298401..d875a70 100644
--- a/arch/arm/mach-h720x/Makefile.boot
+++ b/arch/arm/mach-h720x/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-$(CONFIG_ARCH_H720X)	:= 0x40008000
+   zreladdr-$(CONFIG_ARCH_H720X)	+= 0x40008000
 
diff --git a/arch/arm/mach-imx/Makefile.boot b/arch/arm/mach-imx/Makefile.boot
index ebee18b..dbe6120 100644
--- a/arch/arm/mach-imx/Makefile.boot
+++ b/arch/arm/mach-imx/Makefile.boot
@@ -1,19 +1,19 @@
-zreladdr-$(CONFIG_ARCH_MX1)	:= 0x08008000
+zreladdr-$(CONFIG_ARCH_MX1)	+= 0x08008000
 params_phys-$(CONFIG_ARCH_MX1)	:= 0x08000100
 initrd_phys-$(CONFIG_ARCH_MX1)	:= 0x08800000
 
-zreladdr-$(CONFIG_MACH_MX21)	:= 0xC0008000
+zreladdr-$(CONFIG_MACH_MX21)	+= 0xC0008000
 params_phys-$(CONFIG_MACH_MX21)	:= 0xC0000100
 initrd_phys-$(CONFIG_MACH_MX21)	:= 0xC0800000
 
-zreladdr-$(CONFIG_ARCH_MX25)	:= 0x80008000
+zreladdr-$(CONFIG_ARCH_MX25)	+= 0x80008000
 params_phys-$(CONFIG_ARCH_MX25)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX25)	:= 0x80800000
 
-zreladdr-$(CONFIG_MACH_MX27)	:= 0xA0008000
+zreladdr-$(CONFIG_MACH_MX27)	+= 0xA0008000
 params_phys-$(CONFIG_MACH_MX27)	:= 0xA0000100
 initrd_phys-$(CONFIG_MACH_MX27)	:= 0xA0800000
 
-zreladdr-$(CONFIG_ARCH_MX3)	:= 0x80008000
+zreladdr-$(CONFIG_ARCH_MX3)	+= 0x80008000
 params_phys-$(CONFIG_ARCH_MX3)	:= 0x80000100
 initrd_phys-$(CONFIG_ARCH_MX3)	:= 0x80800000
diff --git a/arch/arm/mach-integrator/Makefile.boot b/arch/arm/mach-integrator/Makefile.boot
index c7e75ac..ff0a4b5 100644
--- a/arch/arm/mach-integrator/Makefile.boot
+++ b/arch/arm/mach-integrator/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-iop13xx/Makefile.boot b/arch/arm/mach-iop13xx/Makefile.boot
index 0b0e19f..3a8c38c 100644
--- a/arch/arm/mach-iop13xx/Makefile.boot
+++ b/arch/arm/mach-iop13xx/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y   := 0x00008000
+   zreladdr-y   += 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y 	:= 0x00800000
diff --git a/arch/arm/mach-iop32x/Makefile.boot b/arch/arm/mach-iop32x/Makefile.boot
index 47000dc..0a833b1 100644
--- a/arch/arm/mach-iop32x/Makefile.boot
+++ b/arch/arm/mach-iop32x/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0xa0008000
+   zreladdr-y	+= 0xa0008000
 params_phys-y	:= 0xa0000100
 initrd_phys-y	:= 0xa0800000
diff --git a/arch/arm/mach-iop33x/Makefile.boot b/arch/arm/mach-iop33x/Makefile.boot
index 67039c3..760a0ef 100644
--- a/arch/arm/mach-iop33x/Makefile.boot
+++ b/arch/arm/mach-iop33x/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ixp2000/Makefile.boot b/arch/arm/mach-ixp2000/Makefile.boot
index d84c580..9c7af91 100644
--- a/arch/arm/mach-ixp2000/Makefile.boot
+++ b/arch/arm/mach-ixp2000/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-ixp23xx/Makefile.boot b/arch/arm/mach-ixp23xx/Makefile.boot
index d5561ad..44fb4a7 100644
--- a/arch/arm/mach-ixp23xx/Makefile.boot
+++ b/arch/arm/mach-ixp23xx/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
diff --git a/arch/arm/mach-ixp4xx/Makefile.boot b/arch/arm/mach-ixp4xx/Makefile.boot
index d84c580..9c7af91 100644
--- a/arch/arm/mach-ixp4xx/Makefile.boot
+++ b/arch/arm/mach-ixp4xx/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index 67039c3..760a0ef 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-ks8695/Makefile.boot b/arch/arm/mach-ks8695/Makefile.boot
index 48eb2cb..c9b0beb 100644
--- a/arch/arm/mach-ks8695/Makefile.boot
+++ b/arch/arm/mach-ks8695/Makefile.boot
@@ -3,6 +3,6 @@
 #   PARAMS_PHYS must be within 4MB of ZRELADDR
 #   INITRD_PHYS must be in RAM
 
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-lpc32xx/Makefile.boot b/arch/arm/mach-lpc32xx/Makefile.boot
index b796b41..2cfe0ee 100644
--- a/arch/arm/mach-lpc32xx/Makefile.boot
+++ b/arch/arm/mach-lpc32xx/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x80008000
+   zreladdr-y	+= 0x80008000
 params_phys-y	:= 0x80000100
 initrd_phys-y	:= 0x82000000
 
diff --git a/arch/arm/mach-mmp/Makefile.boot b/arch/arm/mach-mmp/Makefile.boot
index 574a4aa..5edf03e 100644
--- a/arch/arm/mach-mmp/Makefile.boot
+++ b/arch/arm/mach-mmp/Makefile.boot
@@ -1 +1 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
diff --git a/arch/arm/mach-msm/Makefile.boot b/arch/arm/mach-msm/Makefile.boot
index 24dfbf8..9b803a5 100644
--- a/arch/arm/mach-msm/Makefile.boot
+++ b/arch/arm/mach-msm/Makefile.boot
@@ -1,3 +1,3 @@
-  zreladdr-y		:= 0x10008000
+  zreladdr-y		+= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
diff --git a/arch/arm/mach-mv78xx0/Makefile.boot b/arch/arm/mach-mv78xx0/Makefile.boot
index 67039c3..760a0ef 100644
--- a/arch/arm/mach-mv78xx0/Makefile.boot
+++ b/arch/arm/mach-mv78xx0/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
index e928be1..ca207ca 100644
--- a/arch/arm/mach-mx5/Makefile.boot
+++ b/arch/arm/mach-mx5/Makefile.boot
@@ -1,9 +1,9 @@
-   zreladdr-$(CONFIG_ARCH_MX50)	:= 0x70008000
+   zreladdr-$(CONFIG_ARCH_MX50)	+= 0x70008000
 params_phys-$(CONFIG_ARCH_MX50)	:= 0x70000100
 initrd_phys-$(CONFIG_ARCH_MX50)	:= 0x70800000
-   zreladdr-$(CONFIG_ARCH_MX51)	:= 0x90008000
+   zreladdr-$(CONFIG_ARCH_MX51)	+= 0x90008000
 params_phys-$(CONFIG_ARCH_MX51)	:= 0x90000100
 initrd_phys-$(CONFIG_ARCH_MX51)	:= 0x90800000
-   zreladdr-$(CONFIG_ARCH_MX53)	:= 0x70008000
+   zreladdr-$(CONFIG_ARCH_MX53)	+= 0x70008000
 params_phys-$(CONFIG_ARCH_MX53)	:= 0x70000100
 initrd_phys-$(CONFIG_ARCH_MX53)	:= 0x70800000
diff --git a/arch/arm/mach-mxs/Makefile.boot b/arch/arm/mach-mxs/Makefile.boot
index eb541e0..07b11fe 100644
--- a/arch/arm/mach-mxs/Makefile.boot
+++ b/arch/arm/mach-mxs/Makefile.boot
@@ -1 +1 @@
-zreladdr-y := 0x40008000
+zreladdr-y += 0x40008000
diff --git a/arch/arm/mach-netx/Makefile.boot b/arch/arm/mach-netx/Makefile.boot
index b81cf6a..534a4d2 100644
--- a/arch/arm/mach-netx/Makefile.boot
+++ b/arch/arm/mach-netx/Makefile.boot
@@ -1,2 +1,2 @@
-    zreladdr-y			:= 0x80008000
+    zreladdr-y			+= 0x80008000
 
diff --git a/arch/arm/mach-nomadik/Makefile.boot b/arch/arm/mach-nomadik/Makefile.boot
index c7e75ac..ff0a4b5 100644
--- a/arch/arm/mach-nomadik/Makefile.boot
+++ b/arch/arm/mach-nomadik/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-nuc93x/Makefile.boot b/arch/arm/mach-nuc93x/Makefile.boot
index a057b54..6c3d421 100644
--- a/arch/arm/mach-nuc93x/Makefile.boot
+++ b/arch/arm/mach-nuc93x/Makefile.boot
@@ -1,3 +1,3 @@
-zreladdr-y	:= 0x00008000
+zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-omap1/Makefile.boot b/arch/arm/mach-omap1/Makefile.boot
index 292d56c..13bda8d 100644
--- a/arch/arm/mach-omap1/Makefile.boot
+++ b/arch/arm/mach-omap1/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y		:= 0x10008000
+   zreladdr-y		+= 0x10008000
 params_phys-y		:= 0x10000100
 initrd_phys-y		:= 0x10800000
diff --git a/arch/arm/mach-omap2/Makefile.boot b/arch/arm/mach-omap2/Makefile.boot
index 565aff7..b03e562 100644
--- a/arch/arm/mach-omap2/Makefile.boot
+++ b/arch/arm/mach-omap2/Makefile.boot
@@ -1,3 +1,3 @@
-  zreladdr-y		:= 0x80008000
+  zreladdr-y		+= 0x80008000
 params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
diff --git a/arch/arm/mach-orion5x/Makefile.boot b/arch/arm/mach-orion5x/Makefile.boot
index 67039c3..760a0ef 100644
--- a/arch/arm/mach-orion5x/Makefile.boot
+++ b/arch/arm/mach-orion5x/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-pnx4008/Makefile.boot b/arch/arm/mach-pnx4008/Makefile.boot
index 44c7117..9fa19ba 100644
--- a/arch/arm/mach-pnx4008/Makefile.boot
+++ b/arch/arm/mach-pnx4008/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y		:= 0x80008000
+   zreladdr-y		+= 0x80008000
 params_phys-y		:= 0x80000100
 initrd_phys-y		:= 0x80800000
 
diff --git a/arch/arm/mach-prima2/Makefile.boot b/arch/arm/mach-prima2/Makefile.boot
index d023db3..c77a488 100644
--- a/arch/arm/mach-prima2/Makefile.boot
+++ b/arch/arm/mach-prima2/Makefile.boot
@@ -1,3 +1,3 @@
-zreladdr-y		:= 0x00008000
+zreladdr-y		+= 0x00008000
 params_phys-y		:= 0x00000100
 initrd_phys-y		:= 0x00800000
diff --git a/arch/arm/mach-pxa/Makefile.boot b/arch/arm/mach-pxa/Makefile.boot
index 1ead671..2c1ae92 100644
--- a/arch/arm/mach-pxa/Makefile.boot
+++ b/arch/arm/mach-pxa/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0xa0008000
+   zreladdr-y	+= 0xa0008000
 
diff --git a/arch/arm/mach-realview/Makefile.boot b/arch/arm/mach-realview/Makefile.boot
index d97e003..d2c3d78 100644
--- a/arch/arm/mach-realview/Makefile.boot
+++ b/arch/arm/mach-realview/Makefile.boot
@@ -1,9 +1,9 @@
 ifeq ($(CONFIG_REALVIEW_HIGH_PHYS_OFFSET),y)
-   zreladdr-y	:= 0x70008000
+   zreladdr-y	+= 0x70008000
 params_phys-y	:= 0x70000100
 initrd_phys-y	:= 0x70800000
 else
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 endif
diff --git a/arch/arm/mach-rpc/Makefile.boot b/arch/arm/mach-rpc/Makefile.boot
index 9c9e7685..ae2df0d 100644
--- a/arch/arm/mach-rpc/Makefile.boot
+++ b/arch/arm/mach-rpc/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x10008000
+   zreladdr-y	+= 0x10008000
 params_phys-y	:= 0x10000100
 initrd_phys-y	:= 0x18000000
 
diff --git a/arch/arm/mach-s3c2410/Makefile.boot b/arch/arm/mach-s3c2410/Makefile.boot
index 58c1dd7..4457605 100644
--- a/arch/arm/mach-s3c2410/Makefile.boot
+++ b/arch/arm/mach-s3c2410/Makefile.boot
@@ -1,7 +1,7 @@
 ifeq ($(CONFIG_PM_H1940),y)
-	zreladdr-y		:= 0x30108000
+	zreladdr-y	+= 0x30108000
 	params_phys-y	:= 0x30100100
 else
-	zreladdr-y		:= 0x30008000
+	zreladdr-y	+= 0x30008000
 	params_phys-y	:= 0x30000100
 endif
diff --git a/arch/arm/mach-s3c64xx/Makefile.boot b/arch/arm/mach-s3c64xx/Makefile.boot
index ba41fdc..c642333 100644
--- a/arch/arm/mach-s3c64xx/Makefile.boot
+++ b/arch/arm/mach-s3c64xx/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x50008000
+   zreladdr-y	+= 0x50008000
 params_phys-y	:= 0x50000100
diff --git a/arch/arm/mach-s5p64x0/Makefile.boot b/arch/arm/mach-s5p64x0/Makefile.boot
index ff90aa1..79ece40 100644
--- a/arch/arm/mach-s5p64x0/Makefile.boot
+++ b/arch/arm/mach-s5p64x0/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x20008000
+   zreladdr-y	+= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5pc100/Makefile.boot b/arch/arm/mach-s5pc100/Makefile.boot
index ff90aa1..79ece40 100644
--- a/arch/arm/mach-s5pc100/Makefile.boot
+++ b/arch/arm/mach-s5pc100/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x20008000
+   zreladdr-y	+= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-s5pv210/Makefile.boot b/arch/arm/mach-s5pv210/Makefile.boot
index ff90aa1..79ece40 100644
--- a/arch/arm/mach-s5pv210/Makefile.boot
+++ b/arch/arm/mach-s5pv210/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x20008000
+   zreladdr-y	+= 0x20008000
 params_phys-y	:= 0x20000100
diff --git a/arch/arm/mach-sa1100/Makefile.boot b/arch/arm/mach-sa1100/Makefile.boot
index a56ad04..5a616f6 100644
--- a/arch/arm/mach-sa1100/Makefile.boot
+++ b/arch/arm/mach-sa1100/Makefile.boot
@@ -1,6 +1,7 @@
-   zreladdr-y	:= 0xc0008000
 ifeq ($(CONFIG_ARCH_SA1100),y)
-   zreladdr-$(CONFIG_SA1111)		:= 0xc0208000
+   zreladdr-$(CONFIG_SA1111)		+= 0xc0208000
+else
+   zreladdr-y	+= 0xc0008000
 endif
 params_phys-y	:= 0xc0000100
 initrd_phys-y	:= 0xc0800000
diff --git a/arch/arm/mach-shark/Makefile.boot b/arch/arm/mach-shark/Makefile.boot
index 4320f8b..e40e24e 100644
--- a/arch/arm/mach-shark/Makefile.boot
+++ b/arch/arm/mach-shark/Makefile.boot
@@ -1,2 +1,2 @@
-   zreladdr-y	:= 0x08008000
+   zreladdr-y	+= 0x08008000
 
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
index 1c08ee9..498efd9 100644
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ b/arch/arm/mach-shmobile/Makefile.boot
@@ -1,7 +1,7 @@
 __ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
 		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
 
-   zreladdr-y   := $(__ZRELADDR)
+   zreladdr-y   += $(__ZRELADDR)
 
 # Unsupported legacy stuff
 #
diff --git a/arch/arm/mach-spear3xx/Makefile.boot b/arch/arm/mach-spear3xx/Makefile.boot
index 7a1f3c0..4674a4c 100644
--- a/arch/arm/mach-spear3xx/Makefile.boot
+++ b/arch/arm/mach-spear3xx/Makefile.boot
@@ -1,3 +1,3 @@
-zreladdr-y	:= 0x00008000
+zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-spear6xx/Makefile.boot b/arch/arm/mach-spear6xx/Makefile.boot
index 7a1f3c0..4674a4c 100644
--- a/arch/arm/mach-spear6xx/Makefile.boot
+++ b/arch/arm/mach-spear6xx/Makefile.boot
@@ -1,3 +1,3 @@
-zreladdr-y	:= 0x00008000
+zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
diff --git a/arch/arm/mach-tcc8k/Makefile.boot b/arch/arm/mach-tcc8k/Makefile.boot
index f135c9d..5e02d41 100644
--- a/arch/arm/mach-tcc8k/Makefile.boot
+++ b/arch/arm/mach-tcc8k/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y		:= 0x20008000
+   zreladdr-y		+= 0x20008000
 params_phys-y		:= 0x20000100
 initrd_phys-y		:= 0x20800000
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index 428ad12..5e870d2 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -1,4 +1,4 @@
-zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00008000
+zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	+= 0x00008000
 params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
 
diff --git a/arch/arm/mach-u300/Makefile.boot b/arch/arm/mach-u300/Makefile.boot
index 6fbfc6e..69357af 100644
--- a/arch/arm/mach-u300/Makefile.boot
+++ b/arch/arm/mach-u300/Makefile.boot
@@ -4,10 +4,10 @@
 #   INITRD_PHYS must be in RAM
 
 ifdef CONFIG_MACH_U300_SINGLE_RAM
-     zreladdr-y	:= 0x28E08000
+     zreladdr-y	+= 0x28E08000
   params_phys-y	:= 0x28E00100
 else
-     zreladdr-y	:= 0x48008000
+     zreladdr-y	+= 0x48008000
   params_phys-y	:= 0x48000100
 endif
 
diff --git a/arch/arm/mach-ux500/Makefile.boot b/arch/arm/mach-ux500/Makefile.boot
index c7e75ac..ff0a4b5 100644
--- a/arch/arm/mach-ux500/Makefile.boot
+++ b/arch/arm/mach-ux500/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-versatile/Makefile.boot b/arch/arm/mach-versatile/Makefile.boot
index c7e75ac..ff0a4b5 100644
--- a/arch/arm/mach-versatile/Makefile.boot
+++ b/arch/arm/mach-versatile/Makefile.boot
@@ -1,4 +1,4 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
 
diff --git a/arch/arm/mach-vexpress/Makefile.boot b/arch/arm/mach-vexpress/Makefile.boot
index 07c2d9c..8630b3d 100644
--- a/arch/arm/mach-vexpress/Makefile.boot
+++ b/arch/arm/mach-vexpress/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x60008000
+   zreladdr-y	+= 0x60008000
 params_phys-y	:= 0x60000100
 initrd_phys-y	:= 0x60800000
diff --git a/arch/arm/mach-vt8500/Makefile.boot b/arch/arm/mach-vt8500/Makefile.boot
index a8acc4e..b79c41c 100644
--- a/arch/arm/mach-vt8500/Makefile.boot
+++ b/arch/arm/mach-vt8500/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x01000000
diff --git a/arch/arm/mach-w90x900/Makefile.boot b/arch/arm/mach-w90x900/Makefile.boot
index a057b54..6c3d421 100644
--- a/arch/arm/mach-w90x900/Makefile.boot
+++ b/arch/arm/mach-w90x900/Makefile.boot
@@ -1,3 +1,3 @@
-zreladdr-y	:= 0x00008000
+zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 
diff --git a/arch/arm/mach-zynq/Makefile.boot b/arch/arm/mach-zynq/Makefile.boot
index 67039c3..760a0ef 100644
--- a/arch/arm/mach-zynq/Makefile.boot
+++ b/arch/arm/mach-zynq/Makefile.boot
@@ -1,3 +1,3 @@
-   zreladdr-y	:= 0x00008000
+   zreladdr-y	+= 0x00008000
 params_phys-y	:= 0x00000100
 initrd_phys-y	:= 0x00800000
-- 
1.7.5.4
