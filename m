From: slash.tmp@free.fr (Mason)
Date: Tue, 15 Nov 2016 14:36:33 +0100
Subject: [PATCH] arm: spin one more cycle in timer-based delays
Message-ID: <582B0F61.6030903@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When polling a tick counter in a busy loop, one might sample the
counter just *before* it is updated, and then again just *after*
it is updated. In that case, while mathematically v2-v1 equals 1,
only epsilon has really passed.

So, if a caller requests an N-cycle delay, we spin until v2-v1
is strictly greater than N to avoid these random corner cases.

Signed-off-by: Mason <slash.tmp@free.fr>
---
 arch/arm/lib/delay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 69aad80a3af4..3f1cd15ca102 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -60,7 +60,7 @@ static void __timer_delay(unsigned long cycles)
 {
 	cycles_t start = get_cycles();
 
-	while ((get_cycles() - start) < cycles)
+	while ((get_cycles() - start) <= cycles)
 		cpu_relax();
 }
 
-- 
2.9.0
