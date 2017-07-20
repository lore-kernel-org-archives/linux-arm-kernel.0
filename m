From: zhangshaokun@hisilicon.com (Zhangshaokun)
Date: Thu, 20 Jul 2017 20:54:36 +0800
Subject: [PATCH v3 1/6] Documentation: perf: hisi: Documentation for
 HiSilicon SoC PMU driver
In-Reply-To: <20170719171748.00005866@huawei.com>
References: <1500364799-90518-1-git-send-email-zhangshaokun@hisilicon.com>
 <1500364799-90518-2-git-send-email-zhangshaokun@hisilicon.com>
 <20170719171748.00005866@huawei.com>
Message-ID: <c5c552e2-94e2-9390-9cda-2573844b926d@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonathan,

Thanks for your comments firstly.

On 2017/7/19 17:17, Jonathan Cameron wrote:
> On Tue, 18 Jul 2017 15:59:54 +0800
> Shaokun Zhang <zhangshaokun@hisilicon.com> wrote:
> 
>> This patch adds documentation for the uncore PMUs on HiSilicon SoC.
>>
>> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
>> Signed-off-by: Anurup M <anurup.m@huawei.com>  
> Hi Shaokun,
> 
> Sorry for the late reply on this (only recently joined Huawei)
> 
> This is a fairly generic review of the code rather than going into
> the actual userspace ABI choices as this is an area I'm only just
> starting to become familiar with.
> 
> Thanks,
> 
> Jonathan
>> ---
>>  Documentation/perf/hisi-pmu.txt | 51 +++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 51 insertions(+)
>>  create mode 100644 Documentation/perf/hisi-pmu.txt
>>
>> diff --git a/Documentation/perf/hisi-pmu.txt b/Documentation/perf/hisi-pmu.txt
>> new file mode 100644
>> index 0000000..5fa0b1a
>> --- /dev/null
>> +++ b/Documentation/perf/hisi-pmu.txt
>> @@ -0,0 +1,51 @@
>> +HiSilicon SoC uncore Performance Monitoring Unit (PMU)
>> +======================================================
>> +The HiSilicon SoC chip comprehends various independent system device PMUs
>> +such as L3 cache (L3C), Hydra Home Agent (HHA) and DDRC. These PMUs are
>> +independent and have hardware logic to gather statistics and performance
>> +information.
>> +
>> +HiSilicon SoC encapsulates multiple CPU and IO dies. Each CPU cluster (CC
>> +L) is made up of 4 cpu cores sharing one L3 cache; Each CPU die is called  
> nitpick, I'd not have a line break mid acronym. 
> 

Ok, shall keep CCL in the same line.

>> +Super CPU cluster (SCCL) and is made up of 6 CCLs. Each SCCL has two HHAs
>> +(0 - 1) and four DDRCs (0 - 3), respectively.
>> +
>> +HiSilicon SoC uncore PMU driver
>> +---------------------------------------
>> +Each device PMU has separate registers for event counting, control and
>> +interrupt, and the PMU driver shall register perf PMU drivers like L3C,
>> +HHA and DDRC etc. The available events and configuration options shall
>> +be described in the sysfs, see /sys/devices/hisi_*.  
> Is there not a subsystem directory that would make more sense to
> refer to than the full device list?
> 

For uncore devices, it is more reasonable to list in /sys/devices/***.

Thanks.
Shaokun

>> +The "perf list" command shall list the available events from sysfs.
>> +
>> +Each L3C, HHA and DDRC in one SCCL are registered as an separate PMU with perf.
>> +The PMU name will appear in event listing as hisi_module <index-id>_<sccl-id>.
>> +where "index-id" is the index of module and "sccl-id" is the identifier of
>> +the SCCL.
>> +e.g. hisi_l3c0_1/rd_hit_cpipe is READ_HIT_CPIPE event of L3C index #0 and SCCL
>> +ID #1.
>> +e.g. hisi_hha0_1/rx_operations is RX_OPERATIONS event of HHA index #0 and SCCL
>> +ID #1.
>> +
>> +The driver also provides a "cpumask" sysfs attribute, which shows the CPU core
>> +ID used to count the uncore PMU event.
>> +
>> +Example usage of perf:
>> +$# perf list
>> +hisi_l3c0_3/rd_hit_cpipe/ [kernel PMU event]
>> +------------------------------------------
>> +hisi_l3c0_3/wr_hit_cpipe/ [kernel PMU event]
>> +------------------------------------------
>> +hisi_l3c0_1/rd_hit_cpipe/ [kernel PMU event]
>> +------------------------------------------
>> +hisi_l3c0_1/wr_hit_cpipe/ [kernel PMU event]
>> +------------------------------------------
>> +
>> +$# perf stat -a -e hisi_l3c0_1/rd_hit_cpipe/ sleep 5
>> +$# perf stat -a -e hisi_l3c0_1/config=0x02/ sleep 5
>> +
>> +The current driver does not support sampling. So "perf record" is unsupported.
>> +Also attach to a task is unsupported as the events are all uncore.
>> +
>> +Note: Please contact the maintainer for a complete list of events supported for
>> +the PMU devices in the SoC and its information if needed.  
> 
> 
> _______________________________________________
> linuxarm mailing list
> 
> 
> .
> 
