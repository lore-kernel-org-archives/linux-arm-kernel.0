From: lkp@intel.com (kbuild test robot)
Date: Tue, 6 Oct 2015 12:41:51 +0800
Subject: [PATCH v2 12/22] arm64: Delay cpu feature checks
In-Reply-To: <1444064531-25607-13-git-send-email-suzuki.poulose@arm.com>
Message-ID: <201510061230.QVbFYdKy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

[auto build test ERROR on v4.3-rc4 -- if it's inappropriate base, please ignore]

config: arm64-alldefconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the linux-review/Suzuki-K-Poulose/arm64-Consolidate-CPU-feature-handling HEAD bfdef3a10032e84cc7ae186a058443219f110679 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/kernel/cpufeature.c: In function 'cpu_enable_features':
>> arch/arm64/kernel/cpufeature.c:733:52: error: 'const struct arm64_cpu_capabilities' has no member named 'sys_reg'
      if(!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
                                                       ^
   arch/arm64/kernel/cpufeature.c:739:47: error: 'const struct arm64_cpu_capabilities' has no member named 'sys_reg'
      if (!feature_matches(read_cpu_sysreg(caps[i].sys_reg), &caps[i]))
                                                  ^

vim +733 arch/arm64/kernel/cpufeature.c

   727		const struct arm64_cpu_capabilities *caps = arm64_features;
   728	
   729		for(i = 0; caps[i].desc; i++)
   730			if (caps[i].enable && cpus_have_cap(caps[i].capability))
   731				caps[i].enable(NULL);
   732		for(i = 0; caps[i].desc; i++) {
 > 733			if(!cpus_have_cap(caps[i].capability) || !caps[i].sys_reg)
   734				continue;
   735			/*
   736			 * If the new CPU misses an advertised feature, we cannot proceed

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 7583 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/54c877c6/attachment.obj>
