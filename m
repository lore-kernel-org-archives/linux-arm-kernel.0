From: jnair@caviumnetworks.com (Jayachandran C)
Date: Wed, 1 Feb 2017 09:48:52 +0000
Subject: [PATCH] arm64: Improve parking of stopped CPUs
Message-ID: <1485942532-2643-1-git-send-email-jnair@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current code puts the stopped cpus in an 'yield' instruction loop.
Using a busy loop here is unnecessary, we can use the cpu_park_loop()
function here to do a wfi/wfe.

Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
---
 arch/arm64/kernel/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index cbaab44..0691d2f 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -829,8 +829,7 @@ static void ipi_cpu_stop(unsigned int cpu)
 
 	local_irq_disable();
 
-	while (1)
-		cpu_relax();
+	cpu_park_loop();
 }
 
 /*
-- 
2.7.4
