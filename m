From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 23 Apr 2018 10:28:34 +0200
Subject: [PATCH] ACPI / button: make module loadable when booted in non-ACPI
 mode
Message-ID: <20180423082834.24617-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Modules such as nouveau.ko and i915.ko have a link time dependency on
acpi_lid_open(), and due to its use of acpi_bus_register_driver(),
the button.ko module that provides it is only loadable when booted in
ACPI mode. However, the ACPI button driver can be built into the core
kernel as well, in which case the dependency can always be satisfied,
and the dependent modules can be loaded regardless of whether the
system was booted in ACPI mode or not.

So let's fix this asymmetry by making the ACPI button driver loadable
as a module even if not booted in ACPI mode, so it can provide the
acpi_lid_open() symbol in the same way as when built into the kernel.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
Could we perhaps get this into -stable as well? It is not a classic
regression, but it completely breaks, e.g., Fedora when booting in
DT mode on an ARM system.

 drivers/acpi/button.c | 23 +++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index e1eee7a60fad..0506ca56c615 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -635,4 +635,25 @@ module_param_call(lid_init_state,
 		  NULL, 0644);
 MODULE_PARM_DESC(lid_init_state, "Behavior for reporting LID initial state");
 
-module_acpi_driver(acpi_button_driver);
+/*
+ * Modules such as nouveau.ko and i915.ko have a link time dependency on
+ * acpi_lid_open(), and would therefore not be loadable on ACPI capable kernels
+ * booted in non-ACPI mode if we use the ordinary acpi_bus_[un]register_driver
+ * routines here (which only work when booted in ACPI mode) and build this
+ * driver as a module. So provide our own versions instead.
+ */
+static int __acpi_bus_register_driver(struct acpi_driver *driver)
+{
+	if (!acpi_disabled)
+		return acpi_bus_register_driver(driver);
+	return 0;
+}
+
+static void __acpi_bus_unregister_driver(struct acpi_driver *driver)
+{
+	if (!acpi_disabled)
+		acpi_bus_unregister_driver(driver);
+}
+
+module_driver(acpi_button_driver, __acpi_bus_register_driver,
+	      __acpi_bus_unregister_driver);
-- 
2.17.0
