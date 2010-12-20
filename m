From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 20 Dec 2010 15:58:31 +0530
Subject: [PATCH v4 2/2 (REPOST)] davinci: am18x/da850/omap-l138 evm: add
	support for higher speed grades
In-Reply-To: <1292840911-16325-1-git-send-email-nsekhar@ti.com>
References: <1292840911-16325-1-git-send-email-nsekhar@ti.com>
Message-ID: <1292840911-16325-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from the regular AM18x/DA850/OMAP-L138 SoC operating
at 300MHz, these SoCs have variants that can operate at a
maximum of 456MHz. Variants at 408Mhz and 375 Mhz are available
as well.

Not all silicon is qualified to run at higher speeds and
unfortunately the maximum speed the chip can support can only
be determined from the label on the package (not software
readable).

The EVM hardware for all these variants is the same (except
for the actual SoC populated).

U-Boot on the EVM sets up ATAG_REVISION to inform the OS
regarding the speed grade supported by the silicon. We use
this information to pass on the speed grade information to
the SoC code.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
re-posting with linux-arm-kernel included in CC.

 arch/arm/mach-davinci/board-da850-evm.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-davinci/board-da850-evm.c
index f89b0b7..893d9be 100644
--- a/arch/arm/mach-davinci/board-da850-evm.c
+++ b/arch/arm/mach-davinci/board-da850-evm.c
@@ -540,7 +540,7 @@ static struct regulator_init_data tps65070_regulator_data[] = {
 	{
 		.constraints = {
 			.min_uV = 950000,
-			.max_uV = 1320000,
+			.max_uV = 1350000,
 			.valid_ops_mask = (REGULATOR_CHANGE_VOLTAGE |
 				REGULATOR_CHANGE_STATUS),
 			.boot_on = 1,
@@ -736,6 +736,27 @@ static struct edma_rsv_info *da850_edma_rsv[2] = {
 	&da850_edma_cc1_rsv,
 };
 
+#ifdef CONFIG_CPU_FREQ
+static __init int da850_evm_init_cpufreq(void)
+{
+	switch (system_rev & 0xF) {
+	case 3:
+		da850_max_speed = 456000;
+		break;
+	case 2:
+		da850_max_speed = 408000;
+		break;
+	case 1:
+		da850_max_speed = 372000;
+		break;
+	}
+
+	return da850_register_cpufreq("pll0_sysclk3");
+}
+#else
+static __init int da850_evm_init_cpufreq(void) { return 0; }
+#endif
+
 static __init void da850_evm_init(void)
 {
 	int ret;
@@ -836,7 +857,7 @@ static __init void da850_evm_init(void)
 	if (ret)
 		pr_warning("da850_evm_init: rtc setup failed: %d\n", ret);
 
-	ret = da850_register_cpufreq("pll0_sysclk3");
+	ret = da850_evm_init_cpufreq();
 	if (ret)
 		pr_warning("da850_evm_init: cpufreq registration failed: %d\n",
 				ret);
-- 
1.7.3.2
