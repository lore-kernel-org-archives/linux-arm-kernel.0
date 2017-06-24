From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 25 Jun 2017 04:03:34 +0800
Subject: [arm64:for-next/core 12/40] arch/arm64/kernel/ftrace.c:102:10:
 error: implicit declaration of function '__module_text_address'
Message-ID: <201706250432.rgSHO4BO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
head:   8486e54d30e170c969090f80bbdfa7142d33ed6a
commit: f8af0b364e249eef0c71200826563947cd74267e [12/40] arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f8af0b364e249eef0c71200826563947cd74267e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

Note: the arm64/for-next/core HEAD 8486e54d30e170c969090f80bbdfa7142d33ed6a builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   arch/arm64/kernel/ftrace.c: In function 'ftrace_make_nop':
>> arch/arm64/kernel/ftrace.c:102:10: error: implicit declaration of function '__module_text_address' [-Werror=implicit-function-declaration]
       mod = __module_text_address(pc);
             ^~~~~~~~~~~~~~~~~~~~~
>> arch/arm64/kernel/ftrace.c:102:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
       mod = __module_text_address(pc);
           ^
>> arch/arm64/kernel/ftrace.c:120:8: error: implicit declaration of function 'within_module' [-Werror=implicit-function-declaration]
          !within_module(pc + aarch64_get_branch_offset(replaced),
           ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/__module_text_address +102 arch/arm64/kernel/ftrace.c

    96			 * 'mod' is only set at module load time, but if we end up
    97			 * dealing with an out-of-range condition, we can assume it
    98			 * is due to a module being loaded far away from the kernel.
    99			 */
   100			if (!mod) {
   101				preempt_disable();
 > 102				mod = __module_text_address(pc);
   103				preempt_enable();
   104	
   105				if (WARN_ON(!mod))
   106					return -EINVAL;
   107			}
   108	
   109			/*
   110			 * The instruction we are about to patch may be a branch and
   111			 * link instruction that was redirected via a PLT entry. In
   112			 * this case, the normal validation will fail, but we can at
   113			 * least check that we are dealing with a branch and link
   114			 * instruction that points into the right module.
   115			 */
   116			if (aarch64_insn_read((void *)pc, &replaced))
   117				return -EFAULT;
   118	
   119			if (!aarch64_insn_is_bl(replaced) ||
 > 120			    !within_module(pc + aarch64_get_branch_offset(replaced),
   121					   mod))
   122				return -EINVAL;
   123	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 55833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170625/55edf5e0/attachment-0001.gz>
