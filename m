From: julien.grall@citrix.com (Julien Grall)
Date: Tue, 28 Jul 2015 16:02:44 +0100
Subject: [PATCH 3/8] arm/xen: implement correctly pfn_to_mfn
In-Reply-To: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
References: <1438095769-2560-1-git-send-email-julien.grall@citrix.com>
Message-ID: <1438095769-2560-4-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After the commit introducing convertion between DMA and guest address,
all the callers of pfn_to_mfn are expecting to get a GFN (Guest Frame
Number). On ARM, all the guests are auto-translated so the GFN is equal
to the Linux PFN (Pseudo-physical Frame Number).

The current implementation may return an MFN if the caller is passing a
PFN associated to a mapped foreign grant. In pratical, I haven't seen
the problem on running guest but we should fix it for the sake of
correctness.

Correct the implementation by always returning the pfn passed in parameter.

A follow-up patch will take care to rename pfn_to_mfn to a suitable
name.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/include/asm/xen/page.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/include/asm/xen/page.h b/arch/arm/include/asm/xen/page.h
index 6c9f6d2..493471f 100644
--- a/arch/arm/include/asm/xen/page.h
+++ b/arch/arm/include/asm/xen/page.h
@@ -36,14 +36,6 @@ extern struct rb_root phys_to_mach;
 
 static inline unsigned long pfn_to_mfn(unsigned long pfn)
 {
-	unsigned long mfn;
-
-	if (phys_to_mach.rb_node != NULL) {
-		mfn = __pfn_to_mfn(pfn);
-		if (mfn != INVALID_P2M_ENTRY)
-			return mfn;
-	}
-
 	return pfn;
 }
 
-- 
2.1.4
