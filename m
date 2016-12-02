From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri,  2 Dec 2016 15:50:57 +0000
Subject: [PATCH 0/2] arm64: PMU: Sanitize usage of PMSELR_EL0.SEL
Message-ID: <1480693859-27249-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An ugly interaction between the use of PMSELR_EL0 in a host kernel and
the use of PMXEVCNTR_EL0 in a guest has recently come to light [1],
leading to the guest taking an UNDEF exception in EL1 when using the
PMU.

The fix is pretty simple ("don't do that!"), making the PMU useable on
X-Gene, which seems to have a stricter (but nonetheless valid)
interpretation of the architecture.

Patches against 4.9-rc6.

[1] https://lists.cs.columbia.edu/pipermail/kvmarm/2016-November/022545.html

Marc Zyngier (2):
  arm64: PMU: Do not use PMSELR_EL0 to access PMCCFILTR_EL0
  arm64: PMU: Reset PMSELR_EL0 to a sane value at boot time

 arch/arm64/kernel/perf_event.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.1.4
