From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 27 Aug 2017 12:21:52 +0200
Subject: [PATCH v2 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170827032745.GC13622@lunn.ch>
References: <20170827003328.28370-1-afaerber@suse.de>
 <20170827003328.28370-3-afaerber@suse.de> <20170827020501.GB13622@lunn.ch>
 <a2a21bc4-b7a9-cadf-920c-f078c673dbb9@suse.de>
 <20170827032745.GC13622@lunn.ch>
Message-ID: <0638c59f-9df5-32ca-31ac-a7b07ce6dad6@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

Am 27.08.2017 um 05:27 schrieb Andrew Lunn:
> On Sun, Aug 27, 2017 at 04:30:08AM +0200, Andreas F?rber wrote:
>> Am 27.08.2017 um 04:05 schrieb Andrew Lunn:
>>> n Sun, Aug 27, 2017 at 02:33:27AM +0200, Andreas F?rber wrote:
>>>> +struct rtd119x_rtc {
>>>> +	void __iomem *base;
>>>> +	struct clk *clk;
>>>> +	struct rtc_device *rtcdev;
>>>> +	unsigned base_year;
>>>> +	spinlock_t lock;
>>>
>>> Where is this lock initialised? I would expect a call to
>>> spin_lock_init() somewhere.
>>
>> Hm, the spinlock in my irq mux series doesn't have that call either; my
>> reset driver did have it. The zero initialization appears to work OK,
>> but you're probably right that it should be there.
> 
> Hi Andreas
> 
> I suspect you will have problems if you enable spin lock debug code,
> like CONFIG_DEBUG_SPINLOCK.

Thanks for that hint. Surprisingly the irq mux is still fine with that
option enabled, but the rtc now shows:

[    1.193722] BUG: spinlock bad magic on CPU#0, swapper/0/1
[    1.199264]  lock: 0xffff80007bd40db8, .magic: 00000000, .owner:
<none>/-1, .owner_cpu: 0
[    1.207648] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.13.0-rc6-next-20170825-00061-g88513c6f5687 #180
[    1.217269] Hardware name: Zidoo X9S (DT)
[    1.221378] Call trace:
[    1.223900] [<ffff0000082878f4>] dump_backtrace+0x0/0x320
[    1.229439] [<ffff000008287c28>] show_stack+0x14/0x1c
[    1.234622] [<ffff00000875c6ac>] dump_stack+0x94/0xbc
[    1.239804] [<ffff0000082eba4c>] spin_bug+0x84/0xa4
[    1.244806] [<ffff0000082ebaf8>] do_raw_spin_lock+0x30/0xd4
[    1.250522] [<ffff000008770868>] _raw_spin_lock_irqsave+0x28/0x38
[    1.256772] [<ffff00000864cc14>] rtd119x_rtc_read_time+0x24/0x14c
[    1.263019] [<ffff00000864918c>] __rtc_read_time+0x3c/0x64
[    1.268644] [<ffff0000086491e8>] rtc_read_time+0x34/0x5c
[    1.274091] [<ffff000008649cc8>] __rtc_read_alarm+0x24/0x2f0
[    1.279893] [<ffff000008648b3c>] rtc_device_register+0xa0/0x144
[    1.285962] [<ffff000008648d88>] devm_rtc_device_register+0x5c/0xa4
[    1.292390] [<ffff00000864d038>] rtd119x_rtc_probe+0x174/0x1b4
[    1.298373] [<ffff000008555038>] platform_drv_probe+0x54/0xa8
[    1.304265] [<ffff0000085537dc>] driver_probe_device+0x1fc/0x2b8
[    1.310423] [<ffff00000855390c>] __driver_attach+0x74/0xa4
[    1.316051] [<ffff000008551d58>] bus_for_each_dev+0x80/0x90
[    1.321765] [<ffff000008553198>] driver_attach+0x20/0x28
[    1.327211] [<ffff000008552d8c>] bus_add_driver+0x194/0x1e0
[    1.332925] [<ffff000008554234>] driver_register+0x98/0xd0
[    1.338550] [<ffff000008554f90>] __platform_driver_register+0x48/0x50
[    1.345155] [<ffff0000089924f0>] rtd119x_rtc_driver_init+0x18/0x20
[    1.351493] [<ffff000008283284>] do_one_initcall+0x118/0x13c
[    1.357299] [<ffff000008970dd0>] kernel_init_freeable+0x220/0x224
[    1.363548] [<ffff00000876c128>] kernel_init+0x10/0xf8
[    1.368819] [<ffff000008284200>] ret_from_fork+0x10/0x18
[    1.375104] rtd1295-rtc 9801b600.rtc: rtc core: registered rtc as rtc0

Will fix.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
