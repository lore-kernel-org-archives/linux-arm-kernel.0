From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 17 Jun 2013 19:17:41 -0700
Subject: [RFC PATCH 2/2] arm64: KVM: Fix build errors after 32-bit THP support
In-Reply-To: <1371521861-372-1-git-send-email-christoffer.dall@linaro.org>
References: <1371521861-372-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1371521861-372-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When KVM 32-bit adds THP support the build of KVM/arm64 will break
because we rename some definition to be more sane and change the
interface to coherent_icache_guest_page.

Huge pages are not supported on arm64 and the pgtable predicates will
always return false, so this shouldn't change any functionality on the
64-bit side.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/include/asm/kvm_host.h | 4 ++--
 arch/arm64/include/asm/kvm_mmu.h  | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 644d739..f5d73dc 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -38,8 +38,8 @@
 
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
-#define KVM_NR_PAGE_SIZES	1
-#define KVM_PAGES_PER_HPAGE(x)	(1UL<<31)
+#define KVM_HPAGE_SIZE		1
+#define KVM_PAGES_PER_HPAGE	(1UL<<31)
 
 struct kvm_vcpu;
 int kvm_target_cpu(void);
diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index efe609c..c86749e 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -118,11 +118,11 @@ static inline void kvm_set_s2pte_writable(pte_t *pte)
 
 struct kvm;
 
-static inline void coherent_icache_guest_page(struct kvm *kvm, gfn_t gfn)
+static inline void coherent_icache_guest_page(struct kvm *kvm, hva_t hva,
+					      size_t size)
 {
 	if (!icache_is_aliasing()) {		/* PIPT */
-		unsigned long hva = gfn_to_hva(kvm, gfn);
-		flush_icache_range(hva, hva + PAGE_SIZE);
+		flush_icache_range(hva, hva + size);
 	} else if (!icache_is_aivivt()) {	/* non ASID-tagged VIVT */
 		/* any kind of VIPT cache */
 		__flush_icache_all();
-- 
1.8.1.2
