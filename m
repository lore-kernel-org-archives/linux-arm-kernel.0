From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:27 +0800
Subject: [PATCH v8 4/9] Documentation: perf: hisi: Documentation for
 HiP05/06/07 PMU event counting.
Message-ID: <1495457307-235888-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurup M <anurup.m@huawei.com>

Documentation for perf usage and Hisilicon SoC PMU uncore events.
The Hisilicon SOC has event counters for hardware modules like
L3 cache, Miscellaneous node etc. These events are all uncore.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 Documentation/perf/hisi-pmu.txt | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/perf/hisi-pmu.txt

diff --git a/Documentation/perf/hisi-pmu.txt b/Documentation/perf/hisi-pmu.txt
new file mode 100644
index 0000000..a21571d
--- /dev/null
+++ b/Documentation/perf/hisi-pmu.txt
@@ -0,0 +1,75 @@
+Hisilicon SoC PMU (Performance Monitoring Unit)
+================================================
+The Hisilicon SoC HiP05/06/07 chips consist of various independent system
+device PMU's such as L3 cache(L3C) and Miscellaneous Nodes(MN).
+These PMU devices are independent and have hardware logic to gather
+statistics and performance information.
+
+HiP0x chips are encapsulated by multiple CPU and IO dies. The CPU die is
+called as Super CPU cluster (SCCL) which includes 16 cpu-cores. Every SCCL
+is further grouped as CPU clusters (CCL) which includes 4 cpu-cores each.
+Each SCCL has 1 L3 cache and 1 MN units.
+
+The L3 cache is shared by all CPU cores in a CPU die. The L3C has four banks
+(or instances). Each bank or instance of L3C has Eight 32-bit counter
+registers and also event control registers. The HiP05/06 chip L3 cache has
+22 statistics events. The HiP07 chip has 66 statistics events. These events
+are very useful for debugging.
+
+The MN module is also shared by all CPU cores in a CPU die. It receives
+barriers and DVM(Distributed Virtual Memory) messages from cpu or smmu, and
+perform the required actions and return response messages. These events are
+very useful for debugging. The MN has total 9 statistics events and support
+four 32-bit counter registers in HiP05/06/07 chips.
+
+There is no memory mapping for L3 cache and MN registers. It can be accessed
+by using the Hisilicon djtag interface. The Djtag in a SCCL is an independent
+module which connects with some modules in the SoC by Debug Bus.
+
+Hisilicon SoC (HiP05/06/07) PMU driver
+--------------------------------------
+The HiP0x PMU driver shall register perf PMU drivers like L3 cache, MN etc.
+The available events and configuration options shall be described in the sysfs.
+The "perf list" shall list the available events from sysfs.
+
+The L3 cache in a SCCL is divided as 4 banks. Each L3 cache bank have separate
+PMU registers for event counting and control. The L3 cache banks also do not
+have any CPU affinity. So each L3 cache banks are registered with perf as a
+separate PMU.
+The PMU name will appear in event listing as hisi_l3c<bank-id>_<scl-id>.
+where "bank-id" is the bank index (0 to 3) and "scl-id" is the SCCL identifier
+e.g. hisi_l3c0_2/read_hit is READ_HIT event of L3 cache bank #0 SCCL ID #2.
+
+The MN in a SCCL is registered as a separate PMU with perf.
+The PMU name will appear in event listing as hisi_mn_<scl-id>.
+e.g. hisi_mn_2/read_req. READ_REQUEST event of MN of Super CPU cluster #2.
+
+The event code is represented by 8 bits.
+	i) event 0-7
+		The event code will be represented using the LSB 8 bits.
+
+The driver also provides a "cpumask" sysfs attribute, which shows the CPU core
+ID used to count the uncore PMU event.
+
+Example usage of perf:
+$# perf list
+hisi_l3c0_2/read_hit/ [kernel PMU event]
+------------------------------------------
+hisi_l3c1_2/write_hit/ [kernel PMU event]
+------------------------------------------
+hisi_l3c0_1/read_hit/ [kernel PMU event]
+------------------------------------------
+hisi_l3c0_1/write_hit/ [kernel PMU event]
+------------------------------------------
+hisi_mn_2/read_req/ [kernel PMU event]
+hisi_mn_2/write_req/ [kernel PMU event]
+------------------------------------------
+
+$# perf stat -a -e "hisi_l3c0_2/read_allocate/" sleep 5
+$# perf stat -A -C 0 -e "hisi_l3c0_2/read_allocate/" sleep 5
+
+The current driver does not support sampling. So "perf record" is unsupported.
+Also attach to a task is unsupported as the events are all uncore.
+
+Note: Please contact the maintainer for a complete list of events supported for
+the PMU devices in the SoC and its information if needed.
-- 
1.9.1
