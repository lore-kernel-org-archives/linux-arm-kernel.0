From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 13 Jun 2016 15:00:47 +0100
Subject: [PATCH 3/5] arm/arm64: KVM: Enforce HYP read-only mapping of the
 kernel's rodata section
In-Reply-To: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
References: <1465826449-14349-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1465826449-14349-4-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be able to use C code in HYP, we're now mapping the kernel's
rodata in HYP. It works absolutely fine, except that we're mapping it RWX,
which is not what it should be.

Add a new HYP_PAGE_RO protection, and pass it as the protection flags
when mapping the rodata section.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/pgtable.h        | 1 +
 arch/arm/kvm/arm.c                    | 2 +-
 arch/arm64/include/asm/pgtable-prot.h | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 348caab..f332087 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -98,6 +98,7 @@ extern pgprot_t		pgprot_s2_device;
 #define PAGE_KERNEL		_MOD_PROT(pgprot_kernel, L_PTE_XN)
 #define PAGE_KERNEL_EXEC	pgprot_kernel
 #define PAGE_HYP		_MOD_PROT(pgprot_kernel, L_PTE_HYP)
+#define PAGE_HYP_RO		_MOD_PROT(pgprot_kernel, L_PTE_HYP | L_PTE_RDONLY | L_PTE_XN)
 #define PAGE_HYP_DEVICE		_MOD_PROT(pgprot_hyp_device, L_PTE_HYP)
 #define PAGE_S2			_MOD_PROT(pgprot_s2, L_PTE_S2_RDONLY)
 #define PAGE_S2_DEVICE		_MOD_PROT(pgprot_s2_device, L_PTE_S2_RDONLY)
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 7978e15..0b5099f 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1292,7 +1292,7 @@ static int init_hyp_mode(void)
 	}
 
 	err = create_hyp_mappings(kvm_ksym_ref(__start_rodata),
-				  kvm_ksym_ref(__end_rodata), PAGE_HYP);
+				  kvm_ksym_ref(__end_rodata), PAGE_HYP_RO);
 	if (err) {
 		kvm_err("Cannot map rodata section\n");
 		goto out_err;
diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
index 29fcb33..88db58c 100644
--- a/arch/arm64/include/asm/pgtable-prot.h
+++ b/arch/arm64/include/asm/pgtable-prot.h
@@ -56,6 +56,7 @@
 #define PAGE_KERNEL_EXEC_CONT	__pgprot(_PAGE_DEFAULT | PTE_UXN | PTE_DIRTY | PTE_WRITE | PTE_CONT)
 
 #define PAGE_HYP		__pgprot(_PAGE_DEFAULT | PTE_HYP)
+#define PAGE_HYP_RO		__pgprot(_PAGE_DEFAULT | PTE_HYP | PTE_RDONLY | PTE_HYP_XN)
 #define PAGE_HYP_DEVICE		__pgprot(PROT_DEVICE_nGnRE | PTE_HYP)
 
 #define PAGE_S2			__pgprot(PROT_DEFAULT | PTE_S2_MEMATTR(MT_S2_NORMAL) | PTE_S2_RDONLY)
-- 
2.1.4
