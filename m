From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 15 Mar 2017 18:59:00 +0900
Subject: [PATCH v33 01/14] memblock: add memblock_clear_nomap()
In-Reply-To: <20170315095656.24992-1-takahiro.akashi@linaro.org>
References: <20170315095656.24992-1-takahiro.akashi@linaro.org>
Message-ID: <20170315095901.25063-1-takahiro.akashi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This function, with a combination of memblock_mark_nomap(), will be used
in a later kdump patch for arm64 when it temporarily isolates some range
of memory from the other memory blocks in order to create a specific
kernel mapping at boot time.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 include/linux/memblock.h |  1 +
 mm/memblock.c            | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index bdfc65af4152..e82daffcfc44 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -93,6 +93,7 @@ int memblock_mark_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_clear_hotplug(phys_addr_t base, phys_addr_t size);
 int memblock_mark_mirror(phys_addr_t base, phys_addr_t size);
 int memblock_mark_nomap(phys_addr_t base, phys_addr_t size);
+int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 ulong choose_memblock_flags(void);
 
 /* Low level functions */
diff --git a/mm/memblock.c b/mm/memblock.c
index 696f06d17c4e..2f4ca8104ea4 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -805,6 +805,18 @@ int __init_memblock memblock_mark_nomap(phys_addr_t base, phys_addr_t size)
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
2.11.1
