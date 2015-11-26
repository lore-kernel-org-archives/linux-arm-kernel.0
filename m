From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 26 Nov 2015 14:18:04 -0200
Subject: mx28: bad unlock balance detected
Message-ID: <CAOMZO5B+j5s69JeeYPnpwn2e_doCA+ARzBSGAcGoJGEJ3=u3BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Running linux-next 20151126 on a mx28evk leads to the following bug:

sgtl5000 0-000a: sgtl5000 revision 0x11
sgtl5000 0-000a: Using internal LDO instead of VDDD

=====================================
[ BUG: bad unlock balance detected! ]
4.4.0-rc2-next-20151126-00001-g44eb6b2 #156 Not tainted
-------------------------------------
kworker/u2:0/6 is trying to release lock (&rdev->mutex) at:
[<c02e7858>] regulator_get_voltage+0x30/0x44
but there are no more locks to release!

other info that might help us debug this:
5 locks held by kworker/u2:0/6:
 #0:  ("%s""deferwq"){++++.+}, at: [<c002f1f8>] process_one_work+0x10c/0x49c
 #1:  (deferred_probe_work){+.+.+.}, at: [<c002f1f8>]
process_one_work+0x10c/0x49c
 #2:  (&dev->mutex){......}, at: [<c03197bc>] __device_attach+0x20/0x108
 #3:  (client_mutex){+.+.+.}, at: [<c042dc34>]
snd_soc_register_card+0x280/0x1108
 #4:  (&card->mutex){+.+.+.}, at: [<c042dc40>]
snd_soc_register_card+0x28c/0x1108

stack backtrace:
CPU: 0 PID: 6 Comm: kworker/u2:0 Not tainted
4.4.0-rc2-next-20151126-00001-g44eb6b2 #156
Hardware name: Freescale MXS (Device Tree)
Workqueue: deferwq deferred_probe_work_func
[<c000eea0>] (unwind_backtrace) from [<c000cfa0>] (show_stack+0x10/0x14)
[<c000cfa0>] (show_stack) from [<c0049350>]
(print_unlock_imbalance_bug+0xac/0xdc)
[<c0049350>] (print_unlock_imbalance_bug) from [<c004c2f8>]
(lock_release+0x2a4/0x38c)
[<c004c2f8>] (lock_release) from [<c0513e70>]
(__mutex_unlock_slowpath+0x7c/0x15c)
[<c0513e70>] (__mutex_unlock_slowpath) from [<c02e7858>]
(regulator_get_voltage+0x30/0x44)
[<c02e7858>] (regulator_get_voltage) from [<c043c200>]
(sgtl5000_probe+0x1c0/0x5f0)
[<c043c200>] (sgtl5000_probe) from [<c0428a74>]
(snd_soc_codec_drv_probe+0x14/0x18)
[<c0428a74>] (snd_soc_codec_drv_probe) from [<c042cd54>]
(soc_probe_component+0x200/0x330)
[<c042cd54>] (soc_probe_component) from [<c042e178>]
(snd_soc_register_card+0x7c4/0x1108)
[<c042e178>] (snd_soc_register_card) from [<c0439cdc>]
(devm_snd_soc_register_card+0x30/0x70)
[<c0439cdc>] (devm_snd_soc_register_card) from [<c043d1cc>]
(mxs_sgtl5000_probe+0xc8/0x138)
[<c043d1cc>] (mxs_sgtl5000_probe) from [<c031b1fc>]
(platform_drv_probe+0x50/0xac)
[<c031b1fc>] (platform_drv_probe) from [<c0319ab0>]
(driver_probe_device+0x1e4/0x2b0)
[<c0319ab0>] (driver_probe_device) from [<c03180d8>]
(bus_for_each_drv+0x44/0x8c)
[<c03180d8>] (bus_for_each_drv) from [<c0319840>] (__device_attach+0xa4/0x108)
[<c0319840>] (__device_attach) from [<c0318f84>] (bus_probe_device+0x88/0x90)
[<c0318f84>] (bus_probe_device) from [<c0319370>]
(deferred_probe_work_func+0x64/0x94)
[<c0319370>] (deferred_probe_work_func) from [<c002f290>]
(process_one_work+0x1a4/0x49c)
[<c002f290>] (process_one_work) from [<c002f5e8>] (worker_thread+0x28/0x468)
[<c002f5e8>] (worker_thread) from [<c0034dbc>] (kthread+0xc0/0xdc)
[<c0034dbc>] (kthread) from [<c000a2ec>] (ret_from_fork+0x14/0x28)
mxs-sgtl5000 sound: sgtl5000 <-> 80042000.saif mapping ok

By inspecting the sgtl5000 codec driver I could not find where this
"bad unlock balance" is happening.

Any ideas?

Thanks,

Fabio Estevam
