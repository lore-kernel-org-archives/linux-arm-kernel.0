From: shweta.gulati@ti.com (Shweta Gulati)
Date: Thu, 10 Mar 2011 11:52:28 +0530
Subject: [PATCH] OMAP4: Intialize IVA Device in addition to DSP device.
Message-ID: <1299738148-28557-1-git-send-email-shweta.gulati@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP4 has two different Devices IVA and DSP. DSP is bound
with MPU for DVFS and IVA has its own well defined OPPs.
This Patch adds IVA init to 'omap2_init_processor_devices'
and make sure that API 'omap2_set_init_voltage' is called
for apt dev pointer.

It fixes Error logs:

	omap2_set_init_voltage: Invalid parameters!
	omap2_set_init_voltage: Unable to put vdd_iva to its init voltage

Tested on OMAP4430 SDP Board.
Baseline:
http://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch :pm-core

Signed-off-by: Shweta Gulati <shweta.gulati@ti.com>
---
 arch/arm/mach-omap2/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 30af335..49486f5 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -89,6 +89,7 @@ static void omap2_init_processor_devices(void)
 	if (cpu_is_omap44xx()) {
 		_init_omap_device("l3_main_1", &l3_dev);
 		_init_omap_device("dsp", &dsp_dev);
+		_init_omap_device("iva", &iva_dev);
 	} else {
 		_init_omap_device("l3_main", &l3_dev);
 	}
-- 
1.7.0.4
