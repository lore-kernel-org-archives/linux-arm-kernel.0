From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 25 Oct 2013 11:51:39 +0100
Subject: [PATCH v9 04/18] xen/x86: allow __set_phys_to_machine for
 autotranslate guests
In-Reply-To: <alpine.DEB.2.02.1310251144020.26077@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1310251144020.26077@kaball.uk.xensource.com>
Message-ID: <1382698313-13161-4-git-send-email-stefano.stabellini@eu.citrix.com>
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
index a61c7d5..2ae8699 100644
--- a/arch/x86/xen/p2m.c
+++ b/arch/x86/xen/p2m.c
@@ -799,10 +799,10 @@ bool __set_phys_to_machine(unsigned long pfn, unsigned long mfn)
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
