From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 15 Feb 2016 12:32:33 +0100
Subject: [PATCH v2 2/2] arm64/efi: esrt: add missing call to efi_esrt_init()
In-Reply-To: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1455535953-5056-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1455535953-5056-3-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ESRT support is built by default for all architectures that define
CONFIG_EFI. However, this support was not wired up yet for ARM/arm64,
since efi_esrt_init() was never called. So add the missing call.

Since efi_esrt_init() uses efi_mem_desc_lookup(), which in turn relies
on efi.memmap having been assigned and populated completetely, add the
missing assignments of efi.memmap and efi.memmap->nr_map.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/firmware/efi/arm-init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/efi/arm-init.c b/drivers/firmware/efi/arm-init.c
index 9e15d571b53c..5c5e799bdb50 100644
--- a/drivers/firmware/efi/arm-init.c
+++ b/drivers/firmware/efi/arm-init.c
@@ -197,10 +197,13 @@ void __init efi_init(void)
 	memmap.map_end = memmap.map + params.mmap_size;
 	memmap.desc_size = params.desc_size;
 	memmap.desc_version = params.desc_ver;
+	memmap.nr_map = params.mmap_size / params.desc_size;
+	efi.memmap = &memmap;
 
 	if (uefi_init() < 0)
 		return;
 
+	efi_esrt_init();
 	reserve_regions();
 	early_memunmap(memmap.map, params.mmap_size);
 	memblock_mark_nomap(params.mmap & PAGE_MASK,
-- 
2.5.0
