From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 26 Aug 2014 11:28:46 +0100
Subject: [PATCH 2/6] arm64: Create arch debugfs directory
In-Reply-To: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
Message-ID: <1409048930-21598-3-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Create an arm64 directory in debugfs as a container for the
arch related debug entries. The patch provides the arch_debugfs_dir
prototype expected by core layers.

Acked-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 arch/arm64/kernel/setup.c |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 7ec7846..cf4cec0 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/debugfs.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/stddef.h>
@@ -398,6 +399,19 @@ static int __init arm64_device_init(void)
 }
 arch_initcall_sync(arm64_device_init);
 
+struct dentry *arch_debugfs_dir;
+EXPORT_SYMBOL(arch_debugfs_dir);
+
+static int __init arch_kdebugfs_init(void)
+{
+	arch_debugfs_dir = debugfs_create_dir("arm64", NULL);
+	if (IS_ERR_OR_NULL(arch_debugfs_dir))
+		return -ENOMEM;
+
+	return 0;
+}
+arch_initcall(arch_kdebugfs_init);
+
 static DEFINE_PER_CPU(struct cpu, cpu_data);
 
 static int __init topology_init(void)
-- 
1.7.10.4
