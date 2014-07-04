From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 04 Jul 2014 20:52:07 +0100
Subject: [PATCH 2/4] ARM: SWP emulation: always enable when SMP is enabled
In-Reply-To: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
References: <20140704195134.GJ21766@n2100.arm.linux.org.uk>
Message-ID: <E1X39Wh-0000lq-KV@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SWP is deprecated in ARMv6 and ARMv7 CPUs, but more importantly, when
running on a SMP system, SWP doesn't guarantee atomicity.  This means
it can't really be used (by userspace) for locking purposes in a SMP
environment.

Currently, many configurations leave the SWP emulation disabled, which
means we never know if userspace executes this instruction on ARMv7
hardware.  Rectify this by enabling SWP emulation for ARMv7 with SMP
(where we can trap the instruction.)

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index c348eaee7ee2..c78c7db6aa83 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -669,7 +669,7 @@ config ARM_VIRT_EXT
 	  details.
 
 config SWP_EMULATE
-	bool "Emulate SWP/SWPB instructions"
+	bool "Emulate SWP/SWPB instructions" if !SMP
 	depends on CPU_V7
 	default y if SMP
 	select HAVE_PROC_CPU if PROC_FS
-- 
1.8.3.1
