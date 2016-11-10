From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Nov 2016 09:05:45 +0800
Subject: [PATCH 1/2] arm64: perf: Move ARMv8 PMU perf event definitions
 to asm/perf_event.h
In-Reply-To: <1478721480-24852-1-git-send-email-wei@redhat.com>
Message-ID: <201611100928.Srb5RxpE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wei,

[auto build test ERROR on tip/perf/core]
[also build test ERROR on v4.9-rc4 next-20161109]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Wei-Huang/arm64-perf-Move-ARMv8-PMU-perf-event-definitions-to-asm-perf_event-h/20161110-040107
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Wei-Huang/arm64-perf-Move-ARMv8-PMU-perf-event-definitions-to-asm-perf_event-h/20161110-040107 HEAD 72ad64c0d8d13a655312ace104d723c9dd7dc5b0 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/kvm/../../../virt/kvm/arm/pmu.c: In function 'kvm_pmu_software_increment':
>> arch/arm64/kvm/../../../virt/kvm/arm/pmu.c:308:16: error: 'ARMV8_PMU_EVTYPE_EVENT_SW_INCR' undeclared (first use in this function)
      if ((type == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kvm/../../../virt/kvm/arm/pmu.c:308:16: note: each undeclared identifier is reported only once for each function it appears in
   arch/arm64/kvm/../../../virt/kvm/arm/pmu.c: In function 'kvm_pmu_set_counter_event_type':
   arch/arm64/kvm/../../../virt/kvm/arm/pmu.c:382:18: error: 'ARMV8_PMU_EVTYPE_EVENT_SW_INCR' undeclared (first use in this function)
     if (eventsel == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/ARMV8_PMU_EVTYPE_EVENT_SW_INCR +308 arch/arm64/kvm/../../../virt/kvm/arm/pmu.c

7a0adc70 Shannon Zhao 2015-09-08  302  	enable = vcpu_sys_reg(vcpu, PMCNTENSET_EL0);
7a0adc70 Shannon Zhao 2015-09-08  303  	for (i = 0; i < ARMV8_PMU_CYCLE_IDX; i++) {
7a0adc70 Shannon Zhao 2015-09-08  304  		if (!(val & BIT(i)))
7a0adc70 Shannon Zhao 2015-09-08  305  			continue;
7a0adc70 Shannon Zhao 2015-09-08  306  		type = vcpu_sys_reg(vcpu, PMEVTYPER0_EL0 + i)
7a0adc70 Shannon Zhao 2015-09-08  307  		       & ARMV8_PMU_EVTYPE_EVENT;
7a0adc70 Shannon Zhao 2015-09-08 @308  		if ((type == ARMV8_PMU_EVTYPE_EVENT_SW_INCR)
7a0adc70 Shannon Zhao 2015-09-08  309  		    && (enable & BIT(i))) {
7a0adc70 Shannon Zhao 2015-09-08  310  			reg = vcpu_sys_reg(vcpu, PMEVCNTR0_EL0 + i) + 1;
7a0adc70 Shannon Zhao 2015-09-08  311  			reg = lower_32_bits(reg);

:::::: The code at line 308 was first introduced by commit
:::::: 7a0adc7064b88609e2917446af8789fac1d4fdd1 arm64: KVM: Add access handler for PMSWINC register

:::::: TO: Shannon Zhao <shannon.zhao@linaro.org>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 32739 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161110/5b2a68e8/attachment-0001.gz>
