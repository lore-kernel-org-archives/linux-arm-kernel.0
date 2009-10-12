From: dk-arm-linux@gmx.de (Dieter Kiermaier)
Date: Mon, 12 Oct 2009 14:39:22 +0200
Subject: mdev (hotplug/udev???) umount problem with latest kernel for openrd
Message-ID: <200910121439.22862.dk-arm-linux@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everybody,

I observe a problem with unmounting usb pendrives by using mdev (busybox mini udev).

Today morning I've updated Dhaval Vasas tree ( http://repo.or.cz/w/linux-2.6/linux-2.6-openrd.git )
and since then I couldn't run umount -f /dev/sda1 if I unplug my usb pendrive before that.

My kernel version is now:

sh-3.2# uname -a
Linux DB88FXX81 2.6.32-rc3-ga45e255 #1 PREEMPT Mon Oct 12 09:04:59 CEST 2009 armv5tel GNU/Linux


But that's exactly what happens when I unplug the stick and mdev runs my helper scprit to run umount -f /dev/sda1.

The process umount hangs (but in the background) and also the mdev process hangs and never comes back.

strace on mdev shows:
sh-3.2# strace -p 522
Process 522 attached - interrupt to quit
wait4(526,

strace on umount shows:
sh-3.2# strace -p 533
Process 533 attached - interrupt to quit

and never comes back (couldn't interrupt with CTRL-C for example)

After some time (I think about 120sec...) the following is displayed on my console:
INFO: task umount:533 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
umount        D c03575c0     0   533    526 0x00000001
[<c03575c0>] (schedule+0x360/0x3f0) from [<c00d08dc>] (bdi_sched_wait+0xc/0x18)
[<c00d08dc>] (bdi_sched_wait+0xc/0x18) from [<c03580e4>] (__wait_on_bit+0x60/0xac)
[<c03580e4>] (__wait_on_bit+0x60/0xac) from [<c03581a4>] (out_of_line_wait_on_bit+0x74/0x80)
[<c03581a4>] (out_of_line_wait_on_bit+0x74/0x80) from [<c00d0970>] (sync_inodes_sb+0x88/0x17c)
[<c00d0970>] (sync_inodes_sb+0x88/0x17c) from [<c00d4c24>] (__sync_filesystem+0x30/0x6c)
[<c00d4c24>] (__sync_filesystem+0x30/0x6c) from [<c00b5234>] (generic_shutdown_super+0x2c/0x130)
[<c00b5234>] (generic_shutdown_super+0x2c/0x130) from [<c00b5354>] (kill_block_super+0x1c/0x38)
[<c00b5354>] (kill_block_super+0x1c/0x38) from [<c00b56ac>] (deactivate_super+0x68/0x8c)
[<c00b56ac>] (deactivate_super+0x68/0x8c) from [<c00cc720>] (sys_umount+0x2c8/0x2fc)
[<c00cc720>] (sys_umount+0x2c8/0x2fc) from [<c00259c0>] (ret_fast_syscall+0x0/0x28)


Does anybody has an idea how I can track this down?

With the former version from http://repo.or.cz/w/linux-2.6/linux-2.6-openrd.git everything works fine :(

Any tips are very appreciated.

Dieter
