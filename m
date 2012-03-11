From: robherring2@gmail.com (Rob Herring)
Date: Sun, 11 Mar 2012 16:08:19 -0500
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
Message-ID: <1331500100-31351-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Several platforms create IOMEM defines for casting to 'void __iomem *',
and other platforms are incorrectly using __io() macro for the same
purpose. This creates a common definition and removes all the platform
specific versions. Rather than try to make linux/io.h and asm/io.h
assembly safe, the assembly version of IOMEM is moved into
asm/assembler.h.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Sekhar Nori <nsekhar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
Cc: David Brown <davidb@codeaurora.org>
Cc: Daniel Walker <dwalker@fifo99.com>
Cc: Bryan Huntsman <bryanh@codeaurora.org>
Cc: Sascha Hauer <kernel@pengutronix.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: Colin Cross <ccross@android.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Stephen Warren <swarren@nvidia.com>
Cc: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/include/asm/assembler.h                |    2 ++
 arch/arm/include/asm/io.h                       |    2 ++
 arch/arm/kernel/debug.S                         |    1 +
 arch/arm/kernel/entry-armv.S                    |    1 +
 arch/arm/mach-davinci/include/mach/hardware.h   |    6 ------
 arch/arm/mach-davinci/include/mach/uncompress.h |    2 ++
 arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h |    9 ---------
 arch/arm/mach-mmp/include/mach/addr-map.h       |    6 ------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    6 ------
 arch/arm/mach-msm/include/mach/msm_iomap.h      |    6 ------
 arch/arm/mach-mxs/include/mach/hardware.h       |    6 ------
 arch/arm/mach-omap1/ams-delta-fiq-handler.S     |    1 +
 arch/arm/mach-omap1/iomap.h                     |    6 ------
 arch/arm/mach-omap2/clock3xxx_data.c            |    1 +
 arch/arm/mach-omap2/clock44xx_data.c            |    1 +
 arch/arm/mach-omap2/iomap.h                     |    6 ------
 arch/arm/mach-rpc/include/mach/hardware.h       |    6 ------
 arch/arm/mach-spear3xx/clock.c                  |    1 +
 arch/arm/mach-spear6xx/clock.c                  |    1 +
 arch/arm/mach-tegra/include/mach/iomap.h        |    6 ------
 arch/arm/mach-u300/include/mach/u300-regs.h     |    6 ------
 arch/arm/plat-mxc/include/mach/hardware.h       |    6 ------
 arch/arm/plat-omap/include/plat/hardware.h      |    6 ------
 arch/arm/plat-omap/include/plat/usb.h           |    1 -
 arch/arm/plat-spear/include/plat/hardware.h     |    6 ------
 25 files changed, 13 insertions(+), 88 deletions(-)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 62f8095..88374dd 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -23,6 +23,8 @@
 #include <asm/ptrace.h>
 #include <asm/domain.h>
 
+#define IOMEM(x)	(x)
+
 /*
  * Endian independent macros for shifting bytes within registers.
  */
diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index 11d2072..35d9140 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -102,6 +102,8 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
 	return (void __iomem *)addr;
 }
 
+#define IOMEM(x)	((void __force __iomem *)(x))
+
 /* IO barriers */
 #ifdef CONFIG_ARM_DMA_MEM_BUFFERABLE
 #define __iormb()		rmb()
diff --git a/arch/arm/kernel/debug.S b/arch/arm/kernel/debug.S
index 204e216..501cdbf 100644
--- a/arch/arm/kernel/debug.S
+++ b/arch/arm/kernel/debug.S
@@ -10,6 +10,7 @@
  *  32-bit debugging code
  */
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 		.text
 
diff --git a/arch/arm/kernel/entry-armv.S b/arch/arm/kernel/entry-armv.S
index 22f0ed3..395f627 100644
--- a/arch/arm/kernel/entry-armv.S
+++ b/arch/arm/kernel/entry-armv.S
@@ -15,6 +15,7 @@
  *  that causes it to save wrong values...  Be aware!
  */
 
+#include <asm/assembler.h>
 #include <asm/memory.h>
 #include <asm/glue-df.h>
 #include <asm/glue-pf.h>
diff --git a/arch/arm/mach-davinci/include/mach/hardware.h b/arch/arm/mach-davinci/include/mach/hardware.h
index 414e0b9..0be260b 100644
--- a/arch/arm/mach-davinci/include/mach/hardware.h
+++ b/arch/arm/mach-davinci/include/mach/hardware.h
@@ -32,10 +32,4 @@
 #define __IO_ADDRESS(x)			((x) + IO_OFFSET)
 #define IO_ADDRESS(pa)			IOMEM(__IO_ADDRESS(pa))
 
-#ifdef __ASSEMBLER__
-#define IOMEM(x)                	x
-#else
-#define IOMEM(x)                	((void __force __iomem *)(x))
-#endif
-
 #endif /* __ASM_ARCH_HARDWARE_H */
diff --git a/arch/arm/mach-davinci/include/mach/uncompress.h b/arch/arm/mach-davinci/include/mach/uncompress.h
index 9dc7cf9..da2fb2c 100644
--- a/arch/arm/mach-davinci/include/mach/uncompress.h
+++ b/arch/arm/mach-davinci/include/mach/uncompress.h
@@ -25,6 +25,8 @@
 
 #include <mach/serial.h>
 
+#define IOMEM(x)	((void __force __iomem *)(x))
+
 u32 *uart;
 
 /* PORT_16C550A, in polled non-fifo mode */
diff --git a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
index e711d0e..c4a7b84 100644
--- a/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
+++ b/arch/arm/mach-ep93xx/include/mach/ep93xx-regs.h
@@ -6,15 +6,6 @@
 #define __ASM_ARCH_EP93XX_REGS_H
 
 /*
- * A typesafe __io() variation for variable initialisers
- */
-#ifdef __ASSEMBLER__
-#define IOMEM(p)                p
-#else
-#define IOMEM(p)                ((void __iomem __force *)(p))
-#endif
-
-/*
  * EP93xx Physical Memory Map:
  *
  * The ASDO pin is sampled at system reset to select a synchronous or
diff --git a/arch/arm/mach-mmp/include/mach/addr-map.h b/arch/arm/mach-mmp/include/mach/addr-map.h
index 3e404ac..b1ece08 100644
--- a/arch/arm/mach-mmp/include/mach/addr-map.h
+++ b/arch/arm/mach-mmp/include/mach/addr-map.h
@@ -11,12 +11,6 @@
 #ifndef __ASM_MACH_ADDR_MAP_H
 #define __ASM_MACH_ADDR_MAP_H
 
-#ifndef __ASSEMBLER__
-#define IOMEM(x)	((void __iomem *)(x))
-#else
-#define IOMEM(x)	(x)
-#endif
-
 /* APB - Application Subsystem Peripheral Bus
  *
  * NOTE: the DMA controller registers are actually on the AXI fabric #1
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
index 152b3b7..6c4046c 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap-7x00.h
@@ -38,12 +38,6 @@
  *
  */
 
-#ifdef __ASSEMBLY__
-#define IOMEM(x)	x
-#else
-#define IOMEM(x)	((void __force __iomem *)(x))
-#endif
-
 #define MSM_VIC_BASE          IOMEM(0xE0000000)
 #define MSM_VIC_PHYS          0xC0000000
 #define MSM_VIC_SIZE          SZ_4K
diff --git a/arch/arm/mach-msm/include/mach/msm_iomap.h b/arch/arm/mach-msm/include/mach/msm_iomap.h
index 90682f4..00afdfb 100644
--- a/arch/arm/mach-msm/include/mach/msm_iomap.h
+++ b/arch/arm/mach-msm/include/mach/msm_iomap.h
@@ -37,12 +37,6 @@
  *
  */
 
-#ifdef __ASSEMBLY__
-#define IOMEM(x)	x
-#else
-#define IOMEM(x)	((void __force __iomem *)(x))
-#endif
-
 #if defined(CONFIG_ARCH_MSM7X30)
 #include "msm_iomap-7x30.h"
 #elif defined(CONFIG_ARCH_QSD8X50)
diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
index 53e89a0..4c0e8a6 100644
--- a/arch/arm/mach-mxs/include/mach/hardware.h
+++ b/arch/arm/mach-mxs/include/mach/hardware.h
@@ -20,10 +20,4 @@
 #ifndef __MACH_MXS_HARDWARE_H__
 #define __MACH_MXS_HARDWARE_H__
 
-#ifdef __ASSEMBLER__
-#define IOMEM(addr)	(addr)
-#else
-#define IOMEM(addr)	((void __force __iomem *)(addr))
-#endif
-
 #endif /* __MACH_MXS_HARDWARE_H__ */
diff --git a/arch/arm/mach-omap1/ams-delta-fiq-handler.S b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
index 399c4c4..a051cb8 100644
--- a/arch/arm/mach-omap1/ams-delta-fiq-handler.S
+++ b/arch/arm/mach-omap1/ams-delta-fiq-handler.S
@@ -14,6 +14,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 #include <plat/board-ams-delta.h>
 
diff --git a/arch/arm/mach-omap1/iomap.h b/arch/arm/mach-omap1/iomap.h
index d681757..330c471 100644
--- a/arch/arm/mach-omap1/iomap.h
+++ b/arch/arm/mach-omap1/iomap.h
@@ -22,12 +22,6 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
-#endif
-
 #define OMAP1_IO_OFFSET		0x01000000	/* Virtual IO = 0xfefb0000 */
 #define OMAP1_IO_ADDRESS(pa)	IOMEM((pa) - OMAP1_IO_OFFSET)
 
diff --git a/arch/arm/mach-omap2/clock3xxx_data.c b/arch/arm/mach-omap2/clock3xxx_data.c
index 981b9f9..480fb8f 100644
--- a/arch/arm/mach-omap2/clock3xxx_data.c
+++ b/arch/arm/mach-omap2/clock3xxx_data.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/clk.h>
 #include <linux/list.h>
+#include <linux/io.h>
 
 #include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 79b98f2..c03c110 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -26,6 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/clk.h>
+#include <linux/io.h>
 
 #include <plat/hardware.h>
 #include <plat/clkdev_omap.h>
diff --git a/arch/arm/mach-omap2/iomap.h b/arch/arm/mach-omap2/iomap.h
index e6f9581..0812b15 100644
--- a/arch/arm/mach-omap2/iomap.h
+++ b/arch/arm/mach-omap2/iomap.h
@@ -22,12 +22,6 @@
  * 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
-#endif
-
 #define OMAP2_L3_IO_OFFSET	0x90000000
 #define OMAP2_L3_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L3_IO_OFFSET) /* L3 */
 
diff --git a/arch/arm/mach-rpc/include/mach/hardware.h b/arch/arm/mach-rpc/include/mach/hardware.h
index 050d63c..257166b 100644
--- a/arch/arm/mach-rpc/include/mach/hardware.h
+++ b/arch/arm/mach-rpc/include/mach/hardware.h
@@ -14,12 +14,6 @@
 
 #include <mach/memory.h>
 
-#ifndef __ASSEMBLY__
-#define IOMEM(x) ((void __iomem *)(unsigned long)(x))
-#else
-#define IOMEM(x) x
-#endif /* __ASSEMBLY__ */
-
 /*
  * What hardware must be present
  */
diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
index f67860c..6c4841f 100644
--- a/arch/arm/mach-spear3xx/clock.c
+++ b/arch/arm/mach-spear3xx/clock.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <asm/mach-types.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-spear6xx/clock.c b/arch/arm/mach-spear6xx/clock.c
index ac70e0d..9281cf8 100644
--- a/arch/arm/mach-spear6xx/clock.c
+++ b/arch/arm/mach-spear6xx/clock.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <plat/clock.h>
 #include <mach/misc_regs.h>
diff --git a/arch/arm/mach-tegra/include/mach/iomap.h b/arch/arm/mach-tegra/include/mach/iomap.h
index 082b4d1..c05b311 100644
--- a/arch/arm/mach-tegra/include/mach/iomap.h
+++ b/arch/arm/mach-tegra/include/mach/iomap.h
@@ -281,12 +281,6 @@
  *
  */
 
-#ifdef __ASSEMBLY__
-#define IOMEM(x)	(x)
-#else
-#define IOMEM(x)	((void __force __iomem *)(x))
-#endif
-
 #define IO_IRAM_PHYS	0x40000000
 #define IO_IRAM_VIRT	IOMEM(0xFE400000)
 #define IO_IRAM_SIZE	SZ_256K
diff --git a/arch/arm/mach-u300/include/mach/u300-regs.h b/arch/arm/mach-u300/include/mach/u300-regs.h
index 035fdc9..7b7cba9 100644
--- a/arch/arm/mach-u300/include/mach/u300-regs.h
+++ b/arch/arm/mach-u300/include/mach/u300-regs.h
@@ -18,12 +18,6 @@
  * the defines are used for setting up the I/O memory mapping.
  */
 
-#ifdef __ASSEMBLER__
-#define IOMEM(a) (a)
-#else
-#define IOMEM(a) (void __iomem *) a
-#endif
-
 /* NAND Flash CS0 */
 #define U300_NAND_CS0_PHYS_BASE		0x80000000
 
diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index ca06a68..0630513 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -22,12 +22,6 @@
 
 #include <asm/sizes.h>
 
-#ifdef __ASSEMBLER__
-#define IOMEM(addr)	(addr)
-#else
-#define IOMEM(addr)	((void __force __iomem *)(addr))
-#endif
-
 #define addr_in_module(addr, mod) \
 	((unsigned long)(addr) - mod ## _BASE_ADDR < mod ## _SIZE)
 
diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
index 537b05a..e897978 100644
--- a/arch/arm/plat-omap/include/plat/hardware.h
+++ b/arch/arm/plat-omap/include/plat/hardware.h
@@ -43,12 +43,6 @@
 #endif
 #include <plat/serial.h>
 
-#ifdef __ASSEMBLER__
-#define IOMEM(x)		(x)
-#else
-#define IOMEM(x)		((void __force __iomem *)(x))
-#endif
-
 /*
  * ---------------------------------------------------------------------------
  * Common definitions for all OMAP processors
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index d0fc9f4..762eeb0 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -112,7 +112,6 @@ extern int omap4430_phy_suspend(struct device *dev, int suspend);
  */
 
 #define OMAP2_L4_IO_OFFSET	0xb2000000
-#define IOMEM(x)		((void __force __iomem *)(x))
 #define OMAP2_L4_IO_ADDRESS(pa)	IOMEM((pa) + OMAP2_L4_IO_OFFSET)
 
 static inline u8 omap_readb(u32 pa)
diff --git a/arch/arm/plat-spear/include/plat/hardware.h b/arch/arm/plat-spear/include/plat/hardware.h
index 66d6772..70187d7 100644
--- a/arch/arm/plat-spear/include/plat/hardware.h
+++ b/arch/arm/plat-spear/include/plat/hardware.h
@@ -14,10 +14,4 @@
 #ifndef __PLAT_HARDWARE_H
 #define __PLAT_HARDWARE_H
 
-#ifndef __ASSEMBLY__
-#define IOMEM(x)	((void __iomem __force *)(x))
-#else
-#define IOMEM(x)	(x)
-#endif
-
 #endif /* __PLAT_HARDWARE_H */
-- 
1.7.5.4
