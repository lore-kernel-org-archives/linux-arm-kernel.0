From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 28 Jun 2018 10:51:59 +0530
Subject: [PATCH v5 00/10] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-ID: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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


v5 changes:
 - Fix build failure. 'struct uprobe' was local to uprobe.c file and I
   was using it in some arch specific code which caused a build failure.
   Added new patch [PATCH v5 1/10] to fix it.

v4 changes:
 - Previous version moved the implementation from trace_uprobe to core
   uprobe. But it had some issues. I've fixed them in this version. To
   cut a long story short, reference counter increment/decrement is
   tied to instruction patching. Whenever instruction gets patched, we
   update the reference counter. Now, what if vma holding reference
   counter is not present while patching an instruction? To overcome
   this issue, we will add such uprobe to delayed_uprobe list. Whenever
   process maps the region holding the reference counter, we increment
   it and remove the uprobe from delayed_uprobe list.
 - Until last version, we were incrementing reference counter for each
   uprobe_consumer. That isn't true now. With this implementation, we
   increment and decrement the counter only once. This is fine because
   we increment the counter when we find first valid consumer and we
   decrement it when last consumer is going away. (For a tiny binary,
   multiple vmas maps to the same file portion. In such case, we are
   patching the instruction multiple time and thus we will increment /
   decrement the reference counter multiple time as well.)
 - Fortunately, there is no need to maintain sdt_mm_list now, because
   we are sure that the increment and decrement will always happen in
   sync. This make the implementation lot more simpler compared to
   earlier versions.

v4 can be foud at: https://lkml.org/lkml/2018/6/19/1324 

Note:
 - 'reference counter' is called as 'semaphore' in original Dtrace
   (or Systemtap, bcc and even in ELF) documentation and code. But the 
   term 'semaphore' is misleading in this context. This is just a counter
   used to hold number of tracers tracing on a marker. This is not really
   used for any synchronization. So we are referring it as 'reference
   counter' in kernel / perf code.

[1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
[2] https://github.com/iovisor/bcc/issues/327#issuecomment-200576506


Ravi Bangoria (10):
  Uprobes: Move uprobe structure to uprobe.h
  Uprobes: Simplify uprobe_register() body
  Uprobe: Change set_swbp definition
  Uprobe: Change set_orig_insn definition
  Uprobe: Change uprobe_write_opcode definition
  Uprobes: Support SDT markers having reference count (semaphore)
  trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
  Uprobes/sdt: Prevent multiple reference counter for same uprobe
  Uprobes/sdt: Document about reference counter
  perf probe: Support SDT markers having reference counter (semaphore)

 Documentation/trace/uprobetracer.rst |  16 +-
 arch/arm/probes/uprobes/core.c       |   6 +-
 arch/mips/kernel/uprobes.c           |   6 +-
 include/linux/uprobes.h              |  37 +++-
 kernel/events/uprobes.c              | 390 ++++++++++++++++++++++++++++-------
 kernel/trace/trace.c                 |   2 +-
 kernel/trace/trace_uprobe.c          |  74 ++++++-
 tools/perf/util/probe-event.c        |  39 +++-
 tools/perf/util/probe-event.h        |   1 +
 tools/perf/util/probe-file.c         |  34 ++-
 tools/perf/util/probe-file.h         |   1 +
 tools/perf/util/symbol-elf.c         |  46 +++--
 tools/perf/util/symbol.h             |   7 +
 13 files changed, 542 insertions(+), 117 deletions(-)

-- 
2.14.4
