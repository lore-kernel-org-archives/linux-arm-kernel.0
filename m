From: ccross@google.com (Colin Cross)
Date: Wed, 13 Jul 2011 23:52:21 -0700
Subject: [PATCH] ARM: move memory layout sanity checking before meminfo
	initialization
In-Reply-To: <20110705185758.GI8286@n2100.arm.linux.org.uk>
References: <20110705185758.GI8286@n2100.arm.linux.org.uk>
Message-ID: <CAMbhsRRQ9D+VXTZP3vB7egkROEtN9-FxssFa2EcxuqB3F-Uv6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 5, 2011 at 11:57 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Ensure that the meminfo array is sanity checked before we pass the
> memory to memblock. ?This helps to ensure that memblock and meminfo
> agree on the dimensions of memory, especially when more memory is
> passed than the kernel can deal with.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This patch causes a regression in v3.0-rc7 when overlapping mem=
options are passed to the kernel.  On an OMAP4 board, I was
accidentally using "mem=512M mem=920M" on the command line, which
works fine in v3.0-rc6.  In v3.0-rc7, it causes a BUG during boot.
Reverting this patch fixes the problem, as does correcting the command
line.  I haven't had a chance to debug where it's going wrong yet.

[    7.854064] BUG: sleeping function called from invalid context at
arch/arm/mm/fault.c:310
[    7.863220] Unable to handle kernel paging request at virtual
address 22381f25
[    7.863250] pgd = e45f4000
[    7.863281] [22381f25] *pgd=00000000
[    7.863281] Internal error: Oops: 805 [#1] PREEMPT SMP
[    7.863311] Modules linked in:
[    7.863342] CPU: 0    Not tainted  (3.0.0-rc7-01613-g8cf751c #724)
[    7.863372] PC is at __rmqueue+0xa8/0x3dc
[    7.863403] LR is at get_page_from_freelist+0x4cc/0x56c
[    7.863433] pc : [<c00d8988>]    lr : [<c00db0bc>]    psr: 80000093
[    7.863433] sp : e5041c90  ip : c07149e0  fp : e5041cd4
[    7.863464] r10: 00000000  r9 : c0714940  r8 : ffffff80
[    7.863494] r7 : 00000001  r6 : c0c4af80  r5 : 21301f23  r4 : 22381f21
[    7.863494] r3 : 00200200  r2 : c07149d0  r1 : 00000002  r0 : 00100100
[    7.863525] Flags: Nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment user
[    7.863555] Control: 10c5387d  Table: a45f404a  DAC: 00000015
[    7.863586]
[    7.863586] PC: 0xc00d8908:
[    7.863586] 8908  e3e0807f e2833038 e50b3038 8a00009f e51b2030
e3a0402c e1a0a182 e023a794
[    7.863647] 8928  e0892003 e2823038 e5922038 e1530002 01a01007
0a0000a0 e51b2038 e1a01007
[    7.863677] 8948  e3a0002c e3003200 e3403020 e1570001 e00c0190
e3000100 e3400010 e08a400c
[    7.863739] 8968  e089c00c e0894004 e28cc048 e5944038 e2446018
e50b4034 e5964018 e596501c
[    7.863769] 8988  e5845004 e5854000 e5860018 e3a00000 e586301c
e51b4034 e5143010 e3e03000
[    7.863830] 89a8  e586000c b3a00001 e5863008 e59c3018 b1a00110
e2433001 e58c3018 b082c00a
[    7.863861] 89c8  aa0000b5 e1a000a0 e51c502c e242202c e2411001
e0863280 e1570001 e2834018
[    7.863922] 89e8  e5854004 e5835018 e082500a e583501c e52c402c
e5924028 e2844001 e5824028
[    7.863952]
[    7.863983] LR: 0xc00db03c:
[    7.863983] b03c  1affff38 e51b2038 e3120080 0a00003e e121f002
eaffffa1 e59b3008 e1a00005
[    7.864044] b05c  e59bc008 e2032003 e51b103c e51b3084 e7952102
e58dc000 ebfff4a5 e3500000
[    7.864074] b07c  0affff96 e51b5030 eaffff03 e1a05008 ebfffaa5
eaffff0e e51b306c e3530000
[    7.864135] b09c  1a000019 e51b0060 eb114395 e51b103c e59b2010
e50b0038 e1a00005 ebfff608
[    7.864166] b0bc  e1a07000 e51b0060 eb11430e e3570000 0affffdb
e59f307c e1a00005 e3a01000
[    7.864227] b0dc  e51b2088 e50b3048 eb0034df eaffff21 e5972004
e2803018 e5873004 e5807018
[    7.864257] b0fc  e580201c e5823000 eaffffaf e51bc03c e35c0001
daffffe2 e30d0528 e34c0073
[    7.864318] b11c  e5d03014 e3530001 0affffdd e3001537 e59f0024
ebfeb586 e30d2528 e34c2073
[    7.864349]
[    7.864349] SP: 0xe5041c10:
[    7.864379] 1c10  c06c6500 c06c654c 00000001 00000001 e5041c3c
e5041c30 ffffffff e5041c7c
[    7.864410] 1c30  c0c4af80 00000001 e5041cd4 e5041c48 c004c3ec
c0046498 00100100 00000002
[    7.864471] 1c50  c07149d0 00200200 22381f21 21301f23 c0c4af80
00000001 ffffff80 c0714940
[    7.864501] 1c70  00000000 e5041cd4 c07149e0 e5041c90 c00db0bc
c00d8988 80000093 ffffffff
[    7.864562] 1c90  00002003 000000a0 e5041cc4 c07149a4 c0c4af98
00000000 00000002 00000002
[    7.864593] 1cb0  c0714940 c06d03e8 00000000 00000000 e5040000
000052d0 e5041d74 e5041cd8
[    7.864654] 1cd0  c00db0bc c00d88ec 00000041 e5041ce8 c06c6500
c06c654c e5041d04 fffffffe
[    7.864685] 1cf0  00000000 e51bce64 e5041d4c e5041d08 c052a7c8
c00b63a4 00000000 00000000
[    7.864746]
[    7.864746] IP: 0xc0714960:
[    7.864746] 4960  00000001 00000000 dead4ead 00000000 e503c000
00000000 c0c4af78 c0c4af78
[    7.864807] 4980  c0714980 c0714980 c07e2bf8 c07e2bf8 c0714990
c0714990 c0714998 c0714998
[    7.864837] 49a0  00000002 c07149a4 c07149a4 c07149ac c07149ac
c07149b4 c07149b4 c07149bc
[    7.864898] 49c0  c07149bc c07149c4 c07149c4 00000000 c0c4af98
c0c4af98 c0c66898 c0c66898
[    7.864929] 49e0  c07149e0 c07149e0 c07149e8 c07149e8 c07149f0
c07149f0 00000002 c07149fc
[    7.864990] 4a00  c07149fc c0c66918 c0c66918 c0714a0c c0714a0c
c0714a14 c0714a14 c0714a1c
[    7.865020] 4a20  c0714a1c 00000001 c0714a28 c0714a28 c0c66a18
c0c66a18 c0714a38 c0714a38
[    7.865081] 4a40  c0714a40 c0714a40 c0714a48 c0714a48 00000001
c0714a54 c0714a54 c0c66c18
[    7.865112]
[    7.865142] FP: 0xe5041c54:
[    7.865142] 1c54  00200200 22381f21 21301f23 c0c4af80 00000001
ffffff80 c0714940 00000000
[    7.865173] 1c74  e5041cd4 c07149e0 e5041c90 c00db0bc c00d8988
80000093 ffffffff 00002003
[    7.865234] 1c94  000000a0 e5041cc4 c07149a4 c0c4af98 00000000
00000002 00000002 c0714940
[    7.865264] 1cb4  c06d03e8 00000000 00000000 e5040000 000052d0
e5041d74 e5041cd8 c00db0bc
[    7.865325] 1cd4  c00d88ec 00000041 e5041ce8 c06c6500 c06c654c
e5041d04 fffffffe 00000000
[    7.865356] 1cf4  e51bce64 e5041d4c e5041d08 c052a7c8 c00b63a4
00000000 00000000 00000000
[    7.865417] 1d14  c0714960 c0715244 00000000 00200200 00100100
000252d0 c00b5f54 00000008
[    7.865447] 1d34  00000000 00000001 60000013 00000000 c0714940
e5041d64 00000000 c0715240
[    7.865509]
[    7.865509] R2: 0xc0714950:
[    7.865509] 4950  00000000 00000000 00000000 c00482b8 00000001
00000000 dead4ead 00000000
[    7.865570] 4970  e503c000 00000000 c0c4af78 c0c4af78 c0714980
c0714980 c07e2bf8 c07e2bf8
[    7.865600] 4990  c0714990 c0714990 c0714998 c0714998 00000002
c07149a4 c07149a4 c07149ac
[    7.865661] 49b0  c07149ac c07149b4 c07149b4 c07149bc c07149bc
c07149c4 c07149c4 00000000
[    7.865692] 49d0  c0c4af98 c0c4af98 c0c66898 c0c66898 c07149e0
c07149e0 c07149e8 c07149e8
[    7.865753] 49f0  c07149f0 c07149f0 00000002 c07149fc c07149fc
c0c66918 c0c66918 c0714a0c
[    7.865783] 4a10  c0714a0c c0714a14 c0714a14 c0714a1c c0714a1c
00000001 c0714a28 c0714a28
[    7.865844] 4a30  c0c66a18 c0c66a18 c0714a38 c0714a38 c0714a40
c0714a40 c0714a48 c0714a48
[    7.865875]
[    7.865905] R6: 0xc0c4af00:
[    7.865905] af00  1725101c 15220f1a 131e0e18 111a0c15 0f170b13
0d140a11 0c10090f 0a0e080d
[    7.865966] af20  080b070b 07090609 05070507 04050406 02030304
01020203 01010102 00000101
[    7.865997] af40  00000001 00000000 00000000 01010000 01020101
02030201 03040202 04060303
[    7.866058] af60  06080504 070a0606 090d0707 0a100809 0c13090b
0e160b0d 111a0d0f 131e0f11
[    7.866088] af80  15221113 17261316 1a2a1518 1c2e171a 1e31191c
21361c1e 22381f21 21301f23
[    7.866149] afa0  1c2d1124 1a29121f 1826111c 16220f1a 131e0e18
111b0d15 10170b13 0d140a11
[    7.866180] afc0  0c11090f 0a0e080d 090b070b 0709060a 05070508
04050406 03040304 02030203
[    7.866210] afe0  01020102 01010101 00000101 00000101 00010100
01010100 01020101 02030201
[    7.866271]
[    7.866271] R8: 0xffffff00:
[    7.866302] ff00  ******** ******** ******** ******** ********
******** ******** ********
[    7.866333] ff20  ******** ******** ******** ******** ********
******** ******** ********
[    7.866394] ff40  ******** ******** ******** ******** ********
******** ******** ********
[    7.866424] ff60  ******** ******** ******** ******** ********
******** ******** ********
[    7.866485] ff80  ******** ******** ******** ******** ********
******** ******** ********
[    7.866546] ffa0  ******** ******** ******** ******** ********
******** ******** ********
[    7.866577] ffc0  ******** ******** ******** ******** ********
******** ******** ********
[    7.866638] ffe0  ******** ******** ******** ******** ********
******** ******** ********
[    7.866668]
[    7.866668] R9: 0xc07148c0:
[    7.866699] 48c0  c06ee2d0 c07148a0 e50d6cc4 e5336f04 c06ee2d8
00000000 00000000 c051c8ac
[    7.866729] 48e0  c051c9a0 e50164fc 00000000 00000000 00000000
dead4ead ffffffff ffffffff
[    7.866790] 4900  00000000 00000000 dead4ead ffffffff ffffffff
c0714914 c0714914 c0526118
[    7.866821] 4920  c071532c 00000000 00000000 00000000 00000000
00000000 00000000 00000000
[    7.866882] 4940  000002f5 000003b2 0000046f 00000000 00000000
00000000 00000000 c00482b8
[    7.866912] 4960  00000001 00000000 dead4ead 00000000 e503c000
00000000 c0c4af78 c0c4af78
[    7.866973] 4980  c0714980 c0714980 c07e2bf8 c07e2bf8 c0714990
c0714990 c0714998 c0714998
[    7.867004] 49a0  00000002 c07149a4 c07149a4 c07149ac c07149ac
c07149b4 c07149b4 c07149bc
[    7.867065] Process init (pid: 1, stack limit = 0xe50402f8)
[    7.867095] Stack: (0xe5041c90 to 0xe5042000)
[    7.867095] 1c80:                                     00002003
000000a0 e5041cc4 c07149a4
[    7.867156] 1ca0: c0c4af98 00000000 00000002 00000002 c0714940
c06d03e8 00000000 00000000
[    7.867187] 1cc0: e5040000 000052d0 e5041d74 e5041cd8 c00db0bc
c00d88ec 00000041 e5041ce8
[    7.867218] 1ce0: c06c6500 c06c654c e5041d04 fffffffe 00000000
e51bce64 e5041d4c e5041d08
[    7.867248] 1d00: c052a7c8 c00b63a4 00000000 00000000 00000000
c0714960 c0715244 00000000
[    7.867279] 1d20: 00200200 00100100 000252d0 c00b5f54 00000008
00000000 00000001 60000013
[    7.867309] 1d40: 00000000 c0714940 e5041d64 00000000 c0715240
c06d03e8 00000000 00000000
[    7.867340] 1d60: c0715244 000052d0 e5041e0c e5041d78 c00db42c
c00dabfc 00000000 00000041
[    7.867401] 1d80: c0714940 00000000 e5041f14 e5041e34 00000000
00000000 e500d0a0 e5041e2c
[    7.867431] 1da0: e5041df4 e5041db0 c010cfa8 c011dbf8 00000000
00000000 e5041de4 e5041dc8
[    7.867462] 1dc0: 00000010 000252d0 00000000 00000001 e5041df4
e5041de0 c052bcd4 c0714940
[    7.867492] 1de0: c06d9138 e519b280 00000001 0001000c 000040d0
00000000 e50015a0 ffffffff
[    7.867523] 1e00: e5041e34 e5041e10 c00fe8d4 c00db33c e5040000
e519b280 60000013 c06d0590
[    7.867553] 1e20: 00000000 c0f096d8 e5041e74 e5041e38 c00ff754
c00fe888 c052bfa4 c01f3d24
[    7.867584] 1e40: 00000000 000000d0 00000005 e519b280 00000000
c070e90c c06d0590 e5041e78
[    7.867645] 1e60: 000000d0 c07c4740 e5041eac e5041e78 c00ffa6c
c00ff58c c03cebfc 00000000
[    7.867675] 1e80: e5041e9c c070e90c e519b280 c070e90c 000080d0
c07c744c 00000000 c07c4740
[    7.867706] 1ea0: e5041ecc e5041eb0 c03cebfc c00ff960 00000002
c070e90c c070e90c e4c27800
[    7.867736] 1ec0: e5041eec e5041ed0 c03ced44 c03cebdc 00000002
c070e90c 00000011 e4c27800
[    7.867767] 1ee0: e5041f34 e5041ef0 c045e0d0 c03ced2c e4c27820
e4c27834 e5041f1c 00000000
[    7.867797] 1f00: c011c05c c070f1f4 e4c27820 c0581b1c c07c4740
e4c27800 c06d08f0 00000008
[    7.867828] 1f20: e5040000 00000000 e5041f64 e5041f38 c03cc22c
c045dfcc 00000002 00000000
[    7.867889] 1f40: 00000000 00000002 beccbe3c beccbe9c 00000119
c004cb28 e5041f84 e5041f68
[    7.867919] 1f60: c03cc418 c03cc0d4 e5041f8c 00000000 e5041fa4
00000002 e5041fa4 e5041f88
[    7.867950] 1f80: c03cc5b8 c03cc3d8 00000003 00000001 00021654
beccbe3c 00000000 e5041fa8
[    7.867980] 1fa0: c004c980 c03cc580 00021654 beccbe3c 00000002
00000002 00000000 00025b3a
[    7.868011] 1fc0: 00021654 beccbe3c beccbe9c 00000119 00000001
00000001 000216d8 00000000
[    7.868041] 1fe0: 0001f980 beccbe30 0000ba31 0000856c 60000010
00000002 40a8bf57 4057bfa8
[    7.868072] Backtrace:
[    7.868103] [<c00d88e0>] (__rmqueue+0x0/0x3dc) from [<c00db0bc>]
(get_page_from_freelist+0x4cc/0x56c)
[    7.868164] [<c00dabf0>] (get_page_from_freelist+0x0/0x56c) from
[<c00db42c>] (__alloc_pages_nodemask+0xfc/0x650)
[    7.868225] [<c00db330>] (__alloc_pages_nodemask+0x0/0x650) from
[<c00fe8d4>] (new_slab+0x58/0x1cc)
[    7.868255] [<c00fe87c>] (new_slab+0x0/0x1cc) from [<c00ff754>]
(__slab_alloc.clone.1+0x1d4/0x3d4)
[    7.868286] [<c00ff580>] (__slab_alloc.clone.1+0x0/0x3d4) from
[<c00ffa6c>] (kmem_cache_alloc+0x118/0x124)
[    7.868347] [<c00ff954>] (kmem_cache_alloc+0x0/0x124) from
[<c03cebfc>] (sk_prot_alloc+0x2c/0x150)
[    7.868408] [<c03cebd0>] (sk_prot_alloc+0x0/0x150) from
[<c03ced44>] (sk_alloc+0x24/0x7c)
[    7.868408]  r7:e4c27800 r6:c070e90c r5:c070e90c r4:00000002
[    7.868499] [<c03ced20>] (sk_alloc+0x0/0x7c) from [<c045e0d0>]
(inet_create+0x110/0x31c)
[    7.868499]  r7:e4c27800 r6:00000011 r5:c070e90c r4:00000002
[    7.868560] [<c045dfc0>] (inet_create+0x0/0x31c) from [<c03cc22c>]
(__sock_create+0x164/0x2bc)
[    7.868621] [<c03cc0c8>] (__sock_create+0x0/0x2bc) from
[<c03cc418>] (sock_create+0x4c/0x54)
[    7.868621]  r8:c004cb28 r7:00000119 r6:beccbe9c r5:beccbe3c r4:00000002
[    7.868682] [<c03cc3cc>] (sock_create+0x0/0x54) from [<c03cc5b8>]
(sys_socket+0x44/0x74)
[    7.868713]  r4:00000002
[    7.868743] [<c03cc574>] (sys_socket+0x0/0x74) from [<c004c980>]
(ret_fast_syscall+0x0/0x30)
[    7.868774]  r5:beccbe3c r4:00021654
[    7.868804] Code: e2446018 e50b4034 e5964018 e596501c (e5845004)
[    7.868927] ---[ end trace d65c584bd4f7be75 ]---
[    7.868988] Kernel panic - not syncing: Fatal exception
[    7.869018] Backtrace:
[    7.869079] [<c00508c0>] (dump_backtrace+0x0/0x10c) from
[<c0528558>] (dump_stack+0x18/0x1c)
[    7.869110]  r7:00000805 r6:e503c000 r5:c06ee0e0 r4:c0718088
[    7.869201] [<c0528540>] (dump_stack+0x0/0x1c) from [<c05285d8>]
(panic+0x7c/0x1ac)
[    7.869262] [<c052855c>] (panic+0x0/0x1ac) from [<c0050de8>]
(die+0x188/0x1b8)
[    7.869293]  r3:00000001 r2:00000000 r1:20000113 r0:c0630ae8
[    7.869384] [<c0050c60>] (die+0x0/0x1b8) from [<c005483c>]
(__do_kernel_fault+0x6c/0x8c)
[    7.869415]  r8:e45f2000 r7:00000805 r6:00000000 r5:22381f25 r4:e5041c48
[    7.869506] [<c00547d0>] (__do_kernel_fault+0x0/0x8c) from
[<c00549a4>] (do_page_fault+0x148/0x1fc)
[    7.869537]  r9:00000193 r8:e5041c48 r7:00000805 r6:00000001 r5:22381f25
[    7.869598] r4:e45f2000
[    7.869659] [<c005485c>] (do_page_fault+0x0/0x1fc) from
[<c0054b6c>] (do_translation_fault+0xa0/0xa8)
[    7.869720] [<c0054acc>] (do_translation_fault+0x0/0xa8) from
[<c00464c8>] (do_DataAbort+0x3c/0xa4)
[    7.869750]  r7:e5041c48 r6:22381f25 r5:c06d8e68 r4:00000805
[    7.869873] [<c004648c>] (do_DataAbort+0x0/0xa4) from [<c004c3ec>]
(__dabt_svc+0x4c/0x60)
[    7.869903] Exception stack(0xe5041c48 to 0xe5041c90)
[    7.869964] 1c40:                   00100100 00000002 c07149d0
00200200 22381f21 21301f23
[    7.870025] 1c60: c0c4af80 00000001 ffffff80 c0714940 00000000
e5041cd4 c07149e0 e5041c90
[    7.870086] 1c80: c00db0bc c00d8988 80000093 ffffffff
[    7.870117]  r7:00000001 r6:c0c4af80 r5:e5041c7c r4:ffffffff
[    7.870208] [<c00d88e0>] (__rmqueue+0x0/0x3dc) from [<c00db0bc>]
(get_page_from_freelist+0x4cc/0x56c)
[    7.870239] [<c00dabf0>] (get_page_from_freelist+0x0/0x56c) from
[<c00db42c>] (__alloc_pages_nodemask+0xfc/0x650)
[    7.870300] [<c00db330>] (__alloc_pages_nodemask+0x0/0x650) from
[<c00fe8d4>] (new_slab+0x58/0x1cc)
[    7.870361] [<c00fe87c>] (new_slab+0x0/0x1cc) from [<c00ff754>]
(__slab_alloc.clone.1+0x1d4/0x3d4)
[    7.870422] [<c00ff580>] (__slab_alloc.clone.1+0x0/0x3d4) from
[<c00ffa6c>] (kmem_cache_alloc+0x118/0x124)
[    7.870483] [<c00ff954>] (kmem_cache_alloc+0x0/0x124) from
[<c03cebfc>] (sk_prot_alloc+0x2c/0x150)
[    7.870544] [<c03cebd0>] (sk_prot_alloc+0x0/0x150) from
[<c03ced44>] (sk_alloc+0x24/0x7c)
[    7.870574]  r7:e4c27800 r6:c070e90c r5:c070e90c r4:00000002
[    7.870697] [<c03ced20>] (sk_alloc+0x0/0x7c) from [<c045e0d0>]
(inet_create+0x110/0x31c)
[    7.870727]  r7:e4c27800 r6:00000011 r5:c070e90c r4:00000002
[    7.870819] [<c045dfc0>] (inet_create+0x0/0x31c) from [<c03cc22c>]
(__sock_create+0x164/0x2bc)
[    7.870849] [<c03cc0c8>] (__sock_create+0x0/0x2bc) from
[<c03cc418>] (sock_create+0x4c/0x54)
[    7.870910]  r8:c004cb28 r7:00000119 r6:beccbe9c r5:beccbe3c r4:00000002
[    7.871032] [<c03cc3cc>] (sock_create+0x0/0x54) from [<c03cc5b8>]
(sys_socket+0x44/0x74)
[    7.871093]  r4:00000002
[    7.871124] [<c03cc574>] (sys_socket+0x0/0x74) from [<c004c980>]
(ret_fast_syscall+0x0/0x30)
[    7.871154]  r5:beccbe3c r4:00021654
[    9.372039] in_atomic(): 0, irqs_disabled(): 128, pid: 80, name: ueventd
[    9.379547] Backtrace:
[    9.382568] [<c00508c0>] (dump_backtrace+0x0/0x10c) from
[<c0528558>] (dump_stack+0x18/0x1c)
[    9.391967]  r7:00000817 r6:ffff6dee r5:c06c0080 r4:e464e000
[    9.398925] [<c0528540>] (dump_stack+0x0/0x1c) from [<c00787b4>]
(__might_sleep+0x108/0x128)
[    9.408355] [<c00786ac>] (__might_sleep+0x0/0x128) from
[<c00549c0>] (do_page_fault+0x164/0x1fc)
[    9.418151]  r6:00000000 r5:00100104 r4:e461e1c0
[    9.423828] [<c005485c>] (do_page_fault+0x0/0x1fc) from
[<c00464c8>] (do_DataAbort+0x3c/0xa4)
[    9.433349] [<c004648c>] (do_DataAbort+0x0/0xa4) from [<c004c3ec>]
(__dabt_svc+0x4c/0x60)
[    9.442474] Exception stack(0xe464fd18 to 0xe464fd60)
[    9.448089] fd00:
    00000008 60000013
[    9.457214] fd20: 00100100 00200200 00000001 c0714940 c00482b8
c0c4aee0 00ec9000 e464e000
[    9.466186] fd40: 000000d2 e464fdfc 00000008 e464fd60 c00d8338
c00dad50 60000093 ffffffff
[    9.475311]  r7:c0c4aee0 r6:c00482b8 r5:e464fd4c r4:ffffffff
[    9.482421] [<c00dabf0>] (get_page_from_freelist+0x0/0x56c) from
[<c00db42c>] (__alloc_pages_nodemask+0xfc/0x650)
[    9.493835] [<c00db330>] (__alloc_pages_nodemask+0x0/0x650) from
[<c0279260>] (firmware_data_write+0x110/0x21c)
[    9.505035] [<c0279150>] (firmware_data_write+0x0/0x21c) from
[<c01580f8>] (write+0x11c/0x1a8)
[    9.514495] [<c0157fdc>] (write+0x0/0x1a8) from [<c01032ac>]
(vfs_write+0xb8/0x14c)
[    9.523071] [<c01031f4>] (vfs_write+0x0/0x14c) from [<c010341c>]
(sys_write+0x44/0x74)
[    9.531890]  r8:001e3000 r7:00000004 r6:00001000 r5:beaf1878 r4:e4b35a80
[    9.540161] [<c01033d8>] (sys_write+0x0/0x74) from [<c004c980>]
(ret_fast_syscall+0x0/0x30)
[    9.549468]  r9:e464e000 r8:c004cb28 r6:beaf1878 r5:0000000d r4:0000000b
