From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Tue, 22 Aug 2017 16:07:52 +0800
Subject: [PATCH v5 1/6] Documentation: perf: hisi: Documentation for HiSilicon
 SoC PMU driver
In-Reply-To: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1503389277-134131-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <1503389277-134131-2-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds documentation for the uncore PMUs on HiSilicon SoC.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 Documentation/perf/hisi-pmu.txt | 53 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 Documentation/perf/hisi-pmu.txt

diff --git a/Documentation/perf/hisi-pmu.txt b/Documentation/perf/hisi-pmu.txt
new file mode 100644
index 0000000..267a028
--- /dev/null
+++ b/Documentation/perf/hisi-pmu.txt
@@ -0,0 +1,53 @@
+HiSilicon SoC uncore Performance Monitoring Unit (PMU)
+======================================================
+The HiSilicon SoC chip includes various independent system device PMUs
+such as L3 cache (L3C), Hydra Home Agent (HHA) and DDRC. These PMUs are
+independent and have hardware logic to gather statistics and performance
+information.
+
+The HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster
+(CCL) is made up of 4 cpu cores sharing one L3 cache; each CPU die is
+called Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has
+two HHAs (0 - 1) and four DDRCs (0 - 3), respectively.
+
+HiSilicon SoC uncore PMU driver
+---------------------------------------
+Each device PMU has separate registers for event counting, control and
+interrupt, and the PMU driver shall register perf PMU drivers like L3C,
+HHA and DDRC etc. The available events and configuration options shall
+be described in the sysfs, see :
+/sys/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>/, or
+/sys/bus/event_source/devices/hisi_sccl{X}_<l3c{Y}/hha{Y}/ddrc{Y}>.
+The "perf list" command shall list the available events from sysfs.
+
+Each L3C, HHA and DDRC is registered as a separate PMU with perf. The PMU
+name will appear in event listing as hisi_sccl<sccl-id>_module<index-id>.
+where "sccl-id" is the identifier of the SCCL and "index-id" is the index of
+module.
+e.g. hisi_sccl3_l3c0/rd_hit_cpipe is READ_HIT_CPIPE event of L3C index #0 in
+SCCL ID #3.
+e.g. hisi_sccl1_hha0/rx_operations is RX_OPERATIONS event of HHA index #0 in
+SCCL ID #1.
+
+The driver also provides a "cpumask" sysfs attribute, which shows the CPU core
+ID used to count the uncore PMU event.
+
+Example usage of perf:
+$# perf list
+hisi_sccl3_l3c0/rd_hit_cpipe/ [kernel PMU event]
+------------------------------------------
+hisi_sccl3_l3c0/wr_hit_cpipe/ [kernel PMU event]
+------------------------------------------
+hisi_sccl1_l3c0/rd_hit_cpipe/ [kernel PMU event]
+------------------------------------------
+hisi_sccl1_l3c0/wr_hit_cpipe/ [kernel PMU event]
+------------------------------------------
+
+$# perf stat -a -e hisi_sccl3_l3c0/rd_hit_cpipe/ sleep 5
+$# perf stat -a -e hisi_sccl3_l3c0/config=0x02/ sleep 5
+
+The current driver does not support sampling. So "perf record" is unsupported.
+Also attach to a task is unsupported as the events are all uncore.
+
+Note: Please contact the maintainer for a complete list of events supported for
+the PMU devices in the SoC and its information if needed.
-- 
1.9.1
