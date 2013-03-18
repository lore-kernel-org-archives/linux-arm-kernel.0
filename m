From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:05:40 +0900
Subject: [PATCH 044/142] sh-pfc: Drop unused support for 1:1 physical to
 virtual memory mappings
In-Reply-To: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
References: <1363604838-29359-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1363604838-29359-45-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Now that all PFC platform devices provide memory resources support for
registers without an associated memory resource isn't used anymore. Drop
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/pinctrl/sh-pfc/core.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index e847d16..cadfb37 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -30,10 +30,8 @@ static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
 	struct resource *res;
 	int k;
 
-	if (pdev->num_resources == 0) {
-		pfc->num_windows = 0;
-		return 0;
-	}
+	if (pdev->num_resources == 0)
+		return -EINVAL;
 
 	pfc->window = devm_kzalloc(pfc->dev, pdev->num_resources *
 				   sizeof(*pfc->window), GFP_NOWAIT);
@@ -59,11 +57,11 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 					 unsigned long address)
 {
 	struct sh_pfc_window *window;
-	int k;
+	unsigned int i;
 
 	/* scan through physical windows and convert address */
-	for (k = 0; k < pfc->num_windows; k++) {
-		window = pfc->window + k;
+	for (i = 0; i < pfc->num_windows; i++) {
+		window = pfc->window + i;
 
 		if (address < window->phys)
 			continue;
@@ -74,8 +72,7 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 		return window->virt + (address - window->phys);
 	}
 
-	/* no windows defined, register must be 1:1 mapped virt:phys */
-	return (void __iomem *)address;
+	BUG();
 }
 
 struct sh_pfc_pin *sh_pfc_get_pin(struct sh_pfc *pfc, unsigned int pin)
-- 
1.7.10.4
