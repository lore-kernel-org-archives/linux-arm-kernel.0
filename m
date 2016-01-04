From: mark.rutland@arm.com (Mark Rutland)
Date: Mon,  4 Jan 2016 17:56:38 +0000
Subject: [PATCHv2 05/18] arm64: unmap idmap earlier
In-Reply-To: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1451930211-22460-6-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

During boot we leave the idmap in place until paging_init, as we
previously had to wait for the zero page to become allocated and
accessible.

Now that we have a statically-allocated zero page, we can uninstall the
idmap much earlier in the boot process, making it far eaier to spot
accidental use of physical addresses. This also brings the cold boot
path in line with the secondary boot path.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Jeremy Linton <jeremy.linton@arm.com>
Cc: Laura Abbott <labbott@fedoraproject.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 6 ++++++
 arch/arm64/mm/mmu.c       | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f6621ba..cfed56f 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -314,6 +314,12 @@ void __init setup_arch(char **cmdline_p)
 	 */
 	local_async_enable();
 
+	/*
+	 * TTBR0 is only used for the identity mapping at this stage. Make it
+	 * point to zero page to avoid speculatively fetching new entries.
+	 */
+	cpu_uninstall_idmap();
+
 	efi_init();
 	arm64_memblock_init();
 
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e85a719..c3ea9df 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -463,12 +463,6 @@ void __init paging_init(void)
 	fixup_executable();
 
 	bootmem_init();
-
-	/*
-	 * TTBR0 is only used for the identity mapping at this stage. Make it
-	 * point to zero page to avoid speculatively fetching new entries.
-	 */
-	cpu_uninstall_idmap();
 }
 
 /*
-- 
1.9.1
