From: mark.rutland@arm.com (Mark Rutland)
Date: Fri,  5 Sep 2014 12:22:17 +0100
Subject: [PATCH 0/2] PSCI: don't call CPU_OFF when it might fail
Message-ID: <1409916139-20127-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Apologies to all who received this already, I typo'd the LAKML address]

In certain conditions PSCI's CPU_OFF call may return DENIED (in the presence of
a UP OS on the secure world), or might not exist (in early implementations
prior to PSCI 0.2). Both the arm and arm64 callers fail to handle the former,
and the arm caller doesn't handle the latter.

We can determine wether a CPU_OFF call will succeed by calling
MIGRATE_INFO_TYPE. If we receive 2 (A.K.A. PSCI_0_2_TOS_MP) in response we know
that CPU_OFF should succeed, and in other cases it is necessary to discover
which CPU said OS lives on and attempt migration. As there don't seem to be any
UP implementations out there so far, for now we can limit ourselves to only
supporting CPU hotplug in the PSCI_0_2_TOS_MP case. Hotplug support on such
systems will require additional work, but at least they won't blow up by
default.

These patches add the necessary checks to the arm and arm64 PSCI callers to
prevent the issues described above. MIGRATE_INFO_TYPE is a mandatory part of
PSCI 0.2, so no conforming implementation should be adversely affected. Both
the ARM Trusted Firmware and KVM respond to MIGRATE_INFO_TYPE with
PSCI_0_2_TOS_MP, so should see no loss of functionality (verified on Juno). 

Thanks,
Mark.

Mark Rutland (2):
  arm64: psci: respect MIGRATE_INFO_TYPE
  arm: psci: don't call CPU_OFF blindly

 arch/arm/kernel/psci_smp.c | 36 +++++++++++++++++++++++++++++-------
 arch/arm64/kernel/psci.c   | 14 ++++++++++++++
 2 files changed, 43 insertions(+), 7 deletions(-)

-- 
1.9.1
