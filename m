From: omegamoon@gmail.com (- Cortez -)
Date: Sun, 18 Apr 2010 21:00:13 +0200
Subject: zaurus spitz suspend/resume issue
Message-ID: <i2i1f96a3531004181200ve1f71c03ydb7b4328cbcc6e26@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since resuming my spitz from a suspended state doesn't work in 2.6.34-rc3 at
the moment, I've tried to find out what the problem is with suspend/resume.
Using CONFIG_PM_DEBUG I tried to test this by setting /sys/power/pm_test to
"core" and switching the device off with the power button. This indeed
suspends and resumes the device, but shows following in the system log:

apm-power: Requesting system suspend...
PM: Syncing filesystems ...
done.
Freezing user space processes ... (elapsed 0.02 seconds) done.
Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
Suspending console(s) (use no_console_suspend to debug)
PM: suspend of devices complete after 95.695 msecs
PM: late suspend of devices complete after 1.460 msecs
suspend debug: Waiting for 5 seconds.
PM: early resume of devices complete after 722.103 msecs
------------[ cut here ]------------
WARNING: at kernel/irq/manage.c:361 set_irq_wake+0xa4/0x130()
Unbalanced IRQ 191 wake disable
Modules linked in:
Backtrace:
[<c0024118>] (dump_backtrace+0x0/0x110) from [<c028d7f8>]
(dump_stack+0x18/0x1c)
r7:c3d0de10 r6:c006177c r5:c0312002 r4:00000169
[<c028d7e0>] (dump_stack+0x0/0x1c) from [<c0033fa4>]
(warn_slowpath_common+0x50/0x80)
[<c0033f54>] (warn_slowpath_common+0x0/0x80) from [<c0034020>]
(warn_slowpath_fmt+0x30/0x38)
r7:00000000 r6:000000bf r5:c035e6a0 r4:00000000
[<c0033ff0>] (warn_slowpath_fmt+0x0/0x38) from [<c006177c>]
(set_irq_wake+0xa4/0x130)
r3:000000bf r2:c0312040
[<c00616d8>] (set_irq_wake+0x0/0x130) from [<c01f6814>]
(gpio_keys_resume+0x68/0xa0)
r8:00000034 r7:c03582d0 r6:c3e9ee40 r5:c0358708 r4:00000000
[<c01f67ac>] (gpio_keys_resume+0x0/0xa0) from [<c01bc68c>]
(platform_pm_resume+0x48/0x54)
r8:00000000 r7:c035830c r6:c03582d8 r5:c02ad58c r4:00000010
[<c01bc644>] (platform_pm_resume+0x0/0x54) from [<c01bed44>]
(pm_op+0x78/0xc4)
[<c01beccc>] (pm_op+0x0/0xc4) from [<c01bf218>] (device_resume+0x88/0x140)
r9:00000003 r8:00000010 r6:00000010 r5:c03582d8 r4:c03582d8
[<c01bf190>] (device_resume+0x0/0x140) from [<c01bf438>]
(dpm_resume_end+0x118/0x364)
r7:c036eff0 r6:00000000 r5:c0358330 r4:c03582d8
[<c01bf320>] (dpm_resume_end+0x0/0x364) from [<c005e54c>]
(suspend_devices_and_enter+0x194/0x1e4)
[<c005e3b8>] (suspend_devices_and_enter+0x0/0x1e4) from [<c005e688>]
(enter_state+0xec/0x144)
r6:00000003 r5:c030e820 r4:00000000
[<c005e59c>] (enter_state+0x0/0x144) from [<c005e704>]
(pm_suspend+0x24/0x28)
r6:c3d0c000 r5:c0389eb8 r4:c3c21500
[<c005e6e0>] (pm_suspend+0x0/0x28) from [<c01b38c8>] (kapmd+0x140/0x1a4)
[<c01b3788>] (kapmd+0x0/0x1a4) from [<c0048cd8>] (kthread+0x84/0x8c)
[<c0048c54>] (kthread+0x0/0x8c) from [<c00373f8>] (do_exit+0x0/0x5c0)
r7:00000000 r6:00000000 r5:00000000 r4:00000000
---[ end trace 08b84d7be31aecaf ]---
PM: resume of devices complete after 1359.861 msecs
Restarting tasks ... done.

I'll investigate further, but if any of you have any hints on how to fix
this, please let me know!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100418/05ade26c/attachment.htm>
