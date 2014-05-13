From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 13 May 2014 09:13:52 -0700
Subject: [PATCH v3 00/14] ARM/ARM64: KVM: big endian host support
Message-ID: <1399997646-4716-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is updated patches to address KVM host support in big endian
ARM V7/V8.

Changes since previous version [1] and [2]:

x) joined both v7 [1] and v8 [2] series into one

x) addressed, nearly all, Christoffer's comments to previous
patch series

x) Fixed few issues in 'ARM: KVM: handle 64bit values passed to
mrcc or from mcrr instructions in BE case' that got discovered
after moving to the latest v3.15-rc5 kernel

x) Fixed issue in supporting 32bit guest by V8 BE KVM host

All patches except 'ARM: KVM: one_reg coproc set and
get BE fixes', as far as I see, are best possible proposal.
'ARM: KVM: one_reg coproc set and get BE fixes' changes still
need more discussion. Patch included with this series covers
one possible solution, I'll post notes about other approach
previously suggested by Alex Graf separately.

The patches were tested on top of v3.15-rc5 on TC2 (V7) and 
fastmodels (V8). Tested all possible combinations of KVM host
and guests (V7/V8, BE/LE, 64bit/32bit).

Thanks,
Victor

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231881.html

[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-February/231889.html

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

 arch/arm/include/asm/kvm_asm.h       |  18 ++++++
 arch/arm/include/asm/kvm_emulate.h   |  22 +++++--
 arch/arm/kvm/Kconfig                 |   2 +-
 arch/arm/kvm/coproc.c                | 118 +++++++++++++++++++++++++++--------
 arch/arm/kvm/init.S                  |   7 ++-
 arch/arm/kvm/interrupts.S            |   9 ++-
 arch/arm/kvm/interrupts_head.S       |  20 +++++-
 arch/arm64/include/asm/kvm_emulate.h |  22 +++++++
 arch/arm64/kvm/hyp.S                 |   9 ++-
 arch/arm64/kvm/sys_regs.c            |  33 +++++++---
 virt/kvm/arm/vgic.c                  |  28 +++++++--
 11 files changed, 237 insertions(+), 51 deletions(-)

-- 
1.8.1.4
