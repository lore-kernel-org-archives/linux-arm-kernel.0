From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Mon, 20 Oct 2014 14:45:50 +0000 (UTC)
Subject: Tegra baseline test results for v3.18-rc1
Message-ID: <alpine.DEB.2.02.1410201415580.4472@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Here are some basic Tegra test results for Linux v3.18-rc1.
Logs and other details at:

    http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc1/20141019183104/


Test summary
------------

Build: zImage:
    Pass: ( 2/ 2): multi_v7_defconfig, tegra_defconfig

Boot to userspace: multi_v7_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver

Boot to userspace: tegra_defconfig:
    Pass: ( 3/ 3): tegra114-dalmore-a04, tegra124-jetson-tk1,
		   tegra30-beaver


vmlinux object size
(delta in bytes from test_v3.17 (bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9)):
   text     data      bss    total  kernel
+291561   +15912    +3464  +310937  multi_v7_defconfig
+281379    +9952    +4696  +296027  tegra_defconfig


Boot-time memory difference
(delta in bytes from test_v3.17 (bfe01a5ba2490f299e1d2d5508cbbbadd897bbe9))
    avail    rsrvd     high    freed                board              kconfig                  dtb
    -204k     204k  -65536k      24k tegra114-dalmore-a04   multi_v7_defconfig     tegra114-dalmore
    -192k     192k  -65536k      16k tegra114-dalmore-a04      tegra_defconfig     tegra114-dalmore
    -216k     216k  -65536k      24k  tegra124-jetson-tk1   multi_v7_defconfig  tegra124-jetson-tk1
    -204k     204k  -65536k      16k  tegra124-jetson-tk1      tegra_defconfig  tegra124-jetson-tk1
    -204k     204k  -65536k      24k       tegra30-beaver   multi_v7_defconfig       tegra30-beaver
    -192k     192k  -65536k      16k       tegra30-beaver      tegra_defconfig       tegra30-beaver


The 64MiB decrease in highmem is a bit mysterious.  Am thinking that it is 
probably PCIe-related, given the PCIe messages in the boot logs:

http://nvt.pwsan.com/pub/linux/testlogs/test_v3.18-rc1/20141019183104/boot/boot-log-diff-from-test_v3.17-20141006214755.diff

Looks like we also have some PL310 DT work to do:

+PL310 OF: cache setting yield illegal associativity
+PL310 OF: 0 calculated, only 8 and 16 legal

Also the Cortex-A15 boards are no longer using the ARM localtimers:

-Architected cp15 timer(s) running at 12.00MHz (virt).
-sched_clock: 56 bits at 12MHz, resolution 83ns, wraps every 2863311536128ns
-Switching to timer-based delay loop, resolution 83ns
 Console: colour dummy device 80x30
-Calibrating delay loop (skipped), value calculated using timer frequency.. 24.00 BogoMIPS (lpj=120000)
+Calibrating delay loop (skipped), value calculated using timer frequency.. 2.00 BogoMIPS (lpj=10000)

...

-Switched to clocksource arch_sys_counter
+Switched to clocksource timer_us
