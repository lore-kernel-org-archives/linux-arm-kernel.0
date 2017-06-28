From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 17:21:18 +0800
Subject: [PATCH 3/6] drivers: perf: hisi: Add support for HiSilicon SoC
 L3C PMU driver
In-Reply-To: <1498552001-182148-4-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <201706281748.v6FQazSw%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaokun,

[auto build test ERROR on next-20170619]
[also build test ERROR on v4.12-rc7]
[cannot apply to linus/master linux/master arm64/for-next/core v4.12-rc6 v4.12-rc5 v4.12-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shaokun-Zhang/Add-HiSilicon-SoC-uncore-Performance-Monitoring-Unit-driver/20170628-070841
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c: In function 'hisi_l3c_pmu_read_counter':
>> drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c:69:9: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
     return readq(l3c_pmu->base + reg);
            ^~~~~
   drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c: In function 'hisi_l3c_pmu_write_counter':
>> drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c:85:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
     writeq(val, l3c_pmu->base + reg);
     ^~~~~~
   cc1: some warnings being treated as errors

coccinelle warnings: (new ones prefixed by >>)

>> drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c:348:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

vim +/readq +69 drivers/perf/hisilicon/hisi_uncore_l3c_pmu.c

    63			return 0;
    64		}
    65	
    66		reg = get_counter_reg_off(idx);
    67	
    68		/* Read 64-bits and the upper 16 bits are Read-As-Zero */
  > 69		return readq(l3c_pmu->base + reg);
    70	}
    71	
    72	static void hisi_l3c_pmu_write_counter(struct hisi_pmu *l3c_pmu,
    73					       struct hw_perf_event *hwc, u64 val)
    74	{
    75		u32 idx = hwc->idx;
    76		u32 reg;
    77	
    78		if (!hisi_uncore_pmu_counter_valid(l3c_pmu, idx)) {
    79			dev_err(l3c_pmu->dev, "Unsupported event index:%d!\n", idx);
    80			return;
    81		}
    82	
    83		reg = get_counter_reg_off(idx);
    84		/* Write 64-bits and the upper 16 bits are Writes-Ignored */
  > 85		writeq(val, l3c_pmu->base + reg);
    86	}
    87	
    88	static void hisi_l3c_pmu_write_evtype(struct hisi_pmu *l3c_pmu, int idx,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60689 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/5edee309/attachment-0001.gz>
