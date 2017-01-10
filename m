From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 10 Jan 2017 13:19:05 +0100
Subject: [PATCH] ARM: imx: hide unused variable in #ifdef
Message-ID: <20170110130154.2994705-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bugfix added a new local variable that is only used inside of an #ifdef
section, and unused if CONFIG_PERF_EVENTS is disabled:

arch/arm/mach-imx/mmdc.c:63:25: warning: 'cpuhp_mmdc_state' defined but not used [-Wunused-variable]

This moves the variable down inside that same ifdef.

Fixes: a051f220d6b9 ("ARM/imx/mmcd: Fix broken cpu hotplug handling")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/mmdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 699157759120..c03bf28d8bbc 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -60,7 +60,6 @@
 
 #define to_mmdc_pmu(p) container_of(p, struct mmdc_pmu, pmu)
 
-static enum cpuhp_state cpuhp_mmdc_state;
 static int ddr_type;
 
 struct fsl_mmdc_devtype_data {
@@ -82,6 +81,7 @@ static const struct of_device_id imx_mmdc_dt_ids[] = {
 
 #ifdef CONFIG_PERF_EVENTS
 
+static enum cpuhp_state cpuhp_mmdc_state;
 static DEFINE_IDA(mmdc_ida);
 
 PMU_EVENT_ATTR_STRING(total-cycles, mmdc_pmu_total_cycles, "event=0x00")
-- 
2.9.0
