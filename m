From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Dec 2012 19:45:24 +0100
Subject: [PATCH] ARM: VIC: use irq_domain_add_simple()
In-Reply-To: <CACxGe6tBLfj3CDDZAfGmznj3B-h4OfJsrRc+85w9fnxFH6Cd_Q@mail.gmail.com>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
 <507D61E7.2080704@gmail.com>
 <CACxGe6tBLfj3CDDZAfGmznj3B-h4OfJsrRc+85w9fnxFH6Cd_Q@mail.gmail.com>
Message-ID: <CACRpkdbtn4Pz3uLCxDGOBSVW7vfLECf2UZkT5+X9ip1ZZFb8Lw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 12:34 AM, Grant Likely
<grant.likely@secretlab.ca> wrote:

> It looks to me like the below patch breaks versatile because it makes
> it try to register a linear irq_domain instead of the legacy one that
> it needs. Here are the relevant commits:
>
> 07c9249f1: "ARM: 7554/1: VIC: use irq_domain_add_simple()"
> 946c59a08: "ARM: vic: fix build warning caused by previous commit"
>
> I'm working on getting it properly sorted out (and more importantly
> *simplified*), but in the mean time I think the above two commits need
> to be reverted. Reverting them on my tree fixes booting for me.

Isn't that a bit violent, can't we just fix the real bug?

Does the below patch work for you, it does two things:

1) Bump all Versatile IRQs to offset at 32, because it is using
  IRQ 0 which is NO_IRQ and illegal anyway so it's anyway
  a bug that should be fixed.

2) Make sure we call irq_create_mapping() if the start IRQ is
  anyway 0, as in the device tree case, and make sure to
  actually pass zero in that case.

The initial patch set used negative IRQ as an indicator that
the linear domain should be used and not descriptors
allocated, but as that require changing a lot of singatures
to signed int and since IRQ 0 is now illegal anyway, I
let zero signify linear. Sorry for leftover mistakes like this...

I'll mail them out as separate patches too, and submit to
Russell's tracker if they fix the problem.

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index e4df17c..8f324b9 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -206,6 +206,7 @@ static void __init vic_register(void __iomem
*base, unsigned int irq,
 				struct device_node *node)
 {
 	struct vic_device *v;
+	int i;

 	if (vic_id >= ARRAY_SIZE(vic_devices)) {
 		printk(KERN_ERR "%s: too few VICs, increase CONFIG_ARM_VIC_NR\n", __func__);
@@ -220,6 +221,10 @@ static void __init vic_register(void __iomem
*base, unsigned int irq,
 	vic_id++;
 	v->domain = irq_domain_add_simple(node, fls(valid_sources), irq,
 					  &vic_irqdomain_ops, v);
+	/* create an IRQ mapping for each valid IRQ */
+	for (i = 0; i < fls(valid_sources); i++)
+		if (valid_sources & (1 << i))
+			irq_create_mapping(v->domain, i);
 }

 static void vic_ack_irq(struct irq_data *d)
@@ -416,9 +421,9 @@ int __init vic_of_init(struct device_node *node,
struct device_node *parent)
 		return -EIO;

 	/*
-	 * Passing -1 as first IRQ makes the simple domain allocate descriptors
+	 * Passing 0 as first IRQ makes the simple domain allocate descriptors
 	 */
-	__vic_init(regs, -1, ~0, ~0, node);
+	__vic_init(regs, 0, ~0, ~0, node);

 	return 0;
 }
diff --git a/arch/arm/mach-versatile/include/mach/irqs.h
b/arch/arm/mach-versatile/include/mach/irqs.h
index bf44c61..0fd771c 100644
--- a/arch/arm/mach-versatile/include/mach/irqs.h
+++ b/arch/arm/mach-versatile/include/mach/irqs.h
@@ -25,7 +25,7 @@
  *  IRQ interrupts definitions are the same as the INT definitions
  *  held within platform.h
  */
-#define IRQ_VIC_START		0
+#define IRQ_VIC_START		32
 #define IRQ_WDOGINT		(IRQ_VIC_START + INT_WDOGINT)
 #define IRQ_SOFTINT		(IRQ_VIC_START + INT_SOFTINT)
 #define IRQ_COMMRx		(IRQ_VIC_START + INT_COMMRx)
@@ -100,7 +100,7 @@
 /*
  * Secondary interrupt controller
  */
-#define IRQ_SIC_START		32
+#define IRQ_SIC_START		64
 #define IRQ_SIC_MMCI0B 		(IRQ_SIC_START + SIC_INT_MMCI0B)
 #define IRQ_SIC_MMCI1B 		(IRQ_SIC_START + SIC_INT_MMCI1B)
 #define IRQ_SIC_KMI0		(IRQ_SIC_START + SIC_INT_KMI0)
@@ -120,7 +120,7 @@
 #define IRQ_SIC_PCI1		(IRQ_SIC_START + SIC_INT_PCI1)
 #define IRQ_SIC_PCI2		(IRQ_SIC_START + SIC_INT_PCI2)
 #define IRQ_SIC_PCI3		(IRQ_SIC_START + SIC_INT_PCI3)
-#define IRQ_SIC_END		63
+#define IRQ_SIC_END		95

 #define IRQ_GPIO0_START		(IRQ_SIC_END + 1)
 #define IRQ_GPIO0_END		(IRQ_GPIO0_START + 31)


Yours,
Linus Walleij
