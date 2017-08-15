From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 14 Aug 2017 18:19:50 -0700
Subject: [PATCH 4.12 59/65] pinctrl: samsung: Remove bogus irq_[un]mask from
 resource management
In-Reply-To: <20170815011942.395714306@linuxfoundation.org>
References: <20170815011942.395714306@linuxfoundation.org>
Message-ID: <20170815011944.741233665@linuxfoundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

4.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 3fa53ec2ed885b0aec3f0472e3b4a8a6f1cd748c upstream.

The irq chip callbacks irq_request/release_resources() have absolutely no
business with masking and unmasking the irq.

The core code unmasks the interrupt after complete setup and masks it
before invoking irq_release_resources().

The unmask is actually harmful as it happens before the interrupt is
completely initialized in __setup_irq().

Remove it.

Fixes: f6a8249f9e55 ("pinctrl: exynos: Lock GPIOs as interrupts when used as EINTs")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-gpio at vger.kernel.org
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/samsung/pinctrl-exynos.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/pinctrl/samsung/pinctrl-exynos.c
+++ b/drivers/pinctrl/samsung/pinctrl-exynos.c
@@ -205,8 +205,6 @@ static int exynos_irq_request_resources(
 
 	spin_unlock_irqrestore(&bank->slock, flags);
 
-	exynos_irq_unmask(irqd);
-
 	return 0;
 }
 
@@ -226,8 +224,6 @@ static void exynos_irq_release_resources
 	shift = irqd->hwirq * bank_type->fld_width[PINCFG_TYPE_FUNC];
 	mask = (1 << bank_type->fld_width[PINCFG_TYPE_FUNC]) - 1;
 
-	exynos_irq_mask(irqd);
-
 	spin_lock_irqsave(&bank->slock, flags);
 
 	con = readl(bank->eint_base + reg_con);
