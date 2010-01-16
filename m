From: w.sang@pengutronix.de (Wolfram Sang)
Date: Sat, 16 Jan 2010 20:41:21 +0100
Subject: [RFC] PCMCIA locking updates for 2.6.34
In-Reply-To: <20100116124143.GA30530@comet.dominikbrodowski.net>
References: <20100116124143.GA30530@comet.dominikbrodowski.net>
Message-ID: <20100116194121.GA11556@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dominik,

On Sat, Jan 16, 2010 at 01:41:43PM +0100, Dominik Brodowski wrote:

> 
> on top of what had already been discussed for 2.6.34, here are 12 patches
> trying to fix the locking mess the PCMCIA subsystem used to be. As a
> side-effect, the PCMCIA ioctl will be disabled for all except the ARM
> architecture, and even there you need !SMP and !PREEMPT. Hopefully, we'll be
> able to remove the ioctl from ARM too.
> 
> Everything is available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/brodo/pcmcia-2.6.git#locking

I pulled and tested this branch. Sadly, it doesn't work for me. If I insert a
(previously working) network card, io-resources get allocated, but the driver
does not even print its success-string. Luckily, I had hung-task detection
enabled:

[   54.276728] pcmcia_socket pcmcia_socket0: pccard: PCMCIA card inserted into slot 0
[   54.276747] pcmcia_socket pcmcia_socket0: cs: memory probe 0x0d4000-0x0dffff: clean.
[   54.288227] pcmcia_socket pcmcia_socket0: cs: memory probe 0x60000000-0x60ffffff: clean.
[   54.318694] pcmcia_socket pcmcia_socket0: cs: memory probe 0xa0000000-0xa0ffffff: clean.
[   54.349945] pcmcia_socket pcmcia_socket0: cs: memory probe 0xffd10000-0xffdeffff: clean.
[   54.381320] pcmcia 0.0: pcmcia: registering new device pcmcia0.0
[  240.110047] INFO: task modprobe:2669 blocked for more than 120 seconds.
[  240.110056] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  240.110065] modprobe      D bf05c428     0  2669      1 0x00000000
[  240.110078]  bd823c40 00000086 c1d6637d bf05c428 bf800140 bf87d890 bf05c534 bf87d890
[  240.110096]  bf05c538 bd823c64 8050eac3 bf05c538 bf05c538 bf87d890 ffffffff bf05c534
[  240.110112]  bf03d020 bf05c428 bd823c74 8050ed2e bf03d020 bf03d000 bd823cac c1d66e58
[  240.110128] Call Trace:
[  240.110155]  [<c1d6637d>] ? alloc_io_space+0x32d/0x3a0 [pcmcia]
[  240.110170]  [<8050eac3>] __mutex_lock_slowpath+0x53/0x90
[  240.110181]  [<8050ed2e>] mutex_lock+0x1e/0x30
[  240.110195]  [<c1d66e58>] pcmcia_request_io+0x28/0x420 [pcmcia]
[  240.110204]  [<8050ed23>] ? mutex_lock+0x13/0x30
[  240.110218]  [<c1d69b23>] ? read_cis_cache+0xa3/0x200 [pcmcia]
[  240.110239]  [<c1b60f30>] pcnet_confcheck+0x110/0x174 [pcnet_cs]
[  240.110253]  [<c1d65f49>] pcmcia_do_loop_config+0x69/0x80 [pcmcia]
[  240.110267]  [<c1d6a47d>] pccard_loop_tuple+0xed/0x150 [pcmcia]
[  240.110282]  [<c1d65ee0>] ? pcmcia_do_loop_config+0x0/0x80 [pcmcia]
[  240.110296]  [<c1d666a9>] pcmcia_loop_config+0xb9/0xd0 [pcmcia]
[  240.110310]  [<c1d65ee0>] ? pcmcia_do_loop_config+0x0/0x80 [pcmcia]
[  240.110327]  [<c1b60e20>] ? pcnet_confcheck+0x0/0x174 [pcnet_cs]
[  240.110344]  [<c1b6016d>] pcnet_probe+0x9d/0xbf0 [pcnet_cs]
[  240.110358]  [<c1d69b23>] ? read_cis_cache+0xa3/0x200 [pcmcia]
[  240.110373]  [<c1d6a31f>] ? pccard_read_tuple+0xaf/0x120 [pcmcia]
[  240.110388]  [<80292491>] ? ida_get_new_above+0x81/0x1f0
[  240.110402]  [<c1d63de8>] pcmcia_device_probe+0xf8/0x2b0 [pcmcia]
[  240.110412]  [<8050ed23>] ? mutex_lock+0x13/0x30
[  240.110425]  [<803bae00>] ? driver_sysfs_add+0x50/0x70
[  240.110435]  [<803baf73>] driver_probe_device+0x93/0x280
[  240.110445]  [<802934d9>] ? kobject_add_internal+0xb9/0x240
[  240.110456]  [<803bb1e9>] __driver_attach+0x89/0x90
[  240.110466]  [<803ba683>] bus_for_each_dev+0x53/0x80
[  240.110476]  [<803bad4e>] driver_attach+0x1e/0x20
[  240.110486]  [<803bb160>] ? __driver_attach+0x0/0x90
[  240.110495]  [<803b9f17>] bus_add_driver+0x207/0x300
[  240.110510]  [<c1d63a40>] ? pcmcia_device_remove+0x0/0x1e0 [pcmcia]
[  240.110520]  [<803bb4ca>] driver_register+0x7a/0x170
[  240.110535]  [<c1d65bd4>] pcmcia_register_driver+0xb4/0x170 [pcmcia]
[  240.110549]  [<8016d1c5>] ? tracepoint_module_notify+0x25/0x30
[  240.110561]  [<8014c64d>] ? notifier_call_chain+0x3d/0x80
[  240.110578]  [<c1b6f000>] ? init_pcnet_cs+0x0/0xf [pcnet_cs]
[  240.110596]  [<c1b6f00d>] init_pcnet_cs+0xd/0xf [pcnet_cs]
[  240.110606]  [<80101118>] do_one_initcall+0x28/0x180
[  240.110617]  [<8014cb4f>] ? blocking_notifier_call_chain+0x1f/0x30
[  240.110630]  [<8015f00f>] sys_init_module+0xaf/0x210
[  240.110640]  [<80102bd0>] sysenter_do_call+0x12/0x26

A deadlock? At this stage, the pcmcia-host is stuck. Card removal is detected,
but the resources don't get freed. Let me know if I can provide more info or
can do more testing.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100116/dd0865b4/attachment.sig>
