From: khilman@ti.com (Kevin Hilman)
Date: Mon, 12 Mar 2012 15:09:54 -0700
Subject: [PATCH v3 13/13] gpio/omap: fix incorrect update to
 context.irqenable1
In-Reply-To: <1331118963-26364-14-git-send-email-tarun.kanti@ti.com> (Tarun
 Kanti DebBarma's message of "Wed, 7 Mar 2012 16:46:03 +0530")
References: <1331118963-26364-1-git-send-email-tarun.kanti@ti.com>
 <1331118963-26364-14-git-send-email-tarun.kanti@ti.com>
Message-ID: <87haxtwjwt.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> In _enable_gpio_irqbank() when bank->regs->set_irqenable is valid,
> gpio_mask can be directly set by writing to set_irqenable register
> without overwriting current value. 

Ouch.  Nice catch.

> In order to ensure the same is
> stored in context.irqenable1, we must read from regs->irqenable
> instead of overwriting it with gpio_mask.
> The overwriting makes sense only in the second case where irqenable
> is explicitly read and updated with new gpio_mask before writing it
> back. However, for consistency reading regs->irqenable into the
> bank->context.irqenable1 takes care of both the scenarios.

...takes care of both scenarios, but adds and extra duplicate read for
the second.

Instead, how about just move the context update into each side of the
if/else?  untested patch below to show what I mean.

Kevin


diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index 752ae9b..f8b7099 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -442,6 +442,7 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (bank->regs->set_irqenable) {
 		reg += bank->regs->set_irqenable;
 		l = gpio_mask;
+		bank->context.irqenable1 |= gpio_mask;
 	} else {
 		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
@@ -449,10 +450,10 @@ static void _enable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 			l &= ~gpio_mask;
 		else
 			l |= gpio_mask;
+		bank->context.irqenable1 = l;
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
 }
 
 static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
@@ -463,6 +464,7 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 	if (bank->regs->clr_irqenable) {
 		reg += bank->regs->clr_irqenable;
 		l = gpio_mask;
+		bank->context.irqenable1 &= ~gpio_mask;
 	} else {
 		reg += bank->regs->irqenable;
 		l = __raw_readl(reg);
@@ -470,10 +472,10 @@ static void _disable_gpio_irqbank(struct gpio_bank *bank, int gpio_mask)
 			l |= gpio_mask;
 		else
 			l &= ~gpio_mask;
+		bank->context.irqenable1 = l;
 	}
 
 	__raw_writel(l, reg);
-	bank->context.irqenable1 = l;
 }
 
 static inline void _set_gpio_irqenable(struct gpio_bank *bank, int gpio, int enable)
