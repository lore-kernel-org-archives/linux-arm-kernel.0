From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 17 Oct 2013 18:43:19 +0100
Subject: [PATCH v8 04/19] xen/x86: allow __set_phys_to_machine for
 autotranslate guests
In-Reply-To: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310171833520.26077@kaball.uk.xensource.com>
Message-ID: <1382031814-8782-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow __set_phys_to_machine to be called for autotranslate guests.
It can be used to keep track of phys_to_machine changes, however we
don't do anything with the information at the moment.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/x86/xen/p2m.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/xen/p2m.c b/arch/x86/xen/p2m.c
index 95fb2aa..59d9e70 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -798,10 +798,10 @@ bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn)
 {
 	unsigned topidx, mididx, idx;
 
-	if (unlikely(xen_feature(XENFEAT_auto_translated_physmap))) {
-		BUG_ON(pfn != mfn && mfn != INVALID_P2M_ENTRY);
+	/* don't track P2M changes in autotranslate guests */
+	if (unlikely(xen_feature(XENFEAT_auto_translated_physmap)))
 		return true;
-	}
+
 	if (unlikely(pfn >= MAX_P2M_PFN)) {
 		BUG_ON(mfn != INVALID_P2M_ENTRY);
 		return true;
-- 
1.7.2.5
