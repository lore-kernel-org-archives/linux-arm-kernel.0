From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Thu, 12 Feb 2015 16:39:47 -0600
Subject: [BUG] ARM: socfpga: L2 cache init
In-Reply-To: <20150209213017.GC7994@pengutronix.de>
References: <20150206103946.GM15692@pengutronix.de>
 <20150206110557.GY8656@n2100.arm.linux.org.uk>
 <20150209155314.GA7994@pengutronix.de>
 <54D8E3BB.3060505@opensource.altera.com>
 <20150209185820.GB7994@pengutronix.de> <20150209213017.GC7994@pengutronix.de>
Message-ID: <54DD2BB3.3090507@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On 02/09/2015 03:30 PM, Steffen Trumtrar wrote:
> On Mon, Feb 09, 2015 at 07:58:20PM +0100, Steffen Trumtrar wrote:
>> Hi Dinh!
>>
>> On Mon, Feb 09, 2015 at 10:43:39AM -0600, Dinh Nguyen wrote:
>>> Hi Steffen,
>>>
>>> On 02/09/2015 09:53 AM, Steffen Trumtrar wrote:
>>>> Hi!
>>>>
>>>> On Fri, Feb 06, 2015 at 11:05:57AM +0000, Russell King - ARM Linux wrote:
>>>>> On Fri, Feb 06, 2015 at 11:39:46AM +0100, Steffen Trumtrar wrote:
>>>>>> I have run into a bug on the Socfpga platform. My boards sometimes fail
>>>>>> to boot when I have the commit
>>>>>>
>>>>>> 	commit 8b5c18f05621394eb108d3fbc9bf98b05e8162db
>>>>>> 	Author: Russell King <rmk+kernel@arm.linux.org.uk>
>>>>>> 	Date:   Mon Apr 28 15:55:59 2014 +0100
>>>>>>
>>>>>> 	ARM: l2c: socfpga: convert to generic l2c OF initialisation
>>>>>>
>>>>>> 	Remove the explicit call to l2x0_of_init(), converting to the generic
>>>>>> 	infrastructure instead.
>>>>>>
>>>>>> 	Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>>>>>
>>>>>
>>>>> That should only result in the L2 cache being turned on earlier (before
>>>>> the secondary CPUs come up.)  I wonder if there's a bug in the secondary
>>>>> CPU code which is being tickled by it.
>>>>>
>>>>> What we need is some information on the failure - and as you've noticed,
>>>>> the failure occurs before the console is initialised.  There's two
>>>>> solutions to that:
>>>>>
>>>>> 1. Enable early printk support (and hope that works)
>>>>
>>>> Thanks. I actually got it working. Seems I had forgotten something in the
>>>> config. So, the bootlog now prints
>>>>
>>>> Uncompressing Linux... done, booting the kernel.
>>>> [    0.000000] Booting Linux on physical CPU 0x0
>>>> [    0.000000] Initializing cgroup subsys cpuset
>>>> [    0.000000] Linux version 3.19.0-rc7-test-00001-g7c10eb5fb252 (str at dude) (gcc version 4.9.2 (OSELAS.Toolchain-2014.12.0) ) #163 SMP PREEMPT Mon Feb 9 16:35:27 CET 2015
>>>> [    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
>>>> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
>>>> [    0.000000] Machine model: Terasic SoCkit
>>>> [    0.000000] bootconsole [earlycon0] enabled
>>>> [    0.000000] Memory policy: Data cache writealloc
>>>> [    0.000000] BUG: mapping for 0xfffec000 at 0xfffec000 out of vmalloc space
>>>> Early printk initialized
>>>> [    0.000000] PERCPU: Embedded 10 pages/cpu @bf7d4000 s11456 r8192 d21312 u40960
>>>> [    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
>>>> [    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk  ip=dhcp root=/dev/nfs nfsroot=/home/str/nfsroot/sockit,v3,tcp
>>>> [    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
>>>> [    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
>>>> [    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
>>>> [    0.000000] Memory: 1032636K/1048576K available (4716K kernel code, 222K rwdata, 1412K rodata, 276K init, 127K bss, 15940K reserved, 0K cma-reserved)
>>>> [    0.000000] Virtual kernel memory layout:
>>>> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
>>>> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
>>>> [    0.000000]     vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
>>>> [    0.000000]     lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
>>>> [    0.000000]     modules : 0x7f000000 - 0x80000000   (  16 MB)
>>>> [    0.000000]       .text : 0x80008000 - 0x806044d8   (6130 kB)
>>>> [    0.000000]       .init : 0x80605000 - 0x8064a000   ( 276 kB)
>>>> [    0.000000]       .data : 0x8064a000 - 0x80681a14   ( 223 kB)
>>>> [    0.000000]        .bss : 0x80681a14 - 0x806a161c   ( 128 kB)
>>>> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
>>>> [    0.000000] Preemptible hierarchical RCU implementation.
>>>> [    0.000000] NR_IRQS:16 nr_irqs:16 16
>>>> [    0.000000] L2C-310 enabling early BRESP for Cortex-A9
>>>> [    0.000000] L2C-310 full line of zeros enabled for Cortex-A9
>>>> [    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
>>>> [    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
>>>> [    0.000000] L2C-310: CACHE_ID 0x410030c9, AUX_CTRL 0x46060001
>>>> [    0.000013] sched_clock: 32 bits at 100MHz, resolution 10ns, wraps every 42949672950ns
>>>> [    0.008119] Console: colour dummy device 80x30
>>>> [    0.012670] Calibrating delay loop... 1594.16 BogoMIPS (lpj=7970816)
>>>> [    0.052740] pid_max: default: 32768 minimum: 301
>>>> [    0.057509] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
>>>> [    0.064195] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
>>>> [    0.071877] CPU: Testing write buffer coherency: ok
>>>> [    0.077012] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
>>>> [    0.082841] Setting up static identity map for 0x47cc10 - 0x47cc68
>>>> [    1.139876] CPU1: failed to come online
>>>> [    1.143808] Brought up 1 CPUs
>>>> [    1.146851] SMP: Total of 1 processors activated (1594.16 BogoMIPS).
>>>>
>>>>
>>>> It looks like there actually is something wrong with the SMP setup.
>>>> The SoC is a Cortex-A9 dual core and normally both CPUs are started.
>>>> Maybe it has something to do with
>>>>
>>>> 	BUG: mapping for 0xfffec000 at 0xfffec000 out of vmalloc space
>>>>
>>>> 0xfffec000 is the SCU base address.
>>>>
>>>
>>> This printout has been there for quite a while. The fix should be to
>>> remove the static define SOCFPGA_SCU_VIRT_BASE. I have a patch for this
>>> queue up but haven't had a chance to send it yet.
>>>
>>
>> Cool.
>>
>>> I was able to recreate this error(only 1 CPU coming online), when I
>>> build for socfpga_defconfig. But I cannot seem to recreate it if I build
>>> for multi_v7_defconfig, both CPUs come up just fine.
>>>
>>
>> Interessting.
>>
>>> Would it be possible for you to run your test with multi_v7_defconfig?
>>
>> No problem. Will do and get back with the result.
>>
> 
> Doesn't seem to make such a big difference for me. It still sometimes
> doesn't boot. (I can't give any statistics, because ktest.pl is sadly
> not very reliable in finding all successful/failed boots and I'm to
> lazy to count)
> 

Yes, after a while I can reproduce it with both socfpga_defconfig and
multi_v7_defconfig. Just seems that the failure is easier to reproduce
with socfpga_defconfig.

Like Russell said, it seems that enabling the L2 before bringing up the
secondary CPU is triggering a bug somewhere.

I'm digging around.

Thanks,
Dinh
