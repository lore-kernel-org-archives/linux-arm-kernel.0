From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 30 May 2013 17:18:31 +0100
Subject: [PATCH RFC 4/6] arm64/xen: introduce asm/hypervisor.h and sys_bitops.h
In-Reply-To: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1305301705500.4799@kaball.uk.xensource.com>
Message-ID: <1369930713-6063-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 arch/arm64/include/asm/hypervisor.h  |    6 ++++++
 arch/arm64/include/asm/sync_bitops.h |   26 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/include/asm/hypervisor.h
 create mode 100644 arch/arm64/include/asm/sync_bitops.h

diff --git a/arch/arm64/include/asm/hypervisor.h b/arch/arm64/include/asm/hypervisor.h
new file mode 100644
index 0000000..b90d9e5
--- /dev/null
+++ b/arch/arm64/include/asm/hypervisor.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_ARM_HYPERVISOR_H
+#define _ASM_ARM_HYPERVISOR_H
+
+#include <asm/xen/hypervisor.h>
+
+#endif
diff --git a/arch/arm64/include/asm/sync_bitops.h b/arch/arm64/include/asm/sync_bitops.h
new file mode 100644
index 0000000..8da0bf4
--- /dev/null
+++ b/arch/arm64/include/asm/sync_bitops.h
@@ -0,0 +1,26 @@
+#ifndef __ASM_SYNC_BITOPS_H__
+#define __ASM_SYNC_BITOPS_H__
+
+#include <asm/bitops.h>
+#include <asm/cmpxchg.h>
+
+/* sync_bitops functions are equivalent to the SMP implementation of the
+ * original functions, independently from CONFIG_SMP being defined.
+ *
+ * We need them because _set_bit etc are not SMP safe if !CONFIG_SMP. But
+ * under Xen you might be communicating with a completely external entity
+ * who might be on another CPU (e.g. two uniprocessor guests communicating
+ * via event channels and grant tables). So we need a variant of the bit
+ * ops which are SMP safe even on a UP kernel.
+ */
+
+#define sync_set_bit(nr, p)            set_bit(nr, p)
+#define sync_clear_bit(nr, p)          clear_bit(nr, p)
+#define sync_change_bit(nr, p)         change_bit(nr, p)
+#define sync_test_and_set_bit(nr, p)   test_and_set_bit(nr, p)
+#define sync_test_and_clear_bit(nr, p) test_and_clear_bit(nr, p)
+#define sync_test_and_change_bit(nr, p)        test_and_change_bit(nr, p)
+#define sync_test_bit(nr, addr)                test_bit(nr, addr)
+#define sync_cmpxchg                   cmpxchg
+
+#endif
-- 
1.7.2.5
