From: julien.grall@citrix.com (Julien Grall)
Date: Thu, 14 May 2015 18:00:50 +0100
Subject: [RFC 10/23] xen/biomerge: WORKAROUND always says the biovec are not
 mergeable
In-Reply-To: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
References: <1431622863-28575-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1431622863-28575-11-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When Linux is using 64K page granularity, every page will be slipt in
multiple non-contiguous 4K MFN.

I'm not sure how to handle efficiently the check to know whether we can
merge 2 biovec with a such case. So for now, always says that biovec are
not mergeable.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
---
 drivers/xen/biomerge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/xen/biomerge.c b/drivers/xen/biomerge.c
index 0edb91c..20387c2 100644
--- a/drivers/xen/biomerge.c
+++ b/drivers/xen/biomerge.c
@@ -9,6 +9,9 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 	unsigned long mfn1 = pfn_to_mfn(page_to_pfn(vec1->bv_page));
 	unsigned long mfn2 = pfn_to_mfn(page_to_pfn(vec2->bv_page));
 
+	/* TODO: Implement it correctly */
+	return 0;
+
 	return __BIOVEC_PHYS_MERGEABLE(vec1, vec2) &&
 		((mfn1 == mfn2) || ((mfn1+1) == mfn2));
 }
-- 
2.1.4
