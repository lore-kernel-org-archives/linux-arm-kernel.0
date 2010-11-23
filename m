From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Tue, 23 Nov 2010 15:44:39 +0100
Subject: UBIFS oops after remount ro
Message-ID: <20101123144439.GA12773@debian-wegner1.datadisplay.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi list,

I have a very similar (same?) problem as described here:
http://lkml.org/lkml/2010/5/7/193

- kernel is 2.6.32 on a Marvell Kirkwood system
- several UBIFS partitions (/,/etc/localconfig,
  /etc/localconfigdefault)
- normally all file systems are mounted read-only
- some "run-once" scripts to adjust things on first startup
- all work fine except for one working on the root fs:
if [ ! -f /lib/modules/`uname -r`/modules.dep ] ; then
#	ps
       mount -n -o remount,rw /
       echo "adjusting modules"
       mkdir -p /lib/modules/`uname -r`
       depmod -a
       sync
       sync
       mount -n -o remount,ro /
#       ps
fi
When running this in a shell or as a script in the shell after system
startup is completed, everything is fine. When running this from within
/etc/init.d/rcS (busybox), the script and startup works, but after
around 25 seconds I get this oops:

Unable to handle kernel NULL pointer dereference at virtual address 000000ac
sh-3.2# pgd = c0004000
[000000ac] *pgd=00000000
Internal error: Oops: 817 [#1] PREEMPT
last sysfs file: /sys/devices/pci0000:00/0000:00:01.0/0000:01:08.0/reg_val
Modules linked in: dd_anetfb_k dd_fpgaloader_k dd_hw_config_k
CPU: 0    Not tainted  (2.6.32-svn21303 #1)
PC is at mutex_lock+0x4/0x14
LR is at make_reservation+0x74/0x364
pc : [<c0371e40>]    lr : [<c015cfc4>]    psr: 60000013
sp : dfb61e00  ip : df82e150  fp : dfb60000
r10: 00000001  r9 : 00000000  r8 : 00000000
r7 : 000000ac  r6 : 00000088  r5 : df82e000  r4 : 00000000
r3 : 00000000  r2 : 00000001  r1 : 00000088  r0 : 000000ac
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005397f  Table: 1fb58000  DAC: 00000017
Process flush-ubifs_0_1 (pid: 549, stack limit = 0xdfb60270)
Stack: (0xdfb61e00 to 0xdfb62000)
1e00: 00000001 c008ba44 dfb61e4c df4f8b54 dfb61f18 00000000 df82e14c 000000a0
1e20: 00000088 00000001 000000a0 00000050 dfb61e4c df82e000 df4f8ab8 000000a0
1e40: 00000000 00000000 00000000 dfa16c00 df82e090 c015d79c 00000001 dfb60000
1e60: 00000002 df9792c0 dfb61e94 c003737c df4f8ab8 00000001 df4f8c00 df82e000
1e80: df4f8b54 00000000 00000001 c0163c14 df4f8ab8 00000000 dfb61e4c df4f8ab8
1ea0: 00000000 dfb61f18 00000000 c00cfbec 20000013 df82e068 dfb61f18 dfb60000
1ec0: df4f8ab8 df82e088 00000000 c00d08a8 c049f250 dfa8ca40 00000000 ffff97bc
1ee0: 00000000 df4f8c48 df4f8ac0 dfa8ca00 c049f250 dfb60000 dfb61f78 df82e068
1f00: 00000000 df82e090 00000000 df82e008 00000000 c00d0ad4 df82e008 00000000
1f20: 00000000 00000000 00000400 00000000 00000000 00000000 ffffffff 7fffffff
1f40: 00000000 00000000 dfb61f74 c054be80 c054be80 c00468ac dfb18e80 df82e068
1f60: dfb60000 00000000 df82e0a8 00000000 00000000 c00d0cb8 00000001 00000000
1f80: 00000000 00000000 000001f4 ffff8cfc df82e068 df82e068 00000000 00000000
1fa0: 00000000 c00d0e38 dfb60000 df82e008 df82e068 c0099020 00000000 df8bbf40
1fc0: dfb61fd4 c0098f94 df82e068 c00543bc 00000000 00000000 dfb61fd8 dfb61fd8
1fe0: 00000000 00000000 00000000 00000000 00000000 c002744c 00000000 00000000
[<c0371e40>] (mutex_lock+0x4/0x14) from [<c015cfc4>] (make_reservation+0x74/0x364)
[<c015cfc4>] (make_reservation+0x74/0x364) from [<c015d79c>] (ubifs_jnl_write_inode+0x80/0x1e4)
[<c015d79c>] (ubifs_jnl_write_inode+0x80/0x1e4) from [<c0163c14>] (ubifs_write_inode+0x5c/0xbc)
[<c0163c14>] (ubifs_write_inode+0x5c/0xbc) from [<c00cfbec>] (writeback_single_inode+0x120/0x238)
[<c00cfbec>] (writeback_single_inode+0x120/0x238) from [<c00d08a8>] (writeback_inodes_wb+0x3d4/0x4a8)
[<c00d08a8>] (writeback_inodes_wb+0x3d4/0x4a8) from [<c00d0ad4>] (wb_writeback+0x158/0x1ec)
[<c00d0ad4>] (wb_writeback+0x158/0x1ec) from [<c00d0cb8>] (wb_do_writeback+0x6c/0x1cc)
[<c00d0cb8>] (wb_do_writeback+0x6c/0x1cc) from [<c00d0e38>] (bdi_writeback_task+0x20/0x98)
[<c00d0e38>] (bdi_writeback_task+0x20/0x98) from [<c0099020>] (bdi_start_fn+0x8c/0x100)
[<c0099020>] (bdi_start_fn+0x8c/0x100) from [<c00543bc>] (kthread+0x7c/0x84)
[<c00543bc>] (kthread+0x7c/0x84) from [<c002744c>] (kernel_thread_exit+0x0/0x8)
Code: ebfffd21 e28dd014 e8bd80f0 e3a03000 (e1001093) 
---[ end trace 162376f104dd0abc ]---

Commenting in the "ps" in the above script snippet, I can see that
the flush-ubifs_0_1 process is the one being started during the
script execution.

Here's my /proc/mounts:

rootfs / rootfs rw 0 0
ubi0:rootfs_live / ubifs ro,relatime 0 0
proc /proc proc rw,relatime 0 0
none /tmp tmpfs rw,relatime 0 0
none /var/run tmpfs rw,relatime,size=8192k 0 0
none /proc/bus/usb usbfs rw,relatime 0 0
ubi0:configfiles /etc/localconfig ubifs ro,noatime 0 0
ubi0:configfilesdefault /etc/localconfigdefault ubifs ro,noatime 0 0
ubi0:userdata /mnt/userdata ubifs ro,noatime 0 0
sysfs /sys sysfs rw,relatime 0 0
tmpfs /dev tmpfs rw,relatime,size=10240k,mode=755 0 0
devpts /dev/pts devpts rw,nosuid,noexec,relatime,gid=5,mode=620 0 0

I am a bit puzzled about this all.
- is the flush-ubifs_0_1 process expected to run after the filesystem
  has been mounted read-only?
- could the "duplicate" rootfs entry cause these problems? (I have to
  admit I do not see where it comes from and if/what I could do to
  get rid of it)
- is this the right list to ask? ;-)

Regards,
Wolfgang
