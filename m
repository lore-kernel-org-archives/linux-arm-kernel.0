From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 15 Feb 2017 18:34:51 +0530
Subject: [PATCH 1/2] x86/efi-bgrt: Move efi-bgrt handling out of arch/x86
In-Reply-To: <1487163892-27701-1-git-send-email-bhsharma@redhat.com>
References: <1487163892-27701-1-git-send-email-bhsharma@redhat.com>
Message-ID: <1487163892-27701-2-git-send-email-bhsharma@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now with open-source boot firmware (EDK2) supporting ACPI BGRT table addition
even for architecures like AARCH64, it makes sense to move out the 'efi-bgrt.c'
file and supporting infrastructure from 'arch/x86' directory and house it
inside 'drivers/firmware/efi', so that this common code can be used accross
architecures.

This patch (1) of a series having (2) patches, prepares the background
so that handling of ACPI BGRT tables and BGRT image can be added
in other architectures.

Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Young <dyoung@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>

Signed-off-by: Bhupesh Sharma <bhsharma@redhat.com>
---
 arch/x86/platform/efi/Makefile                         | 1 -
 drivers/firmware/efi/Makefile                          | 1 +
 {arch/x86/platform => drivers/firmware}/efi/efi-bgrt.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {arch/x86/platform => drivers/firmware}/efi/efi-bgrt.c (100%)

diff --git a/arch/x86/platform/efi/Makefile b/arch/x86/platform/efi/Makefile
index 066619b..f1d83b3 100644
--- a/arch/x86/platform/efi/Makefile
+++ b/arch/x86/platform/efi/Makefile
@@ -1,6 +1,5 @@
 OBJECT_FILES_NON_STANDARD_efi_thunk_$(BITS).o := y
 
 obj-$(CONFIG_EFI) 		+= quirks.o efi.o efi_$(BITS).o efi_stub_$(BITS).o
-obj-$(CONFIG_ACPI_BGRT) += efi-bgrt.o
 obj-$(CONFIG_EARLY_PRINTK_EFI)	+= early_printk.o
 obj-$(CONFIG_EFI_MIXED)		+= efi_thunk_$(BITS).o
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index ad67342..0329d31 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -9,6 +9,7 @@
 #
 KASAN_SANITIZE_runtime-wrappers.o	:= n
 
+obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o
 obj-$(CONFIG_EFI)			+= capsule.o memmap.o
 obj-$(CONFIG_EFI_VARS)			+= efivars.o
diff --git a/arch/x86/platform/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
similarity index 100%
rename from arch/x86/platform/efi/efi-bgrt.c
rename to drivers/firmware/efi/efi-bgrt.c
-- 
2.7.4
