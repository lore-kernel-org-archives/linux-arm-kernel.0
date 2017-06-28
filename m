From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 17:56:37 +0800
Subject: [PATCH 4/6] drivers: perf: hisi: Add support for HiSilicon SoC
 HHA PMU driver
In-Reply-To: <1498552001-182148-5-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <201706281706.O4jmBQ6k%fengguang.wu@intel.com>
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

   drivers/perf/hisilicon/hisi_uncore_hha_pmu.c: In function 'hisi_hha_pmu_read_counter':
>> drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:71:9: error: implicit declaration of function 'readq' [-Werror=implicit-function-declaration]
     return readq(hha_pmu->base + reg);
            ^~~~~
   drivers/perf/hisilicon/hisi_uncore_hha_pmu.c: In function 'hisi_hha_pmu_write_counter':
>> drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:87:2: error: implicit declaration of function 'writeq' [-Werror=implicit-function-declaration]
     writeq(val, hha_pmu->base + reg);
     ^~~~~~
   cc1: some warnings being treated as errors

coccinelle warnings: (new ones prefixed by >>)

>> drivers/perf/hisilicon/hisi_uncore_hha_pmu.c:272:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

vim +/readq +71 drivers/perf/hisilicon/hisi_uncore_hha_pmu.c

    65			return 0;
    66		}
    67	
    68		reg = get_counter_reg_off(idx);
    69	
    70		/* Read 64 bits and like L3C, top 16 bits are RAZ */
  > 71		return readq(hha_pmu->base + reg);
    72	}
    73	
    74	static void hisi_hha_pmu_write_counter(struct hisi_pmu *hha_pmu,
    75					       struct hw_perf_event *hwc, u64 val)
    76	{
    77		u32 idx = hwc->idx;
    78		u32 reg;
    79	
    80		if (!hisi_uncore_pmu_counter_valid(hha_pmu, idx)) {
    81			dev_err(hha_pmu->dev, "Unsupported event index:%d!\n", idx);
    82			return;
    83		}
    84	
    85		reg = get_counter_reg_off(idx);
    86		/* Write 64 bits and like L3C, top 16 bits are WI */
  > 87		writeq(val, hha_pmu->base + reg);
    88	}
    89	
    90	static void hisi_hha_pmu_write_evtype(struct hisi_pmu *hha_pmu, int idx,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60689 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/a079c7a9/attachment-0001.gz>
