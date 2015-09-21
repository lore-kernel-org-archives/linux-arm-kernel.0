From: salyzyn@android.com (Mark Salyzyn)
Date: Mon, 21 Sep 2015 13:39:50 -0700
Subject: ARM64 readahead: fault retry breaks mmap file read random detection
Message-ID: <1442868028-27055-1-git-send-email-salyzyn@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Description from commit 45cac65b0fcd
    ("readahead: fault retry breaks mmap file read random detection")

.fault now can retry.  The retry can break state machine of .fault.  In
filemap_fault, if page is miss, ra->mmap_miss is increased.  In the second
try, since the page is in page cache now, ra->mmap_miss is decreased.  And
these are done in one fault, so we can't detect random mmap file access.

Add a new flag to indicate .fault is tried once.  In the second try, skip
ra->mmap_miss decreasing.  The filemap_fault state machine is ok with it.

I only tested x86, didn't test other archs, but looks the change for other
archs is obvious, but who knows :)

< snip >

Yup, arm64 needs this too! Random read improves by 250%, sequential
read improves by 40%, and random write by 400% to an eMMC device with
dm crypto wrapped around it.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
Signed-off-by: Riley Andrews <riandrews@android.com>
Cc: Shaohua Li <shli@kernel.org>
Cc: Shaohua Li <shaohua.li@fusionio.com>
Cc: Rik van Riel <riel@redhat.com>
Cc: Wu Fengguang <fengguang.wu@intel.com>
---
 arch/arm64/mm/fault.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index aba9ead..9fadf6d 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -287,6 +287,7 @@ retry:
 			 * starvation.
 			 */
 			mm_flags &= ~FAULT_FLAG_ALLOW_RETRY;
+			mm_flags |= FAULT_FLAG_TRIED;
 			goto retry;
 		}
 	}
-- 
2.6.0.rc0.131.gf624c3d
