From: LW@KARO-electronics.de (Lothar =?UTF-8?B?V2HDn21hbm4=?=)
Date: Thu, 31 Mar 2016 12:21:49 +0200
Subject: Boot failure on i.MX6 boards due to commit 5e3ca2b349b1
 ("regulator: Try to resolve regulators supplies on registration")
Message-ID: <20160331122149.56281b0d@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

booting a TX6 module (i.MX6Q or i.MX6DL) fails with current linux-next.
Bisecting revealed the culprit to be commit:
5e3ca2b349b1 (""regulator: Try to resolve regulators supplies on registration)

Reverting this commit on top of next-20163031 makes the board functional again.

Booting with "earlyprintk" gives the following bootlog:
|Booting Linux on physical CPU 0x0
|Linux version 4.6.0-rc1-karo+ (lothar at ipc1) (gcc version 4.9.1 (GCC) ) #14 SMP Thu Mar 31 10:02:31 CEST 2016
|CPU: ARMv7 Processor [412fc09a] revision 10 (ARMv7), cr=10c5387d
|CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
|Machine model: Ka-Ro electronics TX6U-801x Module
|bootconsole [earlycon0] enabled
|debug: skip boot console de-registration.
|cma: Reserved 16 MiB at 0x4f000000
|Memory policy: Data cache writealloc
|On node 0 totalpages: 262144
|free_area_init_node: node 0, pgdat 80b2f940, node_mem_map be731000
|  Normal zone: 2048 pages used for memmap
|  Normal zone: 0 pages reserved
|  Normal zone: 262144 pages, LIFO batch:31
|percpu: Embedded 12 pages/cpu @befb7000 s18432 r8192 d22528 u49152
|pcpu-alloc: s18432 r8192 d22528 u49152 alloc=12*4096
|pcpu-alloc: [0] 0 [0] 1 
|Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
|Kernel command line: init=/linuxrc ro ubi.mtd=rootfs ubi.mtd=userfs root=/dev/nfs nfsroot=192.168.1.225:/tftpboot/KARO/imx6q-new,nolock ip=dhcp console=ttymxc0,115200  debug earlyprintk keep_bootcon panic=1
|PID hash table entries: 4096 (order: 2, 16384 bytes)
|Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
|Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)          
|Memory: 1011960K/1048576K available (6328K kernel code, 194K rwdata, 2080K rodata, 1024K init, 440K bss, 20232K 
|reserved, 16384K cma-reserved, 0K highmem)                              
|Virtual kernel memory layout:                                           
|    vector  : 0xffff0000 - 0xffff1000   (   4 kB)                       
|    fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)                       
|    vmalloc : 0xc0800000 - 0xff800000   (1008 MB)                       
|    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)                       
|    pkmap   : 0x7fe00000 - 0x80000000   (   2 MB)
|    modules : 0x7f000000 - 0x7fe00000   (  14 MB)
|      .text : 0x80008000 - 0x80936074   (9401 kB)
|      .init : 0x80a00000 - 0x80b00000   (1024 kB)
|      .data : 0x80b00000 - 0x80b308a0   ( 195 kB)
|       .bss : 0x80b308a0 - 0x80b9e8e4   ( 441 kB)
|SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
|Hierarchical RCU implementation.
|        Build-time adjustment of leaf fanout to 32.
|        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
|RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
|NR_IRQS:16 nr_irqs:16 16
|L2C-310 erratum 769419 enabled
|L2C-310 enabling early BRESP for Cortex-A9
|L2C-310 full line of zeros enabled for Cortex-A9
|L2C-310 ID prefetch enabled, offset 1 lines
|L2C-310 dynamic clock gating enabled, standby mode enabled
|L2C-310 cache controller enabled, 16 ways, 512 kB
|L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x76450001
|Switching to timer-based delay loop, resolution 333ns
|sched_clock: 32 bits at 3000kHz, resolution 333ns, wraps every 715827882841ns
|clocksource: mxc_timer1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 637086815595 ns
|Console: colour dummy device 80x30
|Calibrating delay loop (skipped), value calculated using timer frequency.. 6.00 BogoMIPS (lpj=30000)
|pid_max: default: 32768 minimum: 301
|Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
|Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
|CPU: Testing write buffer coherency: ok
|CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
|Setting up static identity map for 0x10100000 - 0x10100058
|CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
|Brought up 2 CPUs
|SMP: Total of 2 processors activated (12.00 BogoMIPS).
|CPU: All CPU(s) started in SVC mode.
|devtmpfs: initialized
|VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
|clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
|pinctrl core: initialized pinctrl subsystem
|NET: Registered protocol family 16
|DMA: preallocated 256 KiB pool for atomic coherent allocations
|cpuidle: using governor ladder
|cpuidle: using governor menu
|CPU identified as i.MX6DL, silicon rev 1.3
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Here the system hangs.

I did not check yet what exactly is the cause for this, but would like
to know whether someone else has experienced similar problems.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
