From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  4 Mar 2015 14:35:47 +0000
Subject: [PATCH v2 0/6] QEMU ARM64 Migration Fixes
Message-ID: <1425479753-18349-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update to the series I posted last week addressing some of
the comments so far.

The main changes to this series are:

v2

  - Save/Restore MP STATE
    - no longer needs CAP_MP_STATE at start
    - re-uses cpu->powered_off for storing state (no stream ABI change)
    - kvm_enabled() runtime check (although ioctl still in #if defined)
  - Save/Restore SPSR
    - use the correct bank_number for aarch32
    - only tweak SPSR for elevated exception levels
  - arm_giv_kvm
    - add Christoffer's Acked-by:

The only question up in the air at the moment is defining a new
constant for the MP_STATE to represent powered off which I'm going to
look at when I re-spin the kernel series.

Branch: https://github.com/stsquad/qemu/tree/migration/fixes-v3

Alex Benn?e (5):
  target-arm: kvm: save/restore mp state
  hw/intc: arm_gic_kvm.c restore config first
  hw/char: pl011 don't keep setting the IRQ if nothing changed
  target-arm: kvm64 sync FP register state
  target-arm: cpu.h document why env->spsr exists

Christoffer Dall (1):
  target-arm: kvm64 fix save/restore of SPSR regs

 hw/char/pl011.c       |  12 ++++--
 hw/intc/arm_gic_kvm.c |   7 +++-
 target-arm/cpu.h      |   5 +++
 target-arm/kvm64.c    | 109 +++++++++++++++++++++++++++++++++++++++++++++++---
 target-arm/machine.c  |  29 ++++++++++++++
 5 files changed, 151 insertions(+), 11 deletions(-)

-- 
2.3.1
