From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 10 Jan 2013 16:06:43 +0000
Subject: [PATCH v2 0/2] KVM/ARM implementation of PSCI
Message-ID: <1357834005-23843-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an implementation of the Power State Coordination Interface,
as described there (registration required):
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.den0022a/index.html

It allows CPUs to be powered on, off, suspended or migrated. This
series is only concerned with power-{on,off}. KVM Tool uses it to boot
SMP VMs. This is also supported by the mach-virt platform:

git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git virt/mach

Tested on the arm64 model, based on kvm-arm-master as of today.

>From v1:
- Documentation
- Move the one-time init to a separate function
- "One mask fits all"
- Use wait_event_interruptible instead of the open coded version

Marc Zyngier (2):
  ARM: KVM: move one-time init to its own function
  ARM: KVM: Power State Coordination Interface implementation

 Documentation/virtual/kvm/api.txt  |  4 ++
 arch/arm/include/asm/kvm_emulate.h |  5 +++
 arch/arm/include/asm/kvm_host.h    |  5 ++-
 arch/arm/include/asm/kvm_psci.h    | 23 ++++++++++
 arch/arm/include/uapi/asm/kvm.h    | 16 +++++++
 arch/arm/kvm/Makefile              |  2 +-
 arch/arm/kvm/arm.c                 | 59 +++++++++++++++++--------
 arch/arm/kvm/psci.c                | 90 ++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h           |  1 +
 9 files changed, 184 insertions(+), 21 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_psci.h
 create mode 100644 arch/arm/kvm/psci.c

-- 
1.8.1
