From: geoff@infradead.org (Geoff Levand)
Date: Thu, 12 Dec 2013 20:39:46 +0000
Subject: [PATCH 2/5] arm64: Fix the soft_restart routine
In-Reply-To: <cover.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
Message-ID: <fbf47d394de6bd7332b00bc706a9f38cd7a68327.1386879684.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the soft_restart() routine to call cpu_reset() at its identity mapped
physical address.

The cpu_reset() routine must be called at its identity mapped physical address
so that when the MMU is turned off the instruction pointer will be at the correct
location in physical memory.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
---
 arch/arm64/kernel/process.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index de17c89..985eb42 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -72,7 +72,13 @@ static void setup_restart(void)
 void soft_restart(unsigned long addr)
 {
 	setup_restart();
-	cpu_reset(addr);
+
+	/*
+	 * cpu_reset turns the MMU off, so must be called at its identity
+	 * mapped physical address.
+	 */
+
+	(*(void(*)(unsigned long))virt_to_phys(cpu_reset))(addr);
 }
 
 /*
-- 
1.8.1.2
