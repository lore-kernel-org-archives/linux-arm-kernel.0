From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu,  9 Aug 2018 09:48:50 +0530
Subject: [PATCH v8 0/6] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-ID: <20180809041856.1547-1-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v8 changes:
 - Call delayed_uprobe_remove(uprobe, NULL) from put_uprobe() as well.
 - Other minor optimizations.

v7: https://lkml.org/lkml/2018/7/31/20


Description:
Userspace Statically Defined Tracepoints[1] are dtrace style markers
inside userspace applications. Applications like PostgreSQL, MySQL,
Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
have these markers embedded in them. These markers are added by developer
at important places in the code. Each marker source expands to a single
nop instruction in the compiled code but there may be additional
overhead for computing the marker arguments which expands to couple of
instructions. In case the overhead is more, execution of it can be
omitted by runtime if() condition when no one is tracing on the marker:

    if (reference_counter > 0) {
        Execute marker instructions;
    }

Default value of reference counter is 0. Tracer has to increment the 
reference counter before tracing on a marker and decrement it when
done with the tracing.

Currently, perf tool has limited supports for SDT markers. I.e. it
can not trace markers surrounded by reference counter. Also, it's
not easy to add reference counter logic in userspace tool like perf,
so basic idea for this patchset is to add reference counter logic in
the a uprobe infrastructure. Ex,[2]

  # cat tick.c
    ... 
    for (i = 0; i < 100; i++) {
	DTRACE_PROBE1(tick, loop1, i);
        if (TICK_LOOP2_ENABLED()) {
            DTRACE_PROBE1(tick, loop2, i); 
        }
        printf("hi: %d\n", i); 
        sleep(1);
    }   
    ... 

Here tick:loop1 is marker without reference counter where as tick:loop2
is surrounded by reference counter condition.

  # perf buildid-cache --add /tmp/tick
  # perf probe sdt_tick:loop1
  # perf probe sdt_tick:loop2

  # perf stat -e sdt_tick:loop1,sdt_tick:loop2 -- /tmp/tick
  hi: 0
  hi: 1
  hi: 2
  ^C
  Performance counter stats for '/tmp/tick':
             3      sdt_tick:loop1
             0      sdt_tick:loop2
     2.747086086 seconds time elapsed

Perf failed to record data for tick:loop2. Same experiment with this
patch series:

  # ./perf buildid-cache --add /tmp/tick
  # ./perf probe sdt_tick:loop2
  # ./perf stat -e sdt_tick:loop2 /tmp/tick
    hi: 0
    hi: 1
    hi: 2
    ^C  
     Performance counter stats for '/tmp/tick':
                 3      sdt_tick:loop2
       2.561851452 seconds time elapsed

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation


Ravi Bangoria (6):
  Uprobes: Simplify uprobe_register() body
  Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()
  Uprobes: Support SDT markers having reference count (semaphore)
  Uprobes/sdt: Prevent multiple reference counter for same uprobe
  trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
  perf probe: Support SDT markers having reference counter (semaphore)

 arch/arm/probes/uprobes/core.c |   2 +-
 arch/mips/kernel/uprobes.c     |   2 +-
 include/linux/uprobes.h        |   7 +-
 kernel/events/uprobes.c        | 329 +++++++++++++++++++++++++++++++++++------
 kernel/trace/trace.c           |   2 +-
 kernel/trace/trace_uprobe.c    |  75 +++++++++-
 tools/perf/util/probe-event.c  |  39 ++++-
 tools/perf/util/probe-event.h  |   1 +
 tools/perf/util/probe-file.c   |  34 ++++-
 tools/perf/util/probe-file.h   |   1 +
 tools/perf/util/symbol-elf.c   |  46 ++++--
 tools/perf/util/symbol.h       |   7 +
 12 files changed, 472 insertions(+), 73 deletions(-)

-- 
2.14.4
