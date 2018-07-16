From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 16 Jul 2018 12:30:16 +0100
Subject: [PATCHv4 11/12] atomics: check generated headers are up-to-date
In-Reply-To: <20180716113017.3909-1-mark.rutland@arm.com>
References: <20180716113017.3909-1-mark.rutland@arm.com>
Message-ID: <20180716113017.3909-12-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all the generated atomic headers are in place, it would be good
to ensure that:

a) the headers are up-to-date when scripting changes.

b) developers don't directly modify the generated headers.

To ensure both of these properties, let's add a Kbuild step to check
that the generated headers are up-to-date.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
---
 Kbuild                          | 18 ++++++++++++++++--
 scripts/atomic/check-atomics.sh | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+), 2 deletions(-)
 create mode 100755 scripts/atomic/check-atomics.sh

diff --git a/Kbuild b/Kbuild
index 005304205482..47c9fe175bd9 100644
--- a/Kbuild
+++ b/Kbuild
@@ -6,7 +6,8 @@
 # 2) Generate timeconst.h
 # 3) Generate asm-offsets.h (may need bounds.h and timeconst.h)
 # 4) Check for missing system calls
-# 5) Generate constants.py (may need bounds.h)
+# 5) check atomics headers are up-to-date
+# 6) Generate constants.py (may need bounds.h)
 
 #####
 # 1) Generate bounds.h
@@ -72,7 +73,20 @@ missing-syscalls: scripts/checksyscalls.sh $(offsets-file) FORCE
 	$(call cmd,syscalls)
 
 #####
-# 5) Generate constants for Python GDB integration
+# 5) Check atomic headers are up-to-date
+#
+
+always += old-atomics
+targets += old-atomics
+
+quiet_cmd_atomics = CALL    $<
+      cmd_atomics = $(CONFIG_SHELL) scripts/atomic/check-atomics.sh
+
+old-atomics: scripts/atomic/check-atomics.sh FORCE
+	$(call cmd,atomics)
+
+#####
+# 6) Generate constants for Python GDB integration
 #
 
 extra-$(CONFIG_GDB_SCRIPTS) += build_constants_py
diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
new file mode 100755
index 000000000000..c30101cddf2d
--- /dev/null
+++ b/scripts/atomic/check-atomics.sh
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Check if atomic headers are up-to-date
+
+ATOMICDIR=$(dirname $0)
+ATOMICTBL=${ATOMICDIR}/atomics.tbl
+LINUXDIR=${ATOMICDIR}/../..
+
+cat <<EOF |
+gen-atomic-instrumented.sh      asm-generic/atomic-instrumented.h
+gen-atomic-long.sh              asm-generic/atomic-long.h
+gen-atomic-fallback.sh          linux/atomic-fallback.h
+EOF
+while read script header; do
+	if ! (${ATOMICDIR}/${script} ${ATOMICTBL} | diff - ${LINUXDIR}/include/${header} > /dev/null); then
+		printf "warning: include/${header} is out-of-date.\n"
+	fi
+done
-- 
2.11.0
