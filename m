From: junxiao.bi@windriver.com (Junxiao Bi)
Date: Thu, 8 Dec 2011 18:07:51 +0800
Subject: [PATCH 5/6] MTD: map: fix big endian support
In-Reply-To: <1323338872-24716-1-git-send-email-junxiao.bi@windriver.com>
References: <1323338872-24716-1-git-send-email-junxiao.bi@windriver.com>
Message-ID: <1323338872-24716-6-git-send-email-junxiao.bi@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use read*/write*_relaxed to replace __raw_read*/__raw_write*
to make it work in both endians.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: linux-mtd at lists.infradead.org
Signed-off-by: Junxiao Bi <junxiao.bi@windriver.com>
---
 include/linux/mtd/map.h |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/mtd/map.h b/include/linux/mtd/map.h
index a9e6ba4..74b266d 100644
--- a/include/linux/mtd/map.h
+++ b/include/linux/mtd/map.h
@@ -393,14 +393,14 @@ static inline map_word inline_map_read(struct map_info *map, unsigned long ofs)
 	map_word r;
 
 	if (map_bankwidth_is_1(map))
-		r.x[0] = __raw_readb(map->virt + ofs);
+		r.x[0] = readb_relaxed(map->virt + ofs);
 	else if (map_bankwidth_is_2(map))
-		r.x[0] = __raw_readw(map->virt + ofs);
+		r.x[0] = readw_relaxed(map->virt + ofs);
 	else if (map_bankwidth_is_4(map))
-		r.x[0] = __raw_readl(map->virt + ofs);
+		r.x[0] = readl_relaxed(map->virt + ofs);
 #if BITS_PER_LONG >= 64
 	else if (map_bankwidth_is_8(map))
-		r.x[0] = __raw_readq(map->virt + ofs);
+		r.x[0] = readq_relaxed(map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
 		memcpy_fromio(r.x, map->virt+ofs, map->bankwidth);
@@ -413,14 +413,14 @@ static inline map_word inline_map_read(struct map_info *map, unsigned long ofs)
 static inline void inline_map_write(struct map_info *map, const map_word datum, unsigned long ofs)
 {
 	if (map_bankwidth_is_1(map))
-		__raw_writeb(datum.x[0], map->virt + ofs);
+		writeb_relaxed(datum.x[0], map->virt + ofs);
 	else if (map_bankwidth_is_2(map))
-		__raw_writew(datum.x[0], map->virt + ofs);
+		writew_relaxed(datum.x[0], map->virt + ofs);
 	else if (map_bankwidth_is_4(map))
-		__raw_writel(datum.x[0], map->virt + ofs);
+		writel_relaxed(datum.x[0], map->virt + ofs);
 #if BITS_PER_LONG >= 64
 	else if (map_bankwidth_is_8(map))
-		__raw_writeq(datum.x[0], map->virt + ofs);
+		writeq_relaxed(datum.x[0], map->virt + ofs);
 #endif
 	else if (map_bankwidth_is_large(map))
 		memcpy_toio(map->virt+ofs, datum.x, map->bankwidth);
-- 
1.7.0.4
