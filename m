From: jason.hui.liu@nxp.com (Hui Liu)
Date: Tue, 1 Mar 2016 01:55:27 +0000
Subject: Booting MX7Solo with 4.5-rc6
In-Reply-To: <CAOMZO5BX4+AB59SGCUGyk2RKyi706wOxgMp15beyGR9Dg6HWPg@mail.gmail.com>
References: <CAOMZO5A6AO1n+fiwYBa=7VS3i1qk6zZ_ifym1yPt6+ApcTAuoA@mail.gmail.com>
 <AMSPR04MB263126AA78BEE3D8818F80388BA0@AMSPR04MB263.eurprd04.prod.outlook.com>
 <CAOMZO5BX4+AB59SGCUGyk2RKyi706wOxgMp15beyGR9Dg6HWPg@mail.gmail.com>
Message-ID: <DBXPR04MB3841C31AD0E7E04F181EB2EAEBB0@DBXPR04MB384.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Monday, February 29, 2016 11:35 PM
> To: Frank Li <frank.li@nxp.com>
> Cc: Hui Liu <jason.hui.liu@nxp.com>; Peng Fan <peng.fan@nxp.com>; linux-arm-
> kernel at lists.infradead.org; Dong Aisheng <dongas86@gmail.com>
> Subject: Re: Booting MX7Solo with 4.5-rc6
> 
> On Mon, Feb 29, 2016 at 12:23 PM, Frank Li <frank.li@nxp.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Fabio Estevam [mailto:festevam at gmail.com]
> >> Sent: Monday, February 29, 2016 8:23 AM
> >> To: Frank Li <frank.li@nxp.com>; Hui Liu <jason.hui.liu@nxp.com>
> >> Cc: Peng Fan <peng.fan@nxp.com>;
> >> linux-arm-kernel at lists.infradead.org;
> >> Dong Aisheng <dongas86@gmail.com>
> >> Subject: Booting MX7Solo with 4.5-rc6
> >>
> >> Hi,
> >>
> >> I am trying to boot linux-next 20160229 on a m7solo warp board and
> >> this is what I get:
> >>
> >> http://pastebin.com/TmQdqd2B

You can't dequeue the idle thread, thus kernel throw the oops:

bad: scheduling from the idle thread!

The reason is that the code is buggy for using the usleep_range in the clk_pllv3_wait_lock function,
>From the stack dump:

[    0.000000] [<c0152364>] (dequeue_task_idle) from [<c0149bf0>] (deactivate_task+0x64/0x68)
[    0.000000]  r4:c0d064c0 r3:c0152364
[    0.000000] [<c0149b8c>] (deactivate_task) from [<c08dfac0>] (__schedule+0x2cc/0x6d8)
[    0.000000]  r6:c0d06804 r5:debbb450 r4:c0d064c0 r3:00000002
[    0.000000] [<c08df7f4>] (__schedule) from [<c08dfff4>] (schedule+0x3c/0xa0)
[    0.000000]  r10:c0d064c0 r9:c155fd78 r8:00000001 r7:00000000 r6:0006ddd0 r5:00000000
[    0.000000]  r4:0007a120
[    0.000000] [<c08dffb8>] (schedule) from [<c08e4600>] (schedule_hrtimeout_range_clock+0xd4/0x13c)
[    0.000000] [<c08e452c>] (schedule_hrtimeout_range_clock) from [<c08e468c>] (schedule_hrtimeout_range+0x24/0x2c)
[    0.000000]  r10:000006d8 r8:000000e8 r7:00000003 r6:ffff8ad1 r5:c0d02100 r4:de40c1c0
[    0.000000] [<c08e4668>] (schedule_hrtimeout_range) from [<c08e40b0>] (usleep_range+0x54/0x5c)
[    0.000000] [<c08e405c>] (usleep_range) from [<c068b3e4>] (clk_pllv3_wait_lock+0x7c/0xb4)
[    0.000000] [<c068b368>] (clk_pllv3_wait_lock) from [<c068b5f4>] (clk_pllv3_prepare+0x2c/0x30)
[    0.000000]  r6:c0d5c8f4 r5:00000000 r4:de407700 r3:e0840130
[    0.000000] [<c068b5c8>] (clk_pllv3_prepare) from [<c0685a68>] (clk_core_prepare+0xa0/0xcc)
[    0.000000] [<c06859c8>] (clk_core_prepare) from [<c0685a48>] (clk_core_prepare+0x80/0xcc)
[    0.000000]  r5:00000000 r4:de407a00
[    0.000000] [<c06859c8>] (clk_core_prepare) from [<c0685a48>] (clk_core_prepare+0x80/0xcc)
[    0.000000]  r5:00000000 r4:de407c80
[    0.000000] [<c06859c8>] (clk_core_prepare) from [<c0685ab4>] (clk_prepare+0x20/0x30)
[    0.000000]  r5:00000000 r4:de40cd80
[    0.000000] [<c0685a94>] (clk_prepare) from [<c0c4a398>] (imx7d_clocks_init+0x6114/0x6198)
[    0.000000]  r4:de40cd80 r3:600000d3
[    0.000000] [<c0c44284>] (imx7d_clocks_init) from [<c0c308a0>] (of_clk_init+0x140/0x1f0)
[    0.000000]  r10:c0d01f70 r9:00000001 r8:c0d01f68 r7:00000000 r6:de4043c0 r5:debddfd4
[    0.000000]  r4:00000003
[    0.000000] [<c0c30760>] (of_clk_init) from [<c0c049f8>] (time_init+0x2c/0x38)
[    0.000000]  r10:00000001 r9:410fc075 r8:defffb40 r7:c0c5ca48 r6:c0d75000 r5:ffffffff
[    0.000000]  r4:00000000
[    0.000000] [<c0c049cc>] (time_init) from [<c0c00be8>] (start_kernel+0x26c/0x404)
[    0.000000] [<c0c0097c>] (start_kernel) from [<8000807c>] (0x8000807c)


Please remove the usleep_range in the function clk_pllv3_wait_lock. 

Jason Liu

> >>
> >> I can boot this board fine using NXP 3.14.52 kernel.
> >>
> >> These clock warnings also happen on a mx7d sabresd board, but the
> >> boot proceed fine.
> >
> > It caused usleep_range(50, 500) in clk_pllv3_wait_lock.
> > Need aisheng's patch to fix it.
> 
> Yes, I know, but they should not prevent the boot from happening.
> 
> >> Any ideas as to what needs to be done in order to boot a MX7S?
> >
> > Can you try to disable arch_timer in dts?
> 
> Just disabled it, but it did not help. Thanks
