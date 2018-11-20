From: pasha.tatashin@soleen.com (Pavel Tatashin)
Date: Tue, 20 Nov 2018 09:43:39 -0500
Subject: [PATCH v2 0/1] Early boot time stamps for arm64
Message-ID: <20181120144340.30201-1-pasha.tatashin@soleen.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:

v1 - v2
	Addressed comments from Marc Zyngier

I made early boot time stamps available for SPARC and X86.

x86:
https://lore.kernel.org/lkml/20180719205545.16512-1-pasha.tatashin at oracle.com

sparc:
https://www.spinics.net/lists/sparclinux/msg18063.html

As discussed at plumbers, I would like to add the same for arm64. The
implementation does not have to be perfect, and should work only when early
clock is easy to determine. arm64 defines a clock register, and thus makes
it easy, but on some platforms frequency register is broken, so if it is
not known, simply don't initialize clock early.

dmesg before:
https://paste.ubuntu.com/p/3pJ5kgJHyN

dmesg after:
https://paste.ubuntu.com/p/RHKGVd9nSM

As seen from the above with base smp_init is finished after 0.47s:
[    0.464585] SMP: Total of 8 processors activated.

But, in reality, 3.2s is missing which is a quiet long considering this is
only 60G domain.

Pavel Tatashin (1):
  arm64: Early boot time stamps

 arch/arm64/kernel/setup.c            | 25 +++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |  8 ++++----
 include/clocksource/arm_arch_timer.h |  3 +++
 3 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.19.1
