From: ghackmann@android.com (Greg Hackmann)
Date: Wed, 15 Aug 2018 12:51:22 -0700
Subject: [PATCH v2 2/2] arm: mm: check for upper PAGE_SHIFT bits in pfn_valid()
In-Reply-To: <20180815195123.187373-1-ghackmann@google.com>
References: <20180815195123.187373-1-ghackmann@google.com>
Message-ID: <20180815195123.187373-2-ghackmann@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM's pfn_valid() has a similar shifting bug to the ARM64 bug fixed in
the previous patch.  This only affects non-LPAE kernels, since LPAE
kernels will promote to 64 bits inside __pfn_to_phys().

Fixes: 5e6f6aa1c243 ("memblock/arm: pfn_valid uses memblock_is_memory()")
Cc: stable at vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 arch/arm/mm/init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 0cc8e04295a4..bee1f2e4ecf3 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -196,7 +196,11 @@ static void __init zone_sizes_init(unsigned long min, unsigned long max_low,
 #ifdef CONFIG_HAVE_ARCH_PFN_VALID
 int pfn_valid(unsigned long pfn)
 {
-	return memblock_is_map_memory(__pfn_to_phys(pfn));
+	phys_addr_t addr = __pfn_to_phys(pfn);
+
+	if (__phys_to_pfn(addr) != pfn)
+		return 0;
+	return memblock_is_map_memory(addr);
 }
 EXPORT_SYMBOL(pfn_valid);
 #endif
-- 
2.18.0.865.gffc8e1a3cd6-goog
