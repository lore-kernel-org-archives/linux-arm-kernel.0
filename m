From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 12 Jun 2014 09:29:59 -0700
Subject: [PATCH v4 00/14] ARM/ARM64: KVM: big endian host support
Message-ID: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer, Marc,

Could you please look at updated ARM BE KVM series. We worked
separately on specific patches, I believe now they should look
OK.

Changes since previous V3 version of series [1]:

o Updated Review-by Acked-by tags where appropriate

o 'ARM: KVM: __kvm_vcpu_run function return result fix in BE case'
patch changed __ARMEB__ to CONFIG_CPU_ENDIAN_BE8 as Marc suggested

o 'ARM: KVM: one_reg coproc set and get BE fixes' patch was 
siginificantly reworked based on separate thread discussion with
Christoffer - In short summry now we fix only oddball places where
reg_[from|to]_user function is used in case target variable 
mismatching register size

o 'ARM64: KVM: fix vgic_bitmap_get_reg function for BE 64bit case'
incorporated Christoffer's review comments about code comments
(spelling, grammar, etc)

o 'ARM64: KVM: set and get of sys registers in BE case' changed
patch siginificantly based on separate email thread feedback from
Christoffer and Marc - now patch just removes comment about
reg_[to|form]_user being little endian, since it handles only
64 bit register size current code is endian agnostic.

o 'ARM64: KVM: fix big endian issue in access_vm_reg for 32bit guest'
incorporoated Christoffer's review comments - two macros 
vcpu_cp15_64_high and vcpu_cp15_64_low now introduced which
defined differently between BE and LE cases

Series were tested on top of v3.15. On V7 4 combinations, BE/LE 
host x BE/LE guest, were tested with TC2. On V8 8 combinations,
BE/LE host x BE/LE guest x 32/64 bit guest, were tested on
Fast models.

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-May/255849.html

Victor Kamensky (14):
  ARM: KVM: switch hypervisor into BE mode in case of BE host
  ARM: KVM: fix vgic V7 assembler code to work in BE image
  ARM: KVM: handle 64bit values passed to mrcc or from mcrr instructions
    in BE case
  ARM: KVM: __kvm_vcpu_run function return result fix in BE case
  ARM: KVM: vgic mmio should hold data as LE bytes array in BE case
  ARM: KVM: MMIO support BE host running LE code
  ARM: KVM: one_reg coproc set and get BE fixes
  ARM: KVM: enable KVM in Kconfig on big-endian systems
  ARM64: KVM: MMIO support BE host running LE code
  ARM64: KVM: store kvm_vcpu_fault_info est_el2 as word
  ARM64: KVM: fix vgic_bitmap_get_reg function for BE 64bit case
  ARM64: KVM: vgic_elrsr and vgic_eisr need to be byteswapped in BE case
  ARM64: KVM: set and get of sys registers in BE case
  ARM64: KVM: fix big endian issue in access_vm_reg for 32bit guest

 arch/arm/include/asm/kvm_asm.h       | 18 ++++++++
 arch/arm/include/asm/kvm_emulate.h   | 22 ++++++++--
 arch/arm/kvm/Kconfig                 |  2 +-
 arch/arm/kvm/coproc.c                | 84 ++++++++++++++++++++++++++++++++----
 arch/arm/kvm/init.S                  |  7 ++-
 arch/arm/kvm/interrupts.S            |  9 +++-
 arch/arm/kvm/interrupts_head.S       | 20 +++++++--
 arch/arm64/include/asm/kvm_emulate.h | 22 ++++++++++
 arch/arm64/include/asm/kvm_host.h    |  8 ++++
 arch/arm64/kvm/hyp.S                 |  9 +++-
 arch/arm64/kvm/sys_regs.c            | 10 ++---
 virt/kvm/arm/vgic.c                  | 28 ++++++++++--
 12 files changed, 207 insertions(+), 32 deletions(-)

-- 
1.8.1.4
