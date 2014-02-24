From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Feb 2014 11:17:48 +0100
Subject: [GIT PULL] integrator base patches for v3.15
In-Reply-To: <CACRpkdYeaMqTNUTqBSg6vNa9=VucjpFFkx3diHJJNgZTg+iq1w@mail.gmail.com>
References: <CACRpkdYeaMqTNUTqBSg6vNa9=VucjpFFkx3diHJJNgZTg+iq1w@mail.gmail.com>
Message-ID: <201402241117.48617.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 13 February 2014, Linus Walleij wrote:
>       irqchip: vic: update the base IRQ member correctly
>       irqchip: support cascaded VICs
>       ARM: integrator: register the IM-PD1 VIC

I got a randconfig build error for CONFIG_IMPD1=m. Ok to apply this
fix on top?

8<---

irqchip: VIC: export vic_init_cascaded

vic_init_cascaded is called by integrator impd1 code that can
be a loadable module, so the function has to be exported.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/irqchip/irq-vic.c b/drivers/irqchip/irq-vic.c
index 6002942..fd2c980 100644
--- a/drivers/irqchip/irq-vic.c
+++ b/drivers/irqchip/irq-vic.c
@@ -509,6 +509,7 @@ int __init vic_init_cascaded(void __iomem *base, unsigned int parent_irq,
 	/* Return out acquired base */
 	return v->irq;
 }
+EXPORT_SYMBOL_GPL(vic_init_cascaded);
 
 #ifdef CONFIG_OF
 int __init vic_of_init(struct device_node *node, struct device_node *parent)
