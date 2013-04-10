From: robherring2@gmail.com (Rob Herring)
Date: Tue,  9 Apr 2013 22:08:15 -0500
Subject: [RFC PATCH 1/3] pstore-ram: use write-combine mappings
Message-ID: <1365563297-12480-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Atomic operations are undefined behavior on ARM for device or strongly
ordered memory types. So use write-combine variants for mappings. This
corresponds to normal, non-cacheable memory on ARM. For many other
architectures, this change should not change the mapping type.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Colin Cross <ccross@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Tony Luck <tony.luck@intel.com>
Cc: linux-kernel at vger.kernel.org
---
 fs/pstore/ram_core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 0306303..e126d9f 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -337,7 +337,7 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size)
 	page_start = start - offset_in_page(start);
 	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
 
-	prot = pgprot_noncached(PAGE_KERNEL);
+	prot = pgprot_writecombine(PAGE_KERNEL);
 
 	pages = kmalloc(sizeof(struct page *) * page_count, GFP_KERNEL);
 	if (!pages) {
@@ -364,7 +364,7 @@ static void *persistent_ram_iomap(phys_addr_t start, size_t size)
 		return NULL;
 	}
 
-	return ioremap(start, size);
+	return ioremap_wc(start, size);
 }
 
 static int persistent_ram_buffer_map(phys_addr_t start, phys_addr_t size,
-- 
1.7.10.4
