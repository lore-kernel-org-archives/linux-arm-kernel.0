From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 11 Apr 2018 15:55:01 +0200
Subject: [PATCH] gpio: zynq: Setup chip->base based on alias ID
Message-ID: <6ee982f8eb6e07f9ecbb0cc5093152f4a16b9c31.1523454899.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In past Xilinx gpio-zynq driver was setting up gpio chip->base as 0
which was chagned to autodetection when driver was upstreamed. Older
systems, which were using this old version, setup SW stack which expects
zynq gpio base as 0 and right now there is no way how to set this up.

The patch is adding an option to setup chip->base based on aliases which
is something what some other drivers are doing too.
It means when gpio0 alias is setup then chip->base is 0. When gpio alias
is not setup gpiochip_find_base() set it up properly which is current
behavior.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/gpio/gpio-zynq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 23bb10576def..412cb5f31a9b 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -831,7 +831,7 @@ static int zynq_gpio_probe(struct platform_device *pdev)
 	chip->free = zynq_gpio_free;
 	chip->direction_input = zynq_gpio_dir_in;
 	chip->direction_output = zynq_gpio_dir_out;
-	chip->base = -1;
+	chip->base = of_alias_get_id(pdev->dev.of_node, "gpio");
 	chip->ngpio = gpio->p_data->ngpio;
 
 	/* Retrieve GPIO clock */
-- 
2.17.0
