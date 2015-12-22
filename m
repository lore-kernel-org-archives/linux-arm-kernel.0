From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Dec 2015 09:55:16 +0000
Subject: [PATCH 0/2] Fix PC corruption when injecting a fault
Message-ID: <1450778118-12715-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When injecting a fault as the result of a system register trap, we
change the PC to point to the fault handler. This clashes with the
code that increments the PC to skip over the emulated system register
access, leading to a situation where we skip the first instruction of
the fault handler.

The good news is that so far, we never do this, so I believe the
current code is safe. But the PMU code is soon going to exercise that
path, and I'd rather plug it sooner that later.

Thanks,

	M.

Marc Zyngier (2):
  arm: KVM: Do not update PC if the trap handler has updated it
  arm64: KVM: Do not update PC if the trap handler has updated it

 arch/arm/kvm/coproc.c     | 14 +++++++--
 arch/arm64/kvm/sys_regs.c | 73 +++++++++++++++++++++++------------------------
 2 files changed, 48 insertions(+), 39 deletions(-)

-- 
2.1.4
