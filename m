From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 23 Sep 2010 11:18:54 -0700
Subject: [PATCH 2/3] OMAP4: pm: Change l3_main to l3_main_1 during bus device
	init
In-Reply-To: <1285265935-3477-1-git-send-email-khilman@deeprootsystems.com>
References: <1285265935-3477-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1285265935-3477-3-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

The OMAP4 L3 interconnect is split in 3 part for power saving reason.
Because of that there is no l3_main like on OMAP2 & 3 but 3 differentes
l3_main_X instances.

In the case of OMAP4, query only the l3_main_1 part. The clock and
voltage are shared across the 3 instances.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 4477d5d..59ca03b 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -81,9 +81,12 @@ static void omap2_init_processor_devices(void)
 {
 	_init_omap_device("mpu", &mpu_dev);
 	_init_omap_device("iva", &iva_dev);
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
+		_init_omap_device("l3_main_1", &l3_dev);
 		_init_omap_device("dsp", &dsp_dev);
-	_init_omap_device("l3_main", &l3_dev);
+	} else {
+		_init_omap_device("l3_main", &l3_dev);
+	}
 }
 
 /*
-- 
1.7.2.1
