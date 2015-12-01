From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Tue,  1 Dec 2015 15:12:08 +0000
Subject: [PATCH v2 3/6] arm64: Enable CPU capability verification for
 !CONFIG_HOTPLUG_CPU
In-Reply-To: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1448982731-17182-4-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We verify the capabilities of the secondary CPUs only when
hotplug is enabled. The boot time activated CPUs do not
go through the verification by checking whether the system
wide capabilities were initialised or not.

This patch removes the capability check dependency on CONFIG_HOTPLUG_CPU,
to make sure that all the secondary CPUs go through the check.
The boot time activated CPUs will still skip the system wide
capability check. The plan is to hook in a check for CPU features
used by the kernel at early boot up, based on the Boot CPU values.

Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/include/asm/cpufeature.h |    6 ------
 arch/arm64/kernel/cpufeature.c      |   10 ----------
 2 files changed, 16 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8f271b8..26024c4 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -164,13 +164,7 @@ void update_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
 			    const char *info);
 void check_local_cpu_errata(void);
 
-#ifdef CONFIG_HOTPLUG_CPU
 void verify_local_cpu_capabilities(void);
-#else
-static inline void verify_local_cpu_capabilities(void)
-{
-}
-#endif
 
 u64 read_system_reg(u32 id);
 
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index a17fde9..dde1f56 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -767,8 +767,6 @@ static void enable_cpu_capabilities(const struct arm64_cpu_capabilities *caps)
 			on_each_cpu(caps[i].enable, NULL, true);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
-
 /*
  * Flag to indicate if we have computed the system wide
  * capabilities based on the boot time active CPUs. This
@@ -873,14 +871,6 @@ void verify_local_cpu_capabilities(void)
 	}
 }
 
-#else	/* !CONFIG_HOTPLUG_CPU */
-
-static inline void set_sys_caps_initialised(void)
-{
-}
-
-#endif	/* CONFIG_HOTPLUG_CPU */
-
 static void setup_feature_capabilities(void)
 {
 	update_cpu_capabilities(arm64_features, "detected feature:");
-- 
1.7.9.5
