From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 28 Apr 2017 12:01:04 +0100
Subject: [PATCHv3 0/2] arm64: fix hotplug rwsem boot fallout
Message-ID: <1493377266-2205-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These patches fix a boot issue seen on some arm64 platforms as a result of the
hotplug rwsem rework.

Thomas, would you be able to take these into the tip smp/hotplug branch?

Will has acked the arm64 part, and is happy for this to go via tip [1].

I've tested this atop of the tip smp/hotplug branch, and with the arm64
for-next/core branch merged in, which git handles automatically. In both cases,
it builds cleanly and boots fine on Juno R1.

Thanks,
Mark.

Since v1 [2]:
* Fix update_cpu_capabilities() by splitting boot/secondary

Since v2 [3]:
* Align on _cpuslocked naming
* Avoid duplicating workaround string
* Add Will's Acked-by

[1] https://lkml.kernel.org/r/20170427180104.GO1890 at arm.
[2] https://lkml.kernel.org/r/20170427154806.GA6646 at leverpostej
[3] https://lkml.kernel.org/r/1493315077-19496-3-git-send-email-mark.rutland at arm.com

Mark Rutland (1):
  arm64: cpufeature: use static_branch_enable_cpuslocked()

Sebastian Andrzej Siewior (1):
  jump_label: Provide static_key_[enable|/slow_inc]_cpuslocked()

 arch/arm64/include/asm/cpufeature.h |  3 ++-
 arch/arm64/kernel/cpu_errata.c      |  9 ++++++++-
 arch/arm64/kernel/cpufeature.c      |  5 ++++-
 include/linux/jump_label.h          |  7 +++++++
 kernel/jump_label.c                 | 10 ++++++++++
 5 files changed, 31 insertions(+), 3 deletions(-)

-- 
1.9.1
