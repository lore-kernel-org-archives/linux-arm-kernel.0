From: bosko.radivojevic@gmail.com (Bosko Radivojevic)
Date: Fri, 9 Jul 2010 11:25:13 +0200
Subject: Kernel crashing in tcp_sendmsg()
Message-ID: <AANLkTilD3M7d6VFiM9Z-iv7rVyjl7wrjdy9ECh00dfbI@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All!

I have Atmel's AT91SAM9260 based system, Linux 2.6.33.4 kernel with
applied at91 patch. When the system is on a heavy load it happens
quite often to see kernel crashed during web server execution. It
seems the problem it is tcp related. I tried two different web servers
(thttpd and lighttpd) with the same results. I tried to debug the
problem, but without success. Any ideas or hitns how to proceed in
this situtation are more than welcome.

PS. I'm not subscribed to the mailing list so please cc me in replies. Thanks.

Crash report:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c39a4000
[00000000] *pgd=239c1031, *pte=00000000, *ppte=00000000
Internal error: Oops: 817 [#1]
last sysfs file:
Modules linked in: eplcmod
CPU: 0    Not tainted  (2.6.33.4 #42)
PC is at __kprobes_text_end+0x860/0xa80
LR is at csum_partial_copy_from_user+0x18/0x3a4
pc : [<c01e2658>]    lr : [<c0130830>]    psr: 00000013
sp : c3989d68  ip : c3989db4  fp : c3989de8
r10: 4023c000  r9 : c3a5d990  r8 : 00000000
r7 : 000000ed  r6 : 000004c7  r5 : 00000000  r4 : fffffff2
r3 : 00000000  r2 : 000004c7  r1 : c3a48199  r0 : 4023c000
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 239a4000  DAC: 00000015
Process thttpd (pid: 289, stack limit = 0xc3988260)
Stack: (0xc3989d68 to 0xc398a000)
9d60:                   c3a48199 000004c7 c3a5d920 c39ab8a0 000004c7 000000ed
9d80: 00000000 c01b5384 c3989db4 c3989f00 00000000 0000001f 000006b6 000005b4
9da0: c3988000 c00667dc 000005b4 00000040 000000ed 00000000 00000000 000005b4
9dc0: c3989e58 c3989ef8 00000002 c3a55340 000006b6 c3988000 c017f484 c3989e4c
9de0: c3989dec c017f58c c01b5074 00000000 c3846580 c027cd20 000007a3 c342e8c0
9e00: c0261a34 00000000 c3989e0c 00000000 00000000 c3989ef8 00000002 00000000
9e20: 00000000 00000040 c3989e58 c3989e58 c3989f80 fffffdee c3989ef8 00000002
9e40: c3989eec c3989e54 c00bcc90 c017f498 00000000 00000000 c3989e74 c3989e68
9e60: 00000000 00000001 ffffffff c3a55340 00000000 00000000 00000000 00000000
9e80: c3872040 00000000 00000000 00000000 00000000 c3989dec 0000001f 000007a3
9ea0: 00000000 000007a3 c3989ef8 c3988000 bec82920 c0022208 c3989ef8 00000010
9ec0: 00000000 00000002 00000001 000007a3 c3a55340 00000002 000007a3 c3989f80
9ee0: c3989f60 c3989ef0 c00bd364 c00bcbf8 c3989f80 c017f484 00046b88 000000ed
9f00: 4023c000 000006b6 00000092 c0022208 c3988000 00004fa6 c3989f34 c3989f28
9f20: c00267e8 c0026628 c3989fa4 c3989f38 c0021bec c00267a4 c3989ef8 00000002
9f40: bec82920 00000000 00000092 c0022208 000006b6 c3989f7c c3989f64 c00bd4c0
9f60: c00bd2c0 c3989f80 c3a55340 00000000 c3989fa4 c3989f80 c00bd5ac c00bd468
9f80: 00000000 00000000 00000000 0002a208 00022740 bec84db4 00000000 c3989fa8
9fa0: c0022044 c00bd570 0002a208 00022740 00000002 bec82920 00000002 00000000
9fc0: 0002a208 00022740 bec84db4 00022740 00044dd8 bec8253c 000006b6 bec82920
9fe0: 000217c8 bec81534 0000c6d0 4004b210 20000010 00000002 00000000 00000000
Backtrace:
[<c01b5064>] (tcp_sendmsg+0x0/0xaf0) from [<c017f58c>]
(sock_aio_write+0x108/0x118)
[<c017f488>] (sock_aio_write+0x4/0x118) from [<c00bcc90>]
(do_sync_readv_writev+0xa8/0xe8)
 r8:00000002 r7:c3989ef8 r6:fffffdee r5:c3989f80 r4:c3989e58
[<c00bcbe8>] (do_sync_readv_writev+0x0/0xe8) from [<c00bd364>]
(do_readv_writev+0xb4/0x1a8)
[<c00bd2b0>] (do_readv_writev+0x0/0x1a8) from [<c00bd4c0>]
(vfs_writev+0x68/0x74)
[<c00bd458>] (vfs_writev+0x0/0x74) from [<c00bd5ac>] (sys_writev+0x4c/0x80)
 r5:00000000 r4:c3a55340
[<c00bd560>] (sys_writev+0x0/0x80) from [<c0022044>]
(ret_fast_syscall+0x0/0x10)
 r6:bec84db4 r5:00022740 r4:0002a208
Code: 00000000 00000000 e3e0400d e59b5004 (e5854000)
---[ end trace c238dd9fcae91d1d ]---

snippets from objdump -d vmliux:

c0130818 <csum_partial_copy_from_user>:
c0130818:       e92d41f6        push    {r1, r2, r4, r5, r6, r7, r8, lr}
c013081c:       e3520008        cmp     r2, #8
c0130820:       3affffe3        bcc     c01307b4
<csum_partial_copy_nocheck+0x3b4>
c0130824:       e2933000        adds    r3, r3, #0
c0130828:       e3110003        tst     r1, #3
c013082c:       1bffffd0        blne    c0130774
<csum_partial_copy_nocheck+0x374>
c0130830:       e3100003        tst     r0, #3
c0130834:       1a00002f        bne     c01308f8
<csum_partial_copy_from_user+0xe0>
[..]

c0130400 <csum_partial_copy_nocheck>:
[..]
c01307b4:       e3320000        teq     r2, #0
c01307b8:       0affffeb        beq     c013076c
<csum_partial_copy_nocheck+0x36c>
c01307bc:       e3110001        tst     r1, #1
c01307c0:       0a00000c        beq     c01307f8
<csum_partial_copy_nocheck+0x3f8>
c01307c4:       e4f0c001        ldrbt   ip, [r0], #1
c01307c8:       e2422001        sub     r2, r2, #1
c01307cc:       e0b3340c        adcs    r3, r3, ip, lsl #8
c01307d0:       e4c1c001        strb    ip, [r1], #1
c01307d4:       e3120006        tst     r2, #6
c01307d8:       0a000008        beq     c0130800
<csum_partial_copy_nocheck+0x400>
c01307dc:       e4f08001        ldrbt   r8, [r0], #1
c01307e0:       e4f0c001        ldrbt   ip, [r0], #1
c01307e4:       e2422002        sub     r2, r2, #2
c01307e8:       e0b33008        adcs    r3, r3, r8
c01307ec:       e4c18001        strb    r8, [r1], #1
c01307f0:       e0b3340c        adcs    r3, r3, ip, lsl #8
c01307f4:       e4c1c001        strb    ip, [r1], #1
c01307f8:       e3120006        tst     r2, #6
c01307fc:       1afffff6        bne     c01307dc
<csum_partial_copy_nocheck+0x3dc>
c0130800:       e3120001        tst     r2, #1
c0130804:       0a000036        beq     c01308e4
<csum_partial_copy_from_user+0xcc>
c0130808:       e4f08001        ldrbt   r8, [r0], #1
c013080c:       e0b33008        adcs    r3, r3, r8
c0130810:       e4c18001        strb    r8, [r1], #1
c0130814:       ea000032        b       c01308e4
<csum_partial_copy_from_user+0xcc>
[..]
