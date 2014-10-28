From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 28 Oct 2014 17:18:43 +0100
Subject: [PATCH v2 10/10] efi: efi-stub: notify on DTB absence
In-Reply-To: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1414513123-20400-11-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Rutland <mark.rutland@arm.com>

In the absence of a DTB configuration table, the EFI stub will happily
continue attempting to boot a kernel, despite the fact that this kernel
may not function without a description of the hardware. In this case, as
with a typo'd "dtb=" option (e.g. "dbt=") or many other possible
failures, the only output seen by the user will be the rather terse
output from the EFI stub:

EFI stub: Booting Linux Kernel...

To aid those attempting to debug such failures, this patch adds a notice
when no DTB is found, making the output more helpful:

EFI stub: Booting Linux Kernel...
EFI stub: Generating empty DTB

Additionally, a positive acknowledgement is added when a user-specified
DTB is in use:

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from command line

Similarly, a positive acknowledgement is added when a DTB from a
configuration table is in use:

EFI stub: Booting Linux Kernel...
EFI stub: Using DTB from configuration table

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Salter <msalter@redhat.com>
Cc: Matt Fleming <matt.fleming@intel.com>
Acked-by: Roy Franz <roy.franz@linaro.org>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/arm-stub.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/arm-stub.c b/drivers/firmware/efi/libstub/arm-stub.c
index 75ee05964cbc..eb48a1a1a576 100644
--- a/drivers/firmware/efi/libstub/arm-stub.c
+++ b/drivers/firmware/efi/libstub/arm-stub.c
@@ -247,9 +247,18 @@ unsigned long __init efi_entry(void *handle, efi_system_table_t *sys_table,
 			goto fail_free_cmdline;
 		}
 	}
-	if (!fdt_addr)
+
+	if (fdt_addr) {
+		pr_efi(sys_table, "Using DTB from command line\n");
+	} else {
 		/* Look for a device tree configuration table entry. */
 		fdt_addr = (uintptr_t)get_fdt(sys_table);
+		if (fdt_addr)
+			pr_efi(sys_table, "Using DTB from configuration table\n");
+	}
+
+	if (!fdt_addr)
+		pr_efi(sys_table, "Generating empty DTB\n");
 
 	status = handle_cmdline_files(sys_table, image, cmdline_ptr,
 				      "initrd=", dram_base + SZ_512M,
-- 
1.8.3.2
