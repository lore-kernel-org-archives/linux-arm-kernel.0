From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 18:30:38 +0200
Subject: [PATCH 06/21] ARM: tegra: call cpu_do_idle from C code
In-Reply-To: <1366734653-488286-1-git-send-email-arnd@arndb.de>
References: <1366734653-488286-1-git-send-email-arnd@arndb.de>
Message-ID: <1366734653-488286-7-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When building a kernel for multiple CPU architecture levels,
cpu_do_idle() is a macro for an indirect function call, which
cannot be called from assembly code as Tegra does.

Adding a trivial C wrapper for this function lets us build
a tegra kernel with ARMv6 support enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Joseph Lo <josephl@nvidia.com>
Cc: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/pm.c            | 5 +++++
 arch/arm/mach-tegra/sleep-tegra20.S | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-tegra/pm.c b/arch/arm/mach-tegra/pm.c
index 523604d..398e932 100644
--- a/arch/arm/mach-tegra/pm.c
+++ b/arch/arm/mach-tegra/pm.c
@@ -181,6 +181,11 @@ bool tegra_set_cpu_in_lp2(int phy_cpu_id)
 	return last_cpu;
 }
 
+int tegra_cpu_do_idle(void)
+{
+	return cpu_do_idle();
+}
+
 static int tegra_sleep_cpu(unsigned long v2p)
 {
 	/* Switch to the identity mapping. */
diff --git a/arch/arm/mach-tegra/sleep-tegra20.S b/arch/arm/mach-tegra/sleep-tegra20.S
index 9f6bfafd..e3f2417 100644
--- a/arch/arm/mach-tegra/sleep-tegra20.S
+++ b/arch/arm/mach-tegra/sleep-tegra20.S
@@ -197,7 +197,7 @@ ENTRY(tegra20_sleep_cpu_secondary_finish)
 	mov	r3, #CPU_RESETTABLE
 	str	r3, [r0]
 
-	bl	cpu_do_idle
+	bl	tegra_cpu_do_idle
 
 	/*
 	 * cpu may be reset while in wfi, which will return through
-- 
1.8.1.2
