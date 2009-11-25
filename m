From: khw0178.kim@samsung.com (=?ks_c_5601-1987?B?sejH9r/1?=)
Date: Wed, 25 Nov 2009 13:52:29 +0900
Subject: [PATCH] VIC: add the Software priority masking code for PL192
Message-ID: <007801ca6d8b$17fae200$656c170c@dsn.sec.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch provide software priority masking 
for PL192 feature regarding S/W priority mask.

Signed-off-by: Hyunwoong Kim khw0178.kim at samsung.com
---
    arch/arm/common/vic.c                        |    15++-
    arch/arm/include/asm/hardware/vic.h    |    2+

diff -Nur --exclude=.git linux-2.6.29-samsung/arch/arm/common/vic.c 
pre-linux-2.6.29-samsung/arch/arm/common/vic.c
--- linux-2.6.29-samsung/arch/arm/common/vic.c  2009-11-25 13:36:04.672713977 +0900
+++ pre-linux-2.6.29-samsung/arch/arm/common/vic.c      2009-11-25 13:23:24.666816598 +0900
@@ -27,8 +27,21 @@

 static void vic_mask_irq(unsigned int irq)
 {
+       unsigned int prio_value;
+       unsigned int sw_prio;
        void __iomem *base = get_irq_chip_data(irq);
-       irq &= 31;
+       if(irq > 63){
+               irq &= 31;
+               prio_value = readl(base + VIC_PL192_DAISY_PRIO);
+               sw_prio = readl(base + VIC_PL192_SWPRIO_MASK);
+               writel(sw_prio >> (16-prio_value), base + VIC_PL192_SWPRIO_MASK);
+       }
+       else if(irq <= 63){
+               irq &= 31;
+               prio_value = readl(base + VIC_VECT_CNTL0 + (0x4 * irq));
+               sw_prio = readl(base + VIC_PL192_SWPRIO_MASK);
+               writel(sw_prio >> (16-prio_value), base + VIC_PL192_SWPRIO_MASK);
+       }
        writel(1 << irq, base + VIC_INT_ENABLE_CLEAR);
 }

@@ -36,6 +49,7 @@
 {
        void __iomem *base = get_irq_chip_data(irq);
        irq &= 31;
+       writel(0xFFFF, base + VIC_PL192_SWPRIO_MASK);
        writel(1 << irq, base + VIC_INT_ENABLE);
 }

diff -Nur --exclude=.git linux-2.6.29-samsung/arch/arm/include/asm/hardware/vic.h
 pre-linux-2.6.29-samsung/arch/arm/include/asm/hardware/vic.h
--- linux-2.6.29-samsung/arch/arm/include/asm/hardware/vic.h    2009-11-25 13:36:04.703713854 +0900
+++ pre-linux-2.6.29-samsung/arch/arm/include/asm/hardware/vic.h        2009-11-25 13:23:24.666816598 +0900
@@ -31,6 +31,8 @@
 #define VIC_PROTECT                    0x20
 #define VIC_PL190_VECT_ADDR            0x30    /* PL190 only */
 #define VIC_PL190_DEF_VECT_ADDR                0x34    /* PL190 only */
+#define VIC_PL192_SWPRIO_MASK          0x24
+#define VIC_PL192_DAISY_PRIO           0x28

 #define VIC_VECT_ADDR0                 0x100   /* 0 to 15 (0..31 PL192) */
 #define VIC_VECT_CNTL0                 0x200   /* 0 to 15 (0..31 PL192) */
~
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091125/91373478/attachment-0001.htm>
