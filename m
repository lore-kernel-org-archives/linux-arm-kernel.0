From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 10 Apr 2015 14:56:09 +0200
Subject: [PATCH] efi: stub: use a pool allocation for the cmdline
Message-ID: <1428670569-23089-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the allocation for the ASCII-converted command
line to use an ordinary memory pool rather than a separate
page based allocation.

Pool allocations are generally preferred over page based
allocations due to the fact that they cause less fragmentation,
but in the particular case of arm64, where page allocations are
rounded up to 64 KB and where this allocation happens to be the
only explicit low allocation, it results in the lowest 64 KB of
memory to always be taken up by this particular allocation.

So allocate from the EFI_LOADER_DATA pool instead.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index f07d4a67fa76..c95a567ca132 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -684,7 +684,8 @@ char *efi_convert_cmdline(efi_system_table_t *sys_table_arg,
 
 	options_bytes++;	/* NUL termination */
 
-	status = efi_low_alloc(sys_table_arg, options_bytes, 0, &cmdline_addr);
+	status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
+				options_bytes, (void **)&cmdline_addr);
 	if (status != EFI_SUCCESS)
 		return NULL;
 
-- 
1.8.3.2
