From: lkp@intel.com (kbuild test robot)
Date: Sun, 18 Oct 2015 06:56:30 +0800
Subject: [PATCH v3 14/24] arm64: Delay cpu feature capability checks
In-Reply-To: <1444756952-31145-15-git-send-email-suzuki.poulose@arm.com>
Message-ID: <201510180642.xwPchoyX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

[auto build test ERROR on v4.3-rc5 -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/arm64-Consolidate-CPU-feature-handling/20151014-013504
config: arm64-allnoconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/cpufeature.c: In function 'fail_incapable_cpu':
>> arch/arm64/kernel/cpufeature.c:643:34: error: 'const struct cpu_operations' has no member named 'cpu_die'
     if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
                                     ^
   arch/arm64/kernel/cpufeature.c:644:15: error: 'const struct cpu_operations' has no member named 'cpu_die'
      cpu_ops[cpu]->cpu_die(cpu);
                  ^

vim +643 arch/arm64/kernel/cpufeature.c

   637		int cpu = smp_processor_id();
   638	
   639		pr_crit("CPU%d: missing %s : %s\n", cpu, cap_type, cap->desc);
   640		/* Mark this CPU absent */
   641		set_cpu_present(cpu, 0);
   642		/* Check if we can park ourselves */
 > 643		if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
   644			cpu_ops[cpu]->cpu_die(cpu);
   645	
   646		asm volatile(

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 5475 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151018/279edd5f/attachment.obj>
