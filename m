From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Sun, 26 Aug 2012 18:01:03 +0200
Subject: [PATCH 11/13] arch/arm/mach-at91/gpio.c: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1345996865-32082-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1345996865-32082-12-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Julia Lawall <Julia.Lawall@lip6.fr>

Clk_prepare_enable and clk_disable_unprepare combine clk_prepare and
clk_enable, and clk_disable and clk_unprepare.  They make the code more
concise, and ensure that clk_unprepare is called when clk_enable fails.

A simplified version of the semantic patch that introduces calls to these
functions is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression e;
@@

- clk_prepare(e);
- clk_enable(e);
+ clk_prepare_enable(e);

@@
expression e;
@@

- clk_disable(e);
- clk_unprepare(e);
+ clk_disable_unprepare(e);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 arch/arm/mach-at91/gpio.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
index be42cf0..7760f35 100644
--- a/arch/arm/mach-at91/gpio.c
+++ b/arch/arm/mach-at91/gpio.c
@@ -956,19 +956,14 @@ static int __init at91_gpio_setup_clk(int idx)
 		goto err;
 	}
 
-	if (clk_prepare(at91_gpio->clock))
-		goto clk_prep_err;
-
 	/* enable PIO controller's clock */
-	if (clk_enable(at91_gpio->clock)) {
+	if (clk_prepare_enable(at91_gpio->clock)) {
 		pr_err("at91_gpio.%d, failed to enable clock, ignoring.\n", idx);
-		goto clk_err;
+		goto clk_prep_err;
 	}
 
 	return 0;
 
-clk_err:
-	clk_unprepare(at91_gpio->clock);
 clk_prep_err:
 	clk_put(at91_gpio->clock);
 err:
