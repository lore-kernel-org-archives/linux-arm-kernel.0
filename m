From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Tue, 17 Oct 2017 22:14:45 +0800
Subject: [PATCH v7 0/4] Add RAS virtualization support
Message-ID: <1508249689-10350-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the firmware-first RAS solution, corrupt data is detected in a
memory location when guest OS application software executing at EL0
or guest OS kernel El1 software are reading from the memory. The
memory node records errors into an accessible system registers.

Because SCR_EL3.EA is 1, then CPU will trap to El3 firmware, EL3
firmware records the error to APEI table through reading system
register.

Because the error was taken from a lower Exception level, if the
exception is SEA/SEI and HCR_EL2.TEA/HCR_EL2.AMO is 1, firmware
sets ESR_EL2/FAR_EL2 to fake a exception trap to EL2, then
transfers to hypervisor.

For the synchronous external abort(SEA), Hypervisor calls the
handle_guest_sea() to deal with this error, which will reads 
the APEI table to get the error physical address, then call
memory_failure() to identify the this address to poisoned and
deliver SIGBUS signal to userspace. The advantage of using SIGBUS
signal to notify user space is that it can be compatible with
Non-Kvm users.

For the SError Interrupt(SEI), KVM firstly classified the error.
If the SError error comes from guest and is not propagated, then call
handle_guest_sei() to let host firstly handle it. If the address recorded
by APEI table is valid, then deliver SIGBUS signal to user space,
user space will record the address to guest APEI table. Otherwise, directly 
injects virtual SError, or panic if the error is fatal. Sometime the error
address recorded by APEI may be invalid(not accurate), and SIGBUS is not
delivered to userspace. For this case, to make sure notify guest, userspace
still inject virtual SError with specify syndrome to guest. The specify syndrome
will be set to the VSESR_EL2. VSESR_EL2 is a new ARMv8.2 RAS extensions register
which provides the syndrome value reported to software on taking a virtual
SError interrupt exception. By default specify this syndrome value 
to IMPLEMENTATION DEFINED, because all-zero  means 'RAS error: Uncategorized'
instead of 'no valid ISS'.


Dongjiu Geng (4):
  arm64: kvm: route synchronous external abort exceptions to EL2
  arm64: kvm: Introduce KVM_ARM_SET_SERROR_ESR ioctl
  arm64: kvm: Set Virtual SError Exception Syndrome for guest
  arm64: kvm: handle SEI notification for guest

 Documentation/virtual/kvm/api.txt    | 11 +++++++
 arch/arm/include/asm/kvm_host.h      |  1 +
 arch/arm/kvm/guest.c                 |  9 ++++++
 arch/arm64/include/asm/esr.h         | 10 ++++++
 arch/arm64/include/asm/kvm_arm.h     |  2 ++
 arch/arm64/include/asm/kvm_asm.h     |  1 +
 arch/arm64/include/asm/kvm_emulate.h | 17 ++++++++++
 arch/arm64/include/asm/kvm_host.h    | 11 +++++++
 arch/arm64/include/asm/sysreg.h      | 13 ++++++++
 arch/arm64/include/asm/system_misc.h |  2 +-
 arch/arm64/kvm/guest.c               | 14 +++++++++
 arch/arm64/kvm/handle_exit.c         | 61 +++++++++++++++++++++++++++++++++---
 arch/arm64/kvm/hyp/switch.c          | 15 +++++++++
 arch/arm64/kvm/inject_fault.c        | 13 +++++++-
 arch/arm64/kvm/reset.c               |  3 ++
 arch/arm64/kvm/sys_regs.c            | 40 +++++++++++++++++++++++
 arch/arm64/mm/fault.c                | 16 ++++++++++
 include/uapi/linux/kvm.h             |  3 ++
 virt/kvm/arm/arm.c                   |  7 +++++
 19 files changed, 243 insertions(+), 6 deletions(-)

-- 
2.10.1
