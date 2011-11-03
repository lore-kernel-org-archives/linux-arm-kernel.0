From: bill4carson@gmail.com (bill4carson)
Date: Thu, 03 Nov 2011 16:21:28 +0800
Subject: Query about float point operation on Cortex A9
Message-ID: <4EB24F08.9050008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, all

I run STREAM test on ARM Versatile Express Cortex-A9x4 tile with Linux
version 3.1.0+ by adding hugeptlb support. When using huge page,
performance improvements surprisingly hit *only* "Copy" function with
2.7% ~ 10.7%, while "Scale" "Add" "Triadd" functions barely exceed 4k page.

By analyzing the code with Oprofile, it turn out __adddf3/__muldf3 
operations
eating out most of CPU cycles which can be seen from the following log.
Apparently these two operations destroy the benefit brought by hugetlb,
To make hugetlb benchmarking more convincing for the community to accept
I use -mfloat-abi=softfp compile source code, unfortunately I got illegal
instructions after each run.

Is there any other thing need to be done to execute instructions such as
vldr/vmul.f64/vadd.f64 ?


root at localhost:/root> ./run_huge.sh
Profiler running.
hugectl: WARNING: data and bss remapped together in the default hugepage 
size
-------------------------------------------------------------
STREAM version $Revision: 5.9 $
-------------------------------------------------------------
This system uses 8 bytes per DOUBLE PRECISION word.
-------------------------------------------------------------
Array size = 2097152, Offset = 0
Total memory required = 48.0 MB.
Each test is run 10 times, but only
the *best* time for each is used.
-------------------------------------------------------------
Printing one line per active thread....
-------------------------------------------------------------
Your clock granularity/precision appears to be 9 microseconds.
Each test below will take on the order of 267867 microseconds.
    (= 29763 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function      Rate (MB/s)   Avg time     Min time     Max time
Copy:         209.0475       0.1613       0.1605       0.1624
Scale:         95.3991       0.3819       0.3517       0.4015
Add:          125.4612       0.4245       0.4012       0.4696
Triad:         62.7207       0.8052       0.8025       0.8094
-------------------------------------------------------------
Solution Validates
-------------------------------------------------------------
Stopping profiling.
Overflow stats not available
CPU: ARM Cortex-A9, speed 0 MHz (estimated)
Counted CPU_CYCLES events (Number of CPU cycles) with a unit mask of 
0x00 (No unit mask) count 100000
warning: the last modified time of the binary file does not match that 
of the sample file for /root/stream_c_2M.exe
Either this is the wrong binary or the binary has been modified since 
the sample file was created.
samples  %        symbol name
235526   46.7135  __adddf3
185916   36.8740  __muldf3
37467     7.4311  tuned_STREAM_Copy
14374     2.8509  tuned_STREAM_Triad
11627     2.3061  tuned_STREAM_Add
10815     2.1450  tuned_STREAM_Scale
6066      1.2031  main
2399      0.4758  checkSTREAMresults
1        2.0e-04  __divdf3
1        2.0e-04  __floatsidf
1        2.0e-04  mysecond



root at localhost:/root> ./run_4k.sh
Profiler running.
-------------------------------------------------------------
STREAM version $Revision: 5.9 $
-------------------------------------------------------------
This system uses 8 bytes per DOUBLE PRECISION word.
-------------------------------------------------------------
Array size = 2097152, Offset = 0
Total memory required = 48.0 MB.
Each test is run 10 times, but only
the *best* time for each is used.
-------------------------------------------------------------
Printing one line per active thread....
-------------------------------------------------------------
Your clock granularity/precision appears to be 9 microseconds.
Each test below will take on the order of 268604 microseconds.
    (= 29844 clock ticks)
Increase the size of the arrays if this shows that
you are not getting at least 20 clock ticks per test.
-------------------------------------------------------------
WARNING -- The above is only a rough guideline.
For best results, please be sure you know the
precision of your system timer.
-------------------------------------------------------------
Function      Rate (MB/s)   Avg time     Min time     Max time
Copy:         265.7375       0.1269       0.1263       0.1275
Scale:         99.3782       0.3583       0.3376       0.3796
Add:          132.0995       0.3940       0.3810       0.4173
Triad:         71.8116       0.7040       0.7009       0.7082
-------------------------------------------------------------
Solution Validates
-------------------------------------------------------------
Stopping profiling.
Overflow stats not available
CPU: ARM Cortex-A9, speed 0 MHz (estimated)
Counted CPU_CYCLES events (Number of CPU cycles) with a unit mask of 
0x00 (No unit mask) count 100000
warning: the last modified time of the binary file does not match that 
of the sample file for /root/stream_c_2M.exe
Either this is the wrong binary or the binary has been modified since 
the sample file was created.
samples  %        symbol name
274767   46.7235  __adddf3
216873   36.8788  __muldf3
43709     7.4326  tuned_STREAM_Copy
16682     2.8367  tuned_STREAM_Triad
13579     2.3091  tuned_STREAM_Add
12587     2.1404  tuned_STREAM_Scale
7079      1.2038  main
2791      0.4746  checkSTREAMresults
1        1.7e-04  __divdf3
1        1.7e-04  __floatsidf
1        1.7e-04  mysecond

-- 
I am a slow learner
but I will keep trying to fight for my dreams!

--bill
