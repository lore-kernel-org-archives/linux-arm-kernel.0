From: liu.h.jason@gmail.com (Jason Liu)
Date: Wed, 24 Aug 2011 20:30:06 +0800
Subject: [PATCH 2/3] mach-ux500: initialize l2x0 at arch_init time
In-Reply-To: <20110824121425.GA31404@pengutronix.de>
References: <1314177826-19151-1-git-send-email-linus.walleij@stericsson.com>
	<4E54CAE8.1060702@ti.com>
	<CAH9JG2W+KkTZJ67eDqju3jQfc8OZhf0gBzKvhSodpOQS=-q2kQ@mail.gmail.com>
	<CACRpkdZWwwapspVFrZNC8ReURrKVYFUDzdmEL7HiZWOjZ907jQ@mail.gmail.com>
	<20110824121425.GA31404@pengutronix.de>
Message-ID: <CAB4PhKfvZCj6g2yJEo0k_RDtRuQD8eWN5Pr55ubnmyqpg2-P-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, Sascha,

2011/8/24 Sascha Hauer <s.hauer@pengutronix.de>:
> Hi Linus,
>
> On Wed, Aug 24, 2011 at 01:59:40PM +0200, Linus Walleij wrote:
>> On Wed, Aug 24, 2011 at 12:12 PM, Kyungmin Park <kmpark@infradead.org> wrote:
>> > On Wed, Aug 24, 2011 at 6:56 PM, Santosh <santosh.shilimkar@ti.com> wrote:
>> >> On Wednesday 24 August 2011 02:53 PM, Linus Walleij wrote:
>> >>
>> >> More and more you delay L2 cache enable in boot-process,
>> >> your boot-up time is going to shoot-up.
>> >>
>> >> Have you thought about it. Cache's should be enabled as
>> >> early as possible.
>> >
>> > Right, after change from early_init to arch_init. it takes more time.
>>
>> Hm no good. I'll drop this.
>>
>> We've seen that if we try to unlock the I&D l2x0 at the
>> early_initcall() as in [3/3] it will sometimes fail, like it's
>> still locked down afterwards. Calling it from .init_machine()
>> appears to work. So in my dumbness I moved it to
>> arch_initcall() which should be equivalent. Does anyone
>> have some subtle hint or experience on how to get around
>> that one issue, or should I just put in a second
>> arch_initcall() for just the unlocking?
>>
>> Sascha, I guess Freescale should also move the l2x0 init to
>> early_init() in mach-imx/cache-l2x0.c if possible. Can
>> you try the below on your machine(s)?
>
> Sure, what are you interested in? If it works reliably or if works
> faster?

I have tested, it works reliably by change to +early_initcall(mxc_init_l2x0);
on mx31pdk board.

And it's a little bit faster,

Before: arch_initcall(mxc_init_l2x0);

[    0.000000] Linux version 3.1.0-rc3-00006-gaa94168-dirty
(r64343 at r64343-desktop) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1
-203) ) #6 PREEMPT Wed Aug 24 20:27:59 CST 2011
[    0.000000] CPU: ARMv6-compatible processor [4107b364] revision 4
(ARMv6TEJ), cr=00c5387f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] Machine: Freescale MX31PDK (3DS)
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 30464
[    0.000000] Kernel command line: noinitrd console=ttymxc0,115200
root=/dev/mtdblock2 rw ip=off
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 120MB = 120MB total
[    0.000000] Memory: 117708k/117708k available, 13364k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xff600000 - 0xffe00000   (   8 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf4000000   ( 696 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc038e724   (3610 kB)
[    0.000000]       .init : 0xc038f000 - 0xc03ad000   ( 120 kB)
[    0.000000]       .data : 0xc03ae000 - 0xc03d77a0   ( 166 kB)
[    0.000000]        .bss : 0xc03d77c4 - 0xc03e9498   (  72 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:404
[    0.000000] MXC IRQ initialized
[    0.000000] Clock input source is 26000000
[    0.000000] CPU identified as i.MX31, silicon rev 2.8
[    0.000000] sched_clock: 32 bits at 66MHz, resolution 15ns, wraps
every 64585ms
[    0.000244] Calibrating delay loop... 531.66 BogoMIPS (lpj=2658304)
[    0.050233] pid_max: default: 32768 minimum: 301
[    0.050778] Mount-cache hash table entries: 512
[    0.051712] CPU: Testing write buffer coherency: ok
[    0.055422] print_constraints: dummy:
[    0.055827] NET: Registered protocol family 16
[    0.059721] 3-Stack Debug board detected, rev = 0x0200
[    0.061429] L210 cache controller enabled
[    0.061462] l2x0: 8 ways, CACHE_ID 0x41000040, AUX_CTRL 0x00030024,
Cache size: 131072 B
[    0.065331] bio: create slab <bio-0> at 0
[    0.071137] Switching to clocksource mxc_timer1
[    0.072724] NET: Registered protocol family 2
[    0.073146] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.074338] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.074492] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.074593] TCP: Hash tables configured (established 4096 bind 4096)
[    0.074612] TCP reno registered
[    0.074633] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.074673] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.075086] NET: Registered protocol family 1
[    0.075806] RPC: Registered named UNIX socket transport module.
[    0.075832] RPC: Registered udp transport module.
[    0.075848] RPC: Registered tcp transport module.
[    0.075864] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.080406] Switched to NOHz mode on CPU #0
[    0.082045] JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.082709] msgmni has been set to 229
[    0.082948] io scheduler noop registered
[    0.082968] io scheduler deadline registered
[    0.083108] io scheduler cfq registered (default)
[    0.211233] mx3_sdc_fb mx3_sdc_fb: registered, using mode Epson-VGA
[    0.212623] Serial: IMX driver
[    0.212815] imx21-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
[    0.558755] console [ttymxc0] enabled

...

After: early_initcall(mxc_init_l2x0);

[    0.000000] Linux version 3.1.0-rc3-00006-gaa94168-dirty
(r64343 at r64343-desktop) (gcc version 4.3.3 (Sourcery G++ Lite 2009q1
-203) ) #5 PREEMPT Wed Aug 24 20:26:24 CST 2011
[    0.000000] CPU: ARMv6-compatible processor [4107b364] revision 4
(ARMv6TEJ), cr=00c5387f
[    0.000000] CPU: VIPT nonaliasing data cache, VIPT nonaliasing
instruction cache
[    0.000000] Machine: Freescale MX31PDK (3DS)
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 30464
[    0.000000] Kernel command line: noinitrd console=ttymxc0,115200
root=/dev/mtdblock2 rw ip=off
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 120MB = 120MB total
[    0.000000] Memory: 117708k/117708k available, 13364k reserved, 0K highmem
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     DMA     : 0xff600000 - 0xffe00000   (   8 MB)
[    0.000000]     vmalloc : 0xc8800000 - 0xf4000000   ( 696 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc038e724   (3610 kB)
[    0.000000]       .init : 0xc038f000 - 0xc03ad000   ( 120 kB)
[    0.000000]       .data : 0xc03ae000 - 0xc03d77a0   ( 166 kB)
[    0.000000]        .bss : 0xc03d77c4 - 0xc03e9498   (  72 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] NR_IRQS:404
[    0.000000] MXC IRQ initialized
[    0.000000] Clock input source is 26000000
[    0.000000] CPU identified as i.MX31, silicon rev 2.8
[    0.000000] sched_clock: 32 bits at 66MHz, resolution 15ns, wraps
every 64585ms
[    0.000244] Calibrating delay loop... 531.66 BogoMIPS (lpj=2658304)
[    0.050233] pid_max: default: 32768 minimum: 301
[    0.050782] Mount-cache hash table entries: 512
[    0.051715] CPU: Testing write buffer coherency: ok
[    0.052159] L210 cache controller enabled
[    0.052195] l2x0: 8 ways, CACHE_ID 0x41000040, AUX_CTRL 0x00030024,
Cache size: 131072 B
[    0.054546] print_constraints: dummy:
[    0.054810] NET: Registered protocol family 16
[    0.057539] 3-Stack Debug board detected, rev = 0x0200
[    0.062335] bio: create slab <bio-0> at 0
[    0.068090] Switching to clocksource mxc_timer1
[    0.069667] NET: Registered protocol family 2
[    0.070093] IP route cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.070262] Switched to NOHz mode on CPU #0
[    0.071452] TCP established hash table entries: 4096 (order: 3, 32768 bytes)
[    0.071608] TCP bind hash table entries: 4096 (order: 2, 16384 bytes)
[    0.071708] TCP: Hash tables configured (established 4096 bind 4096)
[    0.071728] TCP reno registered
[    0.071749] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.071789] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.072201] NET: Registered protocol family 1
[    0.072924] RPC: Registered named UNIX socket transport module.
[    0.072949] RPC: Registered udp transport module.
[    0.072965] RPC: Registered tcp transport module.
[    0.072981] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.079071] JFFS2 version 2.2. (NAND) ?? 2001-2006 Red Hat, Inc.
[    0.079742] msgmni has been set to 229
[    0.079982] io scheduler noop registered
[    0.080001] io scheduler deadline registered
[    0.080139] io scheduler cfq registered (default)
[    0.208186] mx3_sdc_fb mx3_sdc_fb: registered, using mode Epson-VGA
[    0.209581] Serial: IMX driver
[    0.209770] imx21-uart.0: ttymxc0 at MMIO 0x43f90000 (irq = 45) is a IMX
[    0.555716] console [ttymxc0] enabled
...

Jason

>
> Sascha
>
>>
>> diff --git a/arch/arm/mach-imx/cache-l2x0.c b/arch/arm/mach-imx/cache-l2x0.c
>> index 69d1322..e5538a4 100644
>> --- a/arch/arm/mach-imx/cache-l2x0.c
>> +++ b/arch/arm/mach-imx/cache-l2x0.c
>> @@ -53,4 +53,4 @@ static int mxc_init_l2x0(void)
>>
>> ? ? ? ? return 0;
>> ?}
>> -arch_initcall(mxc_init_l2x0);
>> +early_initcall(mxc_init_l2x0);
>>
>> Yours,
>> Linus Walleij
>>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
