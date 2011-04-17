From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun, 17 Apr 2011 23:01:16 +0900
Subject: [PATCH] ARM: etm: wait for Progbit to go to 1 before programing ETM
Message-ID: <1303048876-28540-1-git-send-email-akinobu.mita@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to "Embedded Trace Macrocell Architecture Specification",
3.4.3. Use of the Programming bit, you must wait for Progbit of the ETM
Status Register to go to 1 before you start to program the ETM registers.
The current code somehow reads programing bit in ETM Control Register
instead.

Likewise, you must wait for Progbit to go to 0 after programing ETM.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Alexander Shishkin <virtuoso@slind.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/kernel/etm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/etm.c b/arch/arm/kernel/etm.c
index 1bec8b5..7229840 100644
--- a/arch/arm/kernel/etm.c
+++ b/arch/arm/kernel/etm.c
@@ -106,7 +106,7 @@ static int trace_start(struct tracectx *t)
 
 	etm_writel(t, v, ETMR_CTRL);
 
-	while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
+	while (!etm_progbit(t) && --timeout)
 		;
 	if (!timeout) {
 		dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
@@ -126,7 +126,7 @@ static int trace_start(struct tracectx *t)
 	etm_writel(t, v, ETMR_CTRL);
 
 	timeout = TRACER_TIMEOUT;
-	while (etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM && --timeout)
+	while (etm_progbit(t) && --timeout)
 		;
 	if (!timeout) {
 		dev_dbg(t->dev, "Waiting for progbit to deassert timed out\n");
@@ -148,7 +148,7 @@ static int trace_stop(struct tracectx *t)
 	etm_unlock(t);
 
 	etm_writel(t, 0x440, ETMR_CTRL);
-	while (!(etm_readl(t, ETMR_CTRL) & ETMCTRL_PROGRAM) && --timeout)
+	while (!etm_progbit(t) && --timeout)
 		;
 	if (!timeout) {
 		dev_dbg(t->dev, "Waiting for progbit to assert timed out\n");
-- 
1.7.4.2
