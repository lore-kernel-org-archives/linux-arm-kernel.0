From: steve.capper@arm.com (Steve Capper)
Date: Wed, 17 Oct 2018 17:34:58 +0100
Subject: [PATCH V2 3/4] arm64: mm: Define arch_get_mmap_end, arch_get_mmap_base
In-Reply-To: <20181017163459.20175-1-steve.capper@arm.com>
References: <20181017163459.20175-1-steve.capper@arm.com>
Message-ID: <20181017163459.20175-4-steve.capper@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have DEFAULT_MAP_WINDOW defined, we can arch_get_mmap_end
and arch_get_mmap_base helpers to allow for high addresses in mmap.

Signed-off-by: Steve Capper <steve.capper@arm.com>
---
 arch/arm64/include/asm/processor.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 46c9d9ff028c..5afc0c5eb1cb 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -78,6 +78,13 @@
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
