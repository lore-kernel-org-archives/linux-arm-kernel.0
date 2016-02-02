From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue,  2 Feb 2016 18:56:40 +0100
Subject: [RFC PATCH 1/3] memblock: add routine to clear the MEMBLOCK_NOMAP
 flag for a region
In-Reply-To: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454435802-7604-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1454435802-7604-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In addition to the existing memblock_mark_nomap(), this implements
memblock_clear_nomap() to do the converse.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 3106ac1c895e..f7d2c8dc2f0d 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -92,6 +92,7 @@ int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 ulong choose_memblock_flags(void);
 
 /* Low level functions */
diff --git a/mm/memblock.c b/mm/memblock.c
index 335a145b75cd..ffa7ab127641 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -835,6 +835,18 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
 }
 
 /**
+ * memblock_clear_nomap - Clear flag MEMBLOCK_NOMAP for a specified region.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Return 0 on success, -errno on failure.
+ */
+int __init_memblock memblock_clear_nomap(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(base, size, 0, MEMBLOCK_NOMAP);
+}
+
+/**
  * __next_reserved_mem_region - next function for for_each_reserved_region()
  * @idx: pointer to u64 loop variable
  * @out_start: ptr to phys_addr_t for start address of the region, can be %NULL
-- 
2.5.0
