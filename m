From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 18 Dec 2017 17:39:10 +0000
Subject: [PATCH v3 03/19] arm64: asm-offsets: Remove potential circular
 dependency
In-Reply-To: <20171218173926.16911-1-marc.zyngier@arm.com>
References: <20171218173926.16911-1-marc.zyngier@arm.com>
Message-ID: <20171218173926.16911-4-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far, we've been lucky enough that none of the include files
that asm-offsets.c requires include asm-offsets.h. This is
about to change, and would introduce a nasty circular dependency...

Let's now guard the inclusion of asm-offsets.h so that it never
gets pulled from asm-offsets.c. The same issue exists between
bounce.c and include/generated/bounds.h, and is worked around
by using the existing guard symbol.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/asm-offsets.h | 2 ++
 arch/arm64/kernel/asm-offsets.c      | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/include/asm/asm-offsets.h b/arch/arm64/include/asm/asm-offsets.h
index d370ee36a182..7d6531a81eb3 100644
--- a/arch/arm64/include/asm/asm-offsets.h
+++ b/arch/arm64/include/asm/asm-offsets.h
@@ -1 +1,3 @@
+#if !defined(__GENERATING_ASM_OFFSETS_H) && !defined(__GENERATING_BOUNDS_H)
 #include <generated/asm-offsets.h>
+#endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 742887330101..5ab8841af382 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -18,6 +18,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#define __GENERATING_ASM_OFFSETS_H	1
+
 #include <linux/sched.h>
 #include <linux/mm.h>
 #include <linux/dma-mapping.h>
-- 
2.14.2
