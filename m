From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 21 Dec 2016 11:19:35 +0100
Subject: [PATCH 3/3] arm: perf: Add platform driver removal function
In-Reply-To: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
References: <20161221101935.17178-1-alexander.stein@systec-electronic.com>
Message-ID: <20161221101935.17178-4-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Despite the driver cannot be built as a module using the option
DEBUG_TEST_DRIVER_REMOVE requires the drivers to actually remove the
device.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/kernel/perf_event_v7.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/kernel/perf_event_v7.c b/arch/arm/kernel/perf_event_v7.c
index b942349..3ad02a2 100644
--- a/arch/arm/kernel/perf_event_v7.c
+++ b/arch/arm/kernel/perf_event_v7.c
@@ -2026,12 +2026,18 @@ static int armv7_pmu_device_probe(struct platform_device *pdev)
 				    armv7_pmu_probe_table);
 }
 
+static int armv7_pmu_device_remove(struct platform_device *pdev)
+{
+	return arm_pmu_device_remove(pdev);
+}
+
 static struct platform_driver armv7_pmu_driver = {
 	.driver		= {
 		.name	= "armv7-pmu",
 		.of_match_table = armv7_pmu_of_device_ids,
 	},
 	.probe		= armv7_pmu_device_probe,
+	.remove		= armv7_pmu_device_remove,
 };
 
 static int __init register_armv7_pmu_driver(void)
-- 
2.10.2
