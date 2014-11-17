From: ydroneaud@opteya.com (Yann Droneaud)
Date: Tue, 18 Nov 2014 00:02:19 +0100
Subject: [PATCH] arm64/mm: Remove hack in mmap randomize layout
Message-ID: <1416265339-8138-1-git-send-email-ydroneaud@opteya.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 8a0a9bd4db63 ('random: make get_random_int() more
random'), get_random_int() returns a random value for each call,
so comment and hack introduced in mmap_rnd() as part of commit
1d18c47c735e ('arm64: MMU fault handling and page table management')
are incorrects.

Commit 1d18c47c735e seems to use the same hack introduced by
commit a5adc91a4b44 ('powerpc: Ensure random space between stack
and mmaps'), latter copied in commit 5a0efea09f42 ('sparc64: Sharpen
address space randomization calculations.').

But both architectures were cleaned up as part of commit
fa8cbaaf5a68 ('powerpc+sparc64/mm: Remove hack in mmap randomize
layout') as hack is no more needed since commit 8a0a9bd4db63.

So the present patch removes the comment and the hack around
get_random_int() on AArch64's mmap_rnd().

Cc: Dan McGee <dpmcgee@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Anton Blanchard <anton@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Fixes: 1d18c47c735e ('arm64: MMU fault handling and page table management')
Signed-off-by: Yann Droneaud <ydroneaud@opteya.com>
---
 arch/arm64/mm/mmap.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/mm/mmap.c b/arch/arm64/mm/mmap.c
index 1d73662f00ff..54922d1275b8 100644
--- a/arch/arm64/mm/mmap.c
+++ b/arch/arm64/mm/mmap.c
@@ -47,22 +47,14 @@ static int mmap_is_legacy(void)
 	return sysctl_legacy_va_layout;
 }
 
-/*
- * Since get_random_int() returns the same value within a 1 jiffy window, we
- * will almost always get the same randomisation for the stack and mmap
- * region. This will mean the relative distance between stack and mmap will be
- * the same.
- *
- * To avoid this we can shift the randomness by 1 bit.
- */
 static unsigned long mmap_rnd(void)
 {
 	unsigned long rnd = 0;
 
 	if (current->flags & PF_RANDOMIZE)
-		rnd = (long)get_random_int() & (STACK_RND_MASK >> 1);
+		rnd = (long)get_random_int() & STACK_RND_MASK;
 
-	return rnd << (PAGE_SHIFT + 1);
+	return rnd << PAGE_SHIFT;
 }
 
 static unsigned long mmap_base(void)
-- 
1.9.3
