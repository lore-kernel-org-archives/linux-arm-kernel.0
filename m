From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon,  9 Jan 2017 01:24:42 -0500
Subject: [RFC 46/55] KVM: arm64: Add more info to the S2 translation result
In-Reply-To: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
References: <1483943091-1364-1-git-send-email-jintack@cs.columbia.edu>
Message-ID: <1483943091-1364-47-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christoffer Dall <christoffer.dall@linaro.org>

When translating an L2 IPA to an L1 IPA, we some times need to know at
which level this translation occurred and what the resulting permissions
was, so populate the translation result structure with these additional
fields.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
Signed-off-by: Jintack Lim <jintack@cs.columbia.edu>
---
 arch/arm64/include/asm/kvm_mmu.h | 3 +++
 arch/arm64/kvm/mmu-nested.c      | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
index bf94f0c..2ac603d 100644
--- a/arch/arm64/include/asm/kvm_mmu.h
+++ b/arch/arm64/include/asm/kvm_mmu.h
@@ -327,6 +327,9 @@ static inline unsigned int kvm_get_vmid_bits(void)
 struct kvm_s2_trans {
 	phys_addr_t output;
 	phys_addr_t block_size;
+	bool writable;
+	bool readable;
+	int level;
 };
 
 #ifdef CONFIG_KVM_ARM_NESTED_HYP
diff --git a/arch/arm64/kvm/mmu-nested.c b/arch/arm64/kvm/mmu-nested.c
index b161b55..b579d23 100644
--- a/arch/arm64/kvm/mmu-nested.c
+++ b/arch/arm64/kvm/mmu-nested.c
@@ -236,6 +236,9 @@ static int walk_nested_s2_pgd(struct kvm_vcpu *vcpu, phys_addr_t ipa,
 		(ipa & GENMASK_ULL(addr_bottom - 1, 0));
 	out->output = paddr;
 	out->block_size = 1UL << ((3 - level) * stride + wi->pgshift);
+	out->readable = desc & (0b01 << 6);
+	out->writable = desc & (0b10 << 6);
+	out->level = level;
 	return 0;
 }
 
-- 
1.9.1
