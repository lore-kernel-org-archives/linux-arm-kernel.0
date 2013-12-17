From: geoff@infradead.org (Geoff Levand)
Date: Mon, 16 Dec 2013 16:19:29 -0800
Subject: [PATCH v2 2/5] arm64: Fix the soft_restart routine
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <1387239569.1002.151.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the soft_restart() routine to call cpu_reset() at its identity mapped
physical address.

The cpu_reset() routine must be called at its identity mapped physical address
so that when the MMU is turned off the instruction pointer will be at the correct
location in physical memory.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
v2: Use typecast and variable for call as in arm code.

 arch/arm64/kernel/process.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89..88e50fc 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -71,8 +71,14 @@ static void setup_restart(void)
 
 void soft_restart(unsigned long addr)
 {
+	typedef void (*phys_reset_t)(unsigned long);
+	phys_reset_t phys_reset;
+
 	setup_restart();
-	cpu_reset(addr);
+
+	/* Switch to the identity mapping. */
+	phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
+	phys_reset(addr);
 }
 
 /*
-- 
1.8.1.2
