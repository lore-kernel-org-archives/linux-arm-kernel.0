From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 15 Jun 2018 16:56:23 +0900
Subject: [PATCH 3/3] init: map UEFI memory map early if on arm or arm64
In-Reply-To: <20180615075623.13454-1-takahiro.akashi@linaro.org>
References: <20180615075623.13454-1-takahiro.akashi@linaro.org>
Message-ID: <20180615075623.13454-4-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As ACPI tables may not always be properly aligned, those regions should
be mapped cacheable in order to allow the kernel safe access to them.
UEFI memory map contains necessary information for mappings, and we want
to make sure that it should get accessible before any acpi_os_ioremap()'s.

So, in this patch, efi_enter_virtual_mode(), which was previously named
efi_enable_runtime_services() and invoked via early_initcall on arm/arm64,
is now moved early enough as the first access will occur in
acpi_load_tables() of acpi_early_init().

See a relevant commit:
    arm64: acpi,efi: fix alignment fault in accessing ACPI tables at kdump

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 init/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..532fc0d02353 100644
--- a/init/main.c
+++ b/init/main.c
@@ -694,6 +694,9 @@ asmlinkage __visible void __init start_kernel(void)
 	debug_objects_mem_init();
 	setup_per_cpu_pageset();
 	numa_policy_init();
+	if (IS_ENABLED(CONFIG_EFI) &&
+	    (IS_ENABLED(CONFIG_ARM64) || IS_ENABLED(CONFIG_ARM)))
+		efi_enter_virtual_mode();
 	acpi_early_init();
 	if (late_time_init)
 		late_time_init();
-- 
2.17.0
