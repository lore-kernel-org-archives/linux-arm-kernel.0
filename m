From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 17 Feb 2018 12:38:16 +0800
Subject: [arm64:fixes/core 4/5] arch/arm64/kernel/armv8_deprecated.c:404:31:
 warning: passing argument 1 of '__range_ok' makes pointer from integer
 without a cast
Message-ID: <201802171213.ppCdl9kU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git fixes/core
head:   8d77124b84783bc37517edc6223d501092ab8e53
commit: 6e3941e8f8e106e25343f140b9d73a2bc64730a7 [4/5] arm64: uaccess: Clean up types for access_ok()
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 6e3941e8f8e106e25343f140b9d73a2bc64730a7
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   In file included from include/linux/uaccess.h:14:0,
                    from arch/arm64/kernel/armv8_deprecated.c:23:
   arch/arm64/kernel/armv8_deprecated.c: In function 'swp_handler':
>> arch/arm64/kernel/armv8_deprecated.c:404:31: warning: passing argument 1 of '__range_ok' makes pointer from integer without a cast [-Wint-conversion]
     if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
                                  ^
   arch/arm64/include/asm/uaccess.h:107:48: note: in definition of macro 'access_ok'
    #define access_ok(type, addr, size) __range_ok(addr, size)
                                                   ^~~~
   arch/arm64/include/asm/uaccess.h:75:29: note: expected 'const void *' but argument is of type 'u32 {aka unsigned int}'
    static inline unsigned long __range_ok(const void __user *addr, unsigned long size)
                                ^~~~~~~~~~

vim +/__range_ok +404 arch/arm64/kernel/armv8_deprecated.c

2af3ec08b David A. Long  2016-07-08  364  
bd35a4adc Punit Agrawal  2014-11-18  365  /*
bd35a4adc Punit Agrawal  2014-11-18  366   * swp_handler logs the id of calling process, dissects the instruction, sanity
bd35a4adc Punit Agrawal  2014-11-18  367   * checks the memory location, calls emulate_swpX for the actual operation and
bd35a4adc Punit Agrawal  2014-11-18  368   * deals with fixup/error handling before returning
bd35a4adc Punit Agrawal  2014-11-18  369   */
bd35a4adc Punit Agrawal  2014-11-18  370  static int swp_handler(struct pt_regs *regs, u32 instr)
bd35a4adc Punit Agrawal  2014-11-18  371  {
bd35a4adc Punit Agrawal  2014-11-18  372  	u32 destreg, data, type, address = 0;
bd35a4adc Punit Agrawal  2014-11-18  373  	int rn, rt2, res = 0;
bd35a4adc Punit Agrawal  2014-11-18  374  
bd35a4adc Punit Agrawal  2014-11-18  375  	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, regs->pc);
bd35a4adc Punit Agrawal  2014-11-18  376  
bd35a4adc Punit Agrawal  2014-11-18  377  	type = instr & TYPE_SWPB;
bd35a4adc Punit Agrawal  2014-11-18  378  
2af3ec08b David A. Long  2016-07-08  379  	switch (aarch32_check_condition(instr, regs->pstate)) {
bd35a4adc Punit Agrawal  2014-11-18  380  	case ARM_OPCODE_CONDTEST_PASS:
bd35a4adc Punit Agrawal  2014-11-18  381  		break;
bd35a4adc Punit Agrawal  2014-11-18  382  	case ARM_OPCODE_CONDTEST_FAIL:
bd35a4adc Punit Agrawal  2014-11-18  383  		/* Condition failed - return to next instruction */
bd35a4adc Punit Agrawal  2014-11-18  384  		goto ret;
bd35a4adc Punit Agrawal  2014-11-18  385  	case ARM_OPCODE_CONDTEST_UNCOND:
bd35a4adc Punit Agrawal  2014-11-18  386  		/* If unconditional encoding - not a SWP, undef */
bd35a4adc Punit Agrawal  2014-11-18  387  		return -EFAULT;
bd35a4adc Punit Agrawal  2014-11-18  388  	default:
bd35a4adc Punit Agrawal  2014-11-18  389  		return -EINVAL;
bd35a4adc Punit Agrawal  2014-11-18  390  	}
bd35a4adc Punit Agrawal  2014-11-18  391  
bd35a4adc Punit Agrawal  2014-11-18  392  	rn = aarch32_insn_extract_reg_num(instr, A32_RN_OFFSET);
bd35a4adc Punit Agrawal  2014-11-18  393  	rt2 = aarch32_insn_extract_reg_num(instr, A32_RT2_OFFSET);
bd35a4adc Punit Agrawal  2014-11-18  394  
bd35a4adc Punit Agrawal  2014-11-18  395  	address = (u32)regs->user_regs.regs[rn];
bd35a4adc Punit Agrawal  2014-11-18  396  	data	= (u32)regs->user_regs.regs[rt2];
bd35a4adc Punit Agrawal  2014-11-18  397  	destreg = aarch32_insn_extract_reg_num(instr, A32_RT_OFFSET);
bd35a4adc Punit Agrawal  2014-11-18  398  
bd35a4adc Punit Agrawal  2014-11-18  399  	pr_debug("addr in r%d->0x%08x, dest is r%d, source in r%d->0x%08x)\n",
bd35a4adc Punit Agrawal  2014-11-18  400  		rn, address, destreg,
bd35a4adc Punit Agrawal  2014-11-18  401  		aarch32_insn_extract_reg_num(instr, A32_RT2_OFFSET), data);
bd35a4adc Punit Agrawal  2014-11-18  402  
bd35a4adc Punit Agrawal  2014-11-18  403  	/* Check access in reasonable access range for both SWP and SWPB */
bd35a4adc Punit Agrawal  2014-11-18 @404  	if (!access_ok(VERIFY_WRITE, (address & ~3), 4)) {
bd35a4adc Punit Agrawal  2014-11-18  405  		pr_debug("SWP{B} emulation: access to 0x%08x not allowed!\n",
bd35a4adc Punit Agrawal  2014-11-18  406  			address);
bd35a4adc Punit Agrawal  2014-11-18  407  		goto fault;
bd35a4adc Punit Agrawal  2014-11-18  408  	}
bd35a4adc Punit Agrawal  2014-11-18  409  
bd35a4adc Punit Agrawal  2014-11-18  410  	res = emulate_swpX(address, &data, type);
bd35a4adc Punit Agrawal  2014-11-18  411  	if (res == -EFAULT)
bd35a4adc Punit Agrawal  2014-11-18  412  		goto fault;
bd35a4adc Punit Agrawal  2014-11-18  413  	else if (res == 0)
bd35a4adc Punit Agrawal  2014-11-18  414  		regs->user_regs.regs[destreg] = data;
bd35a4adc Punit Agrawal  2014-11-18  415  
bd35a4adc Punit Agrawal  2014-11-18  416  ret:
d784e2988 Punit Agrawal  2014-11-18  417  	if (type == TYPE_SWPB)
d784e2988 Punit Agrawal  2014-11-18  418  		trace_instruction_emulation("swpb", regs->pc);
d784e2988 Punit Agrawal  2014-11-18  419  	else
d784e2988 Punit Agrawal  2014-11-18  420  		trace_instruction_emulation("swp", regs->pc);
d784e2988 Punit Agrawal  2014-11-18  421  
bd35a4adc Punit Agrawal  2014-11-18  422  	pr_warn_ratelimited("\"%s\" (%ld) uses obsolete SWP{B} instruction at 0x%llx\n",
bd35a4adc Punit Agrawal  2014-11-18  423  			current->comm, (unsigned long)current->pid, regs->pc);
bd35a4adc Punit Agrawal  2014-11-18  424  
6436beeee Julien Thierry 2017-10-25  425  	arm64_skip_faulting_instruction(regs, 4);
bd35a4adc Punit Agrawal  2014-11-18  426  	return 0;
bd35a4adc Punit Agrawal  2014-11-18  427  
bd35a4adc Punit Agrawal  2014-11-18  428  fault:
390bf1773 Andre Przywara 2016-06-28  429  	pr_debug("SWP{B} emulation: access caused memory abort!\n");
390bf1773 Andre Przywara 2016-06-28  430  	arm64_notify_segfault(regs, address);
bd35a4adc Punit Agrawal  2014-11-18  431  
bd35a4adc Punit Agrawal  2014-11-18  432  	return 0;
bd35a4adc Punit Agrawal  2014-11-18  433  }
bd35a4adc Punit Agrawal  2014-11-18  434  

:::::: The code at line 404 was first introduced by commit
:::::: bd35a4adc4131c530ec7d90242555eac7b3dbe3f arm64: Port SWP/SWPB emulation support from arm

:::::: TO: Punit Agrawal <punit.agrawal@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 59119 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180217/cd55dd8c/attachment-0001.gz>
