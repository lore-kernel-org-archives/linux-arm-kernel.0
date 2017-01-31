From: dhowells@redhat.com (David Howells)
Date: Tue, 31 Jan 2017 15:14:18 +0000
Subject: [PATCH 7/7] efi: Print the secure boot status in x86 setup_arch()
 [ver #7]
In-Reply-To: <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
References: <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
Message-ID: <148587565838.4026.2835771993519594392.stgit@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Print the secure boot status in the x86 setup_arch() but otherwise do
nothing more for now.  More functionality will be added later, but this at
least allows for testing.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/x86/kernel/setup.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 4cfba947d774..22e4b47a5c14 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1176,6 +1176,20 @@ void __init setup_arch(char **cmdline_p)
 	/* Allocate bigger log buffer */
 	setup_log_buf(1);
 
+	if (IS_ENABLED(CONFIG_EFI)) {
+		switch (boot_params.secure_boot) {
+		case efi_secureboot_mode_disabled:
+			pr_info("Secure boot disabled\n");
+			break;
+		case efi_secureboot_mode_enabled:
+			pr_info("Secure boot enabled\n");
+			break;
+		default:
+			pr_info("Secure boot could not be determined\n");
+			break;
+		}
+	}
+
 	reserve_initrd();
 
 	acpi_table_upgrade();
