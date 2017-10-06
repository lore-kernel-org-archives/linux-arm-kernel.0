From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri,  6 Oct 2017 12:39:19 +0100
Subject: [PATCH v1 0/2] KVM: arm64: single step emulation instructions
Message-ID: <20171006113921.24880-1-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julian,

Here are the proposed patches for KVM support. Feel free to merge them
together if you want.

There are two minor wrinkles.

The first is we fake the HSR_EC value to keep QEMU happy. I don't
think this is a major problem because we aren't dealing with a guest
register but the mechanism for the guest debug to know what happened.
In this case we still single-stepped even if an exception wasn't
actually involved.

The second is we have to slightly munge the handling of return
kvm_handle_mmio_return to properly exit the loop on error or 0.

Alex Benn?e (2):
  KVM: arm64: handle single-stepping trapped instructions
  kvm: arm64: handle single-step of userspace mmio instructions

 arch/arm/include/asm/kvm_host.h   |  2 ++
 arch/arm64/include/asm/kvm_host.h |  1 +
 arch/arm64/kvm/debug.c            | 21 ++++++++++++++++++
 arch/arm64/kvm/handle_exit.c      | 45 +++++++++++++++++++++++++++------------
 virt/kvm/arm/arm.c                |  2 +-
 virt/kvm/arm/mmio.c               |  3 ++-
 6 files changed, 58 insertions(+), 16 deletions(-)

-- 
2.14.1
