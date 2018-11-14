From: steve.capper@arm.com (Steve Capper)
Date: Wed, 14 Nov 2018 13:39:18 +0000
Subject: [PATCH V3 3/5] arm64: mm: Define arch_get_mmap_end, arch_get_mmap_base
In-Reply-To: <20181114133920.7134-1-steve.capper@arm.com>
References: <20181114133920.7134-1-steve.capper@arm.com>
Message-ID: <20181114133920.7134-4-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have DEFAULT_MAP_WINDOW defined, we can arch_get_mmap_end
and arch_get_mmap_base helpers to allow for high addresses in mmap.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index da41a2655b69..bbe602cb8fd3 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -72,6 +72,13 @@
 #define STACK_TOP		STACK_TOP_MAX
 #endif /* CONFIG_COMPAT */
 
+#define arch_get_mmap_end(addr) ((addr > DEFAULT_MAP_WINDOW) ? TASK_SIZE :\
+				DEFAULT_MAP_WINDOW)
+
+#define arch_get_mmap_base(addr, base) ((addr > DEFAULT_MAP_WINDOW) ? \
+					base + TASK_SIZE - DEFAULT_MAP_WINDOW :\
+					base)
+
 extern phys_addr_t arm64_dma_phys_limit;
 #define ARCH_LOW_ADDRESS_LIMIT	(arm64_dma_phys_limit - 1)
 
-- 
2.11.0
