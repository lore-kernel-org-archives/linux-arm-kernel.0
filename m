From: HenryC.Chen@mediatek.com (Henry Chen)
Date: Tue, 21 Jul 2015 14:07:25 +0800
Subject: [PATCH] regmap: Add function check before called format_val
In-Reply-To: <20150720150254.GC11162@sirena.org.uk>
References: <1437396110-5192-1-git-send-email-henryc.chen@mediatek.com>
 <20150720150254.GC11162@sirena.org.uk>
Message-ID: <1437458845.30329.51.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-07-20 at 16:02 +0100, Mark Brown wrote:
> On Mon, Jul 20, 2015 at 08:41:50PM +0800, Henry Chen wrote:
> > The regmap_format will not be initialize since regmap_bus is not assgined 
> > on regmap_init(). It should has a function check before using 
> > format_val() to avoid null function called on regmap_bulk_read().
> 
> > -			map->format.format_val(val + (i * val_bytes), ival, 0);
> > +			if (map->format.format_val)
> > +				map->format.format_val(val + (i * val_bytes), ival, 0);
> > +			else
> > +				memcpy(val + (i * val_bytes), &ival, val_bytes);
> 
> Your changelog doesn't explan why we are in this code path in the first
> place without a format_val() and why a memcpy() is an appropriate
> replacement.  It should, it's not clear to me that this is a good fix
> but I don't feel I fully understand the problem.

Sorry for being unclear for issue, the call flow as following,

First, in drivers/mfd/mtk_pmic_wrap.c which registered regmap without
rebmap_bus.
devm_regmap_init(wrp->dev, NULL, wrp, &pwrap_regmap_config);

It call to regmap_init() and go to "skip_format_initialization" because
regmap_bus didn't assign by driver.

if (!bus) {
	map->reg_read  = config->reg_read;
	map->reg_write = config->reg_write;

	map->defer_caching = false;
	goto skip_format_initialization;" 

Then in driver rtc-mt6397.c, it used regmap_bulk_read() to get the time
of PMIC, and hit the null function of format_val(), because the
regmap_bus was null.

It skipped the initialization of format_val() because bus == null, but
called the format_val() at regmap_bulk_read() if bus == null.

Maybe it was not the good fix for this, but should be a problem need to
be reported, or should I need to give the regmap_bus on mtk_pmic_wrap.c?

I tested this on mediatek mt8173 evb platform.
Please see the error below, thanks.

Bad mode in Synchronous Abort handler detected, code 0x86000005 -- IABT
(current EL)
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc1+ #25
Hardware name: MediaTek MT8173 evaluation board (DT)
task: ffffffc077090000 ti: ffffffc07705c000 task.ti: ffffffc07705c000
PC is at 0x0
LR is at regmap_bulk_read+0x104/0x1c4
pc : [<0000000000000000>] lr : [<ffffffc00040efec>] pstate: 20000045
sp : ffffffc07705fa00
x29: ffffffc07705fa00 x28: ffffffc0008ac970
x27: ffffffc0009530f8 x26: 0000000000000001
x25: 0000000000000001 x24: 000000000000e00a
x23: ffffffc07705faa0 x22: 0000000000000002
x21: 0000000000000007 x20: ffffffc075ca8800
x19: 0000000000000001 x18: 0000000000000000
x17: 0000000000000001 x16: 0000000000000016
x15: 0000000000000cb0 x14: 0ffffffffffffffe
x13: 0000000000000010 x12: 0000000000000001
x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
x9 : 6a6473606863646c x8 : 00000000ffffffd0
x7 : 0000000000000000 x6 : 0000000000000000
x5 : 00000000ffffffff x4 : 0000000000000000
x3 : 0000000000000000 x2 : 0000000000000000
x1 : 000000000000001c x0 : ffffffc07705faa0

Internal error: Oops - bad mode: 0 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.2.0-rc1+ #25
Hardware name: MediaTek MT8173 evaluation board (DT)
task: ffffffc077090000 ti: ffffffc07705c000 task.ti: ffffffc07705c000
PC is at 0x0
LR is at regmap_bulk_read+0x104/0x1c4
pc : [<0000000000000000>] lr : [<ffffffc00040efec>] pstate: 20000045
sp : ffffffc07705fa00
x29: ffffffc07705fa00 x28: ffffffc0008ac970
x27: ffffffc0009530f8 x26: 0000000000000001
x25: 0000000000000001 x24: 000000000000e00a
x23: ffffffc07705faa0 x22: 0000000000000002
x21: 0000000000000007 x20: ffffffc075ca8800
x19: 0000000000000001 x18: 0000000000000000
x17: 0000000000000001 x16: 0000000000000016
x15: 0000000000000cb0 x14: 0ffffffffffffffe
x13: 0000000000000010 x12: 0000000000000001
x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
x9 : 6a6473606863646c x8 : 00000000ffffffd0
x7 : 0000000000000000 x6 : 0000000000000000
x5 : 00000000ffffffff x4 : 0000000000000000
x3 : 0000000000000000 x2 : 0000000000000000
x1 : 000000000000001c x0 : ffffffc07705faa0

Process swapper/0 (pid: 1, stack limit = 0xffffffc07705c020)
Stack: (0xffffffc07705fa00 to 0xffffffc077060000)
fa00: 7705fa60 ffffffc0 004cbde4 ffffffc0 7705fb40 ffffffc0 762ead98
ffffffc0
fa20: 7705fb40 ffffffc0 762eada8 ffffffc0 7705fbf8 ffffffc0 007ca368
ffffffc0
fa40: 00908810 ffffffc0 004cbdcc ffffffc0 7705fb40 ffffffc0 0033a998
0000001c
fa60: 7705fab0 ffffffc0 004c962c ffffffc0 7705fb40 ffffffc0 75c5aac8
ffffffc0
fa80: 7705fb40 ffffffc0 75c5aaac ffffffc0 75c5a810 ffffffc0 762ec800
ffffffc0
faa0: 00000000 00000000 75c5aaac ffffffc0 7705fad0 ffffffc0 004c969c
ffffffc0
fac0: 75c5a800 ffffffc0 004c9688 ffffffc0 7705fb00 ffffffc0 004c9e78
ffffffc0
fae0: 75c5a800 ffffffc0 75ccf010 ffffffc0 75c5a800 ffffffc0 7705fb90
ffffffc0
fb00: 7705fb90 ffffffc0 004c8d40 ffffffc0 75c5a800 ffffffc0 75ccf010
ffffffc0
fb20: 00000000 00000000 75c5aaac ffffffc0 00953000 ffffffc0 007ca368
ffffffc0
fb40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
fb60: 00000000 00000000 00006374 00000000 ffffffff ffffffff 80800000
80808080
fb80: 75c5aab6 ffffffc0 feff6273 fefefefe 7705fc20 ffffffc0 004cbf74
ffffffc0
fba0: 762ead98 ffffffc0 75ccf010 ffffffc0 00000000 00000000 007ca368
ffffffc0
fbc0: 008f9000 ffffffc0 00000000 00000000 00842264 ffffffc0 008766b0
ffffffc0
fbe0: 008766e0 ffffffc0 75ccf010 ffffffc0 75ccf000 ffffffc0 007ca368
ffffffc0
fc00: 008f9000 ffffffc0 00000000 00000000 00842264 ffffffc0 008766b0
ffffffc0
fc20: 7705fc50 ffffffc0 003fb5e4 ffffffc0 75ccf010 ffffffc0 00908760
ffffffc0
fc40: 00908788 ffffffc0 00950000 ffffffc0 7705fc80 ffffffc0 003f99e4
ffffffc0
fc60: 75ccf010 ffffffc0 00000000 00000000 00908788 ffffffc0 00950000
ffffffc0
fc80: 7705fcc0 ffffffc0 003f9b90 ffffffc0 75ccf010 ffffffc0 00908788
ffffffc0
fca0: 75ccf070 ffffffc0 008f9ac0 ffffffc0 008f9000 ffffffc0 00876740
ffffffc0
fcc0: 7705fcf0 ffffffc0 003f7ce4 ffffffc0 00000000 00000000 00908788
ffffffc0
fce0: 003f9af4 ffffffc0 00876740 ffffffc0 7705fd30 ffffffc0 003f94cc
ffffffc0
fd00: 00908788 ffffffc0 76a3e3c0 ffffffc0 00000000 00000000 005f2380
ffffffc0
fd20: 77005ea8 ffffffc0 7725ade8 ffffffc0 7705fd40 ffffffc0 003f9168
ffffffc0
fd40: 7705fd80 ffffffc0 003fa460 ffffffc0 00908788 ffffffc0 008c8a60
ffffffc0
fd60: 00000000 00000000 00863990 ffffffc0 00000000 00000000 ffffffd0
00000000
fd80: 7705fdb0 ffffffc0 003fb518 ffffffc0 008c8a60 ffffffc0 008c8a60
ffffffc0
fda0: 762ec4c0 ffffffc0 00863990 ffffffc0 7705fdc0 ffffffc0 008639a8
ffffffc0
fdc0: 7705fdd0 ffffffc0 00082868 ffffffc0 7705fe50 ffffffc0 00842b14
ffffffc0
fde0: 000000bd 00000000 00930000 ffffffc0 008393d8 ffffffc0 00000006
00000000
fe00: 00930000 ffffffc0 008766b0 ffffffc0 00876600 ffffffc0 00000030
00000000
fe20: 7705fe30 ffffffc0 00793498 ffffffc0 00792d88 ffffffc0 00000006
00000006
fe40: 00000000 00000000 7e9fdbac ffffffc0 7705feb0 ffffffc0 005f43e0
ffffffc0
fe60: 005f43d0 ffffffc0 00000000 00000000 00000000 00000000 00000000
00000000
fe80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
fea0: 00000000 00000000 00000000 00000000 00000000 00000000 00085c10
ffffffc0
fec0: 005f43d0 ffffffc0 00000000 00000000 00000000 00000000 00000000
00000000
fee0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ff00: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ff20: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ff40: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ff60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ff80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ffa0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000005
00000000
ffe0: 00000000 00000000 00000000 00000000 0c2ae48d c2569cad c4144163
8cef60fe
Call trace:
[<          (null)>]           (null)
[<ffffffc0004cbde0>] mtk_rtc_read_time+0x9c/0x134
[<ffffffc0004c9628>] __rtc_read_time.isra.3+0x40/0x7c
[<ffffffc0004c9698>] rtc_read_time+0x34/0x58
[<ffffffc0004c9e74>] __rtc_read_alarm+0x20/0x37c
[<ffffffc0004c8d3c>] rtc_device_register+0x194/0x2e0
[<ffffffc0004cbf70>] mtk_rtc_probe+0xf8/0x18c
[<ffffffc0003fb5e0>] platform_drv_probe+0x48/0xc4
[<ffffffc0003f99e0>] driver_probe_device+0x188/0x29c
[<ffffffc0003f9b8c>] __driver_attach+0x98/0xa0
[<ffffffc0003f7ce0>] bus_for_each_dev+0x54/0x98
[<ffffffc0003f94c8>] driver_attach+0x1c/0x28
[<ffffffc0003f9164>] bus_add_driver+0x1c0/0x228
[<ffffffc0003fa45c>] driver_register+0x64/0x130
[<ffffffc0003fb514>] __platform_driver_register+0x5c/0x68
[<ffffffc0008639a4>] mtk_rtc_driver_init+0x14/0x20
[<ffffffc000082864>] do_one_initcall+0x88/0x1ac
[<ffffffc000842b10>] kernel_init_freeable+0x158/0x1fc
[<ffffffc0005f43dc>] kernel_init+0xc/0xd8
