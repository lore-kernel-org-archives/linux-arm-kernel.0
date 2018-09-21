From: lkp@intel.com (kbuild test robot)
Date: Fri, 21 Sep 2018 22:47:42 +0800
Subject: [kvmarm:kvm-arm64/nv-wip 2/5]
 arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:84:7: error: implicit
 declaration of function 'is_hyp_ctxt'; did you mean '__hyp_text'?
Message-ID: <201809212238.0QYAZ1zq%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git kvm-arm64/nv-wip
head:   03b558f083eda25ac9bd2e7af7d751ba34a2124a
commit: e6b4cd37fbd22bd9f9964141628fe5db75fb6a8d [2/5] KVM: arm/arm64: timer: Support hyp timer emulation for nested virt
config: arm-axm55xx_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout e6b4cd37fbd22bd9f9964141628fe5db75fb6a8d
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c: In function 'get_timer_map':
>> arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c:84:7: error: implicit declaration of function 'is_hyp_ctxt'; did you mean '__hyp_text'? [-Werror=implicit-function-declaration]
      if (is_hyp_ctxt(vcpu)) {
          ^~~~~~~~~~~
          __hyp_text
   cc1: some warnings being treated as errors

vim +84 arch/arm/kvm/../../../virt/kvm/arm/arch_timer.c

    80	
    81	static void get_timer_map(struct kvm_vcpu *vcpu, struct timer_map *map)
    82	{
    83		if (nested_virt_in_use(vcpu)) {
  > 84			if (is_hyp_ctxt(vcpu)) {
    85				map->direct_vtimer = vcpu_hvtimer(vcpu);
    86				map->direct_ptimer = vcpu_hptimer(vcpu);
    87				map->emul_vtimer = vcpu_vtimer(vcpu);
    88				map->emul_ptimer = vcpu_ptimer(vcpu);
    89			} else {
    90				map->direct_vtimer = vcpu_vtimer(vcpu);
    91				map->direct_ptimer = vcpu_ptimer(vcpu);
    92				map->emul_vtimer = vcpu_hvtimer(vcpu);
    93				map->emul_ptimer = vcpu_hptimer(vcpu);
    94			}
    95		}
    96	
    97		if (has_vhe()) {
    98			map->direct_vtimer = vcpu_vtimer(vcpu);
    99			map->direct_ptimer = vcpu_ptimer(vcpu);
   100			map->emul_vtimer = NULL;
   101			map->emul_ptimer = NULL;
   102		} else {
   103			map->direct_vtimer = vcpu_vtimer(vcpu);
   104			map->direct_ptimer = NULL;
   105			map->emul_vtimer = NULL;
   106			map->emul_ptimer = vcpu_ptimer(vcpu);
   107		}
   108	}
   109	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 20259 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180921/feb22874/attachment-0001.gz>
