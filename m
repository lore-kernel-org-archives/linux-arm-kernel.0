From: john.garry@huawei.com (John Garry)
Date: Tue, 2 Oct 2018 11:20:46 +0100
Subject: perf segmentation fault from NULL dereference
In-Reply-To: <20180927030035.GF28040@tassilo.jf.intel.com>
References: <712b7c31-f681-7737-71e7-c028b8d2bba5@huawei.com>
 <20180927030035.GF28040@tassilo.jf.intel.com>
Message-ID: <334a114a-bb59-9582-a913-efbb01bd68c5@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/09/2018 04:00, Andi Kleen wrote:
>> Please me let me know if a valid issue so we can get a fix in.
>
> If it crashes it must be a valid issue of course.
>
> But I'm not sure about your bisect. Hard to see how my patch
> could cause this. Sometimes bisects go wrong.
> You verified by just reverting the patch?

It no longer reverts cleanly. And the previous patch - 4ca69ca9db3a - 
did not have this crash:
root at localhost:~# ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ sleep 1
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.001 MB perf.data (6 samples) ]
root at localhost:~#

>
> First thing I would also try is to run with valgrind or ASan and see if it
> reports anything.

Here's the valgrind output:
root at localhost:~#valgrind  --leak-check=yes  ./perf_debug_ record -e 
armv8_pmuv3_0/br_mis_pred/ sleep 1
==16025== Memcheck, a memory error detector
==16025== Copyright (C) 2002-2015, and GNU GPL'd, by Julian Seward et al.
==16025== Using Valgrind-3.11.0 and LibVEX; rerun with -h for copyright info
==16025== Command: ./perf_debug_ record -e armv8_pmuv3_0/br_mis_pred/ 
sleep 1
==16025==
--16025-- WARNING: unhandled arm64-linux syscall: 168
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
--16025-- WARNING: unhandled arm64-linux syscall: 241
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
perf_event_open(..., PERF_FLAG_FD_CLOEXEC) failed with unexpected error 
38 (Function not implemented)
--16025-- WARNING: unhandled arm64-linux syscall: 241
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
perf_event_open(..., 0) failed unexpectedly with error 38 (Function not 
implemented)
--16025-- WARNING: unhandled arm64-linux syscall: 241
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
--16025-- WARNING: unhandled arm64-linux syscall: 241
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
--16025-- WARNING: unhandled arm64-linux syscall: 241
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
--16025-- WARNING: unhandled arm64-linux syscall: 241
--16025-- You may be able to write your own handler.
--16025-- Read the file README_MISSING_SYSCALL_OR_IOCTL.
--16025-- Nevertheless we consider this a bug.  Please report
--16025-- it at http://valgrind.org/support/bug_reports.html.
Error:
The sys_perf_event_open() syscall returned with 38 (Function not 
implemented) for event (armv8_pmuv3_0/br_mis_pred/).
/bin/dmesg | grep -i perf may provide additional information.

==16059==
==16059== Process terminating with default action of signal 15 (SIGTERM)
==16059==    at 0x486F974: __read_nocancel (syscall-template.S:84)
==16059==    by 0x48D02F: read (unistd.h:44)
==16059==    by 0x48D02F: perf_evlist__prepare_workload (evlist.c:1471)
==16059==    by 0x41AB0F: __cmd_record (builtin-record.c:898)
==16059==    by 0x41AB0F: cmd_record (builtin-record.c:1873)
==16059==    by 0x476C7F: run_builtin (perf.c:302)
==16059==    by 0x476F37: handle_internal_command (perf.c:354)
==16059==    by 0x407093: run_argv (perf.c:398)
==16059==    by 0x407093: main (perf.c:520)
==16059==
==16059== HEAP SUMMARY:
==16059==     in use at exit: 56,239 bytes in 226 blocks
==16059==   total heap usage: 1,164 allocs, 938 frees, 2,238,979 bytes 
allocated
==16059==
==16059== 12 bytes in 1 blocks are definitely lost in loss record 1 of 6
==16059==    at 0x4844B88: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-arm64-linux.so)
==16059==
==16059== 344 bytes in 5 blocks are possibly lost in loss record 3 of 6
==16059==    at 0x4846CFC: calloc (in 
/usr/lib/valgrind/vgpreload_memcheck-arm64-linux.so)
==16059==
==16059== 5,736 bytes in 125 blocks are possibly lost in loss record 4 of 6
==16059==    at 0x4844B88: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-arm64-linux.so)
==16059==
==16059== LEAK SUMMARY:
==16059==    definitely lost: 12 bytes in 1 blocks
==16059==    indirectly lost: 0 bytes in 0 blocks
==16059==      possibly lost: 6,080 bytes in 130 blocks
==16059==    still reachable: 50,147 bytes in 95 blocks
==16059==         suppressed: 0 bytes in 0 blocks
==16059== Reachable blocks (those to which a pointer was found) are not 
shown.
==16059== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==16059==
==16059== For counts of detected and suppressed errors, rerun with: -v
==16059== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025== Warning: invalid file descriptor -1 in syscall close()
==16025==
==16025== HEAP SUMMARY:
==16025==     in use at exit: 26,640 bytes in 209 blocks
==16025==   total heap usage: 1,202 allocs, 993 frees, 2,455,112 bytes 
allocated
==16025==
==16025== 328 bytes in 7 blocks are definitely lost in loss record 2 of 6
==16025==    at 0x4844B88: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-arm64-linux.so)
==16025==
==16025== 344 bytes in 5 blocks are possibly lost in loss record 3 of 6
==16025==    at 0x4846CFC: calloc (in 
/usr/lib/valgrind/vgpreload_memcheck-arm64-linux.so)
==16025==
==16025== 6,000 bytes in 126 blocks are possibly lost in loss record 5 of 6
==16025==    at 0x4844B88: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-arm64-linux.so)
==16025==
==16025== LEAK SUMMARY:
==16025==    definitely lost: 328 bytes in 7 blocks
==16025==    indirectly lost: 0 bytes in 0 blocks
==16025==      possibly lost: 6,344 bytes in 131 blocks
==16025==    still reachable: 19,968 bytes in 71 blocks
==16025==         suppressed: 0 bytes in 0 blocks
==16025== Reachable blocks (those to which a pointer was found) are not 
shown.
==16025== To see them, rerun with: --leak-check=full --show-leak-kinds=all
==16025==
==16025== For counts of detected and suppressed errors, rerun with: -v
==16025== ERROR SUMMARY: 3 errors from 3 contexts (suppressed: 0 from 0)
root at localhost:~#

(pretty much the same as previous patch)

Cheers,
John

>
> -Andi
>
> .
>
