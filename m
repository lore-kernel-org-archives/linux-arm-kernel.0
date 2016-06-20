From: aleksey.makarov@linaro.org (Aleksey Makarov)
Date: Mon, 20 Jun 2016 13:56:09 +0300
Subject: [PATCH v4 1/5] ACPI: table upgrade: use cacheable map for tables
In-Reply-To: <20160620105615.15538-1-aleksey.makarov@linaro.org>
References: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Message-ID: <20160620105615.15538-2-aleksey.makarov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The new memory allocated in acpi_table_initrd_init() is used to
copy the upgraded tables to it.  So it should be mapped with
early_memunmap() instead of early_ioremap().

This is critical for ARM.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
Acked-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/tables.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index a372f9e..f829e6a 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -578,10 +578,10 @@ static void __init acpi_table_initrd_init(void *data, size_t size)
 			clen = size;
 			if (clen > MAP_CHUNK_SIZE - slop)
 				clen = MAP_CHUNK_SIZE - slop;
-			dest_p = early_ioremap(dest_addr & PAGE_MASK,
-						 clen + slop);
+			dest_p = early_memremap(dest_addr & PAGE_MASK,
+						clen + slop);
 			memcpy(dest_p + slop, src_p, clen);
-			early_iounmap(dest_p, clen + slop);
+			early_memunmap(dest_p, clen + slop);
 			src_p += clen;
 			dest_addr += clen;
 			size -= clen;
-- 
2.8.3
