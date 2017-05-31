From: lkp@intel.com (kbuild test robot)
Date: Thu, 1 Jun 2017 02:31:19 +0800
Subject: [PATCH v2 2/2] perf: ThunderX2: Add Cavium Thunderx2 SoC UNCORE
 PMU driver
In-Reply-To: <1496224663-13819-3-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <201706010245.AKqnQgAP%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ganapatrao,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.12-rc3 next-20170531]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Ganapatrao-Kulkarni/perf-uncore-Adding-documentation-for-ThunderX2-pmu-uncore-driver/20170531-204518
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/perf/thunderx2_pmu.c: In function 'thunderx2_uncore_update':
>> drivers/perf/thunderx2_pmu.c:499:18: warning: left shift count >= width of type [-Wshift-count-overflow]
      delta = (((1UL << 32) - prev) + new);
                     ^~

vim +499 drivers/perf/thunderx2_pmu.c

   483		u64 delta;
   484		struct hw_perf_event *hwc = &event->hw;
   485		struct thunderx2_pmu_uncore_channel *pmu_uncore;
   486		enum thunderx2_uncore_type type;
   487	
   488		pmu_uncore = pmu_to_thunderx2_pmu_uncore(event->pmu);
   489		type = pmu_uncore->uncore_dev->type;
   490	
   491		if (pmu_uncore->uncore_dev->select_channel)
   492			pmu_uncore->uncore_dev->select_channel(event);
   493	
   494		new = reg_readl(hwc->event_base);
   495		prev = local64_xchg(&hwc->prev_count, new);
   496	
   497		/* handle rollover of counters */
   498		if (new < prev)
 > 499			delta = (((1UL << 32) - prev) + new);
   500		else
   501			delta = new - prev;
   502	
   503		local64_add(delta, &event->count);
   504	}
   505	
   506	enum thunderx2_uncore_type get_uncore_device_type(struct acpi_device *adev)
   507	{

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60135 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/e71a0951/attachment-0001.gz>
