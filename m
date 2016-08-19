From: Nitin.Chaudhary@zii.aero (Nitin Chaudhary)
Date: Thu, 18 Aug 2016 18:17:38 -0700
Subject: [PATCH 2/3] [i.MX6Q] Code cleanup & verification after fixing
 compilation error
In-Reply-To: <1471569459-1546-1-git-send-email-Nitin.Chaudhary@zii.aero>
References: <DB5PR04MB1430487C8BFA276E285493959F150@DB5PR04MB1430.eurprd04.prod.outlook.com>
 <1471569459-1546-1-git-send-email-Nitin.Chaudhary@zii.aero>
Message-ID: <1471569459-1546-3-git-send-email-Nitin.Chaudhary@zii.aero>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cleanup the code after fixing build error in Zhengyu Shen's perf mmdc
integrated driver. The error occured due to migration of CPU Hotplug
notifiers to a state machine based mechanism. Made the necessary cha-
nges into the code and tested the same on an i.MX6QP FSL Board. The
changes allow clean compilation and work fine as well. The results
are as follows:

root at RDU2:~ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-byte
s/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=
/dev/null bs=1M count=5000
5000+0 records in
5000+0 records out
5242880000 bytes (5.2 GB) copied, 5.4982 s, 954 MB/s

 Performance counter stats for 'system wide':

        1597891298      mmdc/busy-cycles/
          28531959      mmdc/read-accesses/
            910.77 MB   mmdc/read-bytes/
        2917082184      mmdc/total-cycles/
          27965222      mmdc/write-accesses/
            894.91 MB   mmdc/write-bytes/

       5.527407668 seconds time elapsed

But still need to check why the automatic power saving mode is not getting
enabled in my board. Any help/guidance on the same will be appreciated.

Signed-off-by: Nitin Chaudhary <Nitin.Chaudhary@zii.aero>
---
 arch/arm/mach-imx/mmdc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 95c222d..45790f5 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -204,9 +204,10 @@ static int mmdc_cpu_offline(unsigned int cpu)

        perf_pmu_migrate_context(&pmu_ptr->pmu, cpu, target);
        cpumask_set_cpu(target, &pmu_ptr->cpu);
-       /*
-       if(pmu_ptr->irq)
-               WARN_ON(irq_set_affinity_hint(pmu_ptr->irq, &pmu_ptr->cpu) != 0);
+       /*
+        * TODO: Need to check if we need it or not
+        * if(pmu_ptr->irq)
+        *       WARN_ON(irq_set_affinity_hint(pmu_ptr->irq, &pmu_ptr->cpu) != 0);
        */
        return 0;
 }
@@ -374,7 +375,12 @@ static int imx_mmdc_probe(struct platform_device *pdev)
        if (unlikely(!timeout)) {
                pr_warn("%s: failed to enable automatic power saving\n",
                        __func__);
-               //return -EBUSY;
+
+               /*
+                * TODO: Need to check why Automatic Power saving is not
+                * getting enabled successfully.
+                * return -EBUSY;
+                */
        }
        pmu_mmdc = kzalloc(sizeof(*pmu_mmdc), GFP_KERNEL);

--
2.7.4


________________________________


This email and any files transmitted with it are confidential & proprietary to Zodiac Inflight Innovations. This information is intended solely for the use of the individual or entity to which it is addressed. Access or transmittal of the information contained in this e-mail, in full or in part, to any other organization or persons is not authorized.
