From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Mon, 29 Mar 2010 12:26:31 +0300
Subject: [RFC 05/10] arm: kdump: make kexec work in interrupt context
In-Reply-To: <5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
References: <cover.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<7b747cd930c20ae4a625c981d88e2773c706fce9.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<e3c9449c42a735f9acee8e50af33762ffcadf7b4.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<0f8c479602b8957c49db7ac56b8f90ac6f4da5dc.1269854500.git.ext-mika.1.westerberg@nokia.com>
	<5d4c557a427346c129c8f6cc43c5819177c05ff5.1269854500.git.ext-mika.1.westerberg@nokia.com>
Message-ID: <f05417b66eedd3c1fe32b433dcdae71a2a151da5.1269854500.git.ext-mika.1.westerberg@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When crash happens in interrupt context there is no userspace context. We always
use current->active_mm in those cases.

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/mm/mmu.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 9d4da6a..7bf192e 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1050,10 +1050,12 @@ void setup_mm_for_reboot(char mode)
 	pgd_t *pgd;
 	int i;
 
-	if (current->mm && current->mm->pgd)
-		pgd = current->mm->pgd;
-	else
-		pgd = init_mm.pgd;
+	/*
+	 * We need to access to user-mode page tables here. For kernel threads
+	 * we don't have any user-mode mappings so we use the context that we
+	 * "borrowed".
+	 */
+	pgd = current->active_mm->pgd;
 
 	base_pmdval = PMD_SECT_AP_WRITE | PMD_SECT_AP_READ | PMD_TYPE_SECT;
 	if (cpu_architecture() <= CPU_ARCH_ARMv5TEJ && !cpu_is_xscale())
-- 
1.5.6.5
