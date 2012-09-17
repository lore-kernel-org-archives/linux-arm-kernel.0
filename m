From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 17 Sep 2012 18:38:50 +0100
Subject: [PATCH v5 04/17] xen/arm: sync_bitops
In-Reply-To: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1209171215490.29232@kaball.uk.xensource.com>
Message-ID: <1347903543-2135-4-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sync_bitops functions are equivalent to the SMP implementation of the
original functions, independently from CONFIG_SMP being defined.

We need them because _set_bit etc are not SMP safe if !CONFIG_SMP. But
under Xen you might be communicating with a completely external entity
who might be on another CPU (e.g. two uniprocessor guests communicating
via event channels and grant tables). So we need a variant of the bit
ops which are SMP safe even on a UP kernel.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Acked-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 arch/arm/include/asm/sync_bitops.h |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/sync_bitops.h

diff --git a/arch/arm/include/asm/sync_bitops.h b/arch/arm/include/asm/sync_bitops.h
new file mode 100644
index 0000000..63479ee
--- /dev/null
+++ b/arch/arm/include/asm/sync_bitops.h
@@ -0,0 +1,27 @@
+#ifndef __ASM_SYNC_BITOPS_H__
+#define __ASM_SYNC_BITOPS_H__
+
+#include <asm/bitops.h>
+#include <asm/system.h>
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
+#define sync_set_bit(nr, p)		_set_bit(nr, p)
+#define sync_clear_bit(nr, p)		_clear_bit(nr, p)
+#define sync_change_bit(nr, p)		_change_bit(nr, p)
+#define sync_test_and_set_bit(nr, p)	_test_and_set_bit(nr, p)
+#define sync_test_and_clear_bit(nr, p)	_test_and_clear_bit(nr, p)
+#define sync_test_and_change_bit(nr, p)	_test_and_change_bit(nr, p)
+#define sync_test_bit(nr, addr)		test_bit(nr, addr)
+#define sync_cmpxchg			cmpxchg
+
+
+#endif
-- 
1.7.2.5
