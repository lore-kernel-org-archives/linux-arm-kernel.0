From: linux@roeck-us.net (Guenter Roeck)
Date: Wed, 18 Jan 2017 09:46:44 -0800
Subject: [PATCH 23/33] Input: xilinx_ps2 - Use 'dev' instead of dereferencing
 it and other changes
In-Reply-To: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
Message-ID: <1484761614-12225-24-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use local variable 'dev' instead of dereferencing it several times.

This conversion was done automatically with coccinelle using the
following semantic patches. The semantic patches and the scripts
used to generate this commit log are available at
https://github.com/groeck/coccinelle-patches

- Use local variable 'struct device *dev' consistently

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/input/serio/xilinx_ps2.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/input/serio/xilinx_ps2.c b/drivers/input/serio/xilinx_ps2.c
index 5223cbf94262..14c40892ed82 100644
--- a/drivers/input/serio/xilinx_ps2.c
+++ b/drivers/input/serio/xilinx_ps2.c
@@ -243,18 +243,17 @@ static int xps2_of_probe(struct platform_device *ofdev)
 	unsigned int irq;
 	int error;
 
-	dev_info(dev, "Device Tree Probing \'%s\'\n",
-			ofdev->dev.of_node->name);
+	dev_info(dev, "Device Tree Probing \'%s\'\n", dev->of_node->name);
 
 	/* Get iospace for the device */
-	error = of_address_to_resource(ofdev->dev.of_node, 0, &r_mem);
+	error = of_address_to_resource(dev->of_node, 0, &r_mem);
 	if (error) {
 		dev_err(dev, "invalid address\n");
 		return error;
 	}
 
 	/* Get IRQ for the device */
-	irq = irq_of_parse_and_map(ofdev->dev.of_node, 0);
+	irq = irq_of_parse_and_map(dev->of_node, 0);
 	if (!irq) {
 		dev_err(dev, "no IRQ found\n");
 		return -ENODEV;
-- 
2.7.4
