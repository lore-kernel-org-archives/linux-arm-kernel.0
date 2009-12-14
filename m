From: jamie.iles@picochip.com (Jamie Iles)
Date: Mon, 14 Dec 2009 14:04:36 +0000
Subject: ARMv6 performance counters v2
Message-ID: <1260799481-29951-1-git-send-email-jamie.iles@picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series implements performance counter support for ARMv6
architectures. The changes since the previous patch series are:
        - the pmu interface (arch/arm/include/asm/pmu.h) to return the
        interrupts for the PMU so that PMU interrupts are stored in a common
        place (arch/arm/kernel/pmu.c) for all platforms and users.
        - The addition of a pmu_init() function that sets the IRQ affinity for
        each PMU to the owning CPU. This was previously done in oprofile but
        also needs to be done for perf events so put it in a common place.
        - hardware perf events are checked to ensure the whole group can go
        onto the cpu when initialised.
        - style cleanups to perf_events.c
        - the use of the generic atomic64's has been split out into a separate
        patch. When we have proper hardware support (as in Will Deacon's
        patch) we can use that.

Jamie Iles (5):
      arm: provide a mechanism to reserve performance counters
      arm/oprofile: reserve the PMU when starting
      arm: use the spinlocked, generic atomic64 support
      arm: enable support for software perf events
      arm/perfevents: implement perf event support for ARMv6
