From: dyoung@redhat.com (Dave Young)
Date: Thu, 14 Aug 2014 17:15:31 +0800
Subject: [PATCH 6/7] x86/efi: clear EFI_RUNTIME_SERVICES bit in case failures
 while entering virtual mode
In-Reply-To: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
References: <1408007731-15081-1-git-send-email-dyoung@redhat.com>
Message-ID: <1408007731-15081-6-git-send-email-dyoung@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If enter virtual mode failed due to some reason other than the efi call
the EFI_RUNTIME_SERVICES bit in efi.flags should be cleared thus users
of efi runtime services can check the bit and handle the case instead of
assume efi runtime is ok.

Per Matt, if efi call SetVirtualAddressMap fails we will be not sure it's safe
to make any assumptions about the state of the system. so kernel panics instead
of clears EFI_RUNTIME_SERVICES bit.

Signed-off-by: Dave Young <dyoung@redhat.com>
---
 arch/x86/platform/efi/efi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 00f4cc5..d3096c0 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -724,6 +724,7 @@ static void __init kexec_enter_virtual_mode(void)
 	 */
 	if (!efi_is_native()) {
 		efi_unmap_memmap();
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
 	}
 
@@ -797,6 +798,7 @@ static void __init __efi_enter_virtual_mode(void)
 	new_memmap = efi_map_regions(&count, &pg_shift);
 	if (!new_memmap) {
 		pr_err("Error reallocating memory, EFI runtime non-functional!\n");
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
 	}
 
@@ -804,8 +806,10 @@ static void __init __efi_enter_virtual_mode(void)
 
 	BUG_ON(!efi.systab);
 
-	if (efi_setup_page_tables(__pa(new_memmap), 1 << pg_shift))
+	if (efi_setup_page_tables(__pa(new_memmap), 1 << pg_shift)) {
+		clear_bit(EFI_RUNTIME_SERVICES, &efi.flags);
 		return;
+	}
 
 	efi_sync_low_kernel_mappings();
 	efi_dump_pagetable();
-- 
1.8.3.1
