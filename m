From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed, 25 Feb 2015 16:02:32 +0000
Subject: [PATCH 0/6] QEMU ARM64 Migration Fixes
Message-ID: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In conjunction with the kernel patch series I've just sent:

  http://thread.gmane.org/gmane.comp.emulators.kvm.arm.devel/101/focus=100

These patches have been fairly heavily tested on the xgene systems
I've got access to and I'm pretty confident we've caught all the
corner cases.

>From QEMU's point of view the fixes are fairly simple. We need to take
a little care when restoring the GIC that config that affects the
later restoration is restored first. The rest was simply missing
serialisation code for SPSR and FP registers.

The pl011 patch was mainly to reduce noise on re-asserting level
triggered interrupt lines. And the cpu.h documentation was for my own
sanity.

Cheers,

Alex.


Alex Benn?e (5):
  target-arm: kvm: save/restore mp state
  arm_gic_kvm.c: restore config before pending IRQs
  hw/char/pl011: don't keep setting the IRQ if nothing changed
  target-arm/kvm64.c: sync FP register state
  target-arm/cpu.h: document why env->spsr exists

Christoffer Dall (1):
  target-arm/kvm64: fix save/restore of SPSR regs

 hw/char/pl011.c       |  12 ++++--
 hw/intc/arm_gic_kvm.c |   7 +++-
 target-arm/cpu.h      |   5 +++
 target-arm/kvm.c      |   1 +
 target-arm/kvm64.c    | 104 +++++++++++++++++++++++++++++++++++++++++++++++---
 target-arm/machine.c  |  38 ++++++++++++++++++
 6 files changed, 156 insertions(+), 11 deletions(-)

-- 
2.3.0
