From: khilman@ti.com (Kevin Hilman)
Date: Mon, 29 Aug 2011 10:35:49 -0700
Subject: [PATCH 16/22] OMAP2+: voltage: enable VC bypass scale method when VC
	is initialized
In-Reply-To: <1314639355-12713-1-git-send-email-khilman@ti.com>
References: <1314639355-12713-1-git-send-email-khilman@ti.com>
Message-ID: <1314639355-12713-17-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

VC is initialized first, set default scaling method to VC bypass.
If/when VP is initialized, default scaling method will be changed to
VP force-update.

Enabling VC bypass as default as soon as VC is initialized allows for
VC bypass scaling to work when no VP is configured/initialized for a
given voltage domain.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c6352e3..e1a22a3 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -802,8 +802,10 @@ int __init omap_voltage_late_init(void)
 		if (!voltdm->scalable)
 			continue;
 
-		if (voltdm->vc)
+		if (voltdm->vc) {
+			voltdm->vdd->volt_scale = omap_vc_bypass_scale;
 			omap_vc_init_channel(voltdm);
+		}
 
 		if (voltdm->vdd) {
 			if (omap_vdd_data_configure(voltdm))
-- 
1.7.6
