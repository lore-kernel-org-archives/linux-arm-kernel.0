From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Thu, 27 Aug 2015 15:58:25 -0700
Subject: [PATCH v1] soc: ti: reset irq affinity before freeing irq
In-Reply-To: <1440711847-24747-1-git-send-email-m-karicheri2@ti.com>
References: <1440711847-24747-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <55DF9611.4060801@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 8/27/2015 2:44 PM, Murali Karicheri wrote:
> When using accumulator queue for rx side for network driver, following
> warning is seen when doing a reboot command from Linux console. This
> is because, affinity value is not reset before calling free_irq(). This
> patch fixes this.
>
> Deconfiguring network interfaces...
> [   55.176589] ------------[ cut here ]-----------
> [   55.181232] WARNING: CPU: 0 PID: 2081 at kernel/irq/manage.c:1370
> __free_irq+0x208/0x214
> [   55.181232] WARNING: CPU: 0 PID: 2081 at kernel/irq/manage.c:1370
> __free_irq+0x208/0x214
> ()
> [   55.189527] Modules linked in:
> [   55.192598] CPU: 0 PID: 2081 Comm: ifconfig Not tainted
> 4.1.5-00908-g1049e206-dirty #1
> [   55.200543] Hardware name: Keystone
> [   55.204040] Backtrace:
> [   55.206507] [<c0012b98>] (dump_backtrace) from [<c0012dbc>]
> (show_stack+0x18/0x1c)
> [   55.214102]  r7:c005d0a8 r6:c06e2184 r5:c06e2184 r4:00000000
> [   55.219811] [<c0012da4>] (show_stack) from [<c04e7168>]
> (dump_stack+0x8c/0xcc)
> [   55.227065] [<c04e70dc>] (dump_stack) from [<c0025944>]
> (warn_slowpath_common+0x88/0xb8)
> [   55.235183]  r7:c005d0a8 r6:0000055a r5:00000009 r4:00000000
> [   55.240889] [<c00258bc>] (warn_slowpath_common) from [<c0025a18>]
> (warn_slowpath_null+0x
> 24/0x2c)
> [   55.249704]  r8:0000006c r7:ee513f60 r6:ee513f00 r5:ee611010 r4:cc873a00
> [   55.256458] [<c00259f4>] (warn_slowpath_null) from [<c005d0a8>]
> (__free_irq+0x208/0x214)
> [   55.264580] [<c005cea0>] (__free_irq) from [<c005d158>]
>   (free_irq+0x54/0xac)
> [   55.271652]  r10:00000002 r9:00000000 r8:00000000 r7:ee611010
> r6:0000006c r5:00000000
> [   55.279538]  r4:ee513f00 r3:00000000
> [   55.283140] [<c005d104>] (free_irq) from [<c02a81b0>]
> (knav_range_setup_acc_irq+0xb0/0x1
> 28)
> [   55.291519]  r7:00000001 r6:0000006c r5:ee611010 r4:00000001
> [   55.297223] [<c02a8100>] (knav_range_setup_acc_irq) from [<c02a8248>]
> (knav_acc_close_qu
> eue+0x20/0x24)
> [   55.306563]  r8:edd1a4c8 r7:00001000 r6:eed89980 r5:ee616650 r4:edf9d990
> [   55.313320] [<c02a8228>] (knav_acc_close_queue) from [<c02a6160>]
> (knav_queue_close+0xb4
> /0xb8)
> [   55.321969] [<c02a60ac>] (knav_queue_close) from [<c0336270>]
> (netcp_free_navigator_reso
> urces+0x1d4/0x2c0)
> [   55.331656]  r5:edd1a480 r4:00000400
> [   55.335255] [<c033609c>] (netcp_free_navigator_resources) from
> [<c033657c>] (netcp_ndo_stop+0x220/0x230)
> [   55.344768]  r10:00008914 r9:edf34400 r8:00000000 r7:edd1a5d8
> r6:edd1a480 r5:00000400
> [   55.352653]  r4:edd1a000
> [   55.355202] [<c033635c>] (netcp_ndo_stop) from [<c03d9c80>]
> (__dev_close_many+0x90/0xd8)
> [   55.363320]  r7:00001003 r6:00001042 r5:edb0de20 r4:edd1a000
> [   55.369023] [<c03d9bf0>] (__dev_close_many) from [<c03d9df4>]
> (__dev_close+0x30/0x48)
> [   55.376880]  r5:00000001 r4:edd1a000
> [   55.380480] [<c03d9dc4>] (__dev_close) from [<c03e175c>]
> (__dev_change_flags+0x9c/0x14c)
> [   55.388602] [<c03e16c0>] (__dev_change_flags) from [<c03e182c>]
> (dev_change_flags+0x20/0
> x50)
> [   55.397069]  r9:edf34400 r8:00000000 r7:00000000 r6:00001003 r5:edd1a138
> r4:edd1a000
> [   55.404875] [<c03e180c>] (dev_change_flags) from [<c0446f94>]
> (devinet_ioctl+0x680/0x754
> )
> [   55.413080]  r9:edf34400 r8:bef6af3c r7:00000000 r6:bef6ac64 r5:edf3440c
> r4:00000000
> [   55.420882] [<c0446914>] (devinet_ioctl) from [<c0448760>]
> (inet_ioctl+0x1a8/0x1d0)
> [   55.428564]  r10:00000000 r9:edb0c000 r8:bef6ac64 r7:00000003
> r6:bef6ac64 r5:bef6ac64
> [   55.436449]  r4:00008914
> [   55.438996] [<c04485b8>] (inet_ioctl) from [<c03c72fc>]
> (sock_ioctl+0x1d0/0x2a8)
> [   55.446423] [<c03c712c>] (sock_ioctl) from [<c00eb608>]
> (do_vfs_ioctl+0x414/0x604)
> [   55.454018]  r7:00000003 r6:ed8b60c0 r5:bef6ac64 r4:ccc88f20
> [   55.459721] [<c00eb1f4>] (do_vfs_ioctl) from [<c00eb834>]
> (SyS_ioctl+0x3c/0x64)
> [   55.467055]  r9:edb0c000 r8:bef6ac64 r7:00008914 r6:ed8b60c0 r5:00000003
> r4:ed8b60c0
> [   55.474858] [<c00eb7f8>] (SyS_ioctl) from [<c000f780>]
> (ret_fast_syscall+0x0/0x3c)
> [   55.482452]  r9:edb0c000 r8:c000f924 r7:00000036 r6:0007e77c r5:bef6ac64
> r4:0007e7d0
> [   55.490252] ---[ end trace f565594c905af0b4 ]---
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>   - v1 - added all of the call trace per comment
>   - Applies to v4.2.0-rc8
>
Thanks Murali. I will drop time stamp while applying it.

Regards,
Santosh
