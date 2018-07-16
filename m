From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Mon, 16 Jul 2018 14:17:00 +0530
Subject: [PATCH v6 0/6] Uprobes: Support SDT markers having reference count
 (semaphore)
Message-ID: <20180716084706.28244-1-ravi.bangoria@linux.ibm.com>
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


v6 changes:
 - Do not export struct uprobe outside of uprobe.c. Instead, use
   container_of(arch_uprobe) to regain uprobe in uprobe_write_opcode().
 - Allow 0 as a special value for reference counter _offset_. I.e.
   two uprobes, one having ref_ctr_offset=0 and the other having
   non-zero ref_ctr_offset can coexists.
 - If vma holding reference counter is not present while patching an
   instruction, we add that uprobe in delayed_uprobe_list. When
   appropriate mapping is created, we increment the reference counter
   and remove uprobe from delayed_uprobe_list. While doing all this,
   v5 was searching for all such uprobes in uprobe_tree which is not 
   require. Also, uprobes are stored in rbtree with inode+offset as
   the key and v5 was searching uprobe based on inode+ref_ctr_offset
   which is wrong too. Fix this by directly looing on delayed_uprobe_list.
 - Consider VM_SHARED vma as invalid for reference counter. Return
   false from valid_ref_ctr_vma() if vma->vm_flags has VM_SHARED set.
 - No need to use FOLL_FORCE in get_user_pages_remote() while getting
   a page to update reference counter. Remove it.
 - Do not mention usage of reference counter in Documentation/.


v5 can be found at: https://lkml.org/lkml/2018/6/28/51

Ravi Bangoria (6):
  Uprobes: Simplify uprobe_register() body
  Uprobe: Additional argument arch_uprobe to uprobe_write_opcode()
  Uprobes: Support SDT markers having reference count (semaphore)
  trace_uprobe/sdt: Prevent multiple reference counter for same uprobe
  Uprobes/sdt: Prevent multiple reference counter for same uprobe
  perf probe: Support SDT markers having reference counter (semaphore)

 arch/arm/probes/uprobes/core.c |   2 +-
 arch/mips/kernel/uprobes.c     |   2 +-
 include/linux/uprobes.h        |   7 +-
 kernel/events/uprobes.c        | 358 ++++++++++++++++++++++++++++++++++++-----
 kernel/trace/trace.c           |   2 +-
 kernel/trace/trace_uprobe.c    |  78 ++++++++-
 tools/perf/util/probe-event.c  |  39 ++++-
 tools/perf/util/probe-event.h  |   1 +
 tools/perf/util/probe-file.c   |  34 +++-
 tools/perf/util/probe-file.h   |   1 +
 tools/perf/util/symbol-elf.c   |  46 ++++--
 tools/perf/util/symbol.h       |   7 +
 12 files changed, 503 insertions(+), 74 deletions(-)

-- 
2.14.4
