From: mark.rutland@arm.com (Mark Rutland)
Date: Tue,  6 Oct 2015 18:24:37 +0100
Subject: [PATCH] arm64: Don't relocate non-existent initrd
Message-ID: <1444152277-826-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When booting a kernel without an initrd, the kernel reports that it
moves -1 bytes worth, having gone through the motions with initrd_start
equal to initrd_end:

    Moving initrd from [4080000000-407fffffff] to [9fff49000-9fff48fff]

Prevent this by bailing out early when the initrd size is zero (i.e. we
have no initrd), avoiding the confusing message and other associated
work.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Fixes: 1570f0d7ab425c1e ("arm64: support initrd outside kernel linear map")
Cc: Mark Salter <msalter@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 6bab21f..2322479 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -364,6 +364,8 @@ static void __init relocate_initrd(void)
 		to_free = ram_end - orig_start;
 
 	size = orig_end - orig_start;
+	if (!size)
+		return;
 
 	/* initrd needs to be relocated completely inside linear mapping */
 	new_start = memblock_find_in_range(0, PFN_PHYS(max_pfn),
-- 
1.9.1
