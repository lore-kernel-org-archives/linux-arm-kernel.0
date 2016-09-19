From: agraf@suse.de (Alexander Graf)
Date: Mon, 19 Sep 2016 13:14:53 +0200
Subject: [PATCH v4 0/2] KVM: ARM: Enable vtimers with user space gic
Message-ID: <1474283695-212421-1-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some systems out there (well, one type in particular - the Raspberry Pi series)
do have virtualization capabilities in the core, but no ARM GIC interrupt
controller.

To run on these systems, the cleanest route is to just handle all
interrupt delivery in user space and only deal with IRQ pins in the core
side in KVM.

This works pretty well already, but breaks when the guest starts to use
architected timers, as these are handled straight inside kernel space today.

This patch set allows user space to receive vtimer events as well as mask
them, so that we can handle all vtimer related interrupt injection from user
space, enabling us to use architected timer with user space gic emulation.

I have successfully run edk2 as well as Linux using these patches on a
Raspberry Pi 3 system with acceptable speed.

A branch with WIP QEMU code can be found here:

  https://github.com/agraf/qemu.git no-kvm-irqchip

To use the user space irqchip, just run it with

  $ qemu-system-aarch64 -M virt ...

if you're on a non-vgic host system. Or -M virt,kernel-irqchip=off if your
host system has vgic support.

v1 -> v2:

  - Add back curly brace that got lost

v2 -> v3:

  - Fix "only only" in documentation
  - Split patches
  - Remove kvm_emulate.h include

v3 -> v4:

  - Improve documentation

Alexander Graf (2):
  KVM: arm/arm64: Add vcpu ENABLE_CAP functionality
  KVM: arm/arm64: Route vtimer events to user space

 Documentation/virtual/kvm/api.txt |  34 ++++++++++-
 arch/arm/include/asm/kvm_host.h   |   3 +
 arch/arm/kvm/arm.c                |  47 +++++++++++---
 arch/arm64/include/asm/kvm_host.h |   3 +
 include/uapi/linux/kvm.h          |  14 +++++
 virt/kvm/arm/arch_timer.c         | 125 +++++++++++++++++++++++++++-----------
 6 files changed, 183 insertions(+), 43 deletions(-)

-- 
1.8.5.6
