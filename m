From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 21 Apr 2015 12:08:51 +0200
Subject: [PATCH 1/2] ARM: include Thumb2 bit in PROCINFO setup function offset
In-Reply-To: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1429607205-7501-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1429610931-14903-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This updates the PROCINFO offset-to-setup-function fields of the
Thumb2 capable CPU definitions to include the Thumb bit when building
a Thumb2 kernel. This ensures that these function are always called
in the correct mode.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/mm/proc-v7.S  | 2 +-
 arch/arm/mm/proc-v7m.S | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index 3d1054f11a8a..eb3f66cb8ad0 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -492,7 +492,7 @@ __v7_setup_stack:
 			PMD_SECT_AF | PMD_FLAGS_UP | \mm_mmuflags)
 	.long	PMD_TYPE_SECT | PMD_SECT_AP_WRITE | \
 		PMD_SECT_AP_READ | PMD_SECT_AF | \io_mmuflags
-	initfn	\initfunc, \name
+	initfn	BSYM(\initfunc), \name
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_SWP | HWCAP_HALF | HWCAP_THUMB | HWCAP_FAST_MULT | \
diff --git a/arch/arm/mm/proc-v7m.S b/arch/arm/mm/proc-v7m.S
index e08e1f2bab76..e85c3b98d4b6 100644
--- a/arch/arm/mm/proc-v7m.S
+++ b/arch/arm/mm/proc-v7m.S
@@ -146,7 +146,7 @@ __v7m_proc_info:
 	.long	0x000f0000		@ Mask for ID
 	.long   0			@ proc_info_list.__cpu_mm_mmu_flags
 	.long   0			@ proc_info_list.__cpu_io_mmu_flags
-	initfn	__v7m_setup, __v7m_proc_info	@ proc_info_list.__cpu_flush
+	initfn	BSYM(__v7m_setup), __v7m_proc_info	@ proc_info_list.__cpu_flush
 	.long	cpu_arch_name
 	.long	cpu_elf_name
 	.long	HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT
-- 
1.8.3.2
