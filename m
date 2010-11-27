From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Nov 2010 12:39:39 +0000
Subject: [PATCH 0/4] ARM: hw_breakpoint: fixes and improvements
In-Reply-To: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
References: <1290704899-13051-1-git-send-email-will.deacon@arm.com>
Message-ID: <20101127123939.GA5998@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 25, 2010 at 05:08:15PM +0000, Will Deacon wrote:
> All feedback welcome!

While in the subject of fixes, sparse seems to have a problem with
hw_breakpoint's usage of percpu stuff:

  CHECK   arch/arm/kernel/hw_breakpoint.c
arch/arm/kernel/hw_breakpoint.c:326:23: warning: incorrect type in assignment (different modifiers)
arch/arm/kernel/hw_breakpoint.c:326:23:    expected struct perf_event **slots
arch/arm/kernel/hw_breakpoint.c:326:23:    got struct perf_event *[noderef] *<noident>
arch/arm/kernel/hw_breakpoint.c:339:23: warning: incorrect type in assignment (different modifiers)
arch/arm/kernel/hw_breakpoint.c:339:23:    expected struct perf_event **slots
arch/arm/kernel/hw_breakpoint.c:339:23:    got struct perf_event *[noderef] *<noident>
arch/arm/kernel/hw_breakpoint.c:377:23: warning: incorrect type in assignment (different modifiers)
arch/arm/kernel/hw_breakpoint.c:377:23:    expected struct perf_event **slots
arch/arm/kernel/hw_breakpoint.c:377:23:    got struct perf_event *[noderef] *<noident>
arch/arm/kernel/hw_breakpoint.c:388:23: warning: incorrect type in assignment (different modifiers)
arch/arm/kernel/hw_breakpoint.c:388:23:    expected struct perf_event **slots t perf_event *[noderef] *<noident>
arch/arm/kernel/hw_breakpoint.c:635:42: warning: incorrect type in initializer (different modifiers)
arch/arm/kernel/hw_breakpoint.c:635:42:    expected struct perf_event **slots
arch/arm/kernel/hw_breakpoint.c:635:42:    got struct perf_event *[noderef] *<noident>
arch/arm/kernel/hw_breakpoint.c:687:42: warning: incorrect type in initializer (different modifiers)
arch/arm/kernel/hw_breakpoint.c:687:42:    expected struct perf_event **slots
arch/arm/kernel/hw_breakpoint.c:687:42:    got struct perf_event *[noderef] *<noident>

perf_event.c seems to also have problems too:

  CHECK   arch/arm/kernel/perf_event.c
arch/arm/kernel/perf_event.c:37:1: warning: symbol 'pmu_lock' was not declared. Should it be static?
arch/arm/kernel/perf_event.c:70:1: warning: symbol 'cpu_hw_events' was not declared. Should it be static?
arch/arm/kernel/perf_event.c:1006:1: warning: symbol 'armv6pmu_enable_event' was not declared. Should it be static?
arch/arm/kernel/perf_event.c:1113:1: warning: symbol 'armv6pmu_stop' was not declared. Should it be static?
arch/arm/kernel/perf_event.c:1956:6: warning: symbol 'armv7pmu_enable_event' was not declared. Should it be static?
arch/arm/kernel/perf_event.c:3072:14: warning: incorrect type in argument 1 (different address spaces)
arch/arm/kernel/perf_event.c:3072:14:    expected void const volatile [noderef] <asn:1>*<noident>
arch/arm/kernel/perf_event.c:3072:14:    got struct frame_tail *tail
arch/arm/kernel/perf_event.c:3074:49: warning: incorrect type in argument 2 (different address spaces)
arch/arm/kernel/perf_event.c:3074:49:    expected void const [noderef] <asn:1>*from
arch/arm/kernel/perf_event.c:3074:49:    got struct frame_tail *tail
