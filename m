From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Wed, 24 May 2017 11:24:31 +0100
Subject: [PATCH v5 6/7] ARM: NOMMU: Set ARM_DMA_MEM_BUFFERABLE for M-class cpus
In-Reply-To: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
References: <1495621472-9323-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1495621472-9323-7-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now, we have dedicated non-cacheable region for consistent DMA
operations. However, that region can still be marked as bufferable by
MPU, so it'd be safer to have barriers by default. M-class machines
that didn't need it until now also likely won't need it in the future,
therefore, we offer this as an option.

Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/mm/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index d731f28..f50bbda 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -1049,8 +1049,8 @@ config ARM_L1_CACHE_SHIFT
 	default 5
 
 config ARM_DMA_MEM_BUFFERABLE
-	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K) && !CPU_V7
-	default y if CPU_V6 || CPU_V6K || CPU_V7
+	bool "Use non-cacheable memory for DMA" if (CPU_V6 || CPU_V6K || CPU_V7M) && !CPU_V7
+	default y if CPU_V6 || CPU_V6K || CPU_V7 || CPU_V7M
 	help
 	  Historically, the kernel has used strongly ordered mappings to
 	  provide DMA coherent memory.  With the advent of ARMv7, mapping
@@ -1065,6 +1065,10 @@ config ARM_DMA_MEM_BUFFERABLE
 	  and therefore turning this on may result in unpredictable driver
 	  behaviour.  Therefore, we offer this as an option.
 
+	  On some of the beefier ARMv7-M machines (with DMA and write
+	  buffers) you likely want this enabled, while those that
+	  didn't need it until now also won't need it in the future.
+
 	  You are recommended say 'Y' here and debug any affected drivers.
 
 config ARM_HEAVY_MB
-- 
2.0.0
