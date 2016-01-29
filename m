From: fengguang.wu@intel.com (kbuild test robot)
Date: Sat, 30 Jan 2016 05:50:39 +0800
Subject: [arm-platforms:kvm-arm64/cm 32/33]
 arch/arm/include/asm/kvm_emulate.h:143:12: warning: passing argument 1 of
 'kvm_vcpu_get_hsr' discards 'const' qualifier from pointer target type
Message-ID: <201601300537.WmSq8zAH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/cm
head:   70921d5e6dc76d6a99550578aad5c058297379b2
commit: 9ef2321d71367574320c68dcd9ad827eae7b05e3 [32/33] arm/arm64: KVM: Handle out-of-RAM cache maintenance as a NOP
config: arm-axm55xx_defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 9ef2321d71367574320c68dcd9ad827eae7b05e3
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   In file included from arch/arm/kvm/arm.c:44:0:
   arch/arm/include/asm/kvm_emulate.h: In function 'kvm_vcpu_dabt_iscm':
>> arch/arm/include/asm/kvm_emulate.h:143:12: warning: passing argument 1 of 'kvm_vcpu_get_hsr' discards 'const' qualifier from pointer target type
     return !!(kvm_vcpu_get_hsr(vcpu) & HSR_DABT_CM);
               ^
   arch/arm/include/asm/kvm_emulate.h:96:19: note: expected 'struct kvm_vcpu *' but argument is of type 'const struct kvm_vcpu *'
    static inline u32 kvm_vcpu_get_hsr(struct kvm_vcpu *vcpu)
                      ^

vim +143 arch/arm/include/asm/kvm_emulate.h

   127	{
   128		return (kvm_vcpu_get_hsr(vcpu) & HSR_SRT_MASK) >> HSR_SRT_SHIFT;
   129	}
   130	
   131	static inline bool kvm_vcpu_dabt_isextabt(struct kvm_vcpu *vcpu)
   132	{
   133		return kvm_vcpu_get_hsr(vcpu) & HSR_DABT_EA;
   134	}
   135	
   136	static inline bool kvm_vcpu_dabt_iss1tw(struct kvm_vcpu *vcpu)
   137	{
   138		return kvm_vcpu_get_hsr(vcpu) & HSR_DABT_S1PTW;
   139	}
   140	
   141	static inline bool kvm_vcpu_dabt_iscm(const struct kvm_vcpu *vcpu)
   142	{
 > 143		return !!(kvm_vcpu_get_hsr(vcpu) & HSR_DABT_CM);
   144	}
   145	
   146	/* Get Access Size from a data abort */
   147	static inline int kvm_vcpu_dabt_get_as(struct kvm_vcpu *vcpu)
   148	{
   149		switch ((kvm_vcpu_get_hsr(vcpu) >> 22) & 0x3) {
   150		case 0:
   151			return 1;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 18683 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160130/8499eeb9/attachment-0001.obj>
