From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  8 Aug 2013 21:07:17 -0700
Subject: [PATCH 1/3] KVM: Move gfn_to_index to x86 specific code
In-Reply-To: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
References: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1376021239-10532-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The gfn_to_index function relies on huge page defines which either may
not make sense on systems that don't support huge pages or are defined
in an unconvenient way for other architectures.  Since this is
x86-specific, move the function to arch/x86/include/asm/kvm_host.h.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/x86/include/asm/kvm_host.h |    7 +++++++
 include/linux/kvm_host.h        |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f87f7fc..fca7f2e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -79,6 +79,13 @@
 #define KVM_HPAGE_MASK(x)	(~(KVM_HPAGE_SIZE(x) - 1))
 #define KVM_PAGES_PER_HPAGE(x)	(KVM_HPAGE_SIZE(x) / PAGE_SIZE)
 
+static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
+{
+	/* KVM_HPAGE_GFN_SHIFT(PT_PAGE_TABLE_LEVEL) must be 0. */
+	return (gfn >> KVM_HPAGE_GFN_SHIFT(level)) -
+		(base_gfn >> KVM_HPAGE_GFN_SHIFT(level));
+}
+
 #define SELECTOR_TI_MASK (1 << 2)
 #define SELECTOR_RPL_MASK 0x03
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a63d83e..635e098 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -828,13 +828,6 @@ static inline int memslot_id(struct kvm *kvm, gfn_t gfn)
 	return gfn_to_memslot(kvm, gfn)->id;
 }
 
-static inline gfn_t gfn_to_index(gfn_t gfn, gfn_t base_gfn, int level)
-{
-	/* KVM_HPAGE_GFN_SHIFT(PT_PAGE_TABLE_LEVEL) must be 0. */
-	return (gfn >> KVM_HPAGE_GFN_SHIFT(level)) -
-		(base_gfn >> KVM_HPAGE_GFN_SHIFT(level));
-}
-
 static inline gfn_t
 hva_to_gfn_memslot(unsigned long hva, struct kvm_memory_slot *slot)
 {
-- 
1.7.10.4
