From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Dec 2010 09:25:27 +0000
Subject: [PATCH 0/13] 64-bit sched_clock
Message-ID: <20101216092527.GL9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series replaces existing sched_clock() implementations
with a version which gives a full 64-bit nanosecond time from counters
with less than 33 bits.

This series depends on the prevously posted clocksource patch series,
and the notrace sched_clock patch, and the ftrace tree previously
merged into my devel-stable branch.  It also depends on a fix to
the clocksource code to achieve the accuracy quoted below - though
it'll build and work without.

We achieve the 64-bit nanosecond time by maintaining a pair of
epochs - one for the counter and a corresponding one for the ns value.
This allows us to calculate how many counter ticks have happened since
the ns epoch was last updated, and therefore how much time has passed.

We use a lockless method to read and update the epoch values,
eliminating any locking overhead.  The epoch update happens at about
90% of the wrap period, resulting in less maintainence overhead.

Lastly, we allow platforms to provide constants for the counter->ns
conversion.

The PXA sched_clock implementation using cnt32_to_63() builds to 72
bytes of code and 12 bytes of data, and provides 54 bits of
nanoseconds, with an error of 0.00008%.

The PXA sched_clock implementation using this infrastructure builds
to 84 bytes of code and 8 bytes of data, and provides 64 bits of
nanoseconds, with an error of 0.00000002%.

The epoch updates in action on Versatile Express (24MHz 32-bit counter):

sched_clock: update 68391420 -> 50e0a246 0ns -> 162637292211ns
sched_clock: update 50e0a246 -> 372c24b7 162637292211ns -> 323625136880ns
sched_clock: update 372c24b7 -> 1d35c46a 323625136880ns -> 484433069633ns
sched_clock: update 1d35c46a -> 0367a736 484433069633ns -> 645350944761ns
...
sched_clock: update f6f7fd55 -> dd2d882e 32669955162290ns -> 32830883021959ns
sched_clock: update dd2d882e -> c36312cd 32830883021959ns -> 32991810879212ns
sched_clock: update c36312cd -> a9989d41 32991810879212ns -> 33152738734673ns
sched_clock: update a9989d41 -> 8fce2781 33152738734673ns -> 33313666587967ns
