From: gking@nvidia.com (Gary King)
Date: Mon, 6 Sep 2010 15:37:12 -0700
Subject: bounce: call flush_dcache_page after bounce_copy_vec
Message-ID: <mailman.235.1283892872.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the bounced page needs to be flushed after data is copied into it,
to ensure that architecture implementations can synchronize
instruction and data caches if necessary.

Signed-off-by: Gary King <gking@nvidia.com>
---
 mm/bounce.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mm/bounce.c b/mm/bounce.c
index 13b6dad..1481de6 100644
--- a/mm/bounce.c
+++ b/mm/bounce.c
@@ -116,8 +116,8 @@ static void copy_to_high_bio_irq(struct bio *to, struct bio *from)
 		 */
 		vfrom = page_address(fromvec->bv_page) + tovec->bv_offset;
 
-		flush_dcache_page(tovec->bv_page);
 		bounce_copy_vec(tovec, vfrom);
+		flush_dcache_page(tovec->bv_page);
 	}
 }
 
-- 
1.7.0.4
