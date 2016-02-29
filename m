From: brian.starkey@arm.com (Brian Starkey)
Date: Mon, 29 Feb 2016 16:09:21 +0000
Subject: [PATCH v2 1/4] memremap: don't modify flags
In-Reply-To: <cover.1456225103.git.brian.starkey@arm.com>
References: <cover.1456225103.git.brian.starkey@arm.com>
Message-ID: <14384f41309a577b80f80356b6a38fce4241a6b1.1456225103.git.brian.starkey@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Don't modify the flags input argument to memremap(). MEMREMAP_WB is
already a special case so we can check for it directly instead of
clearing flag bits in each mapper.

Signed-off-by: Brian Starkey <brian.starkey@arm.com>
---
 kernel/memremap.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/memremap.c b/kernel/memremap.c
index 59c55af..92adb19 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -64,6 +64,9 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 				       IORESOURCE_SYSTEM_RAM, IORES_DESC_NONE);
 	void *addr = NULL;
 
+	if (!flags)
+		return NULL;
+
 	if (is_ram == REGION_MIXED) {
 		WARN_ONCE(1, "memremap attempted on mixed range %pa size: %#lx\n",
 				&offset, (unsigned long) size);
@@ -72,7 +75,6 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 
 	/* Try all mapping types requested until one returns non-NULL */
 	if (flags & MEMREMAP_WB) {
-		flags &= ~MEMREMAP_WB;
 		/*
 		 * MEMREMAP_WB is special in that it can be satisifed
 		 * from the direct map.  Some archs depend on the
@@ -86,21 +88,19 @@ void *memremap(resource_size_t offset, size_t size, unsigned long flags)
 	}
 
 	/*
-	 * If we don't have a mapping yet and more request flags are
-	 * pending then we will be attempting to establish a new virtual
+	 * If we don't have a mapping yet and other request flags are
+	 * present then we will be attempting to establish a new virtual
 	 * address mapping.  Enforce that this mapping is not aliasing
 	 * System RAM.
 	 */
-	if (!addr && is_ram == REGION_INTERSECTS && flags) {
+	if (!addr && is_ram == REGION_INTERSECTS && flags != MEMREMAP_WB) {
 		WARN_ONCE(1, "memremap attempted on ram %pa size: %#lx\n",
 				&offset, (unsigned long) size);
 		return NULL;
 	}
 
-	if (!addr && (flags & MEMREMAP_WT)) {
-		flags &= ~MEMREMAP_WT;
+	if (!addr && (flags & MEMREMAP_WT))
 		addr = ioremap_wt(offset, size);
-	}
 
 	return addr;
 }
-- 
1.7.9.5
