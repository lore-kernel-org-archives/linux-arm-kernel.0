From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:31 -0700
Subject: [PATCH 05/15] pinctrl: sunxi: Switch to devm_ioremap_resource
In-Reply-To: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1398711701-11309-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous code was calling of_iomap, which doesn't do any resource
management, and doesn't call request_mem_region either. Use
devm_ioremap_resource that do both.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 5e6a7022c3be..763a896f0eff 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -794,6 +794,7 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 	struct pinctrl_pin_desc *pins;
 	struct sunxi_pinctrl *pctl;
 	struct reset_control *rstc;
+	struct resource *res;
 	int i, ret, last_pin;
 	struct clk *clk;
 
@@ -804,9 +805,10 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 
 	spin_lock_init(&pctl->lock);
 
-	pctl->membase = of_iomap(node, 0);
-	if (!pctl->membase)
-		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	pctl->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(pctl->membase))
+		return PTR_ERR(pctl->membase);
 
 	device = of_match_device(sunxi_pinctrl_match, &pdev->dev);
 	if (!device)
-- 
1.9.1
