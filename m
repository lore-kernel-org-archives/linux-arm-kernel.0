From: will.deacon@arm.com (Will Deacon)
Date: Wed, 20 Jun 2018 16:23:47 +0100
Subject: [PATCH] arm64: kpti: Use early_param for kpti= command-line option
Message-ID: <1529508227-24331-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We inspect __kpti_forced early on as part of the cpufeature enable
callback which remaps the swapper page table using non-global entries.

Ensure that __kpti_forced has been updated to reflect the kpti=
command-line option before we start using it.

Reported-by: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/cpufeature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index d2856b129097..112b071e793f 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -937,7 +937,7 @@ static int __init parse_kpti(char *str)
 	__kpti_forced = enabled ? 1 : -1;
 	return 0;
 }
-__setup("kpti=", parse_kpti);
+early_param("kpti=", parse_kpti);
 #endif	/* CONFIG_UNMAP_KERNEL_AT_EL0 */
 
 #ifdef CONFIG_ARM64_HW_AFDBM
-- 
2.1.4
