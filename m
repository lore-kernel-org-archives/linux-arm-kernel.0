From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Mon, 19 Sep 2016 17:38:55 -0400
Subject: [PATCH] arm64: migrate exception table users off module.h and onto
 extable.h
Message-ID: <20160919213855.5295-1-paul.gortmaker@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[see: https://lkml.org/lkml/2016/7/24/224 for additional context if needed]

 arch/arm64/kernel/probes/kprobes.c | 2 +-
 arch/arm64/mm/extable.c            | 2 +-
 arch/arm64/mm/fault.c              | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index bf9768588288..9c1866ef3271 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -19,7 +19,7 @@
 #include <linux/kasan.h>
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/slab.h>
 #include <linux/stop_machine.h>
 #include <linux/stringify.h>
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 81acd4706878..c9f118cd812b 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -2,7 +2,7 @@
  * Based on arch/arm/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index c8beaa0da7df..427f2fd49463 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -18,7 +18,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
 #include <linux/hardirq.h>
-- 
2.8.4
