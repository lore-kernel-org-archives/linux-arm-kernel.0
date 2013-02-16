From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Feb 2013 19:24:08 -0200
Subject: [PATCH] gpio: gpiolib: Remove WARN reference
Message-ID: <1361049848-14977-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 372e722ea4d (gpiolib: use descriptors internally) the following 
warning is seen on a mx28evk board:

[    5.116291] ------------[ cut here ]------------
[    5.121306] WARNING: at drivers/gpio/gpiolib.c:125 gpio_to_desc+0x30/0x44()
[    5.128491] invalid GPIO -2
[    5.131563] Modules linked in:
[    5.134846] [<c0014e20>] (unwind_backtrace+0x0/0xf4) from [<c001d428>] (warn_slowpath_common+0x4c/0x68)
[    5.144682] [<c001d428>] (warn_slowpath_common+0x4c/0x68) from [<c001d4d8>] (warn_slowpath_fmt+0x30/0x40)
[    5.154693] [<c001d4d8>] (warn_slowpath_fmt+0x30/0x40) from [<c0283434>] (gpio_to_desc+0x30/0x44)
[    5.164002] [<c0283434>] (gpio_to_desc+0x30/0x44) from [<c0285470>] (gpio_request_one+0x10/0xe8)
[    5.173294] [<c0285470>] (gpio_request_one+0x10/0xe8) from [<c0282f50>] (devm_gpio_request_one+0x40/0x74)
[    5.183332] [<c0282f50>] (devm_gpio_request_one+0x40/0x74) from [<c0319be0>] (fec_probe+0x2d0/0x99c)
[    5.192923] [<c0319be0>] (fec_probe+0x2d0/0x99c) from [<c02c8114>] (platform_drv_probe+0x14/0x18)
[    5.202228] [<c02c8114>] (platform_drv_probe+0x14/0x18) from [<c02c6e00>] (driver_probe_device+0x90/0x224)
[    5.212332] [<c02c6e00>] (driver_probe_device+0x90/0x224) from [<c02c7028>] (__driver_attach+0x94/0x98)
[    5.222162] [<c02c7028>] (__driver_attach+0x94/0x98) from [<c02c5750>] (bus_for_each_dev+0x78/0x98)
[    5.231642] [<c02c5750>] (bus_for_each_dev+0x78/0x98) from [<c02c5fd0>] (bus_add_driver+0x1a4/0x240)
[    5.241207] [<c02c5fd0>] (bus_add_driver+0x1a4/0x240) from [<c02c7608>] (driver_register+0x78/0x140)
[    5.250768] [<c02c7608>] (driver_register+0x78/0x140) from [<c00087a4>] (do_one_initcall+0x30/0x17c)
[    5.260347] [<c00087a4>] (do_one_initcall+0x30/0x17c) from [<c05fa29c>] (kernel_init_freeable+0xe8/0x1b0)
[    5.270381] [<c05fa29c>] (kernel_init_freeable+0xe8/0x1b0) from [<c044dfd4>] (kernel_init+0x8/0xe4)
[    5.279886] [<c044dfd4>] (kernel_init+0x8/0xe4) from [<c000f248>] (ret_from_fork+0x14/0x2c)
[    5.288740] ---[ end trace c15c72a22979d58d ]---

mx28evk has two ethernet controllers. The GPIO that performs the 
ethernet reset on both ports is the same GPIO, so on the board dts file, only in
one ethernet instance is passed the GPIO reset property.

Replace the WARN with a pr_warn message.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Another possible fix would be to do:

 arch/arm/boot/dts/imx28-evk.dts |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2da316e..87c6aa4 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -237,6 +237,8 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac1_pins_a>;
+			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-duration = <100>;
 			status = "okay";
 		};
 	};

,but then we would end up doing the reset twice, since it is the same GPIO that resets 
the two ethernet controllers.

 drivers/gpio/gpiolib.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index fff9786..01f193a 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -122,10 +122,12 @@ static int gpio_chip_hwgpio(const struct gpio_desc *desc)
  */
 static struct gpio_desc *gpio_to_desc(unsigned gpio)
 {
-	if (WARN(!gpio_is_valid(gpio), "invalid GPIO %d\n", gpio))
+	if (!gpio_is_valid(gpio)) {
+		pr_warn("gpiolib: invalid GPIO %d\n", gpio);
 		return NULL;
-	else
+	} else {
 		return &gpio_desc[gpio];
+	}
 }
 
 /**
-- 
1.7.9.5
