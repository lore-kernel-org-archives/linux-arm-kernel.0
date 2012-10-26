From: tero.jaasko@gmail.com (Tero Jaasko)
Date: Fri, 26 Oct 2012 18:56:16 +0300 (EEST)
Subject: [PATCH] arm: kirkwood: add support for ZyXEL NSA310
In-Reply-To: <20121025181426.GC21046@lunn.ch>
References: <alpine.DEB.2.02.1210251735020.15860@mirri>
 <20121025181426.GC21046@lunn.ch>
Message-ID: <alpine.DEB.2.02.1210261834070.20029@mirri>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hello, Andrew
 
> > +#define NSA310_GPIO_LED_ESATA_GREEN	12
> > <..>
> > +#define NSA310_GPIO_POWER_OFF		48
> 
> It looks like most of these are not used. Please remove them.

True. Fixed.

> > +static struct mtd_partition nsa310_mtd_parts[] = {
> > +	{
> > +		.name	= "uboot",
> > +		.offset	= 0,
> > +		.size	= 0x100000,
> > +		.mask_flags = MTD_WRITEABLE,
> > +	}, {
> > <..>
> You should be able to put all that into DT. Take a look at

Correct. I did the conversion and tested that the partitions
can be read with dd and produce exactly the same data before and
after conversion. So, the partition offsets at least should be fine. 

> > +static struct i2c_board_info __initdata nsa310_i2c_info[] = {
> > +	{ I2C_BOARD_INFO("adt7476", 0x2e) },
> > +};
> 
> You can also do this in DT as well. kirkwood-ts219.dtsi has
> 
>                 i2c at 11000 {
>                         status = "okay";
>                         clock-frequency = <400000>;

Ok, I did convert the i2c definition to use the devicetree. 
The adt7476 device itself is not at reach of device tree,
AFAIK and requires more work at there?

Thanks for your valuable comments. Following is a new patch that
should address the problems and mistakes you pointed and also
some of the pointed by Jason Cooper. The nand and i2c are now
defined at DT and I also removed the pointless defines and 
ARM_APPENDED_DTB. It is based against the Linus' official 
3.6 version.

Best regards,
Tero

---
>From 16afb94d976e481f8b5da580a9a2248b0f89dfe5 Mon Sep 17 00:00:00 2001
From: Tero Jaasko <tero.jaasko@mail.suomi.net>
Date: Fri, 26 Oct 2012 17:56:07 +0300
Subject: [PATCH] arm: kirkwood: add support for ZyXEL NSA310

Bring in the support for ZyXEL NSA310 NAS box. Code is mostly imported
from the openwrt.org, (https://dev.openwrt.org/browser/trunk/target/
linux/kirkwood/patches-3.3/202-zyxel-nsa-310.patch?rev=31673).

Original code is converted to use flattened device tree descriptions
for the support for serial uart, i2c, sata, nand, gpio keys and
gpio leds.

Signed-off-by: Tero Jaasko <tero.jaasko@mail.suomi.net>
---
 arch/arm/boot/dts/kirkwood-nsa310.dts | 144 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-kirkwood/Kconfig        |   8 ++
 arch/arm/mach-kirkwood/Makefile       |   1 +
 arch/arm/mach-kirkwood/Makefile.boot  |   1 +
 arch/arm/mach-kirkwood/board-dt.c     |   4 +
 arch/arm/mach-kirkwood/board-nsa310.c | 105 +++++++++++++++++++++++++
 arch/arm/mach-kirkwood/common.h       |   6 ++
 7 files changed, 269 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310.dts
 create mode 100644 arch/arm/mach-kirkwood/board-nsa310.c

diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
new file mode 100644
index 0000000..5509f96
--- /dev/null
+++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
@@ -0,0 +1,144 @@
+/dts-v1/;
+
+/include/ "kirkwood.dtsi"
+
+/ {
+	model = "ZyXEL NSA310";
+	compatible = "zyxel,nsa310", "marvell,kirkwood-88f6281", "marvell,kirkwood";
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x10000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200";
+	};
+
+	ocp at f1000000 {
+
+		serial at 12000 {
+			clock-frequency = <200000000>;
+			status = "ok";
+		};
+
+		sata at 80000 {
+			status = "okay";
+			nr-ports = <2>;
+		};
+
+		i2c at 11000 {
+			status = "okay";
+		};
+
+		nand at 3000000 {
+			status = "okay";
+			chip-delay = <35>;
+
+			partition at 0 {
+				label = "uboot";
+				reg = <0x0000000 0x0100000>;
+				read-only;
+			};
+			partition at 100000 {
+				label = "uboot_env";
+				reg = <0x0100000 0x0080000>;
+			};
+			partition at 180000 {
+				label = "key_store";
+				reg = <0x0180000 0x0080000>;
+			};
+			partition at 200000 {
+				label = "info";
+				reg = <0x0200000 0x0080000>;
+			};
+			partition at 280000 {
+				label = "etc";
+				reg = <0x0280000 0x0a00000>;
+			};
+			partition at c80000 {
+				label = "kernel_1";
+				reg = <0x0c80000 0x0a00000>;
+			};
+			partition at 1680000 {
+				label = "rootfs1";
+				reg = <0x1680000 0x2fc0000>;
+			};
+			partition at 4640000 {
+				label = "kernel_2";
+				reg = <0x4640000 0x0a00000>;
+			};
+			partition at 5040000 {
+				label = "rootfs2";
+				reg = <0x5040000 0x2fc0000>;
+			};
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		button at 1 {
+			label = "Power Button";
+			linux,code = <116>;
+			gpios = <&gpio1 14 0>;
+		};
+		button at 2 {
+			label = "Copy Button";
+			linux,code = <133>;
+			gpios = <&gpio1 5 1>;
+		};
+		button at 3 {
+			label = "Reset Button";
+			linux,code = <0x198>;
+			gpios = <&gpio1 4 1>;
+		};
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		green-sys {
+			label = "nsa310:green:sys";
+			gpios = <&gpio0 28 0>;
+		};
+		red-sys {
+			label = "nsa310:red:sys";
+			gpios = <&gpio0 29 0>;
+		};
+		green-hdd {
+			label = "nsa310:green:hdd";
+			gpios = <&gpio1 9 0>;
+		};
+		red-hdd {
+			label = "nsa310:red:hdd";
+			gpios = <&gpio1 10 0>;
+		};
+		green-esata {
+			label = "nsa310:green:esata";
+			gpios = <&gpio0 12 0>;
+		};
+		red-esata {
+			label = "nsa310:red:esata";
+			gpios = <&gpio0 13 0>;
+		};
+		green-usb {
+			label = "nsa310:green:usb";
+			gpios = <&gpio0 15 0>;
+		};
+		red-usb {
+			label = "nsa310:red:usb";
+			gpios = <&gpio0 16 0>;
+		};
+		green-copy {
+			label = "nsa310:green:copy";
+			gpios = <&gpio1 7 0>;
+		};
+		red-copy {
+			label = "nsa310:red:copy";
+			gpios = <&gpio1 8 0>;
+		};
+	};
+};
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index ca5c15a..d5e76a9 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -195,6 +195,14 @@ config MACH_T5325
 	  Say 'Y' here if you want your kernel to support the
 	  HP t5325 Thin Client.
 
+config MACH_NSA310_DT
+	bool "ZyXEL NSA-310 (Flattened Device Tree)"
+	select ARCH_KIRKWOOD_DT
+	select ARM_ATAG_DTB_COMPAT
+	help
+	  Say 'Y' here if you want your kernel to support the
+	  ZyXEL NSA-310 board (Flattened Device Tree).
+
 endmenu
 
 endif
diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
index 055c85a..b2663e2 100644
--- a/arch/arm/mach-kirkwood/Makefile
+++ b/arch/arm/mach-kirkwood/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_IB62X0_DT)		+= board-ib62x0.o
 obj-$(CONFIG_MACH_TS219_DT)		+= board-ts219.o tsx1x-common.o
 obj-$(CONFIG_MACH_GOFLEXNET_DT)		+= board-goflexnet.o
 obj-$(CONFIG_MACH_LSXL_DT)		+= board-lsxl.o
+obj-$(CONFIG_MACH_NSA310_DT)		+= board-nsa310.o
diff --git a/arch/arm/mach-kirkwood/Makefile.boot b/arch/arm/mach-kirkwood/Makefile.boot
index a13299d..67d8666 100644
--- a/arch/arm/mach-kirkwood/Makefile.boot
+++ b/arch/arm/mach-kirkwood/Makefile.boot
@@ -12,3 +12,4 @@ dtb-$(CONFIG_MACH_TS219_DT)	+= kirkwood-ts219-6282.dtb
 dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
 dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
 dtb-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
+dtb-$(CONFIG_MACH_NSA310_DT) += kirkwood-nsa310.dtb
diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e4eb450..2a005a7 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -87,6 +87,9 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("buffalo,lsxl"))
 		lsxl_init();
 
+	if (of_machine_is_compatible("zyxel,nsa310"))
+		nsa310_init();
+
 	of_platform_populate(NULL, kirkwood_dt_match_table,
 			     kirkwood_auxdata_lookup, NULL);
 }
@@ -100,6 +103,7 @@ static const char *kirkwood_dt_board_compat[] = {
 	"qnap,ts219",
 	"seagate,goflexnet",
 	"buffalo,lsxl",
+	"zyxel,nsa310",
 	NULL
 };
 
diff --git a/arch/arm/mach-kirkwood/board-nsa310.c b/arch/arm/mach-kirkwood/board-nsa310.c
new file mode 100644
index 0000000..027ce83
--- /dev/null
+++ b/arch/arm/mach-kirkwood/board-nsa310.c
@@ -0,0 +1,105 @@
+/*
+ * arch/arm/mach-kirkwood/nsa-310-setup.c
+ *
+ * ZyXEL NSA-310 Setup
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/gpio.h>
+
+#include <asm/mach-types.h>
+#include <asm/mach/arch.h>
+#include <mach/kirkwood.h>
+#include "common.h"
+#include "mpp.h"
+
+#define NSA310_GPIO_USB_POWER_OFF	21
+#define NSA310_GPIO_POWER_OFF		48
+
+static unsigned int nsa310_mpp_config[] __initdata = {
+	MPP12_GPIO, /* led esata green */
+	MPP13_GPIO, /* led esata red */
+	MPP15_GPIO, /* led usb green */
+	MPP16_GPIO, /* led usb red */
+	MPP21_GPIO, /* control usb power off */
+	MPP28_GPIO, /* led sys green */
+	MPP29_GPIO, /* led sys red */
+	MPP36_GPIO, /* key reset */
+	MPP37_GPIO, /* key copy */
+	MPP39_GPIO, /* led copy green */
+	MPP40_GPIO, /* led copy red */
+	MPP41_GPIO, /* led hdd green */
+	MPP42_GPIO, /* led hdd red */
+	MPP44_GPIO, /* ?? */
+	MPP46_GPIO, /* key power */
+	MPP48_GPIO, /* control power off */
+	0
+};
+
+static struct i2c_board_info __initdata nsa310_i2c_info[] = {
+	{ I2C_BOARD_INFO("adt7476", 0x2e) },
+};
+
+static void nsa310_power_off(void)
+{
+	gpio_set_value(NSA310_GPIO_POWER_OFF, 1);
+}
+
+static int __init nsa310_gpio_request(unsigned int gpio, unsigned long flags,
+				       const char *label)
+{
+	int err;
+
+	err = gpio_request_one(gpio, flags, label);
+	if (err)
+		pr_err("NSA-310: can't setup GPIO%u (%s), err=%d\n",
+			gpio, label, err);
+
+	return err;
+}
+
+static void __init nsa310_gpio_init(void)
+{
+	int err;
+
+	err = nsa310_gpio_request(NSA310_GPIO_POWER_OFF, GPIOF_OUT_INIT_LOW,
+				  "Power Off");
+	if (!err)
+		pm_power_off = nsa310_power_off;
+
+	nsa310_gpio_request(NSA310_GPIO_USB_POWER_OFF, GPIOF_OUT_INIT_LOW,
+			    "USB Power Off");
+}
+
+void __init nsa310_init(void)
+{
+	u32 dev, rev;
+
+	kirkwood_mpp_conf(nsa310_mpp_config);
+
+	nsa310_gpio_init();
+
+	/* this can be removed once the mainline kirkwood.dtsi gets
+	 * the ehci configuration by default */
+	kirkwood_ehci_init();
+
+	kirkwood_pcie_id(&dev, &rev);
+
+	i2c_register_board_info(0, ARRAY_AND_SIZE(nsa310_i2c_info));
+}
+
+static int __init nsa310_pci_init(void)
+{
+	if (of_machine_is_compatible("zyxel,nsa310"))
+		kirkwood_pcie_init(KW_PCIE0);
+
+	return 0;
+}
+
+subsys_initcall(nsa310_pci_init);
diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
index 304dd1a..a9256d7 100644
--- a/arch/arm/mach-kirkwood/common.h
+++ b/arch/arm/mach-kirkwood/common.h
@@ -94,6 +94,12 @@ void lsxl_init(void);
 static inline void lsxl_init(void) {};
 #endif
 
+#ifdef CONFIG_MACH_NSA310_DT
+void nsa310_init(void);
+#else
+static inline void nsa310_init(void) {};
+#endif
+
 /* early init functions not converted to fdt yet */
 char *kirkwood_id(void);
 void kirkwood_l2_init(void);
-- 
1.7.12.3
