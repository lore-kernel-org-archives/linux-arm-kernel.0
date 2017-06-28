From: lkp@intel.com (kbuild test robot)
Date: Wed, 28 Jun 2017 09:49:53 +0800
Subject: [PATCH 2/6] drivers: perf: hisi: Add support for HiSilicon SoC
 uncore PMU driver
In-Reply-To: <1498552001-182148-3-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <201706280909.xG39IHY4%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaokun,

[auto build test ERROR on next-20170619]
[also build test ERROR on v4.12-rc7]
[cannot apply to linus/master linux/master arm64/for-next/core v4.12-rc6 v4.12-rc5 v4.12-rc4]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shaokun-Zhang/Add-HiSilicon-SoC-uncore-Performance-Monitoring-Unit-driver/20170628-070841
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/perf/hisilicon/hisi_uncore_pmu.c: In function 'hisi_read_scl_and_ccl_id':
>> drivers/perf/hisilicon/hisi_uncore_pmu.c:72:10: error: implicit declaration of function 'read_cpuid_mpidr' [-Werror=implicit-function-declaration]
     mpidr = read_cpuid_mpidr();
             ^~~~~~~~~~~~~~~~
>> drivers/perf/hisilicon/hisi_uncore_pmu.c:73:14: error: 'MPIDR_MT_BITMASK' undeclared (first use in this function)
     if (mpidr & MPIDR_MT_BITMASK) {
                 ^~~~~~~~~~~~~~~~
   drivers/perf/hisilicon/hisi_uncore_pmu.c:73:14: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/perf/hisilicon/hisi_uncore_pmu.c:75:14: error: implicit declaration of function 'MPIDR_AFFINITY_LEVEL' [-Werror=implicit-function-declaration]
       *scl_id = MPIDR_AFFINITY_LEVEL(mpidr, 3);
                 ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/read_cpuid_mpidr +72 drivers/perf/hisilicon/hisi_uncore_pmu.c

    66	
    67	/* Read Super CPU cluster and CPU cluster ID from MPIDR_EL1 */
    68	void hisi_read_scl_and_ccl_id(u32 *scl_id, u32 *ccl_id)
    69	{
    70		u64 mpidr;
    71	
  > 72		mpidr = read_cpuid_mpidr();
  > 73		if (mpidr & MPIDR_MT_BITMASK) {
    74			if (scl_id)
  > 75				*scl_id = MPIDR_AFFINITY_LEVEL(mpidr, 3);
    76			if (ccl_id)
    77				*ccl_id = MPIDR_AFFINITY_LEVEL(mpidr, 2);
    78		} else {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60609 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170628/928ea38f/attachment-0001.gz>
