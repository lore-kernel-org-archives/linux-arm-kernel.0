From: philipp.tomsich@theobroma-systems.com (Philipp Tomsich)
Date: Mon, 13 Apr 2015 21:44:30 +0200
Subject: [PATCH v4 20/24] arm64:ilp32: use compat-syscalls for msgsnd and
 msgrcv for ILP32
In-Reply-To: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
Message-ID: <649a5110365ed1bac99b91eb88e65425eb61ca29.1428953303.git.philipp.tomsich@theobroma-systems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

msgsnd and msgrcv require the compat-layer, as they are defined to
use data structures with a 'long' (32bit in ILP32, 64bit in LP64)
element.

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
---
 arch/arm64/kernel/sys_ilp32.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/sys_ilp32.c b/arch/arm64/kernel/sys_ilp32.c
index 06c05ce..3471f27 100644
--- a/arch/arm64/kernel/sys_ilp32.c
+++ b/arch/arm64/kernel/sys_ilp32.c
@@ -1,9 +1,12 @@
 /*
- * AArch64- ILP32 specific system calls implementation
+ * AArch64: ILP32 specific system calls implementation
  *
  * Copyright (C) 2013 Cavium Inc.
  * Author: Andrew Pinski <apinski@cavium.com>
  *
+ * Copyright (C) 2014 Theobroma Systems GmbH
+ *                    <philipp.tomsich@theobroma-systems.com>
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -50,6 +53,10 @@
 /* Ptrace has some structures which are different between ILP32 and LP64 */
 #define sys_ptrace		compat_sys_ptrace
 
+/* message type is 64bit in LP64 and 32bit in ILP32 */
+#define sys_msgsnd              compat_sys_msgsnd
+#define sys_msgrcv              compat_sys_msgrcv
+
 /* struct msghdr */
 #define sys_recvfrom		compat_sys_recvfrom
 #define sys_recvmmsg		compat_sys_recvmmsg
-- 
1.9.1
