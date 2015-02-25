From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 25 Feb 2015 12:59:42 +0000
Subject: [PATCH v2] drivers: cpuidle: cpuidle-arm64: include asm/proc-fns.h
 explicitly
Message-ID: <1424869182-19725-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM64 CPUidle driver requires the cpu_do_idle function so that it can
be used to enter the shallowest idle state, and it is declared in
asm/proc-fns.h.

The current ARM64 CPUidle driver does not include asm/proc-fns.h
explicitly and it has so far relied on implicit inclusion from other
header files.

Owing to some header dependencies reshuffling this currently triggers
build failures when CONFIG_ARM64_64K_PAGES=y:

drivers/cpuidle/cpuidle-arm64.c: In function "arm64_enter_idle_state"
drivers/cpuidle/cpuidle-arm64.c:42:3: error: implicit declaration of
function "cpu_do_idle" [-Werror=implicit-function-declaration]
   cpu_do_idle();
   ^

This patch adds the explicit inclusion of the asm/proc-fns.h header file
to fix the build breakage and stop relying on implicit asm/proc-fns.h
inclusion.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
[lp: rewrote commit log]
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>
---
v2 changes:

- Picked up
  http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/325523.html
- Rebased against 4.0-rc1 and rewrote commit log

 drivers/cpuidle/cpuidle-arm64.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpuidle/cpuidle-arm64.c b/drivers/cpuidle/cpuidle-arm64.c
index 39a2c62..c8bb6c5 100644
--- a/drivers/cpuidle/cpuidle-arm64.c
+++ b/drivers/cpuidle/cpuidle-arm64.c
@@ -19,6 +19,7 @@
 #include <linux/of.h>
 
 #include <asm/cpuidle.h>
+#include <asm/proc-fns.h>
 
 #include "dt_idle_states.h"
 
-- 
2.2.1
