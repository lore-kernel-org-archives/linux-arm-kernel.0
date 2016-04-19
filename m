From: patrice.chotard@st.com (patrice.chotard at st.com)
Date: Tue, 19 Apr 2016 14:18:37 +0200
Subject: [PATCH 8/8] gpio: stmpe: configure GPIO as output by default
In-Reply-To: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
References: <1461068317-28016-1-git-send-email-patrice.chotard@st.com>
Message-ID: <1461068317-28016-9-git-send-email-patrice.chotard@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

Configures all GPIOs as output, in order to minimize power
consumption when GPIOs are unused.

Signed-off-by: Amelie DELAUNAY <amelie.delaunay@st.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/gpio/gpio-stmpe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-stmpe.c b/drivers/gpio/gpio-stmpe.c
index 45e5b92..80c6ae6 100644
--- a/drivers/gpio/gpio-stmpe.c
+++ b/drivers/gpio/gpio-stmpe.c
@@ -410,7 +410,7 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
 	struct stmpe *stmpe = dev_get_drvdata(pdev->dev.parent);
 	struct device_node *np = pdev->dev.of_node;
 	struct stmpe_gpio *stmpe_gpio;
-	int ret;
+	int ret, i;
 	int irq = 0;
 
 	irq = platform_get_irq(pdev, 0);
@@ -475,6 +475,10 @@ static int stmpe_gpio_probe(struct platform_device *pdev)
 					     NULL);
 	}
 
+	/* To minimize power consumption, configure unused GPIOs as outputs */
+	for (i = 0; i < stmpe_gpio->chip.ngpio; i++)
+		stmpe_gpio_direction_output(&stmpe_gpio->chip, i, 0);
+
 	platform_set_drvdata(pdev, stmpe_gpio);
 
 	return 0;
-- 
1.9.1
