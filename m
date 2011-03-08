From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 07 Mar 2011 22:44:28 -0700
Subject: [PATCH 1/5] OMAP2+: hwmod: fix incorrect computation of autoidle_mask
In-Reply-To: <20110308054315.1309.10538.stgit@twilight.localdomain>
References: <20110308054315.1309.10538.stgit@twilight.localdomain>
Message-ID: <20110308054425.1309.54087.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Autoidle is a single bit, TIOCP_CFG[0], setting on OMAP1/2/3/4 platforms.
In _set_module_autoidle() I am seeing 0x3 value where the mask is computed.
This should be 0x1.

v2:
(1) Modified the subject.
(2) Modified the description with further specific information.

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Tested Info:
Boot tested on OMAP 1/2/3/4.

Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Acked-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..9b4f6cd 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -373,7 +373,7 @@ static int _set_module_autoidle(struct omap_hwmod *oh, u8 autoidle,
 	}
 
 	autoidle_shift = oh->class->sysc->sysc_fields->autoidle_shift;
-	autoidle_mask = (0x3 << autoidle_shift);
+	autoidle_mask = (0x1 << autoidle_shift);
 
 	*v &= ~autoidle_mask;
 	*v |= autoidle << autoidle_shift;
