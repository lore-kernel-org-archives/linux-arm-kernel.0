From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 15:20:16 +0100
Subject: [PATCH] ARM64: mark cpus_have_hwcap as __maybe_unused
Message-ID: <5369626.MJXv4CTaxt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

cpus_have_hwcap() is defined as a 'static' function an only used in
one place that is inside of an #ifdef, so we get a warning when
the only user is disabled:

arch/arm64/kernel/cpufeature.c:699:13: warning: 'cpus_have_hwcap' defined but not used [-Wunused-function]

This marks the function as __maybe_unused, so the compiler knows that
it can drop the function definition without warning about it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 37b01d53ceef ("arm64/HWCAP: Use system wide safe values")
---
Found on arm64 allnoconfig

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 52f0d7a5a1c2..c8cf89223b5a 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -696,7 +696,7 @@ static void cap_set_hwcap(const struct arm64_cpu_capabilities *cap)
 }
 
 /* Check if we have a particular HWCAP enabled */
-static bool cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
+static bool __maybe_unused cpus_have_hwcap(const struct arm64_cpu_capabilities *cap)
 {
 	bool rc;
 
