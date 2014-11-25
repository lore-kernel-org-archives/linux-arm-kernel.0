From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 25 Nov 2014 16:09:58 +0000
Subject: [PATCH 0/7] KVM Guest Debug support for arm64
Message-ID: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches implement support for debugging of KVM guests on
arm64 hardware. It supports SW and HW break points as well as
single-step functionality. I've created a branch of QEMU with the
userspace support to test this at:

https://github.com/stsquad/qemu/tree/kvm/guest-debug-kvm-submission

I've done some initial manual testing and everything seems fine but I
have yet to write my test suite. One area which has not yet been
tested is debug inside the guest while being debugged. The current
implementation effectively suspends the guests ability to use single
step and HW assisted debugging while KVM is debugging it. However the
door is open to userspace trying to accommodate this mode as the
guest's view of debugging registers is separate from actual values
when guest debugging is in operation.

The first 3 patches simply lay the groundwork for the later
functionality. Each patch then introduces each bit of functionality
except the re-factor patch which I split out from the HW assisted
debug patch to aid review.

In reference to the recent discussion about exposing the number of
debug registers to userspace I ended up using the KVM_EXTENSION ioctl
which helpfully allows to return of any positive number for success.
It seemed by far the simplest API to use from both the kernel and
userspace point of view.

The patches all pass checkpatch apart from the changes to
asm-offsets.c which complain about leading spaces and long lines. I
left them as is to fit in with the formatting of the rest of the file.

Alex Benn?e (7):
  KVM: add commentary for kvm_debug_exit_arch struct
  KVM: arm: guest debug, define API headers
  KVM: arm: guest debug, add stub KVM_SET_GUEST_DEBUG ioctl
  KVM: arm64: guest debug, add SW break point support
  KVM: arm64: guest debug, add support for single-step
  KVM: arm64: re-factor hyp.S debug register code
  KVM: arm64: guest debug, HW assisted debug support

 Documentation/virtual/kvm/api.txt      |  11 +-
 arch/arm/kvm/arm.c                     |  89 +++++++++-
 arch/arm64/include/asm/hw_breakpoint.h |  12 ++
 arch/arm64/include/asm/kvm_host.h      |   4 +-
 arch/arm64/include/uapi/asm/kvm.h      |  28 ++++
 arch/arm64/kernel/asm-offsets.c        |   6 +
 arch/arm64/kernel/hw_breakpoint.c      |  12 --
 arch/arm64/kvm/handle_exit.c           |  80 +++++++++
 arch/arm64/kvm/hyp.S                   | 292 ++++++++++++++-------------------
 arch/arm64/kvm/reset.c                 |   6 +
 include/uapi/linux/kvm.h               |  21 ++-
 11 files changed, 371 insertions(+), 190 deletions(-)

-- 
2.1.3
