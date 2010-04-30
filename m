From: tony@atomide.com (Tony Lindgren)
Date: Fri, 30 Apr 2010 13:33:59 -0700
Subject: [PATCH 06/11] omap4: Fix omap_l2_cache_init not to run for other omaps
In-Reply-To: <20100430202603.25812.41834.stgit@baageli.muru.com>
References: <20100430202603.25812.41834.stgit@baageli.muru.com>
Message-ID: <20100430203359.25812.56284.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In multi-omap configuration all the initcalls run. To avoid
bad things from happening with 44xx specific initcalls on
other omaps, we need to check that the booted system is
omap4 before running.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-4430sdp.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index b88f28c..e603b00 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -55,6 +55,9 @@ static int __init omap_l2_cache_init(void)
 	extern void omap_smc1(u32 fn, u32 arg);
 	void __iomem *l2cache_base;
 
+	if (!cpu_is_omap44xx())
+		return -ENODEV;
+
 	/* To avoid code running on other OMAPs in
 	 * multi-omap builds
 	 */
