From: lkp@intel.com (kbuild test robot)
Date: Sun, 5 Nov 2017 02:49:27 +0800
Subject: [PATCH v1 3/3] KVM: arm64: add ESB in exception handler entry
 and exit.
In-Reply-To: <1509563697-6359-4-git-send-email-gengdongjiu@huawei.com>
References: <1509563697-6359-4-git-send-email-gengdongjiu@huawei.com>
Message-ID: <201711050220.e6qabuar%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on v4.14-rc7 next-20171103]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Dongjiu-Geng/arm64-add-a-macro-for-SError-synchronization/20171104-224216
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   arch/arm64/kvm/hyp/entry.S: Assembler messages:
>> arch/arm64/kvm/hyp/entry.S:88: Error: selected processor does not support `esb'
--
   arch/arm64/kvm/hyp/hyp-entry.S: Assembler messages:
>> arch/arm64/kvm/hyp/hyp-entry.S:57: Error: selected processor does not support `esb'

vim +88 arch/arm64/kvm/hyp/entry.S

    51	
    52	/*
    53	 * u64 __guest_enter(struct kvm_vcpu *vcpu,
    54	 *		     struct kvm_cpu_context *host_ctxt);
    55	 */
    56	ENTRY(__guest_enter)
    57		// x0: vcpu
    58		// x1: host context
    59		// x2-x17: clobbered by macros
    60		// x18: guest context
    61	
    62		// Store the host regs
    63		save_callee_saved_regs x1
    64	
    65		// Store the host_ctxt for use at exit time
    66		str	x1, [sp, #-16]!
    67	
    68		add	x18, x0, #VCPU_CONTEXT
    69	
    70		// Restore guest regs x0-x17
    71		ldp	x0, x1,   [x18, #CPU_XREG_OFFSET(0)]
    72		ldp	x2, x3,   [x18, #CPU_XREG_OFFSET(2)]
    73		ldp	x4, x5,   [x18, #CPU_XREG_OFFSET(4)]
    74		ldp	x6, x7,   [x18, #CPU_XREG_OFFSET(6)]
    75		ldp	x8, x9,   [x18, #CPU_XREG_OFFSET(8)]
    76		ldp	x10, x11, [x18, #CPU_XREG_OFFSET(10)]
    77		ldp	x12, x13, [x18, #CPU_XREG_OFFSET(12)]
    78		ldp	x14, x15, [x18, #CPU_XREG_OFFSET(14)]
    79		ldp	x16, x17, [x18, #CPU_XREG_OFFSET(16)]
    80	
    81		// Restore guest regs x19-x29, lr
    82		restore_callee_saved_regs x18
    83	
    84		// Restore guest reg x18
    85		ldr	x18,      [x18, #CPU_XREG_OFFSET(18)]
    86	
    87		// synchronize host pending asynchronous error
  > 88		error_synchronize
    89		// Do not touch any register after this!
    90		eret
    91	ENDPROC(__guest_enter)
    92	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57567 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171105/387d324b/attachment-0001.gz>
