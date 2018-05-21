From: lkp@intel.com (kbuild test robot)
Date: Tue, 22 May 2018 07:30:06 +0800
Subject: [PATCH 2/6] arm_pmu: Change API to support 64bit counter values
In-Reply-To: <1526638943-2110-3-git-send-email-suzuki.poulose@arm.com>
References: <1526638943-2110-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <201805220546.ySDTMDEX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.17-rc6 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/arm64-perf-Support-for-chaining-event-counters/20180521-102117
config: arm-corgi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kernel/perf_event_xscale.c: In function 'xscale2pmu_init':
>> arch/arm/kernel/perf_event_xscale.c:741:24: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
     cpu_pmu->read_counter = xscale2pmu_read_counter;
                           ^
   arch/arm/kernel/perf_event_xscale.c:742:25: error: assignment from incompatible pointer type [-Werror=incompatible-pointer-types]
     cpu_pmu->write_counter = xscale2pmu_write_counter;
                            ^
   cc1: some warnings being treated as errors

vim +741 arch/arm/kernel/perf_event_xscale.c

43eab878 Will Deacon        2010-11-13  734  
351a102d Greg Kroah-Hartman 2012-12-21  735  static int xscale2pmu_init(struct arm_pmu *cpu_pmu)
43eab878 Will Deacon        2010-11-13  736  {
3d1ff755 Mark Rutland       2012-12-19  737  	cpu_pmu->name		= "armv5_xscale2";
513c99ce Sudeep Holla       2012-07-31  738  	cpu_pmu->handle_irq	= xscale2pmu_handle_irq;
513c99ce Sudeep Holla       2012-07-31  739  	cpu_pmu->enable		= xscale2pmu_enable_event;
513c99ce Sudeep Holla       2012-07-31  740  	cpu_pmu->disable	= xscale2pmu_disable_event;
513c99ce Sudeep Holla       2012-07-31 @741  	cpu_pmu->read_counter	= xscale2pmu_read_counter;
513c99ce Sudeep Holla       2012-07-31  742  	cpu_pmu->write_counter	= xscale2pmu_write_counter;
513c99ce Sudeep Holla       2012-07-31  743  	cpu_pmu->get_event_idx	= xscale2pmu_get_event_idx;
513c99ce Sudeep Holla       2012-07-31  744  	cpu_pmu->start		= xscale2pmu_start;
513c99ce Sudeep Holla       2012-07-31  745  	cpu_pmu->stop		= xscale2pmu_stop;
513c99ce Sudeep Holla       2012-07-31  746  	cpu_pmu->map_event	= xscale_map_event;
513c99ce Sudeep Holla       2012-07-31  747  	cpu_pmu->num_events	= 5;
547faa3c Suzuki K Poulose   2018-05-18  748  	cpu_pmu->counter_width	= 32;
513c99ce Sudeep Holla       2012-07-31  749  
513c99ce Sudeep Holla       2012-07-31  750  	return 0;
43eab878 Will Deacon        2010-11-13  751  }
a12c72cc Mark Rutland       2015-05-26  752  

:::::: The code at line 741 was first introduced by commit
:::::: 513c99ce4e64245be1f83f56039ec4891b451955 ARM: perf: allocate CPU PMU dynamically at probe time

:::::: TO: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 18856 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180522/fdf9dc7a/attachment-0001.gz>
