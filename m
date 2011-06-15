From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 15 Jun 2011 13:38:04 -0600
Subject: [PATCH 2/2] gpio/tegra: add devicetree support
In-Reply-To: <20110615193734.23641.8004.stgit@ponder>
References: <20110615193734.23641.8004.stgit@ponder>
Message-ID: <20110615193759.23641.26212.stgit@ponder>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for decoding gpios from the device tree

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 .../devicetree/bindings/gpio/gpio_nvidia.txt       |    7 +++++++
 drivers/gpio/gpio-tegra.c                          |   10 ++++++++++
 2 files changed, 17 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_nvidia.txt

diff --git a/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
new file mode 100644
index 0000000..afb3ff3
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio_nvidia.txt
@@ -0,0 +1,7 @@
+NVIDIA Tegra 2 GPIO controller
+
+Required properties:
+- compatible : "nvidia,tegra250-gpio"
+- #gpio-cells : Should be two. The first cell is the pin number and the
+  second cell is used to specify optional parameters (currently unused).
+- gpio-controller : Marks the device node as a GPIO controller.
diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
index 919d638..13afb88 100644
--- a/drivers/gpio/gpio-tegra.c
+++ b/drivers/gpio/gpio-tegra.c
@@ -23,6 +23,7 @@
 
 #include <linux/io.h>
 #include <linux/gpio.h>
+#include <linux/of.h>
 
 #include <asm/mach/irq.h>
 
@@ -340,6 +341,15 @@ static int __init tegra_gpio_init(void)
 		}
 	}
 
+#ifdef CONFIG_OF_GPIO
+	/*
+	 * This isn't ideal, but it gets things hooked up until this
+	 * driver is converted into a platform_device
+	 */
+	tegra_gpio_chip.of_node = of_find_compatible_node(NULL, NULL,
+						"nvidia,tegra250-gpio");
+#endif /* CONFIG_OF_GPIO */
+
 	gpiochip_add(&tegra_gpio_chip);
 
 	for (i = INT_GPIO_BASE; i < (INT_GPIO_BASE + TEGRA_NR_GPIOS); i++) {
