From: will.deacon@arm.com (Will Deacon)
Date: Mon, 29 Jan 2018 11:59:54 +0000
Subject: [PATCH v2 3/9] arm64: mm: Permit transitioning from Global to
 Non-Global without BBM
In-Reply-To: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
References: <1517227200-20412-1-git-send-email-will.deacon@arm.com>
Message-ID: <1517227200-20412-4-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Break-before-make is not needed when transitioning from Global to
Non-Global mappings, provided that the contiguous hint is not being used.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index b44992ec9643..fc7902bda02b 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -118,6 +118,10 @@ static bool pgattr_change_is_safe(u64 old, u64 new)
 	if ((old | new) & PTE_CONT)
 		return false;
 
+	/* Transitioning from Global to Non-Global is safe */
+	if (((old ^ new) == PTE_NG) && (new & PTE_NG))
+		return true;
+
 	return ((old ^ new) & ~mask) == 0;
 }
 
-- 
2.1.4
