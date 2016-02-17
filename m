From: romain.perier@gmail.com (Romain Perier)
Date: Wed, 17 Feb 2016 18:28:33 +0100
Subject: [PATCH 1/2] ARM: meson: Adding support to retrieve serial and SoC
 revision
In-Reply-To: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
References: <1455730114-2547-1-git-send-email-romain.perier@gmail.com>
Message-ID: <1455730114-2547-2-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This path adds support to get the revision and the serial of the running
SoC, on Meson8. On these plaforms, these informations can be found into
CBUS registers. To do so, we instanciate a syscon register, then create
a soc_device, and finally we expose everything to the system.

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 arch/arm/mach-meson/meson.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm/mach-meson/meson.c b/arch/arm/mach-meson/meson.c
index 4e23571..2816e30 100644
--- a/arch/arm/mach-meson/meson.c
+++ b/arch/arm/mach-meson/meson.c
@@ -13,8 +13,16 @@
  *
  */
 
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
+#include <linux/mfd/syscon.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/sys_soc.h>
 #include <asm/mach/arch.h>
+#include <asm/system_info.h>
+
+#define MESON_REVISION_REG (0x45c)
 
 static const char * const meson_common_board_compat[] = {
 	"amlogic,meson6",
@@ -23,7 +31,54 @@ static const char * const meson_common_board_compat[] = {
 	NULL,
 };
 
+static void __init meson_init_machine(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	struct soc_device *soc_dev;
+	struct regmap *hwrev;
+	unsigned int val;
+	int ret;
+
+	hwrev = syscon_regmap_lookup_by_compatible("amlogic,meson8b-hwrev");
+	if (IS_ERR(hwrev)) {
+		pr_err("hwrev node not found\n");
+		return;
+	}
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return;
+	ret = regmap_read(hwrev, 0, &val);
+	if (ret < 0) {
+		pr_err("Could not get SoC id\n");
+		return;
+	}
+	system_serial_high = val << 24;
+
+	ret = regmap_read(hwrev, MESON_REVISION_REG, &val);
+	if (ret < 0) {
+		pr_err("Could not get SoC revision\n");
+		return;
+	}
+	system_rev = val == 0x11111111 ? 0xA : 0xB;
+
+	soc_dev_attr->family = "Amlogic Meson";
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "0x%x", system_rev);
+	soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "0x%x", system_serial_high);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		pr_err("Could not register soc device\n");
+		kfree(soc_dev_attr);
+		return;
+	}
+
+	pr_info("Amlogic Meson SoC Rev%X (%X:%X)\n", system_rev, system_serial_high, system_rev);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, soc_dev);
+}
+
 DT_MACHINE_START(MESON, "Amlogic Meson platform")
+	.init_machine	= meson_init_machine,
 	.dt_compat	= meson_common_board_compat,
 	.l2c_aux_val	= 0,
 	.l2c_aux_mask	= ~0,
-- 
2.5.0
