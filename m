From: jean-michel.hautbois@veo-labs.com (Jean-Michel Hautbois)
Date: Fri, 6 Nov 2015 17:32:30 +0100
Subject: i.MX6: Oops when unplugging a USB key
Message-ID: <CAH-u=81BFm1nquN5z7hFN9auV=9dPMPkRFX_PneK22UXgPbJnA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi !

I have an issue on my i.MX6 board I don't understand (kernel is a 4.2)...
When I connect a USB key, and then disconnect it, it oopses and
reboots (as I have panic on oops, and reboot on panic).
Seems to be on the umount part...
The USB is connected through a smsc95xx but I don't think this is related...

Any idea is welcome :)

[  571.128235] usb-storage 1-1.4:1.0: USB Mass Storage device detected
[  571.140704] scsi host1: usb-storage 1-1.4:1.0
[  572.936422] scsi 1:0:0:0: Direct-Access     Verbatim STORE N GO
  1100 PQ: 0 ANSI: 0 CCS
[  572.959867] sd 1:0:0:0: [sdb] 7831552 512-byte logical blocks:
(4.00 GB/3.73 GiB)
[  572.968380] sd 1:0:0:0: [sdb] Write Protect is off
[  572.987033] sd 1:0:0:0: [sdb] No Caching mode page found
[  572.992455] sd 1:0:0:0: [sdb] Assuming drive cache: write through
[  573.013121]  sdb: sdb1
[  573.029477] sd 1:0:0:0: [sdb] Attached SCSI removable disk
[  574.073686] EXT4-fs (sdb1): recovery complete
[  574.083047] EXT4-fs (sdb1): mounted filesystem with ordered data
mode. Opts: (null)
[  588.296126] usb 1-1.4: USB disconnect, device number 4
[  588.685817] Buffer I/O error on dev sdb1, logical block 425984,
lost sync page write
[  588.695588] JBD2: Error -5 detected when updating journal
superblock for sdb1-8.
[  588.703026] Aborting journal on device sdb1-8.
[  588.707511] Buffer I/O error on dev sdb1, logical block 425984,
lost sync page write
[  588.715821] JBD2: Error -5 detected when updating journal
superblock for sdb1-8.
[  588.724018] EXT4-fs (sdb1): previous I/O error to superblock detected
[  588.730896] Unable to handle kernel paging request at virtual
address 264bc000
[  588.738128] pgd = a2ed8000
[  588.740842] [264bc000] *pgd=00000000
[  588.744445] Internal error: Oops: 5 [#1] SMP ARM
[  588.749069] Modules linked in: imx6q_cpufreq snd_soc_adv76xx
smsc95xx usbnet adv7604 snd_soc_sgtl5000 fbcon bitblit softcursor font
[  588.771308] CPU: 1 PID: 1561 Comm: umount Tainted: G         C
4.2.0+g7eebce7 #1
[  588.779143] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  588.785677] task: a5c73b00 ti: a5c60000 task.ti: a5c60000
[  588.791091] PC is at __percpu_counter_add+0x48/0x11c
[  588.796062] LR is at 0x10
[  588.798690] pc : [<803dcce4>]    lr : [<00000010>]    psr: 800d0093
[  588.798690] sp : a5c61db8  ip : 00000000  fp : a5c61ddc
[  588.810172] r10: 80f40b7c  r9 : 00000000  r8 : 00000001
[  588.815402] r7 : 80ffef10  r6 : 264bc000  r5 : 80f415b8  r4 : a61a4ed0
[  588.821934] r3 : 00000000  r2 : 00000001  r1 : 00000000  r0 : 00000002
[  588.828468] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[  588.835695] Control: 10c5387d  Table: 32ed804a  DAC: 00000015
[  588.841446] Process umount (pid: 1561, stack limit = 0xa5c60210)
[  588.847457] Stack: (0xa5c61db8 to 0xa5c62000)
[  588.851823] 1da0:
    80f40b7c a61a4e48
[  588.860008] 1dc0: bfb90120 80ffef10 a3460488 80ffd3c8 a5c61e0c
a5c61de0 80119578 803dcca8
[  588.868193] 1de0: 00000010 00000000 a34605d4 bfb90120 00000000
a34605e4 a00d0013 a2c09400
[  588.876378] 1e00: a5c61e34 a5c61e10 8019b764 80119470 00000a32
bfb90120 00000000 a34605d4
[  588.884562] 1e20: 80ffd4aa 9d9bd380 a5c61e54 a5c61e38 8019b8b0
8019b708 00000000 a6340800
[  588.892747] 1e40: 80f40ac4 80f415b8 a5c61e94 a5c61e58 802346e4
8019b7cc 002cf5ed 00000000
[  588.900932] 1e60: a2c09400 00000001 00000000 a6344000 a2c09400
a6340800 00000000 00000000
[  588.909117] 1e80: a5c60000 00000000 a5c61ecc a5c61e98 802354d8
80234584 8017de58 8017ca04
[  588.917301] 1ea0: a5c61ea0 a5c61ea0 a63408a4 a6340800 a63408a4
8091ab30 00000000 00000000
[  588.925486] 1ec0: a5c61eec a5c61ed0 80161680 8023540c 80161990
a3460380 00000083 a5c73b00
[  588.933670] 1ee0: a5c61f0c a5c61ef0 801619b8 8016160c 80161990
a6340800 80f763c8 a5c73b00
[  588.941855] 1f00: a5c61f24 a5c61f10 80161e28 8016199c a6340800
810111f4 a5c61f3c a5c61f28
[  588.950041] 1f20: 801629a0 80161dc4 a5fe9e00 810111f4 a5c61f54
a5c61f40 80182470 80162940
[  588.958225] 1f40: 80182510 a5c73e54 a5c61f64 a5c61f58 8018252c
80182430 a5c61f8c a5c61f68
[  588.966409] 1f60: 80052950 8018251c a5fe9e1c 00000000 a5c60000
a5c61fb0 80010ce4 80010ce4
[  588.974594] 1f80: a5c61fac a5c61f90 80014b94 80052898 014be038
014be158 76f83680 00000034
[  588.982778] 1fa0: 00000000 a5c61fb0 80010b64 80014b08 00000000
00000000 00000000 00000002
[  588.990963] 1fc0: 014be038 014be158 76f83680 00000034 00000000
014bf9d0 00000000 ffffffff
[  588.999148] 1fe0: 76ee22d4 7eed76dc 76f58e28 76ee22ec 60070010
014be158 00000000 00000000
[  589.007329] Backtrace:
[  589.009809] [<803dcc9c>] (__percpu_counter_add) from [<80119578>]
(account_page_dirtied+0x114/0x38c)
[  589.018946]  r9:80ffd3c8 r8:a3460488 r7:80ffef10 r6:bfb90120
r5:a61a4e48 r4:80f40b7c
[  589.026789] [<80119464>] (account_page_dirtied) from [<8019b764>]
(__set_page_dirty.constprop.40+0x68/0xc4)
[  589.036534]  r9:a2c09400 r8:a00d0013 r7:a34605e4 r6:00000000
r5:bfb90120 r4:a34605d4
[  589.044370] [<8019b6fc>] (__set_page_dirty.constprop.40) from
[<8019b8b0>] (mark_buffer_dirty+0xf0/0x2cc)
[  589.053940]  r8:9d9bd380 r7:80ffd4aa r6:a34605d4 r5:00000000
r4:bfb90120 r3:00000a32
[  589.061785] [<8019b7c0>] (mark_buffer_dirty) from [<802346e4>]
(ext4_commit_super+0x16c/0x23c)
[  589.070401]  r7:80f415b8 r6:80f40ac4 r5:a6340800 r4:00000000
[  589.076136] [<80234578>] (ext4_commit_super) from [<802354d8>]
(ext4_put_super+0xd8/0x310)
[  589.084404]  r10:00000000 r9:a5c60000 r8:00000000 r7:00000000
r6:a6340800 r5:a2c09400
[  589.092320]  r4:a6344000
[  589.094882] [<80235400>] (ext4_put_super) from [<80161680>]
(generic_shutdown_super+0x80/0xe8)
[  589.103497]  r8:00000000 r7:00000000 r6:8091ab30 r5:a63408a4 r4:a6340800
[  589.110291] [<80161600>] (generic_shutdown_super) from [<801619b8>]
(kill_block_super+0x28/0x7c)
[  589.119079]  r6:a5c73b00 r5:00000083 r4:a3460380 r3:80161990
[  589.124814] [<80161990>] (kill_block_super) from [<80161e28>]
(deactivate_locked_super+0x70/0x94)
[  589.133690]  r6:a5c73b00 r5:80f763c8 r4:a6340800 r3:80161990
[  589.139425] [<80161db8>] (deactivate_locked_super) from
[<801629a0>] (deactivate_super+0x6c/0x70)
[  589.148300]  r5:810111f4 r4:a6340800
[  589.151923] [<80162934>] (deactivate_super) from [<80182470>]
(cleanup_mnt+0x4c/0x94)
[  589.159757]  r5:810111f4 r4:a5fe9e00
[  589.163375] [<80182424>] (cleanup_mnt) from [<8018252c>]
(__cleanup_mnt+0x1c/0x20)
[  589.170948]  r4:a5c73e54 r3:80182510
[  589.174569] [<80182510>] (__cleanup_mnt) from [<80052950>]
(task_work_run+0xc4/0x10c)
[  589.182417] [<8005288c>] (task_work_run) from [<80014b94>]
(do_work_pending+0x98/0xc0)
[  589.190337]  r8:80010ce4 r7:80010ce4 r6:a5c61fb0 r5:a5c60000
r4:00000000 r3:a5fe9e1c
[  589.198175] [<80014afc>] (do_work_pending) from [<80010b64>]
(work_pending+0xc/0x20)
[  589.205922]  r7:00000034 r6:76f83680 r5:014be158 r4:014be038
[  589.211655] Code: e5916010 e594c038 e7956106 e1a01fce (e79cc006)
[  589.217764] ---[ end trace e99f4ace915e36a8 ]---
[  589.222388] Kernel panic - not syncing: Fatal exception

Thanks,
JM
