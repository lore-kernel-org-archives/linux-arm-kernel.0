From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 8 Nov 2012 13:40:54 +0000
Subject: [PATCH] ARM: VIC: remove unused irq_base variable
In-Reply-To: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
References: <1350392786-29191-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <201211081340.54440.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"ARM: VIC: use irq_domain_add_simple()" causes a new warning:

arch/arm/common/vic.c: In function 'vic_of_init':
arch/arm/common/vic.c:410:6: warning: unused variable 'irq_base' [-Wunused-variable]

Since the irq_base variable is not used any more, it should be
removed now

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

---
On Tuesday 16 October 2012, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> Instead of allocating descriptors on-the-fly for the device tree
> initialization case, use irq_domain_add_simple() which will take
> care of this if you pass negative as the first_irq.
> 
> Alter the signature of __vic_init() to pass the first_irq as
> signed so this works as expected.
> 
> Switching the VIC to use irq_domain_add_simple() also has the
> upside of displaying the same WARNING when you boot with
> pre-allocated descriptors on systems using SPARSE_IRQ but
> yet not using device tree.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index 4fd5d98..e4df17c 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -407,7 +407,6 @@ void __init vic_init(void __iomem *base, unsigned int irq_start,
 int __init vic_of_init(struct device_node *node, struct device_node *parent)
 {
 	void __iomem *regs;
-	int irq_base;
 
 	if (WARN(parent, "non-root VICs are not supported"))
 		return -EINVAL;
