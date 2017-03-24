From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 24 Mar 2017 12:15:25 +0000
Subject: [PATCH 0/4] perf: Enabling PMUv3 on 32bit ARM systems
Message-ID: <20170324121529.22603-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PMUv3 has been introduced with ARMv8 and, while it has only been used
on 64bit systems so far, it would definitely be useful for 32bit
guests running under KVM, for example.

This is done in three steps:
(1) Move the driver from arch/arm64 to drivers/perf
(2) Add a handful of system register accessors so that we can reuse
    the driver on 32bit
(3) Provide the same accessors on 32bit, enable compilation, and
    make it the default selection for mach-virt.

The one thing that I find a bit dodgy is the use of CONFIG_CPU_V7 to
allow the selection of the driver. I'm not sure if we should just
remove it altogether (it should never probe on anything but an ARMv8
CPU), or define a CONFIG_CPU_V8... Guidance appreciated.

Tested on a 32bit VM running on a X-Gene system:

root at zomby-woof:~# uname -a
Linux zomby-woof 4.11.0-rc3+ #6979 SMP PREEMPT Fri Mar 24 10:01:42 GMT 2017 armv7l GNU/Linux
root at zomby-woof:~# dmesg | grep -i pmu
[    2.440279] hw perfevents: enabled with armv8_pmuv3 PMU driver, 5 counters available
root at zomby-woof:~# perf stat -e cycles,L1-icache-loads,dTLB-load-misses ~maz/hackbench 100 process 1000
Running with 100*40 (== 4000) tasks.
Time: 59.370

 Performance counter stats for '/home/maz/hackbench 100 process 1000':

      323663890100      cycles                                                      
       46297944079      L1-icache-loads                                             
           6570884      dTLB-load-misses                                            

      60.777397600 seconds time elapsed

Marc Zyngier (4):
  arm64: perf: Move PMUv3 driver to drivers/perf
  arm64: perf: Abstract system register accesses away
  ARM: perf: Allow the use of the PMUv3 driver on 32bit ARM
  ARM: mach-virt: Select PMUv3 driver by default

 arch/arm/Kconfig                                   |   1 +
 arch/arm/include/asm/arm_pmuv3.h                   | 115 +++++++++++++++++++++
 arch/arm64/include/asm/arm_pmuv3.h                 | 102 ++++++++++++++++++
 arch/arm64/include/asm/perf_event.h                |  55 ----------
 arch/arm64/kernel/Makefile                         |   1 -
 drivers/perf/Kconfig                               |   9 ++
 drivers/perf/Makefile                              |   1 +
 .../perf_event.c => drivers/perf/arm_pmuv3.c       |  36 +++----
 include/kvm/arm_pmu.h                              |   2 +-
 include/linux/perf/arm_pmuv3.h                     |  77 ++++++++++++++
 10 files changed, 324 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/include/asm/arm_pmuv3.h
 create mode 100644 arch/arm64/include/asm/arm_pmuv3.h
 rename arch/arm64/kernel/perf_event.c => drivers/perf/arm_pmuv3.c (98%)
 create mode 100644 include/linux/perf/arm_pmuv3.h

-- 
2.11.0
