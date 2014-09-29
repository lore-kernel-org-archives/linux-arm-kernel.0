From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon, 29 Sep 2014 01:04:01 -0700
Subject: [PATCH] arm64: ptrace: hw_break_set take into account hardware
 breakpoints number
Message-ID: <1411977842-16515-1-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Folks,

I've run into the issue where I failed to debug multithreaded
process on real ARMV8 h/w. GDB was failing with 
"Unexpected error setting hardware debug registers" error.
and on strace of gdb it showed
"ptrace(PTRACE_SETREGSET, 447, 0x403 /* NT_??? */, [{0x7fc1ba8cf8, 264}]) = -1 ENOSPC (No space left on device)"

Initially I thought it is "cdc27c2 arm64: ptrace: avoid 
using HW_BREAKPOINT_EMPTY for disabled events" but I had
it in my tree already. It turns out it is something
different.

Failure happens because current code does not take into
account number of available h/w breakpoints. It works
with default settings in fastmodels where by default it
has 16 h/w breakpoints. And after understanding root cause
I was able to reproduce the issue with fastmodels when I
passed "-C cluster0.cpu0.number-of-breakpoints=0x4 ...
-C cluster1.cpu3.number-of-breakpoints=0x4" options 
restricting number of available h/w breakpoints.

The issue that ENOSPC returned by  __reserve_bp_slot function
called with the following backtrace:

#0 __reserve_bp_slot( bp = (struct perf_event*) 0xFFFFFFC07B72A400 ) at hw_breakpoint.c:281
#1 reserve_bp_slot( bp = (struct perf_event*) 0xFFFFFFC07B72A400 ) at hw_breakpoint.c:320
#2 register_perf_hw_breakpoint( bp = (struct perf_event*) 0xFFFFFFC07B72A400 ) at hw_breakpoint.c:396
#3 hw_breakpoint_event_init( bp = <Value not available : Undefined value in stack frame for register X0> ) at hw_breakpoint.c:572
#4 perf_init_event( event = (struct perf_event*) 0xFFFFFFC07B72A400 ) at core.c:6733
#5 perf_event_alloc( attr = <Value not available : Undefined value in stack frame for register X0>, cpu = <Value not available : Undefined value in stack frame for register X1>, task = <Value not available : Undefined value in stack frame for register X2>, group_leader = (struct perf_event*) 0xFFFFFFC07B72A400, parent_event = <Value not available : Undefined value in stack frame for register X4>, overflow_handler = <Value not available : Undefined value in stack frame for register X5>, context = <Value not available : Undefined value in stack frame for register X6> ) at core.c:6885
#6 perf_event_create_kernel_counter( attr = <Value currently has no location>, cpu = -1, task = (struct task_struct*) 0xFFFFFFC07B4A1600, overflow_handler = <Value currently has no location>, context = <Value currently has no location> ) at core.c:7395
#7 register_user_hw_breakpoint( attr = <Value currently has no location>, triggered = <Value currently has no location>, context = <Value currently has no location>, tsk = <Value currently has no location> ) at hw_breakpoint.c:423
#8 ptrace_hbp_create( idx = <Value optimised away by compiler>, tsk = <Value optimised away by compiler>, note_type = <Value optimised away by compiler> ) at ptrace.c:208
#9 ptrace_hbp_set_addr( note_type = <Value currently has no location>, tsk = <Value currently has no location>, idx = <Value currently has no location>, addr = 0 ) at ptrace.c:350
#10 hw_break_set( target = <Value not available : Undefined value in stack frame for register X0>, regset = <Value currently has no location>, pos = 16, count = 248, kbuf = (const void*) 0x0, ubuf = <Value currently has no location> ) at ptrace.c:450
#11 ptrace_regset( task = (struct task_struct*) 0xFFFFFFC07B4A1600, req = <Value currently has no location>, type = <Value currently has no location>, kiov = (struct iovec*) 0xFFFFFFC07AC1FE00 ) at ptrace.c:787
#12 ptrace_request( child = (struct task_struct*) 0xFFFFFFC07B4A1600, request = <Value currently has no location>, addr = <Value currently has no location>, data = <Value currently has no location> ) at ptrace.c:999
#13 arch_ptrace( child = <Value currently has no location>, request = <Value currently has no location>, addr = <Value currently has no location>, data = <Value currently has no location> ) at ptrace.c:1086
#14 SYSC_ptrace( data = <Value optimised away by compiler>, addr = <Value optimised away by compiler>, pid = <Value optimised away by compiler>, request = <Value optimised away by compiler> ) at ptrace.c:1065
#15 [/wd1/linaro/linux-build/_le_64_linus_302/vmlinux EL1N:0xFFFFFFC00008429C ]

In __reserve_bp_slot function it fails on this snippet:

>	if (slots.pinned + (!!slots.flexible) > nr_slots[type])
>		return -ENOSPC;

basically when in hw_break_set function code iterates
over 16 entries of 'struct user_hwdebug_state' it tries to
reserve real entries in __reserve_bp_slot with above
call stack - ptrace_hbp_set_addr calls ptrace_hbp_get_initialised_bp
which in turns calls ptrace_hbp_create if it cannot find
existing bp. The issue is that on real h/w with limited
number of h/w breakpoints, less than 16, it fails.

My proposed fix, that follows this cover latter, just reads
actual number of available h/w breakpoint/wathcpoint slots
and it iterates over 'struct user_hwdebug_state' only upto
that number of entries or size of 'struct user_hwdebug_state'. 
Assumption here is that all relevant entries passed in
PTRACE_SETREGSET are in first entries of 'struct
user_hwdebug_state' array.

Patch was tested on mustang. I did test multithreaded process
debugging, also hbreak and watchpoint functionality. Mustang
supports and could do up to 4 h/w breakpoint and 4 h/w 
watchpoints for given executable.

Thanks,
Victor

Apendix 1 Test case to reproduce the issue
------------------------------------------

Illustrate issue of failure to debug multithread process

root at mustang:~# cat threads.c 
#include <pthread.h>
#include <stdio.h>
#include <unistd.h>

#define NUM_THREADS 4

void
threads_sleep1 (void)
{
    sleep(1);
}

void
threads_sleep2 (void)
{
    sleep(1);
}

void
threads_func1 (void)
{
}

void
threads_func2 (void)
{
    threads_func1();
}

static void *
test_thread (void *arg)
{
    int i;
    for (i = 0; i < 200000; i++) {
        threads_func2();
        if ((i % 10000) == 0) {
            threads_sleep2();
         }
    }

    return NULL;
}

int
main (void)
{
    int i;
    pthread_t threads[NUM_THREADS];
    
    for (i = 0; i < NUM_THREADS; i++) {
        pthread_create(threads + i,
                       NULL,
                       test_thread,
                       NULL);
    }

    test_thread(NULL);

    for (i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }
    
    return 0;
}
root at mustang:~# gcc -g -o threads threads.c -lpthread
root@mustang:~# gdb threads
GNU gdb (Linaro GDB) 7.6.1-2013.10
Copyright (C) 2013 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "aarch64-poky-linux".
For bug reporting instructions, please see:
<http://bugs.launchpad.net/gdb-linaro/>...
Reading symbols from /home/root/threads...done.
(gdb) run
Starting program: /home/root/threads 
warning: Could not load shared library symbols for linux-vdso.so.1.
Do you need "set solib-search-path" or "set sysroot"?
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/lib/libthread_db.so.1".
Unexpected error setting hardware debug registers
(gdb)

Victor Kamensky (1):
  arm64: ptrace: hw_break_set take into account hardware breakpoints
    number

 arch/arm64/kernel/ptrace.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
1.8.1.4
