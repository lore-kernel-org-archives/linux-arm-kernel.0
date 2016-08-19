From: Nitin.Chaudhary@zii.aero (Nitin Chaudhary)
Date: Thu, 18 Aug 2016 18:17:39 -0700
Subject: [PATCH 3/3] [PATCH][i.MX6Q]Removed MMDC Auto Power saving timeout
 error
In-Reply-To: <1471569459-1546-1-git-send-email-Nitin.Chaudhary@zii.aero>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <1471569459-1546-1-git-send-email-Nitin.Chaudhary@zii.aero>
Message-ID: <1471569459-1546-4-git-send-email-Nitin.Chaudhary@zii.aero>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Moved the busy loop to check MMDC0_MAPSR bit[4] for MMDC Automatic
power saving mode enable to a deferred kernel workqueue ~5s after
probe. Now the check passes successfully and no failure logs are
seen. The power numbers are also lower on the board. The below are
relevant dmesg outputs:

root at RDU2:~ dmesg | grep -i mmdc
[    0.132669] imx-mmdc 21b0000.mmdc: No access to interrupts, using timer.
[    0.132775] imx-mmdc 21b0000.mmdc: imx_mmdc_probe success
[    5.210514] is_mmdc_auto_powersave: MMDC auto power saving enabled MAPSR: 0x00001076

Signed-off-by: Nitin Chaudhary <Nitin.Chaudhary@zii.aero>
---
 arch/arm/mach-imx/mmdc.c | 43 +++++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 45790f5..9f27814 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -80,6 +80,7 @@ struct mmdc_pmu
        struct hrtimer hrtimer;
        unsigned int irq;
        struct device *dev;
+       struct delayed_work init_work;
        struct perf_event *mmdc_events[MMDC_NUM_COUNTERS];
 };

@@ -149,6 +150,27 @@ static const struct attribute_group * attr_groups[] = {
        NULL,
 };

+static void is_mmdc_auto_powersave(struct work_struct *work)
+{
+
+       void __iomem *mmdc_base, *reg;
+       int timeout = 0x400;
+       mmdc_base = pmu_mmdc->mmdc_base;
+       reg = mmdc_base + MMDC_MAPSR;
+
+       /* Ensure Automatic Power saving mode is successfully enabled */
+       while (!(readl_relaxed(reg) & 1 << BP_MMDC_MAPSR_PSS) && --timeout)
+               cpu_relax();
+
+       if (unlikely(!timeout)) {
+               pr_warn("%s: failed to enable automatic power saving, recheck\n",
+                       __func__);
+       } else {
+               pr_info("%s: MMDC auto power saving enabled MAPSR: 0x%08x\n",
+                       __func__);
+       }
+}
+
 static u32 mmdc_read_counter(int cfg, u64 prev_val)
 {
        u32 val;
@@ -348,7 +370,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
        void __iomem *mmdc_base, *reg;
        char * name;
        u32 val;
-       int timeout = 0x800;
        int mmdc_num;
        int err;

@@ -368,20 +389,6 @@ static int imx_mmdc_probe(struct platform_device *pdev)
        val &= ~(1 << BP_MMDC_MAPSR_PSD);
        writel_relaxed(val, reg);

-       /* Ensure it's successfully enabled */
-       while (!(readl_relaxed(reg) & 1 << BP_MMDC_MAPSR_PSS) && --timeout)
-               cpu_relax();
-
-       if (unlikely(!timeout)) {
-               pr_warn("%s: failed to enable automatic power saving\n",
-                       __func__);
-
-               /*
-                * TODO: Need to check why Automatic Power saving is not
-                * getting enabled successfully.
-                * return -EBUSY;
-                */
-       }
        pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);

        if (!pmu_mmdc) {
@@ -409,7 +416,11 @@ static int imx_mmdc_probe(struct platform_device *pdev)
        }
        platform_set_drvdata(pdev, pmu_mmdc);
        perf_pmu_register(&(pmu_mmdc->pmu), name, -1);
-
+
+       /* Check if automatic Power saving mode was enabled */
+       INIT_DELAYED_WORK(&pmu_mmdc->init_work, is_mmdc_auto_powersave);
+       schedule_delayed_work(&pmu_mmdc->init_work, msecs_to_jiffies(5000));
+
        dev_info(pmu_mmdc->dev, "%s success\n",__func__);

        return 0;
--
2.7.4


________________________________


This email and any files transmitted with it are confidential & proprietary to Zodiac Inflight Innovations. This information is intended solely for the use of the individual or entity to which it is addressed. Access or transmittal of the information contained in this e-mail, in full or in part, to any other organization or persons is not authorized.
