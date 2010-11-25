From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 25 Nov 2010 13:29:30 +0100
Subject: [PATCH] imx: dma: remove SDMA_IS_MERGED
In-Reply-To: <AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
	(Fabio Estevam's message of "Thu, 25 Nov 2010 10:09:58 -0200")
References: <1290626971-14863-1-git-send-email-fabio.estevam@freescale.com>
	<20101124194439.GY4693@pengutronix.de>
	<AANLkTingtkuvLE9TMxM5f=uwgK95Wfw8kPyXa_NxekEZ@mail.gmail.com>
	<20101124201831.GZ4693@pengutronix.de>
	<AANLkTi=BXLAOVxTbUerDVisHy9FHFV-YcXu1LN9GHN_h@mail.gmail.com>
	<20101125091346.GS6017@pengutronix.de>
	<AANLkTi=L_5ib-Kj0fZRci7-bPOpkyojejZ9+jZpmH9aC@mail.gmail.com>
Message-ID: <87tyj5wpqt.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fabio Estevam <festevam@gmail.com> writes:

Hi,
> Hi Sascha,
>
> On Thu, Nov 25, 2010 at 7:13 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
>> On Wed, Nov 24, 2010 at 07:42:31PM -0200, Fabio Estevam wrote:
>>> Hi Uwe,
>>>
>>> 2010/11/24 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
>>> ....
>>> > I usually prefer just using DEBUG_LL and put
>>> >
>>> > ? ? ? ?#ifdef CONFIG_DEBUG_LL
>>> > ? ? ? ? ? ? ? ?void printch(char);
>>> > ? ? ? ? ? ? ? ?printch(c);
>>> > ? ? ? ?#endif
>>> >
>>> > into emit_log_char. ?But I think that's only because I don't know how to
>>> > use early printk properly. ?(You might need an additional kernel
>>> > parameter?!)
>>>
>>> Thanks. I see that the kernel crashes at sdma_get_firmware.
>>
>> This is a bug which should be fixed in this -rc cycle. Anyway, note
>> that I have a patch in my for-2.6.38 queue which makes the SDMA work
>> without a valid firmware. In this case only the scripts in ROM are used.
>
> Yes, I am using your for-next branch, which contains the patch to make
> SDMA work without a valid firmware.
>
> I also generated the SDMA firmware (sdma-imx51-to1.bin) via your sdma
> tool and placed it under /lib/firmware, but the result is the same

I've tried some weeks ago to boot with sdma support enabled and found
out that it was looking for sdma-imx51-to0.bin so I thought it was still
early work and gave up. Maybe it's still not fixed.

> with or without a valid firmware: when request_firmware is called the
> following crash happens:
>
> Unable to handle kernel NULL pointer dereference at virtual address 00000048
> pgd = c0004000
> [00000048] *pgd=00000000
> Internal error: Oops: 5 [#1]
> last sysfs file:
> Modules linked in:
> CPU: 0    Not tainted  (2.6.37-rc3+ #324)
> PC is at get_device_parent+0x80/0x168
> LR is at mutex_lock+0x14/0x34
> pc : [<c01cac88>]    lr : [<c029d81c>]    psr: 60000013
> sp : df83bd78  ip : df83bd60  fp : df83bd94
> r10: c037edf8  r9 : 00000001  r8 : 00000000
> r7 : df861540  r6 : df84ba10  r5 : df85c640  r4 : df85c640
> r3 : 00000000  r2 : 00000000  r1 : df84ba08  r0 : 00000000
> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> Control: 10c5387f  Table: 90004019  DAC: 00000017
> Process swapper (pid: 1, stack limit = 0xdf83a2e8)
> Stack: (0xdf83bd78 to 0xdf83c000)
> bd60:                                                       df861580 df85c640
> bd80: df85c648 00000000 df83bddc df83bd98 c01cbc38 c01cac14 00000000 df84ba08
> bda0: df85c600 df85c640 df83bdd0 df83bdb8 c01cb028 df84ba08 df85c600 df85c640
> bdc0: df861540 00000000 00000001 c037edf8 df83be14 df83bde0 c01d47a4 c01cbbb4
> bde0: c036cef8 df83be58 df80a000 df80a000 df861500 00000000 df851b00 00001508
> be00: df80a004 00000000 df83be2c df83be18 c01d4a50 c01d4654 00000000 c0019754
> be20: df83be8c df83be30 c0019774 c01d4a3c c031d457 df80a000 df83be74 df83be48
> be40: df852c90 df84ba08 df80b51c 00000006 00000000 c0381c68 df861540 00000000
> be60: df83be7c df84ba08 df84ba08 c0381c68 c0381c68 00000000 00000000 00000000
> be80: df83be9c df83be90 c01cf1f0 c00193ac df83bebc df83bea0 c01ce1c8 c01cf1e0
> bea0: df84ba08 df84ba3c c0381c68 00000000 df83bedc df83bec0 c01ce2e0 c01ce124
> bec0: 00000000 c0381c68 c01ce278 00000000 df83bf04 df83bee0 c01cd9c8 c01ce284
> bee0: df81cab8 df84a7b0 c01a0bc4 c0381c68 df859c80 c037eb00 df83bf14 df83bf08
> bf00: c01ce00c c01cd980 df83bf44 df83bf18 c01cd2b4 c01cdff8 c031d453 df83bf28
> bf20: c0381c68 c001937c c003c3e8 00000000 00000000 00000000 df83bf6c df83bf48
> bf40: c01ce5f8 c01cd20c 00000000 c0381c54 c001937c c003c3e8 00000000 00000000
> bf60: df83bf7c df83bf70 c01cf64c c01ce554 df83bf94 df83bf80 c01cf680 c01cf60c
> bf80: c001ed30 c001937c df83bfa4 df83bf98 c0019394 c01cf66c df83bfdc df83bfa8
> bfa0: c00243d4 c0019388 0000010f c0008504 c003c3e8 00000013 c001ed30 c0008504
> bfc0: c003c3e8 00000013 00000000 00000000 df83bff4 df83bfe0 c00085a0 c002430c
> bfe0: 00000000 00000000 00000000 df83bff8 c003c3e8 c0008510 10109206 dbd6f7f5
> Backtrace:
> [<c01cac08>] (get_device_parent+0x0/0x168) from [<c01cbc38>] (device_add+0x90/0x
> 480)
>  r6:00000000 r5:df85c648 r4:df85c640 r3:df861580
> [<c01cbba8>] (device_add+0x0/0x480) from [<c01d47a4>] (_request_firmware+0x15c/0
> x364)
> [<c01d4648>] (_request_firmware+0x0/0x364) from [<c01d4a50>] (request_firmware+0
> x20/0x28)
> [<c01d4a30>] (request_firmware+0x0/0x28) from [<c0019774>] (sdma_probe+0x3d4/0x6
> 9c)
> [<c00193a0>] (sdma_probe+0x0/0x69c) from [<c01cf1f0>] (platform_drv_probe+0x1c/0
> x20)
> [<c01cf1d4>] (platform_drv_probe+0x0/0x20) from [<c01ce1c8>] (driver_probe_devic
> e+0xb0/0x160)
> [<c01ce118>] (driver_probe_device+0x0/0x160) from [<c01ce2e0>] (__driver_attach+
> 0x68/0x8c)
>  r7:00000000 r6:c0381c68 r5:df84ba3c r4:df84ba08
> [<c01ce278>] (__driver_attach+0x0/0x8c) from [<c01cd9c8>] (bus_for_each_dev+0x54
> /0x84)
>  r6:00000000 r5:c01ce278 r4:c0381c68 r3:00000000
> [<c01cd974>] (bus_for_each_dev+0x0/0x84) from [<c01ce00c>] (driver_attach+0x20/0
> x28)
>  r6:c037eb00 r5:df859c80 r4:c0381c68
> [<c01cdfec>] (driver_attach+0x0/0x28) from [<c01cd2b4>] (bus_add_driver+0xb4/0x2
> 28)
> [<c01cd200>] (bus_add_driver+0x0/0x228) from [<c01ce5f8>] (driver_register+0xb0/
> 0x13c)
> [<c01ce548>] (driver_register+0x0/0x13c) from [<c01cf64c>] (platform_driver_regi
> ster+0x4c/0x60)
>  r8:00000000 r7:00000000 r6:c003c3e8 r5:c001937c r4:c0381c54
> r3:00000000
> [<c01cf600>] (platform_driver_register+0x0/0x60) from [<c01cf680>] (platform_dri
> ver_probe+0x20/0x70)
> [<c01cf660>] (platform_driver_probe+0x0/0x70) from [<c0019394>] (sdma_module_ini
> t+0x18/0x24)
>  r5:c001937c r4:c001ed30
> [<c001937c>] (sdma_module_init+0x0/0x24) from [<c00243d4>] (do_one_initcall+0xd4
> /0x1a8)
> [<c0024300>] (do_one_initcall+0x0/0x1a8) from [<c00085a0>] (kernel_init+0x9c/0x1
> 54)
> [<c0008504>] (kernel_init+0x0/0x154) from [<c003c3e8>] (do_exit+0x0/0x58c)
>  r4:00000000 r3:00000000
> Code: e59f00e0 eb034ae1 e59530ac e5933038 (e5b30048)
> ---[ end trace 1b75b31a2719ed1c ]---
> Kernel panic - not syncing: Attempted to kill init!
>
> I am trying to fix this, but suggestions are welcome.

Even if the fw name is bad, it should not crash. Maybe missing some
checks or init code ? Of course, it's only an idea. Your problem may
have nothing to do with missing firmware.

Arnaud
