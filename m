From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 20 Apr 2016 17:20:35 +0200
Subject: [PATCH] efi/arm-init: reserve rather than unmap the memory map for
 ARM as well
Message-ID: <1461165635-8041-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that ARM has a fully functional memremap() implementation, there is
no longer a need to remove the UEFI memory map from the linear mapping
in order to be able to create a permanent mapping for it using generic
code.

So remove the 'IS_ENABLED(CONFIG_ARM)' conditional we added in commit
7cc8cbcf82d1 ("efi/arm64: Don't apply MEMBLOCK_NOMAP to UEFI memory map
mapping"), and revert to using memblock_reserve() for both ARM and arm64

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---

This is the permanent fix I alluded to in the commit log for the patch
mentioned above. Russell has pulled the memremap() patches so this is
good to go for v4.7

Note that current efi-next already has a conflict with v4.6-rc4 (where
that patch landed) which will get even worse with this on top, so it may
make sense to rebase efi-next onto v4.6-rc4 before pulling this
(but note that this patch depends on 'efi/arm*: Use memremap() to create
the persistent memmap mapping', so please don't reorder them to maintain
bisectability)

 drivers/firmware/efi/arm-init.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 909d974d35d9..49a681182eef 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -209,18 +209,7 @@ void __init efi_init(void)
 	efi_memattr_init();
 	early_memunmap(efi.memmap.map, params.mmap_size);
 
-	if (IS_ENABLED(CONFIG_ARM)) {
-		/*
-		 * ARM currently does not allow ioremap_cache() to be called on
-		 * memory regions that are covered by struct page. So remove the
-		 * UEFI memory map from the linear mapping.
-		 */
-		memblock_mark_nomap(params.mmap & PAGE_MASK,
-				    PAGE_ALIGN(params.mmap_size +
-					       (params.mmap & ~PAGE_MASK)));
-	} else {
-		memblock_reserve(params.mmap & PAGE_MASK,
-				 PAGE_ALIGN(params.mmap_size +
-					    (params.mmap & ~PAGE_MASK)));
-	}
+	memblock_reserve(params.mmap & PAGE_MASK,
+			 PAGE_ALIGN(params.mmap_size +
+				    (params.mmap & ~PAGE_MASK)));
 }
-- 
2.5.0
