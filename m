From: b-cousson@ti.com (Benoit Cousson)
Date: Wed, 15 Dec 2010 15:49:25 +0100
Subject: [PATCH v2 4/6] OMAP2+: hwmod: Disable clocks when hwmod enable fails
In-Reply-To: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
References: <1292424567-25794-1-git-send-email-b-cousson@ti.com>
Message-ID: <1292424567-25794-5-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rajendra Nayak <rnayak@ti.com>

In cases where a module (hwmod) does not become accesible on enabling
the main clocks (can happen if there are external clocks needed
for the module to become accesible), make sure the clocks are not
left enabled.
This ensures that when the requisite external dependencies are met
a omap_hwmod_enable and omap_hwmod_idle/shutdown would rightly enable
and disable clocks using clk framework. Leaving the clocks enabled in
the error case causes additional usecounting at the clock framework
level leaving the clock enabled forever.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 91b011e..c576121 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1233,6 +1233,7 @@ static int _enable(struct omap_hwmod *oh)
 			_enable_sysc(oh);
 		}
 	} else {
+		_disable_clocks(oh);
 		pr_debug("omap_hwmod: %s: _wait_target_ready: %d\n",
 			 oh->name, r);
 	}
-- 
1.7.0.4
