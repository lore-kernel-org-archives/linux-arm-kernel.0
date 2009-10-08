From: arasv@magellan-technology.com (Aras Vaichas)
Date: Fri, 9 Oct 2009 09:45:26 +1100
Subject: jffs2_gcd_mtd oops
Message-ID: <ed62800910081545x7bd8fe42g7f14afb356f0fb54@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, I'm using 2.6.26.3 + AT91 patches on at at91rm9200 custom board
with a JFFS2 rootfs on NAND. I'm doing a test where I FTP a large file
on to the NAND flash over and over again. The file is quite large and
causes the NAND to reach 82% full.

Eventually it stops working and creates an oops (see attached).

During the test I observed the system freeze (no console activity, no
heartbeat LED) for up to 30 seconds. I assumed that this was caused by
the JFFS2 gcd.

After the crash I can see that there are about 20 instances of ftpd in
the process list.

What would be the most likely cause of this crash? FTPD, or the
garbage collection daemon?

Should I simply move to UBIFS or update my kernel version?

--- SNIP ---

Unable to handle kernel paging request at virtual address 00100100
pgd = c0004000
[00100100] *pgd=00000000
Internal error: Oops: 17 [#1] PREEMPT
Modules linked in: g_ether vfat fat nls_base
CPU: 0    Not tainted  (2.6.26.3-magarm #110)
PC is at jffs2_thread_should_wake+0x94/0xa4
LR is at 0xa8000
pc : [<c00fa200>]    lr : [<000a8000>]    psr: 80000013
sp : c1d05f3c  ip : 0000002a  fp : c1d05f54
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000001  r6 : 00000002  r5 : 00000001  r4 : c1cfcc00
r3 : 00000039  r2 : 00100100  r1 : c1cfcc8c  r0 : 00000000
Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000317f  Table: 21f88000  DAC: 00000017
Process jffs2_gcd_mtd5 (pid: 198, stack limit = 0xc1d04260)
Stack: (0xc1d05f3c to 0xc1d06000)
5f20:                                                                40000013
5f40: c1d04000 c1cfcc00 c1d05ff4 c1d05f58 c0101c4c c00fa17c 00000001 00000000
5f60: 00000080 00000000 00000000 00000000 00000047 00012814 c1d05f98 c1d05f88
5f80: c01ee8e4 c01ee560 c1d04000 c1d05fac c1d05f9c c0035f70 c01ee8b8 00000000
5fa0: 00000000 c1d05fb0 c0023b84 c0035f48 00000000 c1cfcc00 c0101bcc c003c894
5fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
5fe0: 00000000 00000000 00000000 c1d05ff8 c003c894 c0101bdc 7e93e2dd 687b106b
Backtrace:
[<c00fa16c>] (jffs2_thread_should_wake+0x0/0xa4) from [<c0101c4c>]
(jffs2_garbage_collect_thread+0x80/0x1bc)
 r6:c1cfcc00 r5:c1d04000 r4:40000013
[<c0101bcc>] (jffs2_garbage_collect_thread+0x0/0x1bc) from
[<c003c894>] (do_exit+0x0/0x65c)
 r7:00000000 r6:00000000 r5:00000000 r4:00000000
Code: e5d4306d e2866001 e1560003 0affffe5 (e5922000)
---[ end trace c9f69e2833be38d7 ]---

Unable to handle kernel NULL pointer dereference at virtual address 00000034
pgd = c1f88000
[00000034] *pgd=21fd4031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#2] PREEMPT
Modules linked in: g_ether vfat fat nls_base
CPU: 0    Tainted: G      D    (2.6.26.3-magarm #110)
PC is at prepare_signal+0x14/0x18c
LR is at send_signal+0x24/0x1e0
pc : [<c004579c>]    lr : [<c0045b50>]    psr: 80000093
sp : c1fa9bcc  ip : c1fa9bec  fp : c1fa9be8
r10: c1c59cc0  r9 : 00000000  r8 : c1cfcc00
r7 : 00000001  r6 : c1c59cc0  r5 : 00000000  r4 : c1fa8000
r3 : 00000000  r2 : c1c59cc0  r1 : c1c59cc0  r0 : 00000001
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: c000317f  Table: 21f88000  DAC: 00000015
Process ftpd (pid: 814, stack limit = 0xc1fa8260)
Stack: (0xc1fa9bcc to 0xc1faa000)
9bc0:                            c1fa8000 80000013 00000001 00000001 c1fa9c14
9be0: c1fa9bec c0045b50 c0045798 c1fa8000 80000013 c1d66000 c1872540 c1cfcc00
9c00: 00cbf000 00000000 c1fa9c24 c1fa9c18 c0045d38 c0045b3c c1fa9c40 c1fa9c28
9c20: c00462c4 c0045d34 c1fa8000 c1cfcc00 c1d66000 c1fa9c50 c1fa9c44 c0046310
9c40: c0046298 c1fa9c68 c1fa9c54 c0101ab0 c0046300 c1cfcc00 00000000 c1fa9c7c
9c60: c1fa9c6c c00f95ac c0101a78 c103cf10 c1fa9cd4 c1fa9c80 c00fcc5c c00f95a8
9c80: 00001000 00000003 00000000 00000000 c0414000 00001000 00001000 c0414000
9ca0: 00001548 60c8c5e3 60c8c5e3 00001000 00000000 c1872540 c1d66000 c1872568
9cc0: 00000000 c029d280 c1fa9d2c c1fa9cd8 c00f7b5c c00fc9bc 00cbf000 00001000
9ce0: c1fa9cf8 c18725a8 00000000 00001000 00cbf000 00000000 00000000 00005bd2
9d00: 00005bd2 c01f8400 c1fa8000 00cbf000 00000000 00001000 00001000 00000000
9d20: c1fa9dc0 c1fa9d30 c0067e2c c00f7a14 00001000 00001000 c029d280 00005bd2
9d40: c1872600 000b985a 00000000 00393870 00000000 c1fc4ba8 c0282148 00001000
9d60: 00000000 00001000 c01f8400 c1872568 c01f8400 c1872600 c104aa00 c1fa9ea8
9d80: 00005bd2 c029d280 c1fa9ea0 00000001 00001000 00001000 00cbe000 00000000
9da0: 00cc0000 00000000 00000000 c1fa9df4 c1fa9df0 c1fa9e54 c1fa9dc8 c0068b60
9dc0: c0067ca8 00cbe000 00000000 c1fa9ef0 00002000 00000000 00000000 c1872600
9de0: c104aa00 c1fa9ef0 c1fa9ea0 c1fa9ea8 00002000 00cbe000 00000000 00002000
9e00: 00000001 13228714 00005bd2 c1fa8000 13308dcc 00005bd2 c0271fe8 c1fa9e70
9e20: c1fa9e2c c00535a8 c0059554 c1fa9ea8 c1872568 00cbe000 00000000 c1fa9ef0
9e40: c1fa9ea0 c18725d4 c1fa9e94 c1fa9e58 c0068c10 c0068624 c01ee8b8 c1fa9e5c
9e60: c1872600 c104aa00 00000001 c1fa9ea8 c1fa9ef0 c104aa00 c1fa9f78 c1fa9ea0
9e80: 00000000 0001f9f0 c1fa9f50 c1fa9e9c c0087794 c0068ba4 00cbe000 00000000
9ea0: bea8ff10 00002000 c1c59cc0 c1fc4cd8 00000000 00000001 ffffffff c104aa00
9ec0: 00000000 00000000 00000000 00000000 c1fc4b80 00000000 00000000 c1001300
9ee0: c1fc4b80 c004fa44 c1fa9ee8 c1fa9ee8 00cbe000 00000000 00000000 00000000
9f00: c1fa8000 c1fa9f78 00002000 c1fa9f2c c1fa9f1c c01ee8e4 c01ee560 00000000
9f20: c1fa9f64 c1fa9f30 c003e440 c104aa00 bea8ff10 c1fa9f78 00002000 00000000
9f40: c1fa8000 c1fa9f74 c1fa9f54 c00878a8 c00876e4 0001f9f0 c104aa20 c104aa00
9f60: c1fa9f78 00cbe000 c1fa9fa4 c1fa9f78 c00879ec c00877f4 00cbe000 00000000
9f80: 00000000 00002000 bea8ff10 00024988 00000004 c0023ca4 00000000 c1fa9fa8
9fa0: c0023b00 c00879b0 00002000 bea8ff10 00000004 bea8ff10 00002000 fbad2484
9fc0: 00002000 bea8ff10 00024988 00024698 00012848 00000000 0001f9f0 bea92584
9fe0: 00000000 bea8ff08 0000b570 401110b4 60000010 00000004 7c647c07 df146cf7
Backtrace:
[<c0045788>] (prepare_signal+0x0/0x18c) from [<c0045b50>]
(send_signal+0x24/0x1e0)
 r7:00000001 r6:00000001 r5:80000013 r4:c1fa8000
[<c0045b2c>] (send_signal+0x0/0x1e0) from [<c0045d38>]
(specific_send_sig_info+0x14/0x18)
[<c0045d24>] (specific_send_sig_info+0x0/0x18) from [<c00462c4>]
(send_sig_info+0x3c/0x68)
[<c0046288>] (send_sig_info+0x0/0x68) from [<c0046310>] (send_sig+0x20/0x24)
 r6:c1d66000 r5:c1cfcc00 r4:c1fa8000
[<c00462f0>] (send_sig+0x0/0x24) from [<c0101ab0>]
(jffs2_garbage_collect_trigger+0x48/0x68)
[<c0101a68>] (jffs2_garbage_collect_trigger+0x0/0x68) from
[<c00f95ac>] (jffs2_complete_reservation+0x14/0x20)
 r5:00000000 r4:c1cfcc00
[<c00f9598>] (jffs2_complete_reservation+0x0/0x20) from [<c00fcc5c>]
(jffs2_write_inode_range+0x2b0/0x31c)
 r4:c103cf10
[<c00fc9ac>] (jffs2_write_inode_range+0x0/0x31c) from [<c00f7b5c>]
(jffs2_write_end+0x158/0x294)
[<c00f7a04>] (jffs2_write_end+0x0/0x294) from [<c0067e2c>]
(generic_file_buffered_write+0x198/0x680)
[<c0067c98>] (generic_file_buffered_write+0x4/0x680) from [<c0068b60>]
(__generic_file_aio_write_nolock+0x54c/0x57c)
[<c0068614>] (__generic_file_aio_write_nolock+0x0/0x57c) from
[<c0068c10>] (generic_file_aio_write+0x80/0xf4)
[<c0068b94>] (generic_file_aio_write+0x4/0xf4) from [<c0087794>]
(do_sync_write+0xc0/0x110)
[<c00876d4>] (do_sync_write+0x0/0x110) from [<c00878a8>] (vfs_write+0xc4/0x148)
 r9:c1fa8000 r8:00000000 r7:00002000 r6:c1fa9f78 r5:bea8ff10
r4:c104aa00
[<c00877e4>] (vfs_write+0x0/0x148) from [<c00879ec>] (sys_write+0x4c/0x74)
 r7:00cbe000 r6:c1fa9f78 r5:c104aa00 r4:c104aa20
[<c00879a0>] (sys_write+0x0/0x74) from [<c0023b00>] (ret_fast_syscall+0x0/0x2c)
 r8:c0023ca4 r7:00000004 r6:00024988 r5:bea8ff10 r4:00002000
Code: e92dd8f0 e24cb004 e5915230 e1a06001 (e5953034)
---[ end trace c9f69e2833be38d7 ]---

note: ftpd[814] exited with preempt_count 2
Unable to handle kernel NULL pointer dereference at virtual address 00000034
pgd = c0004000
[00000034] *pgd=00000000
Internal error: Oops: 17 [#3] PREEMPT
Modules linked in: g_ether vfat fat nls_base
CPU: 0    Tainted: G      D    (2.6.26.3-magarm #110)
PC is at prepare_signal+0x14/0x18c
LR is at send_signal+0x24/0x1e0
pc : [<c004579c>]    lr : [<c0045b50>]    psr: 80000093
sp : c1c69e74  ip : c1c69e94  fp : c1c69e90
r10: c1c59cc0  r9 : 00000000  r8 : c1c69f54
r7 : 00000001  r6 : c1c59cc0  r5 : 00000000  r4 : c1c68000
r3 : 00000000  r2 : c1c59cc0  r1 : c1c59cc0  r0 : 00000001
Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: c000317f  Table: 21eb0000  DAC: 00000017
Process pdflush (pid: 75, stack limit = 0xc1c68260)
Stack: (0xc1c69e74 to 0xc1c6a000)
9e60:                                              c1c68000 80000013 00000001
9e80: 00000001 c1c69ebc c1c69e94 c0045b50 c0045798 c1c68000 80000013 c1cfca3c
9ea0: c0275e48 c1c69f54 00000000 00000000 c1c69ecc c1c69ec0 c0045d38 c0045b3c
9ec0: c1c69ee8 c1c69ed0 c00462c4 c0045d34 c1c68000 c1cfcc00 c1cfca3c c1c69ef8
9ee0: c1c69eec c0046310 c0046298 c1c69f10 c1c69efc c0101ab0 c0046300 c1cfcc00
9f00: 00000000 c1c69f28 c1c69f14 c010297c c0101a78 c1cfca00 c1c68000 c1c69f48
9f20: c1c69f2c c0089640 c0102960 c1c68000 c1c69fb0 c0271788 c1c69fa4 c1c69f9c
9f40: c1c69f4c c006d9b8 c00895a4 c1c585c0 c1c69f70 00000000 00000000 c1c69f4c
9f60: 00000000 00000000 00000000 00000000 00000000 00000000 00000025 c1c68000
9f80: c1c69fb0 c02759e0 c1c69fa4 c0271788 c1c69fdc c1c69fa0 c006ecc0 c006d970
9fa0: 00000001 c1c585c0 c006d960 00000000 c1c69fb0 c1c69fb0 016a88cf fffffffc
9fc0: c006eb1c 00000000 00000000 00000000 c1c69ff4 c1c69fe0 c004f36c c006eb2c
9fe0: 00000000 00000000 00000000 c1c69ff8 c003c894 c004f328 ff7ffbff dfddfa7f
Backtrace:
[<c0045788>] (prepare_signal+0x0/0x18c) from [<c0045b50>]
(send_signal+0x24/0x1e0)
 r7:00000001 r6:00000001 r5:80000013 r4:c1c68000
[<c0045b2c>] (send_signal+0x0/0x1e0) from [<c0045d38>]
(specific_send_sig_info+0x14/0x18)
[<c0045d24>] (specific_send_sig_info+0x0/0x18) from [<c00462c4>]
(send_sig_info+0x3c/0x68)
[<c0046288>] (send_sig_info+0x0/0x68) from [<c0046310>] (send_sig+0x20/0x24)
 r6:c1cfca3c r5:c1cfcc00 r4:c1c68000
[<c00462f0>] (send_sig+0x0/0x24) from [<c0101ab0>]
(jffs2_garbage_collect_trigger+0x48/0x68)
[<c0101a68>] (jffs2_garbage_collect_trigger+0x0/0x68) from
[<c010297c>] (jffs2_write_super+0x2c/0x48)
 r5:00000000 r4:c1cfcc00
[<c0102950>] (jffs2_write_super+0x0/0x48) from [<c0089640>]
(sync_supers+0xac/0x10c)
 r5:c1c68000 r4:c1cfca00
[<c0089594>] (sync_supers+0x0/0x10c) from [<c006d9b8>] (wb_kupdate+0x58/0x14c)
 r7:c1c69fa4 r6:c0271788 r5:c1c69fb0 r4:c1c68000
[<c006d960>] (wb_kupdate+0x0/0x14c) from [<c006ecc0>] (pdflush+0x1a4/0x298)
 r8:c0271788 r7:c1c69fa4 r6:c02759e0 r5:c1c69fb0 r4:c1c68000
[<c006eb1c>] (pdflush+0x0/0x298) from [<c004f36c>] (kthread+0x54/0x7c)
 r8:00000000 r7:00000000 r6:00000000 r5:c006eb1c r4:fffffffc
[<c004f318>] (kthread+0x0/0x7c) from [<c003c894>] (do_exit+0x0/0x65c)
 r5:00000000 r4:00000000
Code: e92dd8f0 e24cb004 e5915230 e1a06001 (e5953034)
---[ end trace c9f69e2833be38d7 ]---
------------[ cut here ]------------

WARNING: at kernel/exit.c:965 do_exit+0x34/0x65c()
Modules linked in: g_ether vfat fat nls_base
[<c0027650>] (dump_stack+0x0/0x14) from [<c0039f44>]
(warn_on_slowpath+0x4c/0x68)
[<c0039ef8>] (warn_on_slowpath+0x0/0x68) from [<c003c8c8>] (do_exit+0x34/0x65c)
 r6:0000000b r5:c1c585c0 r4:c1c68000
[<c003c894>] (do_exit+0x0/0x65c) from [<c0027884>] (die+0x1d8/0x210)
[<c00276ac>] (die+0x0/0x210) from [<c0028d0c>] (__do_kernel_fault+0x6c/0x7c)
[<c0028ca0>] (__do_kernel_fault+0x0/0x7c) from [<c0029044>]
(do_page_fault+0x208/0x224)
 r7:c1c69e2c r6:00000017 r5:c1c585c0 r4:ffffffff
[<c0028e3c>] (do_page_fault+0x0/0x224) from [<c0023228>]
(do_DataAbort+0x3c/0xa0)
[<c00231ec>] (do_DataAbort+0x0/0xa0) from [<c00236c0>] (__dabt_svc+0x40/0x60)
Exception stack(0xc1c69e2c to 0xc1c69e74)
9e20:                            00000001 c1c59cc0 c1c59cc0 00000000 c1c68000
9e40: 00000000 c1c59cc0 00000001 c1c69f54 00000000 c1c59cc0 c1c69e90 c1c69e94
9e60: c1c69e74 c0045b50 c004579c 80000093 ffffffff
 r8:c1c69f54 r7:00000001 r6:c1c59cc0 r5:c1c69e60 r4:ffffffff
[<c0045788>] (prepare_signal+0x0/0x18c) from [<c0045b50>]
(send_signal+0x24/0x1e0)
 r7:00000001 r6:00000001 r5:80000013 r4:c1c68000
[<c0045b2c>] (send_signal+0x0/0x1e0) from [<c0045d38>]
(specific_send_sig_info+0x14/0x18)
[<c0045d24>] (specific_send_sig_info+0x0/0x18) from [<c00462c4>]
(send_sig_info+0x3c/0x68)
[<c0046288>] (send_sig_info+0x0/0x68) from [<c0046310>] (send_sig+0x20/0x24)
 r6:c1cfca3c r5:c1cfcc00 r4:c1c68000
[<c00462f0>] (send_sig+0x0/0x24) from [<c0101ab0>]
(jffs2_garbage_collect_trigger+0x48/0x68)
[<c0101a68>] (jffs2_garbage_collect_trigger+0x0/0x68) from
[<c010297c>] (jffs2_write_super+0x2c/0x48)
 r5:00000000 r4:c1cfcc00
[<c0102950>] (jffs2_write_super+0x0/0x48) from [<c0089640>]
(sync_supers+0xac/0x10c)
 r5:c1c68000 r4:c1cfca00
[<c0089594>] (sync_supers+0x0/0x10c) from [<c006d9b8>] (wb_kupdate+0x58/0x14c)
 r7:c1c69fa4 r6:c0271788 r5:c1c69fb0 r4:c1c68000
[<c006d960>] (wb_kupdate+0x0/0x14c) from [<c006ecc0>] (pdflush+0x1a4/0x298)
 r8:c0271788 r7:c1c69fa4 r6:c02759e0 r5:c1c69fb0 r4:c1c68000
[<c006eb1c>] (pdflush+0x0/0x298) from [<c004f36c>] (kthread+0x54/0x7c)
 r8:00000000 r7:00000000 r6:00000000 r5:c006eb1c r4:fffffffc
[<c004f318>] (kthread+0x0/0x7c) from [<c003c894>] (do_exit+0x0/0x65c)
 r5:00000000 r4:00000000
---[ end trace c9f69e2833be38d7 ]---
note: pdflush[75] exited with preempt_count 2


Aras
