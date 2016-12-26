From: jintack@cs.columbia.edu (Jintack Lim)
Date: Mon, 26 Dec 2016 12:11:58 -0500
Subject: [RFC 0/8] Provide the EL1 physical timer to the VM
Message-ID: <1482772326-29110-1-git-send-email-jintack@cs.columbia.edu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architecture defines the EL1 physical timer and the virtual
timer, and it is reasonable for an OS to expect to be able to access
both.  However, the current KVM implementation does not provide the EL1
physical timer to VMs but terminates VMs on access to the timer.

On VHE systems, this would be as simple as allowing full access to the
EL1 physical timer to VMs because the KVM host does not use the EL1
physical timer.  However, on non-VHE systems, the KVM host already uses
the EL1 physical timer which prevents us from granting full access of
the EL1 physical timer to VMs.

This patchset enables VMs to use the EL1 physical timer through
trap-and-emulate.  The KVM host emulates each EL1 physical timer
register access and sets up the background timer accordingly.  When the
background timer expires, the KVM host injects EL1 physical timer
interrupts to the VM.  Alternatively, it's also possible to allow VMs to
access the EL1 physical timer without trapping.  However, this requires
somehow using the EL2 physical timer for the Linux host while running
the VM instead of the EL1 physical timer.  Right now I just implemented
trap-and-emulate because this was straightforward to do, and I leave it
to future work to determine if transferring the EL1 physical timer state
to the EL2 timer provides any performance benefit.

This feature will be useful for any OS that wishes to access the EL1
physical timer. Nested virtualization is one of those use cases. A
nested hypervisor running inside a VM would think it has full access to
the hardware and naturally tries to use the EL1 physical timer as Linux
would do. Other nested hypervisors may try to use the EL2 physical timer
as Xen would do, but supporting the EL2 physical timer to the VM is out
of scope of this patchset. This patchset will make it easy to add the
EL2 timer support in the future, though.

Note, Linux VMs booting in EL1 will be unaffected by this patch set and
will continue to use only the virtual timer and this patch set will
therefore not introduce any performance degredation as a result of
trap-and-emulate.

Jintack Lim (8):
  KVM: arm/arm64: Abstract virtual timer context into separate structure
  KVM: arm/arm64: Decouple kvm timer functions from virtual timer
  KVM: arm/arm64: Add the EL1 physical timer context
  KVM: arm/arm64: Initialize the emulated EL1 physical timer
  KVM: arm64: Add the EL1 physical timer access handler
  KVM: arm/arm64: Update the physical timer interrupt level
  KVM: arm/arm64: Set up a background timer for the physical timer
    emulation
  KVM: arm/arm64: Emulate the EL1 phys timer register access

 arch/arm/kvm/arm.c           |   3 +-
 arch/arm/kvm/reset.c         |   9 +-
 arch/arm64/kvm/reset.c       |   9 +-
 arch/arm64/kvm/sys_regs.c    |  63 +++++++++++++
 include/kvm/arm_arch_timer.h |  43 +++++----
 virt/kvm/arm/arch_timer.c    | 214 ++++++++++++++++++++++++++++++-------------
 virt/kvm/arm/hyp/timer-sr.c  |  16 ++--
 7 files changed, 264 insertions(+), 93 deletions(-)

-- 
1.9.1
