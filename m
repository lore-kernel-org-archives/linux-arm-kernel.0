From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Jul 2016 18:52:55 +0100
Subject: [PATCH v10 3/7] arm64: cpuidle: drop __init section marker to
 arm_cpuidle_init
In-Reply-To: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
References: <1468950779-21745-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1468950779-21745-4-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit ea389daa7fd9 ("arm64: cpuidle: add __init section marker to
arm_cpuidle_init") added the __init annotation to arm_cpuidle_init
as it was not needed after booting which was correct at that time.

However with the introduction of ACPI LPI support, this will be used
from cpuhotplug path in ACPI processor driver.

This patch drops the __init annotation from arm_cpuidle_init to avoid
the following warning:

WARNING: vmlinux.o(.text+0x113c8): Section mismatch in reference from the
	function acpi_processor_ffh_lpi_probe() to the function
	.init.text:arm_cpuidle_init()
The function acpi_processor_ffh_lpi_probe() references
the function __init arm_cpuidle_init().
This is often because acpi_processor_ffh_lpi_probe lacks a __init
annotation or the annotation of arm_cpuidle_init is wrong.

Cc: Mark Rutland <mark.rutland@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kernel/cpuidle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/cpuidle.c b/arch/arm64/kernel/cpuidle.c
index e11857fce05f..06786fdaadeb 100644
--- a/arch/arm64/kernel/cpuidle.c
+++ b/arch/arm64/kernel/cpuidle.c
@@ -15,7 +15,7 @@
 #include <asm/cpuidle.h>
 #include <asm/cpu_ops.h>
 
-int __init arm_cpuidle_init(unsigned int cpu)
+int arm_cpuidle_init(unsigned int cpu)
 {
 	int ret = -EOPNOTSUPP;
 
-- 
2.7.4
