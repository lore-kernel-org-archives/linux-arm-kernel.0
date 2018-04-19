From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 19 Apr 2018 18:58:25 +0200
Subject: [PATCH] ACPI / bus: ignore rather than fail bus driver registrations
 on non-ACPI boot
Message-ID: <20180419165825.13008-1-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building ACPI bus drivers such as button.ko into the core kernel,
other drivers that depend on its symbols are loadable even when booting
with ACPI disabled. For instance, nouveau.ko has a link time dependency
on acpi_lid_open() on ACPI capable kernels, and calls it regardless of
whether the system booted via ACPI.

However, when building button.ko as a module, it will refuse to load if
the system did not boot in ACPI mode, which subsequently prevents the
nouveau driver from loading as well, resulting in broken graphics.

Given that returning an error from an initcall() is ignored for drivers
that are built into the kernel, let's align the module case with this,
and not return an error when registering an ACPI bus driver on a system
that did not boot via ACPI.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 84b4a62018eb..529d3d496fab 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -880,7 +880,7 @@ int acpi_bus_register_driver(struct acpi_driver *driver)
 	int ret;
 
 	if (acpi_disabled)
-		return -ENODEV;
+		return 0;
 	driver->drv.name = driver->name;
 	driver->drv.bus = &acpi_bus_type;
 	driver->drv.owner = driver->owner;
-- 
2.17.0
