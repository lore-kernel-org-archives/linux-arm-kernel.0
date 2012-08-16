From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 16 Aug 2012 16:36:09 +0100
Subject: [PATCH v3 17/25] xen/arm: implement alloc/free_xenballooned_pages
 with alloc_pages/kfree
In-Reply-To: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1208161618550.4850@kaball.uk.xensource.com>
Message-ID: <1345131377-14713-17-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only until we get the balloon driver to work.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/arm/xen/enlighten.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 14af29d..3348d90 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -148,3 +148,21 @@ static int __init xen_init_events(void)
 	return 0;
 }
 postcore_initcall(xen_init_events);
+
+/* XXX: only until balloon is properly working */
+int alloc_xenballooned_pages(int nr_pages, struct page **pages, bool highmem)
+{
+	*pages = alloc_pages(highmem ? GFP_HIGHUSER : GFP_KERNEL,
+			get_order(nr_pages));
+	if (*pages == NULL)
+		return -ENOMEM;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(alloc_xenballooned_pages);
+
+void free_xenballooned_pages(int nr_pages, struct page **pages)
+{
+	kfree(*pages);
+	*pages = NULL;
+}
+EXPORT_SYMBOL_GPL(free_xenballooned_pages);
-- 
1.7.2.5
