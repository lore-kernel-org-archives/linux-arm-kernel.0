From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 26 Oct 2015 17:41:00 +0900
Subject: [PATCH] arm64/efi: register UEFI runtime mmio regions as iomem
 resources
In-Reply-To: <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
References: <CAD0U-h+cr0xpAAcCD1P8k2hUcJJL2Ga+-Grrb8WaZrgm08G2nA@mail.gmail.com>
Message-ID: <1445848860-9547-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to prevent kernel drivers from attaching to MMIO regions
that are owned by the firmware, register them as iomem resources.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/efi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
index a48d1f477b2e..f2c6763d6c37 100644
--- a/arch/arm64/kernel/efi.c
+++ b/arch/arm64/kernel/efi.c
@@ -229,6 +229,22 @@ void __init efi_init(void)
 	early_memunmap(memmap.map, params.mmap_size);
 }
 
+static void __init efi_reserve_iomem_resource(efi_memory_desc_t *md)
+{
+	struct resource *res;
+
+	res = kzalloc(sizeof(*res), GFP_KERNEL);
+	if (WARN_ON_ONCE(!res))
+		return;
+
+	res->start = md->phys_addr & PAGE_MASK;
+	res->end = PAGE_ALIGN(md->phys_addr + (md->num_pages << EFI_PAGE_SHIFT)) - 1;
+	res->name = "UEFI Runtime MMIO";
+	res->flags = IORESOURCE_MEM | IORESOURCE_BUSY | IORESOURCE_EXCLUSIVE;
+
+	request_resource(&iomem_resource, res);
+}
+
 static bool __init efi_virtmap_init(void)
 {
 	efi_memory_desc_t *md;
@@ -239,6 +255,8 @@ static bool __init efi_virtmap_init(void)
 
 		if (!(md->attribute & EFI_MEMORY_RUNTIME))
 			continue;
+		if (md->type == EFI_MEMORY_MAPPED_IO)
+			efi_reserve_iomem_resource(md);
 		if (md->virt_addr == 0)
 			return false;
 
-- 
2.1.4
