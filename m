From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 25 Aug 2011 20:31:49 +0530
Subject: [PATCH v4 1/4] regulator: helper routine to extract regulator_init=
Message-ID: <mailman.196.1319712196.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

_data

The helper routine is meant to be used by the regulator drivers
to extract the regulator_init_data structure from the data
that is passed from device tree.
'consumer_supplies' which is part of regulator_init_data is not extracted
as the regulator consumer mappings are passed through DT differently,
implemented in subsequent patches.
Similarly the regulator<-->parent/supply mapping is handled in
subsequent patches.

Also add documentation for regulator bindings to be used to pass
regulator_init_data struct information from device tree.

Some of the regulator properties which are linux and board specific,
are left out since its not clear if they can
be in someway embedded into the kernel or passed in from DT.
They will be revisited later.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 .../devicetree/bindings/regulator/regulator.txt    |   33 ++++++++
 drivers/regulator/Kconfig                          |    7 ++
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/of_regulator.c                   |   81 ++++++++++++++++=
++++
 include/linux/regulator/of_regulator.h             |   20 +++++
 5 files changed, 142 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator.t=
xt
 create mode 100644 drivers/regulator/of_regulator.c
 create mode 100644 include/linux/regulator/of_regulator.h

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt
b/Documentation/devicetree/bindings/regulator/regulator.txt
new file mode 100644
index 0000000..c488bf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -0,0 +1,33 @@
+Voltage/Current Regulators
+
+Optional properties:
+- regulator-name: A string used as a descriptive name for regulator output=
s
+- regulator-min-uV: smallest voltage consumers may set
+- regulator-max-uV: largest voltage consumers may set
+- regulator-uV-offset: Offset applied to voltages to compensate for
voltage drops
+- regulator-min-uA: smallest current consumers may set
+- regulator-max-uA: largest current consumers may set
+- regulator-always-on: boolean, regulator should never be disabled
+- regulator-boot-on: bootloader/firmware enabled regulator
+- <name>-supply: phandle to the parent supply/regulator node
+
+Example:
+
+	xyzreg: regulator at 0 {
+		regulator-min-uV =3D <1000000>;
+		regulator-max-uV =3D <2500000>;
+		regulator-always-on;
+		vin-supply =3D <&vin>;
+	};
+
+The same binding used by a regulator to reference its
+supply can be used by any consumer to reference its
+regulator/supply
+
+Example of a device node referencing a regulator node,
+
+	devicenode: node at 0x0 {
+		...
+		...
+		<name>-supply =3D <&xyzreg>;
+	};
diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index c7fd2c0..8106958 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -64,6 +64,13 @@ config REGULATOR_USERSPACE_CONSUMER

           If unsure, say no.

+config OF_REGULATOR
+	bool
+	depends on OF
+	help
+	  OpenFirmware regulator framework helper routines that can
+	  used by regulator drivers to extract data from device tree.
+
 config REGULATOR_BQ24022
 	tristate "TI bq24022 Dual Input 1-Cell Li-Ion Charger IC"
 	help
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 040d5aa..e6bc009 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_REGULATOR) +=3D core.o dummy.o
 obj-$(CONFIG_REGULATOR_FIXED_VOLTAGE) +=3D fixed.o
 obj-$(CONFIG_REGULATOR_VIRTUAL_CONSUMER) +=3D virtual.o
 obj-$(CONFIG_REGULATOR_USERSPACE_CONSUMER) +=3D userspace-consumer.o
+obj-$(CONFIG_OF_REGULATOR) +=3D of_regulator.o

 obj-$(CONFIG_REGULATOR_AD5398) +=3D ad5398.o
 obj-$(CONFIG_REGULATOR_BQ24022) +=3D bq24022.o
diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regula=
tor.c
new file mode 100644
index 0000000..798faaa
--- /dev/null
+++ b/drivers/regulator/of_regulator.c
@@ -0,0 +1,81 @@
+/*
+ * OF helpers for regulator framework
+ *
+ * Copyright (C) 2011 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/regulator/machine.h>
+
+static void of_get_regulation_constraints(struct device_node *np,
+					struct regulator_init_data **init_data)
+{
+	const __be32 *min_uV, *max_uV, *uV_offset;
+	const __be32 *min_uA, *max_uA;
+	struct regulation_constraints *constraints =3D &(*init_data)->constraints=
;
+
+	constraints->name =3D of_get_property(np, "regulator-name", NULL);
+
+	min_uV =3D of_get_property(np, "regulator-min-uV", NULL);
+	if (min_uV)
+		constraints->min_uV =3D be32_to_cpu(*min_uV);
+	max_uV =3D of_get_property(np, "regulator-max-uV", NULL);
+	if (max_uV)
+		constraints->max_uV =3D be32_to_cpu(*max_uV);
+
+	/* Voltage change possible? */
+	if (constraints->min_uV !=3D constraints->max_uV)
+		constraints->valid_ops_mask |=3D REGULATOR_CHANGE_VOLTAGE;
+
+	uV_offset =3D of_get_property(np, "regulator-uV-offset", NULL);
+	if (uV_offset)
+		constraints->uV_offset =3D be32_to_cpu(*uV_offset);
+	min_uA =3D of_get_property(np, "regulator-min-uA", NULL);
+	if (min_uA)
+		constraints->min_uA =3D be32_to_cpu(*min_uA);
+	max_uA =3D of_get_property(np, "regulator-max-uA", NULL);
+	if (max_uA)
+		constraints->max_uA =3D be32_to_cpu(*max_uA);
+
+	/* Current change possible? */
+	if (constraints->min_uA !=3D constraints->max_uA)
+		constraints->valid_ops_mask |=3D REGULATOR_CHANGE_CURRENT;
+
+	if (of_find_property(np, "regulator-boot-on", NULL))
+		constraints->boot_on =3D true;
+
+	if (of_find_property(np, "regulator-always-on", NULL))
+		constraints->always_on =3D true;
+	else /* status change should be possible if not always on. */
+		constraints->valid_ops_mask |=3D REGULATOR_CHANGE_STATUS;
+}
+
+/**
+ * of_get_regulator_init_data - extract regulator_init_data structure info
+ * @dev: device requesting for regulator_init_data
+ *
+ * Populates regulator_init_data structure by extracting data from device
+ * tree node, returns a pointer to the populated struture or NULL if memor=
y
+ * alloc fails.
+ */
+struct regulator_init_data *of_get_regulator_init_data(struct device *dev)
+{
+	struct regulator_init_data *init_data;
+
+	if (!dev->of_node)
+		return NULL;
+
+	init_data =3D devm_kzalloc(dev, sizeof(*init_data), GFP_KERNEL);
+	if (!init_data)
+		return NULL; /* Out of memory? */
+
+	of_get_regulation_constraints(dev->of_node, &init_data);
+	return init_data;
+}
diff --git a/include/linux/regulator/of_regulator.h
b/include/linux/regulator/of_regulator.h
new file mode 100644
index 0000000..621c071
--- /dev/null
+++ b/include/linux/regulator/of_regulator.h
@@ -0,0 +1,20 @@
+/*
+ * OpenFirmware regulator support routines
+ *
+ */
+
+#ifndef __LINUX_OF_REG_H
+#define __LINUX_OF_REG_H
+
+#if defined(CONFIG_OF_REGULATOR)
+extern struct regulator_init_data
+	*of_get_regulator_init_data(struct device *dev);
+#else
+static inline struct regulator_init_data
+	*of_get_regulator_init_data(struct device *dev)
+{
+	return NULL;
+}
+#endif /* CONFIG_OF_REGULATOR */
+
+#endif /* __LINUX_OF_REG_H */
--=20
1.7.1

>
