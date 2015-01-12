From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 12 Jan 2015 19:36:48 +0000
Subject: [PATCH 2/2] arm64: mm: dump: add missing includes
In-Reply-To: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
References: <1421091408-10660-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421091408-10660-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 dump code is currently relying on some definitions which are
pulled in via transitive dependencies. While current build issues have
been fixed by a separate patch, it seems we have implicit dependencies
on the following definitions:

* MODULES_VADDR         (asm/memory.h)
* MODULES_END           (asm/memory.h)
* PAGE_OFFSET           (asm/memory.h)
* PTE_*                 (asm/pgtable-hwdef.h)
* ENOMEM                (linux/errno.h)
* device_initcall       (linux/init.h)

This patch ensures we explicitly include the relevant headers for the
above items, hopefully preventing future issues as headers are
refactored.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Mark Brown <broonie@kernel.org>
Cc: Steve Capper <steve.capper@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Will Deacon <Will.Deacon@arm.com>
---
 arch/arm64/mm/dump.c | 4 ++++
 1 file changed, 4 insertions(+)

This was previously posted as a standalone patch [1]. As patch 1 fixes
the original issue, this patch has been modified to fix the remaining
potential issues that we don't yet seem to be hitting. I've also taken
Russell's advice to use linux/errno.h.

Steve, I've dropped your ack now that the fix for the original issue is
in patch 1. Hopefully that's just a formality :)

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-January/315326.html

diff --git a/arch/arm64/mm/dump.c b/arch/arm64/mm/dump.c
index 203a6cf..48a4a2f 100644
--- a/arch/arm64/mm/dump.c
+++ b/arch/arm64/mm/dump.c
@@ -14,13 +14,17 @@
  * of the License.
  */
 #include <linux/debugfs.h>
+#include <linux/errno.h>
 #include <linux/fs.h>
+#include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/sched.h>
 #include <linux/seq_file.h>
 
 #include <asm/fixmap.h>
+#include <asm/memory.h>
 #include <asm/pgtable.h>
+#include <asm/pgtable-hwdef.h>
 
 #define LOWEST_ADDR	(UL(0xffffffffffffffff) << VA_BITS)
 
-- 
1.9.1
