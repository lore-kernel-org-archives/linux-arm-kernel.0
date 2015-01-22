From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 22 Jan 2015 18:20:36 +0000
Subject: [PATCHv2 2/2] arm64: mm: dump: add missing includes
In-Reply-To: <1421950836-19869-1-git-send-email-mark.rutland@arm.com>
References: <1421950836-19869-1-git-send-email-mark.rutland@arm.com>
Message-ID: <1421950836-19869-3-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The arm64 dump code is currently relying on some definitions which are
pulled in via transitive dependencies. It seems we have implicit
dependencies on the following definitions:

* MODULES_VADDR         (asm/memory.h)
* MODULES_END           (asm/memory.h)
* PAGE_OFFSET           (asm/memory.h)
* PTE_*                 (asm/pgtable-hwdef.h)
* ENOMEM                (linux/errno.h)
* device_initcall       (linux/init.h)

This patch ensures we explicitly include the relevant headers for the
above items, fixing the observed build issue and hopefully preventing
future issues as headers are refactored.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Reported-by: Mark Brown <broonie@kernel.org>
Acked-by: Steve Capper <steve.capper@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Laura Abbott <lauraa@codeaurora.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/mm/dump.c | 4 ++++
 1 file changed, 4 insertions(+)

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
