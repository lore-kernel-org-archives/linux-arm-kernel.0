From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 19 Nov 2010 23:01:05 +0530
Subject: [PATCH 4/5] omap4: l2x0: Set share override bit
In-Reply-To: <1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com>
References: <1290187866-26941-1-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-2-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-3-git-send-email-santosh.shilimkar@ti.com>
	<1290187866-26941-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1290187866-26941-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clearing bit 22 in the PL310 Auxiliary Control register (shared
attribute override enable) has the side effect of transforming Normal
Shared Non-cacheable reads into Cacheable no-allocate reads.

Coherent DMA buffers in Linux always have a Cacheable alias via the
kernel linear mapping and the processor can speculatively load cache
lines into the PL310 controller. With bit 22 cleared, Non-cacheable
reads would unexpectedly hit such cache lines leading to buffer
corruption

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap4-common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index b3cea78..2006da1 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -80,6 +80,7 @@ static int __init omap_l2_cache_init(void)
 		aux_ctrl |= 0x2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT;
 	} else {
 		aux_ctrl |= ((0x3 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
+			(1 << L2X0_AUX_CTRL_SHARE_OVERRIDE_SHIFT) |
 			(1 << L2X0_AUX_CTRL_DATA_PREFETCH_SHIFT) |
 			(1 << L2X0_AUX_CTRL_INSTR_PREFETCH_SHIFT));
 	}
-- 
1.6.0.4
