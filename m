From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 16 Aug 2016 18:43:16 +0800
Subject: [arm-platforms:kvm-arm64/vgic-v3-apr0 3/3]
 arch/arm64/kvm/hyp/vgic-v3-sr.c:228:26: error: 'struct kvm_vcpu_arch' has no
 member named 'v3_has_g0_interrupts'
Message-ID: <201608161807.DZ1yT6D6%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/vgic-v3-apr0
head:   26214414ebaa28da4f07a9af1a6b7d3a4835545e
commit: 26214414ebaa28da4f07a9af1a6b7d3a4835545e [3/3] arm64: KVM: vgic-v3: Don't save ICH_AP0Rn when no Group0 interrupts are injected
config: arm64-defconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 26214414ebaa28da4f07a9af1a6b7d3a4835545e
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kvm/hyp/vgic-v3-sr.c:18:0:
   arch/arm64/kvm/hyp/vgic-v3-sr.c: In function '__vgic_v3_save_state':
>> arch/arm64/kvm/hyp/vgic-v3-sr.c:228:26: error: 'struct kvm_vcpu_arch' has no member named 'v3_has_g0_interrupts'
      if (unlikely(vcpu->arch.v3_has_g0_interrupts))
                             ^
   include/linux/compiler.h:168:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   arch/arm64/kvm/hyp/vgic-v3-sr.c: In function '__vgic_v3_restore_state':
>> arch/arm64/kvm/hyp/vgic-v3-sr.c:288:19: error: 'struct vgic_v3_cpu_if' has no member named 'vgic_lrs'
        g0 |= !(cpu_if->vgic_lrs[i] & ICH_LR_GROUP);
                      ^
   arch/arm64/kvm/hyp/vgic-v3-sr.c:310:13: error: 'struct kvm_vcpu_arch' has no member named 'v3_has_g0_interrupts'
      vcpu->arch.v3_has_g0_interrupts = g0;
                ^

vim +228 arch/arm64/kvm/hyp/vgic-v3-sr.c

   222				else
   223					cpu_if->vgic_lr[i] = __gic_v3_get_lr(i);
   224	
   225				__gic_v3_set_lr(0, i);
   226			}
   227	
 > 228			if (unlikely(vcpu->arch.v3_has_g0_interrupts))
   229				read_aprs(cpu_if->vgic_ap0r, 0, nr_pri_bits);
   230	
   231			read_aprs(cpu_if->vgic_ap1r, 1, nr_pri_bits);
   232	
   233			vcpu->arch.vgic_cpu.live_lrs = 0;
   234		} else {
   235			cpu_if->vgic_misr  = 0;
   236			cpu_if->vgic_eisr  = 0;
   237			cpu_if->vgic_elrsr = 0xffff;
   238			cpu_if->vgic_ap0r[0] = 0;
   239			cpu_if->vgic_ap0r[1] = 0;
   240			cpu_if->vgic_ap0r[2] = 0;
   241			cpu_if->vgic_ap0r[3] = 0;
   242			cpu_if->vgic_ap1r[0] = 0;
   243			cpu_if->vgic_ap1r[1] = 0;
   244			cpu_if->vgic_ap1r[2] = 0;
   245			cpu_if->vgic_ap1r[3] = 0;
   246		}
   247	
   248		val = read_gicreg(ICC_SRE_EL2);
   249		write_gicreg(val | ICC_SRE_EL2_ENABLE, ICC_SRE_EL2);
   250	
   251		if (!cpu_if->vgic_sre) {
   252			/* Make sure ENABLE is set at EL2 before setting SRE at EL1 */
   253			isb();
   254			write_gicreg(1, ICC_SRE_EL1);
   255		}
   256	}
   257	
   258	void __hyp_text __vgic_v3_restore_state(struct kvm_vcpu *vcpu)
   259	{
   260		struct vgic_v3_cpu_if *cpu_if = &vcpu->arch.vgic_cpu.vgic_v3;
   261		u64 val;
   262		u32 max_lr_idx, nr_pri_bits;
   263		u16 live_lrs = 0;
   264		bool g0 = false;
   265		int i;
   266	
   267		/*
   268		 * VFIQEn is RES1 if ICC_SRE_EL1.SRE is 1. This causes a
   269		 * Group0 interrupt (as generated in GICv2 mode) to be
   270		 * delivered as a FIQ to the guest, with potentially fatal
   271		 * consequences. So we must make sure that ICC_SRE_EL1 has
   272		 * been actually programmed with the value we want before
   273		 * starting to mess with the rest of the GIC.
   274		 */
   275		if (!cpu_if->vgic_sre) {
   276			write_gicreg(0, ICC_SRE_EL1);
   277			isb();
   278		}
   279	
   280		val = read_gicreg(ICH_VTR_EL2);
   281		max_lr_idx = vtr_to_max_lr_idx(val);
   282		nr_pri_bits = vtr_to_nr_pri_bits(val);
   283	
   284		for (i = 0; i <= max_lr_idx; i++) {
   285			if (cpu_if->vgic_lr[i] & ICH_LR_STATE) {
   286				live_lrs |= (1 << i);
   287				if (cpu_if->vgic_sre)
 > 288					g0 |= !(cpu_if->vgic_lrs[i] & ICH_LR_GROUP);
   289			}
   290		}
   291	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30700 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160816/b7a5efde/attachment-0001.obj>
