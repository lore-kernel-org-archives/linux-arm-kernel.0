From: tremyfr@yahoo.fr (trem)
Date: Tue, 13 Nov 2012 21:43:20 +0100
Subject: usb clock not found on imx27 when using dt
In-Reply-To: <20121113073812.GZ10369@pengutronix.de>
References: <1352666074.32152.YahooMailNeo@web28806.mail.ir2.yahoo.com>
 <20121112075411.GO10369@pengutronix.de> <50A15966.8040204@yahoo.fr>
 <20121113073812.GZ10369@pengutronix.de>
Message-ID: <50A2B0E8.2040603@yahoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/11/12 08:38, s.hauer at pengutronix.de wrote:
>>> Please investigate in using the chipidea driver. This will be the way
>>> forward for i.MX.
>>
>> I use the chipidea driver for the usb.
>>
>> The main issue is that the chipidea driver don't found the clock :
>>
>> [    0.761693] imx_usb mxc-ehci.0: Failed to get clock, err=-2
>> [    0.767620] imx_usb: probe of mxc-ehci.0 failed with error -2
>>
>> The driver ci13xxx_imx request the clock in the probe function
>> in the following line:
>> data->clk = devm_clk_get(&pdev->dev, NULL);
>> calling: clk = clk_get(dev, id);
>> calling: clk_get_sys(dev_id, con_id);
>> calling: clk_find(dev_id, con_id);
>> with dev_id = mxc-ehci.0 and con_id = NULL
>> This last function fail to found a clock.
>>
>> In the function mx27_clocks_init, several mxc-ehci.0
>> clocks are registered, but all with a con_id.
>>
>> So the function clk_find fails.
>>
>> As I'm not really sure of the dts, I don't know if the problem
>> is in the dts or in the driver (maybe both).
>
> You have to register the lookups for the chipidea driver with
> clk_register_clkdev(). The lookups are only what the name suggests:
> lookups. They are no clocks by themselves. This means that you have to
> add another lookup which matches the device name.

Thanks for this help, I've added three "clocks" for the chipidea driver :
clk_register_clkdev(clk[usb_div], NULL, "mxc-ehci.0");

And I don't have the missing clock issue, but a kernel panic :

[    0.679565] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.687807] usbcore: registered new interface driver cdc_acm
[    0.693503] cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
[    0.702506] usbcore: registered new interface driver usblp
[    0.708292] Initializing USB Mass Storage driver...
[    0.713885] usbcore: registered new interface driver usb-storage
[    0.720190] USB Mass Storage support registered.
[    0.726361] usbcore: registered new interface driver usbserial
[    0.732984] usbcore: registered new interface driver ftdi_sio
[    0.739510] usbserial: USB Serial support registered for FTDI USB Serial Device
[    0.747708] usbcore: registered new interface driver pl2303
[    0.754044] usbserial: USB Serial support registered for pl2303
[    0.762611] Unhandled fault: external abort on non-linefetch (0x008) at 0xf4424100
[    0.770227] Internal error: : 8 [#1] PREEMPT ARM
[    0.774861] Modules linked in:
[    0.777950] CPU: 0    Not tainted  (3.7.0-rc5-ge917a67 #2)
[    0.783469] PC is at ci_hdrc_probe+0xcc/0x430
[    0.787853] LR is at devm_kzalloc+0x4c/0x64
[    0.792058] pc : [<c03da658>]    lr : [<c023ffa8>]    psr: 60000013
[    0.792058] sp : d3833d98  ip : 40000013  fp : 00000000
[    0.803550] r10: c054db14  r9 : 00000000  r8 : f4424100
[    0.808788] r7 : d398c4e0  r6 : d39b1180  r5 : d39b1190  r4 : d3901010
[    0.815329] r3 : 00000100  r2 : 00000000  r1 : d3901010  r0 : d3901010
[    0.821871] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.829194] Control: 0005317f  Table: a0004000  DAC: 00000017
[    0.834954] Process swapper (pid: 1, stack limit = 0xd38321b8)
[    0.840799] Stack: (0xd3833d98 to 0xd3834000)
[    0.845174] 3d80:                                                       d39b1198 00000000
[    0.853384] 3da0: d39b1190 c055ea90 d39b1190 c0545010 c055ea6c c023e574 d39b1190 c023d288
[    0.861592] 3dc0: d39b1190 d3833dd8 c023d4a4 00000000 c055ea6c c023bb68 d380755c d39cdb74
[    0.869798] 3de0: d39cda50 d39b11c4 d39b1190 d39b1190 00000000 c023d588 d39b1190 c05367b0
[    0.878004] 3e00: d39b1190 c023c6a8 d39b1190 d38c99b0 d39b1198 c023b4d0 00000021 00000000
[    0.886210] 3e20: 00000002 c01e9aac d39b1180 d39b1190 d3832000 d39b1180 d39b1190 00000002
[    0.894416] 3e40: d38573a0 00000002 d3832000 c054db14 00000000 c023eb6c d39b1180 00000000
[    0.902622] 3e60: 00000000 d38573a0 00000002 c02b4cb0 ffffffff 00000000 d398c530 d38c99b0
[    0.910828] 3e80: d38c99a0 d398c530 00000000 00000000 ffffffff c03dac80 d38c99b0 c055ea90
[    0.919035] 3ea0: d38c99b0 c0545184 c050a32c 0000007a c051c8b8 c023e574 d38c99b0 c023d288
[    0.927241] 3ec0: d38c99b0 c0545184 d38c99e4 00000000 c050a32c c023d4a0 c0545184 d3833ee8
[    0.935448] 3ee0: c023d414 c023bbf4 d380754c d38c8d50 c0545184 c0545184 c05367b0 d39cda80
[    0.943654] 3f00: 00000000 c023c380 c04a6948 d3832000 c0545184 d3832000 c0545184 c054dc00
[    0.951860] 3f20: 00000000 c023da70 d3832000 00000007 c054dc00 00000000 c050a32c c00087ec
[    0.960065] 3f40: c04a70ec c04db800 00000006 00000006 00000000 c05147fc 00000006 c05147fc
[    0.968269] 3f60: 00000007 c054dc00 c0514808 c04f71ac 0000007a c03d7404 00000006 00000006
[    0.976475] 3f80: c04f71ac 01234567 d3832000 00000000 c03d7314 00000000 00000000 00000000
[    0.984678] 3fa0: 00000000 00000000 00000000 c0014730 00000000 00000000 00000000 00000000
[    0.992881] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    1.001084] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00008000
[    1.009335] [<c03da658>] (ci_hdrc_probe+0xcc/0x430) from [<c023e574>] (platform_drv_probe+0x14/0x18)
[    1.018523] [<c023e574>] (platform_drv_probe+0x14/0x18) from [<c023d288>] (driver_probe_device+0x80/0x20c)
[    1.028221] [<c023d288>] (driver_probe_device+0x80/0x20c) from [<c023bb68>] (bus_for_each_drv+0x64/0x8c)
[    1.037746] [<c023bb68>] (bus_for_each_drv+0x64/0x8c) from [<c023d588>] (device_attach+0x80/0x98)
[    1.046660] [<c023d588>] (device_attach+0x80/0x98) from [<c023c6a8>] (bus_probe_device+0x84/0xac)
[    1.055570] [<c023c6a8>] (bus_probe_device+0x84/0xac) from [<c023b4d0>] (device_add+0x534/0x604)
[    1.064392] [<c023b4d0>] (device_add+0x534/0x604) from [<c023eb6c>] (platform_device_add+0x134/0x20c)
[    1.073667] [<c023eb6c>] (platform_device_add+0x134/0x20c) from [<c02b4cb0>] (ci13xxx_add_device+0xd8/0x110)
[    1.083543] [<c02b4cb0>] (ci13xxx_add_device+0xd8/0x110) from [<c03dac80>] (ci13xxx_imx_probe+0x250/0x304)
[    1.093246] [<c03dac80>] (ci13xxx_imx_probe+0x250/0x304) from [<c023e574>] (platform_drv_probe+0x14/0x18)
[    1.102860] [<c023e574>] (platform_drv_probe+0x14/0x18) from [<c023d288>] (driver_probe_device+0x80/0x20c)
[    1.112557] [<c023d288>] (driver_probe_device+0x80/0x20c) from [<c023d4a0>] (__driver_attach+0x8c/0x90)
[    1.121991] [<c023d4a0>] (__driver_attach+0x8c/0x90) from [<c023bbf4>] (bus_for_each_dev+0x64/0x8c)
[    1.131077] [<c023bbf4>] (bus_for_each_dev+0x64/0x8c) from [<c023c380>] (bus_add_driver+0xa0/0x22c)
[    1.140167] [<c023c380>] (bus_add_driver+0xa0/0x22c) from [<c023da70>] (driver_register+0x78/0x140)
[    1.149253] [<c023da70>] (driver_register+0x78/0x140) from [<c00087ec>] (do_one_initcall+0x30/0x178)
[    1.158438] [<c00087ec>] (do_one_initcall+0x30/0x178) from [<c03d7404>] (kernel_init+0xf0/0x294)
[    1.167277] [<c03d7404>] (kernel_init+0xf0/0x294) from [<c0014730>] (ret_from_fork+0x14/0x24)
[    1.175833] Code: e584800c e5933004 e0888003 e5848010 (e5d83000)
[    1.182012] ---[ end trace f1f4ba6255ab3146 ]---
[    1.187015] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b


Regards,
Philippe
