From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Jun 2018 13:50:07 +0200
Subject: [PATCH] arm64: cpu_errata: include required headers
Message-ID: <20180605115227.1621618-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without including psci.h and arm-smccc.h, we now get a build failure in
some configurations:

arch/arm64/kernel/cpu_errata.c: In function 'arm64_update_smccc_conduit':
arch/arm64/kernel/cpu_errata.c:278:10: error: 'psci_ops' undeclared (first use in this function); did you mean 'sysfs_ops'?

arch/arm64/kernel/cpu_errata.c: In function 'arm64_set_ssbd_mitigation':
arch/arm64/kernel/cpu_errata.c:311:3: error: implicit declaration of function 'arm_smccc_1_1_hvc' [-Werror=implicit-function-declaration]
   arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_WORKAROUND_2, state, NULL);

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This showed up only recently, but I have not bisected what caused it.
---
 arch/arm64/kernel/cpu_errata.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 2b9a31a6a16a..1d2b6d768efe 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -16,6 +16,8 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/arm-smccc.h>
+#include <linux/psci.h>
 #include <linux/types.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
-- 
2.9.0
