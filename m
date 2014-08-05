From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Tue, 5 Aug 2014 06:06:18 +0000
Subject: Suspend/resume broken on mx5/mx6 running 4.16
In-Reply-To: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
References: <CAOMZO5BN9H-4__2s9yyGiuOBsLO0gf9LOQ0_N1552P8LWJTxCg@mail.gmail.com>
Message-ID: <9930f46074e04c90a58fa6b01e055ff2@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <festevam@gmail.com> Data: Tuesday, August 05, 2014 1:54 AM
>To: Guo Shawn-R65073; Sascha Hauer
>Cc: linux-arm-kernel at lists.infradead.org; Russell King; Duan Fugang-B38611;
>Marek Va?ut
>Subject: Suspend/resume broken on mx5/mx6 running 4.16
>
>Hi,
>
>On a 3.16 kernel I noticed that suspend/resume is broken on mx53 and mx6q:
>
>root at imxqssabresd:~# echo enabled > /sys/class/tty/ttymxc0/power/wakeup
>root at imx6qsabresd:~# echo mem > /sys/power/state
>PM: Syncing filesystems ... done.
>Freezing user space processes ... (elapsed 0.003 seconds) done.
>Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
>Unable to handle kernel NULL pointer dereference at virtual address
>0000002c pgd = bcd14000 [0000002c] *pgd=4d9e0831, *pte=00000000,
>*ppte=00000000 Internal error: Oops: 17 [#1] SMP ARM Modules linked in:
>CPU: 0 PID: 617 Comm: sh Not tainted 3.16.0 #17
>task: bc0c4e00 ti: bceb6000 task.ti: bceb6000 PC is at
>fec_suspend+0x10/0x70 LR is at dpm_run_callback.isra.7+0x34/0x6c
>pc : [<803f8a98>]    lr : [<80361f44>]    psr: 600f0013
>sp : bceb7d70  ip : bceb7d88  fp : bceb7d84
>r10: 8091523c  r9 : 00000000  r8 : bd88f478
>r7 : 803f8a88  r6 : 81165988  r5 : 00000000  r4 : 00000000
>r3 : 00000000  r2 : 00000000  r1 : bd88f478  r0 : bd88f478
>Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>Control: 10c5387d  Table: 4cd1404a  DAC: 00000015 Process sh (pid: 617,
>stack limit = 0xbceb6240)
>Stack: (0xbceb7d70 to 0xbceb8000)
>7d60:                                     00000000 00000000 bceb7dbc
>bceb7d88
>7d80: 80361f44 803f8a94 80671c98 80067974 00000000 00000000 00000000
>bd88f478
>7da0: 00000000 81165988 00000002 bd88f4ac bceb7dec bceb7dc0 80362bc4
>80361f1c
>7dc0: bd88f52c 0088f478 8092fefc bd88f52c bd88f478 8092fefc 81165988
>8092ff64
>7de0: bceb7e34 bceb7df0 80363b2c 80362aa8 c8717e25 00000003 80363f58
>00000002
>7e00: c8717e25 00000003 00000000 00000002 00000003 809153f4 bd7dad80
>8091541c
>7e20: 00000004 807e1bd4 bceb7e4c bceb7e38 80363fd4 80363ad4 81110000
>00000003
>7e40: bceb7e8c bceb7e50 8006c508 80363f80 bceb7e7c bceb7e60 80668bc0
>8006ed58
>7e60: 807e5b54 bceb7e84 00000000 00000003 809153f4 bd7dad80 8091541c
>807e1bd4
>7e80: bceb7eac bceb7e90 8006ca98 8006c474 0000006d 80915414 00000003
>00000003
>7ea0: bceb7edc bceb7eb0 8006b57c 8006c834 00000004 bdb2b000 00000004
>bd7dad80
>7ec0: bceb7f78 00000004 bdb2b00c bdb2b000 bceb7eec bceb7ee0 8029def8
>8006b510
>7ee0: bceb7f0c bceb7ef0 8014754c 8029dee8 801474f8 00000000 00000000
>bd7dad80
>7f00: bceb7f44 bceb7f10 8014688c 80147504 00000000 00000000 00000001
>bdbf9680
>7f20: 00000004 00c95fd8 bceb7f78 00000004 bceb6000 00c95fd8 bceb7f74
>bceb7f48
>7f40: 800e4d6c 801467d0 800ffbb4 800ffb34 00000000 00000000 bdbf9680
>bdbf9680
>7f60: 00000004 00c95fd8 bceb7fa4 bceb7f78 800e5190 800e4cd0 00000000
>00000000
>7f80: 00000004 00c95fd8 00000001 00000004 8000ed24 00000000 00000000
>bceb7fa8
>7fa0: 8000eb60 800e5158 00000004 00c95fd8 00000001 00c95fd8 00000004
>00000000
>7fc0: 00000004 00c95fd8 00000001 00000004 00000020 00c9428c 0007e640
>7eda9848
>7fe0: 00000000 7eda9614 00012b94 466c73ac 600f0010 00000001 00000000
>00000000
>Backtrace:
>[<803f8a88>] (fec_suspend) from [<80361f44>]
>(dpm_run_callback.isra.7+0x34/0x6c)
> r4:00000000 r3:00000000
>[<80361f10>] (dpm_run_callback.isra.7) from [<80362bc4>]
>(__device_suspend+0x128/0x2b8)
> r8:bd88f4ac r7:00000002 r6:81165988 r5:00000000 r4:bd88f478 [<80362a9c>]
>(__device_suspend) from [<80363b2c>] (dpm_suspend+0x64/0x224)
> r8:8092ff64 r7:81165988 r6:8092fefc r5:bd88f478 r4:bd88f52c [<80363ac8>]
>(dpm_suspend) from [<80363fd4>] (dpm_suspend_start+0x60/0x68)
> r10:807e1bd4 r9:00000004 r8:8091541c r7:bd7dad80 r6:809153f4 r5:00000003
> r4:00000002
>[<80363f74>] (dpm_suspend_start) from [<8006c508>]
>(suspend_devices_and_enter+0xa0/0x3c0)
> r5:00000003 r4:81110000
>[<8006c468>] (suspend_devices_and_enter) from [<8006ca98>]
>(pm_suspend+0x270/0x2b0)
> r10:807e1bd4 r8:8091541c r7:bd7dad80 r6:809153f4 r5:00000003 r4:00000000
>[<8006c828>] (pm_suspend) from [<8006b57c>] (state_store+0x78/0xdc)
> r6:00000003 r5:00000003 r4:80915414 r3:0000006d [<8006b504>] (state_store)
>from [<8029def8>] (kobj_attr_store+0x1c/0x28)
> r10:bdb2b000 r9:bdb2b00c r8:00000004 r7:bceb7f78 r6:bd7dad80 r5:00000004
> r4:bdb2b000 r3:00000004
>[<8029dedc>] (kobj_attr_store) from [<8014754c>] (sysfs_kf_write+0x54/0x58)
>[<801474f8>] (sysfs_kf_write) from [<8014688c>]
>(kernfs_fop_write+0xc8/0x188)
> r6:bd7dad80 r5:00000000 r4:00000000 r3:801474f8 [<801467c4>]
>(kernfs_fop_write) from [<800e4d6c>] (vfs_write+0xa8/0x1b0)
> r10:00c95fd8 r9:bceb6000 r8:00000004 r7:bceb7f78 r6:00c95fd8 r5:00000004
> r4:bdbf9680
>[<800e4cc4>] (vfs_write) from [<800e5190>] (SyS_write+0x44/0x90)
> r10:00c95fd8 r8:00000004 r7:bdbf9680 r6:bdbf9680 r5:00000000 r4:00000000
>[<800e514c>] (SyS_write) from [<8000eb60>] (ret_fast_syscall+0x0/0x48)
> r10:00000000 r8:8000ed24 r7:00000004 r6:00000001 r5:00c95fd8 r4:00000004
>Code: e1a0c00d e92dd818 e24cb004 e5904088 (e594302c) ---[ end trace
>fa9dea6c9b5c5526 ]---
>
>I haven't started debugging this issue, but just wanted to report it in
>case someone else is already looking into this.

I use linux net tree cannot reproduce the issue like your log, but show another issue as below log:
(imx6dl sabresd board, Nfs mount rootfs)

root at freescale ~$ uname -r
3.16.0-rc5-01146-gda388973d	
root at freescale ~$ cat /proc/cmdline
console=ttymxc0,115200 uart3 fec.macaddr=0x00,0x01,0x03,0x03,0x03,0x19 ip=dhcp nfsroot=10.192.242.134:/data/rootfs_mx6r,tcp,v3
root at freescale ~$
root at freescale ~$ echo enabled > /sys/class/tty/ttymxc0/power/wakeup
root at freescale ~$   echo mem > /sys/power/state
PM: Syncing filesystems ... done.
Freezing user space processes ...


end_request: I/O error, dev mtdblock0, sector 0
Buffer I/O error on device mtdblock0, logical block 0

Freezing of tasks failed after 20.008 seconds (1 tasks refusing to freeze, wq_busy=0):
hald-probe-stor D 8067ee88     0   806    802 0x00000005
Backtrace:
[<8067ecc0>] (__schedule) from [<8067f2d0>] (schedule+0x38/0x84)
 r10:00000001 r9:00000001 r8:800a7f70 r7:00000002 r6:bd4ae000 r5:be7c3fa8
 r4:be7c3b00
[<8067f298>] (schedule) from [<8067f59c>] (io_schedule+0x8c/0xbc)
[<8067f510>] (io_schedule) from [<800a7f80>] (sleep_on_page+0x10/0x18)
 r6:be7ef7e0 r5:bd4afc0c r4:bd4afc04 r3:00000821
[<800a7f70>] (sleep_on_page) from [<8067fa48>] (__wait_on_bit_lock+0x74/0xc0)
[<8067f9d4>] (__wait_on_bit_lock) from [<800a80d0>] (__lock_page+0x8c/0xa4)
 r9:00000001 r8:bd4afc58 r7:bd4afc90 r6:bd5d2700 r5:80061c38 r4:00000000
[<800a8044>] (__lock_page) from [<800b6a44>] (truncate_inode_pages_range+0x4f4/0x518)
 r6:ffffffff r5:bddb021c r4:befa5ce0
[<800b6550>] (truncate_inode_pages_range) from [<800b6a88>] (truncate_inode_pages+0x20/0x28)
 r10:00000000 r9:00000010 r8:0002001d r7:bd838400 r6:00000000 r5:ffffffff
 r4:ffffffff
[<800b6a68>] (truncate_inode_pages) from [<8011987c>] (kill_bdev+0x40/0x44)
 r5:bddb0010 r4:bddb021c
[<8011983c>] (kill_bdev) from [<8011aef0>] (__blkdev_put+0x70/0x180)
 r4:bddb0000 r3:000200d0
[<8011ae80>] (__blkdev_put) from [<8011b7e0>] (blkdev_put+0x50/0x144)
 r9:00000010 r8:bd8d0f90 r7:bdd8e5c0 r6:bddb0010 r5:0002001d r4:bddb0000
[<8011b790>] (blkdev_put) from [<8011b984>] (blkdev_close+0x20/0x28)
 r7:bdd8e5c0 r6:bd933790 r5:bd8d0f90 r4:bd4d5dc0
[<8011b964>] (blkdev_close) from [<800e9014>] (__fput+0x90/0x1d4)
[<800e8f84>] (__fput) from [<800e91c0>] (____fput+0x10/0x14)
 r10:bdb5c780 r9:00000000 r8:00000000 r7:bd5d2700 r6:80975100 r5:00000000
 r4:bd5d2aa8
[<800e91b0>] (____fput) from [<80045354>] (task_work_run+0xb8/0xe8)
[<8004529c>] (task_work_run) from [<8002bbb0>] (do_exit+0x320/0x970)
 r8:bd5d2700 r7:bd4ae028 r6:bd4ae000 r5:0000000f r4:bd5d2ab8 r3:00000000
[<8002b890>] (do_exit) from [<8002d06c>] (do_group_exit+0x48/0xb8)
 r7:bd4ae028
[<8002d024>] (do_group_exit) from [<80039054>] (get_signal_to_deliver+0x220/0x5d4)
 r7:bd4ae028 r6:bd4afecc r5:00000009 r4:00418004
[<80038e34>] (get_signal_to_deliver) from [<80011944>] (do_signal+0x114/0x438)
 r10:00000000 r9:fffffffc r8:76dda1bc r7:bd4afeb8 r6:bd4ae038 r5:76dda1b8
 r4:bd4affb0
[<80011830>] (do_signal) from [<80011e08>] (do_work_pending+0x9c/0xd4)
 r10:00000000 r9:bd4ae000 r8:8000ec44 r7:bd4affb0 r6:8000ec44 r5:bd4ae000
 r4:bd4ae000
[<80011d6c>] (do_work_pending) from [<8000ead8>] (work_pending+0xc/0x20)
 r8:8000ec44 r7:00000003 r6:00000800 r5:76e71000 r4:01546b98

Restarting tasks ... done.
root at freescale ~$
root at freescale ~$

Thanks,
Andy
