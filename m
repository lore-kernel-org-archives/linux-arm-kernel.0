From: lkp@intel.com (kbuild test robot)
Date: Tue, 18 Sep 2018 20:16:48 +0800
Subject: [arm-platforms:kvm-arm64/nv-wip 88/115]
 arch/arm64/kvm/sys_regs.c:1908:26: error: passing argument 1 of
 'vcpu_el2_e2h_is_set' from incompatible pointer type
Message-ID: <201809182046.6943Edly%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/nv-wip
head:   173677c6812ce2b5748dfec2f9814f30c2cf01ce
commit: 2a4367529d7b477d7cde07b0720fa0b56a4f0f5e [88/115] KVM: arm64: Emulate AT S1E[01] instructions
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 2a4367529d7b477d7cde07b0720fa0b56a4f0f5e
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm64 

Note: the arm-platforms/kvm-arm64/nv-wip HEAD 173677c6812ce2b5748dfec2f9814f30c2cf01ce builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   arch/arm64/kvm/sys_regs.c: In function 'handle_s1e01':
>> arch/arm64/kvm/sys_regs.c:1908:26: error: passing argument 1 of 'vcpu_el2_e2h_is_set' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu))
                             ^~~~
   In file included from arch/arm64/kvm/sys_regs.c:35:0:
   arch/arm64/include/asm/kvm_emulate.h:219:20: note: expected 'const struct kvm_cpu_context *' but argument is of type 'struct kvm_vcpu *'
    static inline bool vcpu_el2_e2h_is_set(const struct kvm_cpu_context *ctxt)
                       ^~~~~~~~~~~~~~~~~~~
>> arch/arm64/kvm/sys_regs.c:1909:9: error: 'struct kvm_cpu_context' has no member named 'hw_sys_regs'; did you mean 'sys_regs'?
      ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
            ^~~~~~~~~~~
            sys_regs
>> arch/arm64/kvm/sys_regs.c:1909:29: error: 'struct kvm_cpu_context' has no member named 'shadow_sys_regs'; did you mean 'sys_regs'?
      ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
                                ^~~~~~~~~~~~~~~
                                sys_regs
   arch/arm64/kvm/sys_regs.c:1911:9: error: 'struct kvm_cpu_context' has no member named 'hw_sys_regs'; did you mean 'sys_regs'?
      ctxt->hw_sys_regs = ctxt->sys_regs;
            ^~~~~~~~~~~
            sys_regs
   cc1: some warnings being treated as errors

vim +/vcpu_el2_e2h_is_set +1908 arch/arm64/kvm/sys_regs.c

  1899	
  1900	static bool handle_s1e01(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
  1901				 const struct sys_reg_desc *r)
  1902	{
  1903		struct kvm_cpu_context *ctxt = &vcpu->arch.ctxt;
  1904		bool el2_format;
  1905		int sys_encoding = sys_insn(p->Op0, p->Op1, p->CRn, p->CRm, p->Op2);
  1906	
  1907		/* See '2. EL0/EL1 AT instructions: S1E[01]x, S12E1x' table. */
> 1908		if (vcpu_el2_e2h_is_set(vcpu) && vcpu_el2_tge_is_set(vcpu))
> 1909			ctxt->hw_sys_regs = ctxt->shadow_sys_regs;
  1910		else
  1911			ctxt->hw_sys_regs = ctxt->sys_regs;
  1912	
  1913		el2_format = vcpu_el2_format_used(vcpu);
  1914	
  1915		kvm_call_hyp(__kvm_at_insn, vcpu, p->regval, el2_format, sys_encoding);
  1916	
  1917		return true;
  1918	}
  1919	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 40248 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180918/4b78d347/attachment-0001.gz>
