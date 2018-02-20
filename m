From: lkp@intel.com (kbuild test robot)
Date: Tue, 20 Feb 2018 10:11:32 +0800
Subject: [PATCH] arm64: Add support for new control bits CTR_EL0.IDC and
 CTR_EL0.IDC
In-Reply-To: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
References: <1518829066-3558-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <201802201000.EqpnvgN2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2 next-20180219]
[cannot apply to arm64/for-next/core]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Shanker-Donthineni/arm64-Add-support-for-new-control-bits-CTR_EL0-IDC-and-CTR_EL0-IDC/20180219-031155
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kernel/hibernate-asm.S: Assembler messages:
>> arch/arm64/kernel/hibernate-asm.S:101: Error: unexpected comma after the mnemonic name `mrs' -- `mrs ,ctr_el0'
>> arch/arm64/kernel/hibernate-asm.S:101: Error: operand 2 must be an integer register -- `ubfm x3,,#16,#19'
--
   arch/arm64/kernel/relocate_kernel.S: Assembler messages:
>> arch/arm64/kernel/relocate_kernel.S:37: Error: unexpected comma after the mnemonic name `mrs' -- `mrs ,ctr_el0'
>> arch/arm64/kernel/relocate_kernel.S:37: Error: operand 2 must be an integer register -- `ubfm x0,,#16,#19'

vim +101 arch/arm64/kernel/hibernate-asm.S

82869ac57 James Morse        2016-04-27   46  
82869ac57 James Morse        2016-04-27   47  
82869ac57 James Morse        2016-04-27   48  /*
82869ac57 James Morse        2016-04-27   49   * Resume from hibernate
82869ac57 James Morse        2016-04-27   50   *
82869ac57 James Morse        2016-04-27   51   * Loads temporary page tables then restores the memory image.
82869ac57 James Morse        2016-04-27   52   * Finally branches to cpu_resume() to restore the state saved by
82869ac57 James Morse        2016-04-27   53   * swsusp_arch_suspend().
82869ac57 James Morse        2016-04-27   54   *
82869ac57 James Morse        2016-04-27   55   * Because this code has to be copied to a 'safe' page, it can't call out to
82869ac57 James Morse        2016-04-27   56   * other functions by PC-relative address. Also remember that it may be
82869ac57 James Morse        2016-04-27   57   * mid-way through over-writing other functions. For this reason it contains
82869ac57 James Morse        2016-04-27   58   * code from flush_icache_range() and uses the copy_page() macro.
82869ac57 James Morse        2016-04-27   59   *
82869ac57 James Morse        2016-04-27   60   * This 'safe' page is mapped via ttbr0, and executed from there. This function
82869ac57 James Morse        2016-04-27   61   * switches to a copy of the linear map in ttbr1, performs the restore, then
82869ac57 James Morse        2016-04-27   62   * switches ttbr1 to the original kernel's swapper_pg_dir.
82869ac57 James Morse        2016-04-27   63   *
82869ac57 James Morse        2016-04-27   64   * All of memory gets written to, including code. We need to clean the kernel
82869ac57 James Morse        2016-04-27   65   * text to the Point of Coherence (PoC) before secondary cores can be booted.
82869ac57 James Morse        2016-04-27   66   * Because the kernel modules and executable pages mapped to user space are
82869ac57 James Morse        2016-04-27   67   * also written as data, we clean all pages we touch to the Point of
82869ac57 James Morse        2016-04-27   68   * Unification (PoU).
82869ac57 James Morse        2016-04-27   69   *
82869ac57 James Morse        2016-04-27   70   * x0: physical address of temporary page tables
82869ac57 James Morse        2016-04-27   71   * x1: physical address of swapper page tables
82869ac57 James Morse        2016-04-27   72   * x2: address of cpu_resume
82869ac57 James Morse        2016-04-27   73   * x3: linear map address of restore_pblist in the current kernel
82869ac57 James Morse        2016-04-27   74   * x4: physical address of __hyp_stub_vectors, or 0
82869ac57 James Morse        2016-04-27   75   * x5: physical address of a  zero page that remains zero after resume
82869ac57 James Morse        2016-04-27   76   */
82869ac57 James Morse        2016-04-27   77  .pushsection    ".hibernate_exit.text", "ax"
82869ac57 James Morse        2016-04-27   78  ENTRY(swsusp_arch_suspend_exit)
82869ac57 James Morse        2016-04-27   79  	/*
82869ac57 James Morse        2016-04-27   80  	 * We execute from ttbr0, change ttbr1 to our copied linear map tables
82869ac57 James Morse        2016-04-27   81  	 * with a break-before-make via the zero page
82869ac57 James Morse        2016-04-27   82  	 */
529c4b05a Kristina Martsenko 2017-12-13   83  	break_before_make_ttbr_switch	x5, x0, x6
82869ac57 James Morse        2016-04-27   84  
82869ac57 James Morse        2016-04-27   85  	mov	x21, x1
82869ac57 James Morse        2016-04-27   86  	mov	x30, x2
82869ac57 James Morse        2016-04-27   87  	mov	x24, x4
82869ac57 James Morse        2016-04-27   88  	mov	x25, x5
82869ac57 James Morse        2016-04-27   89  
82869ac57 James Morse        2016-04-27   90  	/* walk the restore_pblist and use copy_page() to over-write memory */
82869ac57 James Morse        2016-04-27   91  	mov	x19, x3
82869ac57 James Morse        2016-04-27   92  
82869ac57 James Morse        2016-04-27   93  1:	ldr	x10, [x19, #HIBERN_PBE_ORIG]
82869ac57 James Morse        2016-04-27   94  	mov	x0, x10
82869ac57 James Morse        2016-04-27   95  	ldr	x1, [x19, #HIBERN_PBE_ADDR]
82869ac57 James Morse        2016-04-27   96  
82869ac57 James Morse        2016-04-27   97  	copy_page	x0, x1, x2, x3, x4, x5, x6, x7, x8, x9
82869ac57 James Morse        2016-04-27   98  
82869ac57 James Morse        2016-04-27   99  	add	x1, x10, #PAGE_SIZE
82869ac57 James Morse        2016-04-27  100  	/* Clean the copied page to PoU - based on flush_icache_range() */
072f0a633 Suzuki K Poulose   2016-09-09 @101  	raw_dcache_line_size x2, x3
82869ac57 James Morse        2016-04-27  102  	sub	x3, x2, #1
82869ac57 James Morse        2016-04-27  103  	bic	x4, x10, x3
82869ac57 James Morse        2016-04-27  104  2:	dc	cvau, x4	/* clean D line / unified line */
82869ac57 James Morse        2016-04-27  105  	add	x4, x4, x2
82869ac57 James Morse        2016-04-27  106  	cmp	x4, x1
82869ac57 James Morse        2016-04-27  107  	b.lo	2b
82869ac57 James Morse        2016-04-27  108  
82869ac57 James Morse        2016-04-27  109  	ldr	x19, [x19, #HIBERN_PBE_NEXT]
82869ac57 James Morse        2016-04-27  110  	cbnz	x19, 1b
82869ac57 James Morse        2016-04-27  111  	dsb	ish		/* wait for PoU cleaning to finish */
82869ac57 James Morse        2016-04-27  112  
82869ac57 James Morse        2016-04-27  113  	/* switch to the restored kernels page tables */
529c4b05a Kristina Martsenko 2017-12-13  114  	break_before_make_ttbr_switch	x25, x21, x6
82869ac57 James Morse        2016-04-27  115  
82869ac57 James Morse        2016-04-27  116  	ic	ialluis
82869ac57 James Morse        2016-04-27  117  	dsb	ish
82869ac57 James Morse        2016-04-27  118  	isb
82869ac57 James Morse        2016-04-27  119  
82869ac57 James Morse        2016-04-27  120  	cbz	x24, 3f		/* Do we need to re-initialise EL2? */
82869ac57 James Morse        2016-04-27  121  	hvc	#0
82869ac57 James Morse        2016-04-27  122  3:	ret
82869ac57 James Morse        2016-04-27  123  
82869ac57 James Morse        2016-04-27  124  	.ltorg
82869ac57 James Morse        2016-04-27  125  ENDPROC(swsusp_arch_suspend_exit)
82869ac57 James Morse        2016-04-27  126  

:::::: The code at line 101 was first introduced by commit
:::::: 072f0a633838aca13b5a8b211eb64f5c445cfd7c arm64: Introduce raw_{d,i}cache_line_size

:::::: TO: Suzuki K Poulose <suzuki.poulose@arm.com>
:::::: CC: Will Deacon <will.deacon@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 38167 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180220/f342e89f/attachment-0001.gz>
