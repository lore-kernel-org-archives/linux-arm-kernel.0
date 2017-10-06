From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Fri,  6 Oct 2017 14:16:52 +0100
Subject: [PATCH 1/2] arm64: Ensure the instruction emulation is ready for
 userspace
Message-ID: <20171006131653.15876-1-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We trap and emulate some instructions (e.g, mrs, deprecated instructions)
for the userspace. However the handlers for these are registered as
late_initcalls and the userspace could be up and running from the initramfs
by that time (with populate_rootfs, which is a rootfs_initcall()). This
could cause problems for the early applications ending up in failure
like :

[   11.152061] modprobe[93]: undefined instruction: pc=0000ffff8ca48ff4

This patch promotes the specific calls to core_initcalls, which are
guaranteed to be completed before we hit userspace.

Cc: stable at vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Dave Martin <dave.martin@arm.com>
Cc: Matthias Brugger <mbrugger@suse.com>
Cc: James Morse <james.morse@arm.com>
Reported-by: Matwey V. Kornilov <matwey.kornilov@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/kernel/armv8_deprecated.c | 2 +-
 arch/arm64/kernel/cpufeature.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index f0e6d717885b..d06fbe4cd38d 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -649,4 +649,4 @@ static int __init armv8_deprecated_init(void)
 	return 0;
 }
 
-late_initcall(armv8_deprecated_init);
+core_initcall(armv8_deprecated_init);
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index cd52d365d1f0..21e2c95d24e7 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1307,4 +1307,4 @@ static int __init enable_mrs_emulation(void)
 	return 0;
 }
 
-late_initcall(enable_mrs_emulation);
+core_initcall(enable_mrs_emulation);
-- 
2.13.6
