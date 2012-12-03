From: will.deacon@arm.com (Will Deacon)
Date: Mon,  3 Dec 2012 17:56:43 +0000
Subject: [PATCH 3/3] ARM: nommu: do not enable DCACHE_WORD_ACCESS when
 !CONFIG_MMU
In-Reply-To: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
References: <1354557403-20386-1-git-send-email-will.deacon@arm.com>
Message-ID: <1354557403-20386-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b9a50f74905a ("ARM: 7450/1: dcache: select DCACHE_WORD_ACCESS for
little-endian ARMv6+ CPUs") added support for word-at-time path
comparisons, relying on the ability to perform unaligned loads with
negligible performance impact in hardware.

For nommu configurations without MPU support, this is unpredictable and
so we should fall back to the byte-by-byte routines.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index ade7e92..3388431 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -6,7 +6,7 @@ config ARM
 	select ARCH_HAVE_CUSTOM_GPIO_H
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select CPU_PM if (SUSPEND || CPU_IDLE)
-	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN
+	select DCACHE_WORD_ACCESS if (CPU_V6 || CPU_V6K || CPU_V7) && !CPU_BIG_ENDIAN && MMU
 	select GENERIC_ATOMIC64 if (CPU_V6 || !CPU_32v6K || !AEABI)
 	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
 	select GENERIC_IRQ_PROBE
-- 
1.8.0
