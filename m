From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 2 Feb 2010 01:32:58 +0800
Subject: [PATCH 4/4] mmp2: append board irq events
In-Reply-To: <771cded01001250304m6885189ejd1cc1ce3b339e7d2@mail.gmail.com>
References: <771cded01001250304m6885189ejd1cc1ce3b339e7d2@mail.gmail.com>
Message-ID: <f17812d71002010932m6c2c1467s16cec746e439718d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 7:04 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 9e4af800fe09dbcd6423843ad617e20821885b2a Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Mon, 25 Jan 2010 05:22:09 -0500
> Subject: [PATCH] mmp2: append board irq events
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

I'd prefer this to be separated into two as follows, the board IRQ
stuff, I'd like to keep it simple and aligned with the mach-pxa/ is
doing so to ease the future movement to dynamic IRQ maybe.

commit e039ba833de953cb32d1b80063aa425fdc6a3ca0
Author: Haojian Zhuang <haojian.zhuang@marvell.com>
Date:   Thu Jan 28 12:27:36 2010 +0800

    [ARM] mmp2: add missing ICU register definitions

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

diff --git a/arch/arm/mach-mmp/include/mach/regs-icu.h
b/arch/arm/mach-mmp/include/mach/regs-icu.h
index 02b8bf8..f882d91 100644
--- a/arch/arm/mach-mmp/include/mach/regs-icu.h
+++ b/arch/arm/mach-mmp/include/mach/regs-icu.h
@@ -40,6 +40,11 @@
 #define ICU_INT_ROUTE_PJ4_IRQ		(1 << 5)
 #define ICU_INT_ROUTE_PJ4_FIQ		(1 << 6)

+#define MMP2_ICU_PJ4_IRQ_STATUS0	ICU_REG(0x138)
+#define MMP2_ICU_PJ4_IRQ_STATUS1	ICU_REG(0x13c)
+#define MMP2_ICU_PJ4_FIQ_STATUS0	ICU_REG(0x140)
+#define MMP2_ICU_PJ4_FIQ_STATUS1	ICU_REG(0x144)
+
 #define MMP2_ICU_INT4_STATUS		ICU_REG(0x150)
 #define MMP2_ICU_INT5_STATUS		ICU_REG(0x154)
 #define MMP2_ICU_INT17_STATUS		ICU_REG(0x158)
@@ -56,4 +61,11 @@
 #define MMP2_ICU_PJ4_IRQ_SEL		ICU_REG(0x104)
 #define MMP2_ICU_PJ4_FIQ_SEL		ICU_REG(0x108)

+#define MMP2_ICU_INVERT			ICU_REG(0x164)
+
+#define MMP2_ICU_INV_PMIC		(1 << 0)
+#define MMP2_ICU_INV_PERF		(1 << 1)
+#define MMP2_ICU_INV_COMMTX		(1 << 2)
+#define MMP2_ICU_INV_COMMRX		(1 << 3)
+
 #endif /* __ASM_MACH_ICU_H */

And

commit 807e69408bdf82190e4e551a9580d911ea7452dd
Author: Haojian Zhuang <haojian.zhuang@marvell.com>
Date:   Thu Jan 28 12:34:59 2010 +0800

    [ARM] mmp2: add support for board IRQs

    Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

diff --git a/arch/arm/mach-mmp/include/mach/irqs.h
b/arch/arm/mach-mmp/include/mach/irqs.h
index f907cc9..0270119 100644
--- a/arch/arm/mach-mmp/include/mach/irqs.h
+++ b/arch/arm/mach-mmp/include/mach/irqs.h
@@ -222,6 +222,10 @@
 #define IRQ_GPIO_NUM			192
 #define IRQ_GPIO(x)			(IRQ_GPIO_START + (x))

-#define NR_IRQS		(IRQ_GPIO_START + IRQ_GPIO_NUM)
+/* Board IRQ - 64 by default, increase if not enough */
+#define IRQ_BOARD_START			(IRQ_GPIO_START + IRQ_GPIO_NUM)
+#define IRQ_BOARD_END			(IRQ_BOARD_START + 64)
+
+#define NR_IRQS				(IRQ_BOARD_END)

 #endif /* __ASM_MACH_IRQS_H */
