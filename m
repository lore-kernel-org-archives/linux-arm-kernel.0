From: phil@raspberrypi.org (Phil Elwell)
Date: Tue, 5 Dec 2017 13:30:11 +0000
Subject: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
In-Reply-To: <20171205132339.behn34z6b7ci2m4j@camel2.lan>
References: <20170823135836.52fb44fc@gandalf.local.home>
 <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
 <20170823150351.606ba09f@gandalf.local.home>
 <20171205114709.f6aj6i426keq2cn5@camel2.lan>
 <20171205131416.GW10595@n2100.armlinux.org.uk>
 <20171205132339.behn34z6b7ci2m4j@camel2.lan>
Message-ID: <5b9b86cf-4b62-c984-fe52-a22df8fce33c@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/2017 13:23, Matthias Reichl wrote:
> On Tue, Dec 05, 2017 at 01:14:17PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Dec 05, 2017 at 12:47:09PM +0100, Matthias Reichl wrote:
>>> On Wed, Aug 23, 2017 at 03:03:51PM -0400, Steven Rostedt wrote:
>>>> On Wed, 23 Aug 2017 11:48:13 -0700
>>>> Kees Cook <keescook@chromium.org> wrote:
>>>>
>>>>>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>>>>>> index ad80548..fd75f38 100644
>>>>>> --- a/arch/arm/mm/init.c
>>>>>> +++ b/arch/arm/mm/init.c
>>>>>> @@ -745,19 +745,29 @@ static int __mark_rodata_ro(void *unused)
>>>>>>         return 0;
>>>>>>  }
>>>>>>
>>>>>> +static int kernel_set_to_readonly;  
>>>>>
>>>>> Adding a comment here might be a good idea, something like:
>>>>>
>>>>> /* Has system boot-up reached mark_rodata_ro() yet? */
>>>>
>>>> I don't mind adding a comment, but the above is rather self explanatory
>>>> (one can easily see that it is set in mark_rodata_ro() with a simple
>>>> search).
>>>>
>>>> If a comment is to be added, something a bit more descriptive of the
>>>> functionality of the variable would be appropriate:
>>>>
>>>> /*
>>>>  * Ignore modifying kernel text permissions until the kernel core calls
>>>>  * make_rodata_ro() at system start up.
>>>>  */
>>>>
>>>> I can resend with the comment, or whoever takes this could add it
>>>> themselves.
>>>
>>> Gentle ping: this patch doesn't seem to have landed in upstream
>>> trees yet. Is any more work required?
>>>
>>> It would be nice to have this fix added. Just tested next-20171205
>>> on RPi B+, it oopses when the function tracer is enabled during boot.
>>> next-20171205 plus this patch boots up fine.
>>
>> When does it oops?
> 
> Rather early in the boot process:
> 
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 4.15.0-rc2-next-20171205 (hias at camel2) (gcc version 4.9.3 (crosstool-NG crosstool-ng-1.22.0-88-g8460611)) #3 Tue Dec 5 12:35:08 CET 2017
> [    0.000000] CPU: ARMv6-compatible processor [410fb767] revision 7 (ARMv7), cr=00c5387d
> [    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT nonaliasing instruction cache
> [    0.000000] OF: fdt: Machine model: Raspberry Pi Model B Plus Rev 1.2
> [    0.000000] earlycon: pl11 at MMIO32 0x20201000 (options '')
> [    0.000000] bootconsole [pl11] enabled
> [    0.000000] Memory policy: Data cache writeback
> [    0.000000] cma: Reserved 32 MiB at 0x13c00000
> [    0.000000] CPU: All CPU(s) started in SVC mode.
> [    0.000000] random: fast init done
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 89408
> [    0.000000] Kernel command line: bcm2708_fb.fbwidth=1280 bcm2708_fb.fbheight=1024 bcm2708_fb.fbswap=1 dma.dmachans=0x7f35 bcm2708.boardrev=0x10 bcm2708.serial=0x59ce1e57 bcm2708.uart_clock=48000000 bcm2708.disk_led_gpio=47 bcm2708.disk_led_active_low=0 smsc95xx.macaddr=B8:27:EB:CE:1E:57 vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000  root=/dev/mmcblk0p2 rw rootwait elevator=noop earlycon=pl011,mmio32,0x20201000 console=/dev/ttyAMA0,115200 ftrace=function
> [    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
> [    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
> [    0.000000] Memory: 311776K/360448K available (7168K kernel code, 561K rwdata, 2212K rodata, 1024K init, 683K bss, 15904K reserved, 32768K cma-reserved)
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
> [    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
> [    0.000000]     vmalloc : 0xd6800000 - 0xff800000   ( 656 MB)
> [    0.000000]     lowmem  : 0xc0000000 - 0xd6000000   ( 352 MB)
> [    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
> [    0.000000]       .text : 0x(ptrval) - 0x(ptrval)   (8160 kB)
> [    0.000000]       .init : 0x(ptrval) - 0x(ptrval)   (1024 kB)
> [    0.000000]       .data : 0x(ptrval) - 0x(ptrval)   ( 562 kB)
> [    0.000000]        .bss : 0x(ptrval) - 0x(ptrval)   ( 684 kB)
> [    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
> [    0.000000] ftrace: allocating 25789 entries in 76 pages
> [    0.000000] Starting tracer 'function'
> [    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
> [    0.000052] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 2147483647500ns
> [    0.008889] clocksource: timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275 ns
> [    0.018979] bcm2835: system timer (irq = 27)
> [    0.028070] Console: colour dummy device 80x30
> [    0.033154] Calibrating delay loop... 697.95 BogoMIPS (lpj=3489792)
> [    0.090179] pid_max: default: 32768 minimum: 301
> [    0.097851] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.104852] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
> [    0.117353] CPU: Testing write buffer coherency: ok
> [    0.127472] Setting up static identity map for 0x100000 - 0x100054
> [    0.145654] devtmpfs: initialized
> [    0.235561] VFP support v0.3: implementor 41 architecture 1 part 20 variant b rev 5
> [    0.245751] Unable to handle kernel paging request at virtual address c09eb214
> [    0.253373] pgd = 8aaa5336
> [    0.256250] [c09eb214] *pgd=0080840e(bad)
> [    0.260567] Internal error: Oops: 80d [#1] ARM
> [    0.265073] Modules linked in:
> [    0.268188] CPU: 0 PID: 1 Comm: swapper Not tainted 4.15.0-rc2-next-20171205 #3
> [    0.275592] Hardware name: BCM2835
> [    0.279046] task: 11ad8790 task.stack: 886fda4c
> [    0.283670] PC is at ksysfs_init+0x64/0xb0
> [    0.287840] LR is at internal_create_group+0x294/0x2c4
> [    0.293049] pc : [<c0b0a33c>]    lr : [<c0292898>]    psr: 20000053
> [    0.299400] sp : d3a3ded0  ip : c028e908  fp : d3a3dee4
> [    0.304694] r10: 00000000  r9 : c0c8c500  r8 : c0c8c500
> [    0.309991] r7 : 00000000  r6 : c0c04048  r5 : c0c8d19c  r4 : 00000000
> [    0.316607] r3 : 00000024  r2 : c0abf19c  r1 : c09eb20c  r0 : d3a81d80
> [    0.323224] Flags: nzCv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment none
> [    0.330543] Control: 00c5387d  Table: 00004008  DAC: 00000051
> [    0.336367] Process swapper (pid: 1, stack limit = 0xfa32e9e1)
> [    0.342280] Stack: (0xd3a3ded0 to 0xd3a3e000)
> [    0.346703] dec0:                                     00000001 c0b0a2d8 d3a3df5c d3a3dee8
> [    0.354999] dee0: c01027b0 c0b0a2e4 c0a280c0 00000000 d3a3df5c d3a3df00 c0138578 c0b00650
> [    0.363294] df00: d3a3df00 c0c0c328 00000000 c0a280d4 0000009f c0a280d4 00000001 00000001
> [    0.371590] df20: 000000a0 c0a27454 d5fffd21 d5fffd28 c014f4c0 4710e3ed 00000001 000000a0
> [    0.379886] df40: c0b5681c c0b7cb84 c0c8c500 c0c8c500 d3a3df94 d3a3df60 c0b00ef8 c01026f8
> [    0.388180] df60: 00000001 00000001 00000000 c0b00644 00000000 c07463a4 00000000 00000000
> [    0.396475] df80: 00000000 00000000 d3a3dfac d3a3df98 c07463bc c0b00df0 ffffffff 00000000
> [    0.404769] dfa0: 00000000 d3a3dfb0 c01010e8 c07463b0 00000000 00000000 00000000 00000000
> [    0.413061] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.421354] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
> [    0.429689] [<c0b0a33c>] (ksysfs_init) from [<c01027b0>] (do_one_initcall+0xc4/0x184)
> [    0.437652] [<c01027b0>] (do_one_initcall) from [<c0b00ef8>] (kernel_init_freeable+0x114/0x1d4)
> [    0.446490] [<c0b00ef8>] (kernel_init_freeable) from [<c07463bc>] (kernel_init+0x18/0x11c)
> [    0.454887] [<c07463bc>] (kernel_init) from [<c01010e8>] (ret_from_fork+0x14/0x2c)
> [    0.462559] Exception stack(0xd3a3dfb0 to 0xd3a3dff8)
> [    0.467683] dfa0:                                     00000000 00000000 00000000 00000000
> [    0.475976] dfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
> [    0.484266] dfe0: 00000000 00000000 00000000 00000000 00000013 00000000
> [    0.490982] Code: e3a00000 e89da830 e59f1048 e5950000 (e5813008) 
> [    0.497194] ---[ end trace 53d55c7b93eb8c51 ]---
> [    0.502064] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.502064] 
> [    0.511346] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    0.511346] 
> 
> so long,
> 
> Hias
> 
>>
>> Reading through this code, I'm left wondering why we switch the rodata
>> section to be writable here - if we're poking at kernel text, then
>> surely we shouldn't be the read-only data read-write?
>>
>> Should kernel_set_to_readonly also be a rodata-after-init variable?

This was my initial explanation:

1. Data which is marked __ro_after_init is initially writeable.

2. The ro_perms data covers kernel text, read-only data and __ro_after_init data.

3. set_kernel_text_rw marks everything in ro_perms as writeable.

4. set_kernel_text_ro marks everything in ro_perms as read-only, including the __ro_after_init data.

5. Using the function tracing code involves code modification, resulting in calls to
   __ftrace_modify_code and set_kernel_text_ro.

6. Therefore if function tracing is enabled before kernel_init has completed then the __ro_after_init
   data is made read-only prematurely.

Phil
