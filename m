From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 13 May 2011 14:49:50 +0530
Subject: [RFC PATCH v3] Consolidate SRAM support
In-Reply-To: <20110512174546.GB8633@n2100.arm.linux.org.uk>
References: <20110415130607.GM1611@n2100.arm.linux.org.uk>
	<20110512174546.GB8633@n2100.arm.linux.org.uk>
Message-ID: <4DCCF7B6.8020305@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 5/12/2011 11:15 PM, Russell King - ARM Linux wrote:
> On Fri, Apr 15, 2011 at 02:06:07PM +0100, Russell King - ARM Linux wrote:
> This is work in progress.
>

Tried this patch on OMAP and found couple of issues.

1. Compilation break. Below is the fix for the same.

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 68f57ff..78d1af4 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -75,6 +75,7 @@
  static unsigned long omap_sram_start;
  static unsigned long omap_sram_base;
  static unsigned long omap_sram_size;
+static unsigned long omap_sram_ceil;

  /*
   * Depending on the target RAMFS firewall setup, the public usable 
amount of
-- 
1.6.0.4


2. The boot takes data abort while allocating memory for
struct pv_pool. Here is the back-trace.
I haven't debugged it further though.

-000|NSR:0xFFFF0010(asm)
  -->|exception
-001|kmem_cache_alloc_trace(size = 0x0C, cachep = 0x0, flags = 0x80D0)
-002|pv_pool_create(addr = 0xFE400000, phys = 0x40200000, len = 
0x00010000, min_alloc_order = 0x3)
-003|omap_sram_init()
-004|paging_init(?)
-005|setup_arch(cmdline_p = 0xC058BFE4)
-006|start_kernel()
-007|NSR:0x8000803C(asm)
  ---|end of frame
     |

Regards
Santosh
