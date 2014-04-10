From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Apr 2014 15:52:40 +0200
Subject: [PATCH v3 1/7] pinctrl: sunxi: check clk_prepare_enable return value
In-Reply-To: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1397137966-30818-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1397137966-30818-2-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Check the clk_prepare_enable return value to avoid false positive probe.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
---
 drivers/pinctrl/pinctrl-sunxi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-sunxi.c b/drivers/pinctrl/pinctrl-sunxi.c
index f9fabe9..2d9ca1c 100644
--- a/drivers/pinctrl/pinctrl-sunxi.c
+++ b/drivers/pinctrl/pinctrl-sunxi.c
@@ -884,7 +884,9 @@ static int sunxi_pinctrl_probe(struct platform_device *pdev)
 		goto gpiochip_error;
 	}
 
-	clk_prepare_enable(clk);
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto gpiochip_error;
 
 	pctl->irq = irq_of_parse_and_map(node, 0);
 	if (!pctl->irq) {
-- 
1.8.3.2
