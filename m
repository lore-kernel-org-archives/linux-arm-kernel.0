From: ratbert.chuang@gmail.com (Po-Yu Chuang)
Date: Tue, 15 Mar 2011 14:13:57 +0800
Subject: [PATCH v2] arm: cmpxchg syscall should data abort if page not write
In-Reply-To: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
References: <1300098516-1601-1-git-send-email-ratbert.chuang@gmail.com>
Message-ID: <1300169637-1628-1-git-send-email-ratbert.chuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Po-Yu Chuang <ratbert@faraday-tech.com>

If the page to cmpxchg is user mode read only (not write),
we should simulate a data abort first.

Signed-off-by: Po-Yu Chuang <ratbert@faraday-tech.com>
---
v2:
remove !pte_young() check

 arch/arm/kernel/traps.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 446aee9..eac7c05 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -563,7 +563,7 @@ asmlinkage int arm_syscall(int no, struct pt_regs *regs)
 		if (!pmd_present(*pmd))
 			goto bad_access;
 		pte = pte_offset_map_lock(mm, pmd, addr, &ptl);
-		if (!pte_present(*pte) || !pte_dirty(*pte)) {
+		if (!pte_present(*pte) || !pte_write(*pte) || !pte_dirty(*pte)) {
 			pte_unmap_unlock(pte, ptl);
 			goto bad_access;
 		}
-- 
1.6.3.3
