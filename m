From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 25 Aug 2015 12:32:51 +0200
Subject: [PATCH 9/9] ARM: software-based priviledged-no-access support
In-Reply-To: <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
References: <20150821133043.GV7557@n2100.arm.linux.org.uk>
 <E1ZSmQG-0002za-E3@rmk-PC.arm.linux.org.uk>
Message-ID: <CAMuHMdVMka2mt5pFpnXfLRY2M3Sj_71MgEpthOia2C99RaP_DA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Fri, Aug 21, 2015 at 3:31 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> Provide a software-based implementation of the priviledged no access
> support found in ARMv8.1.
>
> Userspace pages are mapped using a different domain number from the
> kernel and IO mappings.  If we switch the user domain to "no access"
> when we enter the kernel, we can prevent the kernel from touching
> userspace.
>
> However, the kernel needs to be able to access userspace via the
> various user accessor functions.  With the wrapping in the previous
> patch, we can temporarily enable access when the kernel needs user
> access, and re-disable it afterwards.
>
> This allows us to trap non-intended accesses to userspace, eg, caused
> by an inadvertent dereference of the LIST_POISON* values, which, with
> appropriate user mappings setup, can be made to succeed.  This in turn
> can allow use-after-free bugs to be further exploited than would
> otherwise be possible.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This patch, which is now in arm-soc/for-next, breaks shmobile_defconfig
on r8a7791/koelsch, which has a dual core CA15:

    [ ok ] Configuring network interfaces...done.
    Unhandled fault: page domain fault (0x01b) at 0xbe8e6120
    pgd = edbb0000
    [be8e6120] *pgd=6da77831, *pte=bf4d075f, *ppte=bf4d0c7f
    Internal error: : 1b [#1] SMP ARM
    CPU: 1 PID: 1629 Comm: ntpdate Not tainted
4.2.0-rc8-06444-g3c24fd89c9421db1 #31
    9
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    task: ed883a80 ti: ed41c000 task.ti: ed41c000
    PC is at csum_partial_copy_from_user+0x28/0x3d8
    LR is at csum_and_copy_from_iter+0x334/0x4c0
    pc : [<c04ba510>]    lr : [<c01c82e8>]    psr: 000f0013
    sp : ed41db00  ip : 00000020  fp : ed41db6c
    r10: ed41ddc0  r9 : 00000027  r8 : ed41dc20
    r7 : 00000027  r6 : eda52653  r5 : ed41dec8  r4 : 00000000
    r3 : 00000000  r2 : 00000027  r1 : eda5262c  r0 : be8e6120
    Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 10c5307d  Table: 6dbb006a  DAC: 00000051
    Process ntpdate (pid: 1629, stack limit = 0xed41c210)
    Stack: (0xed41db00 to 0xed41e000)
    db00: eda5262c 00000027 00000000 ed41dec8 eda52653 00000027
ed41dc20 c01c82e8
    db20: ed41db3c c03d7d44 000000d0 c00a85a0 ed41db74 00000000
ed41dba4 00000000
    db40: 00000000 00000027 edb36940 ed9b9380 00000000 ed41dc20
0000002f ed41dc30
    db60: ed41db8c ed41db70 c040dd5c c01c7fc0 00000000 00000000
00000027 edb36940
    db80: ed41dc04 ed41db90 c040c454 c040dd04 00000000 edb36940
ed41dbc4 00000043
    dba0: 000005c8 000005c8 0000002f 00000000 00000000 00000010
000005dc ee3c7280
    dba0: 000005c8 000005c8 0000002f 00000000 00000000 00000010
000005dc ee3c7280
    dbc0: 00000000 000005dc 00000000 00000014 ed41dc04 ffffff97
c040bde4 00004040
    dbe0: ed41dc20 ed9b95a8 ed9b9380 ed41dec0 c040dcf8 00003500
ed41dc74 ed41dc08
    dc00: c040e7f4 c040be8c ed883e5c c040dcf8 ed41dec0 0000002f
00000008 00004040
    dc20: ed41dc20 ed41dc20 00000000 c067bc40 00000000 00000000
00000000 000005dc
    dc40: 0000002f ee3c7280 ffff0000 ed41dc00 ed9b9380 ed9b95a8
ed41dec0 fe61a8c0
    dc60: 00000000 fe61a8c0 ed41dd64 ed41dc78 c0432118 c040e758
0000002f 00000008
    dc80: ed41dcb4 ed41dcb0 00004040 ffffffff 00000000 00000000
ed9b95a8 00000000
    dca0: c040dcf8 1c61a8c0 00000000 00000027 00000000 fe61a8c0
00000000 00000000
    dcc0: ffff0000 00000000 01ffffff b6d21000 edbb2db0 edb81580
ed41dd74 ed41dce8
    dce0: c0098d60 c00985d0 c04c27f8 ed41ddc0 00000001 be8e6068
00000051 ed41ddc0
    dd00: 00000008 00000000 00000008 c00cc668 00000008 ed41dec8
ed41dd9c 00000001
    dd20: 00000001 00000001 ed41dd64 ed41dd38 c01c8c7c c01c62f0
00000027 ed9b9380
    dd40: ed41dec0 00000027 ed41dda0 edc78c80 ed41deec 00004040
ed41dd84 ed41dd68
    dd60: c043b224 c0431c30 c043b198 ed41dec0 be8e6078 00000000
ed41dd94 ed41dd88
    dd80: c03cbaf0 c043b1a4 ed41deac ed41dd98 c03cbd3c c03cbae0
6f7f979f 00000000
    dda0: eedaf25c b6d21000 edb12484 edbb2db0 ed41de24 ed41ddc0
c00b1898 c00b02d8
    ddc0: be8e6120 00000027 00000001 000000fe 00000001 ee36d740
ed41ddf4 ed9b95a8
    dde0: c06a5b80 00000000 00000000 ed9b95a8 ed9b95a8 ee25f580
ed41de64 ed41de08
    de00: c0407274 00000000 c06a5b80 00000000 ee3c7280 00000006
c06a5b80 ee3c7280
    de20: c06a5b80 c06a5b80 ed9b9380 ed8736f0 ed41de4c ed41de40
ed41de94 ed41de48
    de40: c042e1c8 c04049b8 c0432688 c04c5a44 ed9b9380 ed9b944c
ee3c7280 ed41df08
    de60: ed9b95a8 00000000 ed41de8c ed41de78 ed9b9380 00000000
ed41de94 ed41de88
    de80: c00e5c08 00000000 be8e6078 edc78c80 00000002 00004000
ed41c030 00000000
    dea0: ed41df94 ed41deb0 c03ccfe8 c03cbbc0 ed41deec ed41dec0
00000000 00000000
    dec0: 00000000 00000000 00000001 00000000 00000027 ed41ddc0
00000001 00000000
    dee0: 00000000 00004040 00000000 c037ff04 ed41df44 ed41df00
c007181c c03801b0
    df00: 08cc6da6 00000000 00000000 002aea54 ffffffff 00ffffff
ed41df44 ed41df80
    df20: be8e5f88 00000005 0000004e c000fea4 ed41c000 00000000
ed41df54 ed41df48
    df40: c0071918 c00717dc ed41df7c ed41df58 c0071f04 00000000
00000001 be8e6060
    df60: 00000000 c000fea4 ed41c000 ffffffff 00000000 00004000
00000002 00000176
    df80: c000fea4 ed41c000 ed41dfa4 ed41df98 c03cd080 c03ccf80
00000000 ed41dfa8
    dfa0: c000fce0 c03cd07c 00000000 00004000 00000003 be8e6078
00000002 00004000
    dfc0: 00000000 00004000 00000002 00000176 00000003 00000005
b6e4ec14 2af73cb0
    dfe0: 00000176 be8e5f70 b6df6191 b6d798e6 800f0030 00000003
00000000 00000000
    Backtrace:
    [<c01c7fb4>] (csum_and_copy_from_iter) from [<c040dd5c>]
(ip_generic_getfrag+0x64/0xb4)
     r10:ed41dc30 r9:0000002f r8:ed41dc20 r7:00000000 r6:ed9b9380 r5:edb36940
     r4:00000027
    [<c040dcf8>] (ip_generic_getfrag) from [<c040c454>]
(__ip_append_data.isra.37+0x5d4/0x9b0)
     r5:edb36940 r4:00000027
    [<c040be80>] (__ip_append_data.isra.37) from [<c040e7f4>]
(ip_make_skb+0xa8/0xe0)
     r10:00003500 r9:c040dcf8 r8:ed41dec0 r7:ed9b9380 r6:ed9b95a8 r5:ed41dc20
     r4:00004040
    [<c040e74c>] (ip_make_skb) from [<c0432118>] (udp_sendmsg+0x4f4/0x6d8)
     r9:fe61a8c0 r8:00000000 r7:fe61a8c0 r6:ed41dec0 r5:ed9b95a8 r4:ed9b9380
    [<c0431c24>] (udp_sendmsg) from [<c043b224>] (inet_sendmsg+0x8c/0xc0)
     r10:00004040 r9:ed41deec r8:edc78c80 r7:ed41dda0 r6:00000027 r5:ed41dec0
     r4:ed9b9380
    [<c043b198>] (inet_sendmsg) from [<c03cbaf0>] (sock_sendmsg+0x1c/0x2c)
     r6:00000000 r5:be8e6078 r4:ed41dec0 r3:c043b198
    [<c03cbad4>] (sock_sendmsg) from [<c03cbd3c>] (___sys_sendmsg+0x188/0x1f8)
    [<c03cbbb4>] (___sys_sendmsg) from [<c03ccfe8>] (__sys_sendmmsg+0x74/0xfc)
     r10:00000000 r9:ed41c030 r8:00004000 r7:00000002 r6:edc78c80 r5:be8e6078
     r4:00000000
    [<c03ccf74>] (__sys_sendmmsg) from [<c03cd080>] (SyS_sendmmsg+0x10/0x14)
     r9:ed41c000 r8:c000fea4 r7:00000176 r6:00000002 r5:00004000 r4:00000000
    [<c03cd070>] (SyS_sendmmsg) from [<c000fce0>] (ret_fast_syscall+0x0/0x3c)
    Code: e3100003 1a00002f e3d2c00f 0a00000b (e4904004)
    ---[ end trace 21df281cc5d080da ]---

There are a few more networking-related backtraces during further booting
of userspace.

After disabling CONFIG_CPU_SW_DOMAIN_PAN it  fails differently:

    VFS: Mounted root (nfs filesystem) readonly on device 0:13.
    devtmpfs: mounted
    Freeing unused kernel memory: 300K (c0629000 - c0674000)
    Unhandled fault: page domain fault (0x81b) at 0x000263e0
    pgd = ed908000
    [000263e0] *pgd=6e299831, *pte=bf81d75f, *ppte=bf81dc7f
    Internal error: : 81b [#1] SMP ARM
    CPU: 1 PID: 1 Comm: init Not tainted 4.2.0-rc8-06444-g3c24fd89c9421db1 #332
    Hardware name: Generic R8A7791 (Flattened Device Tree)
    task: ee0319c0 ti: ee04e000 task.ti: ee04e000
    PC is at __clear_user_std+0x34/0x68
    LR is at padzero+0x4c/0x60
    pc : [<c01b2bd8>]    lr : [<c010a470>]    psr: 20000113
    sp : ee04fe40  ip : 00000000  fp : ee04fe54
    r10: ee0f5300  r9 : ee316120  r8 : 00000000
    r7 : 000265fc  r6 : 000263e0  r5 : ee314400  r4 : ee290e00
    r3 : 00000000  r2 : 00000000  r1 : 00000c18  r0 : 000263e0
    Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
    Control: 10c5307d  Table: 6d90806a  DAC: 00000051
    Process init (pid: 1, stack limit = 0xee04e210)
    Stack: (0xee04fe40 to 0xee050000)
    fe40: 00000c20 c010a470 ee04fed4 ee04fe58 c010ae78 c010a430
00001812 00000000
    fe60: ee04fe94 ee04fe58 ee04e018 00025ef4 00015ad8 00010000
00000009 00010000
    fe80: 00000001 ee316000 ee31b300 000263e0 ee3d3600 00000000
ef7e93c0 00000000
    fea0: ee04febc ee04feb0 c001dde4 fffffff8 ee0f5300 c06c3ccc
c06c3ccc c067ff0c
    fec0: c0680374 c06c3ccc ee04ff04 ee04fed8 c00cf0b8 c010a7cc
c067c8b8 ee0f5300
    fee0: 00000000 ee13a000 00000001 00000000 ed9d5040 c0679318
ee04ff4c ee04ff08
    ff00: c00cf5a4 c00cf038 c05d6ab9 ed9d5078 c0679290 00000000
00000000 ee031c18
    ff20: ee04ff44 c0679318 c0679290 00000000 00000000 00000000
00000000 00000000
    ff40: ee04ff64 ee04ff50 c00cf784 c00cf198 00000000 00000000
ee04ff7c ee04ff68
    ff60: c000a5c8 c00cf75c c06a6000 c05ca7cd ee04ff94 ee04ff80
c000a5e4 c000a5ac
    ff80: c06a6000 c04b54c4 ee04ffac ee04ff98 c04b5544 c000a5dc
ee04e000 00000000
    ffa0: 00000000 ee04ffb0 c000fc88 c04b54d0 00000000 00000000
00000000 00000000
    ffc0: 00000000 00000000 00000000 00000000 00000000 00000000
00000000 00000000
    ffe0: 00000000 00000000 00000000 00000000 00000013 00000000
00000000 00000000
    Backtrace:
    [<c010a424>] (padzero) from [<c010ae78>] (load_elf_binary+0x6b8/0xfbc)
    [<c010a7c0>] (load_elf_binary) from [<c00cf0b8>]
(search_binary_handler+0x8c/0x160)
     r10:c06c3ccc r9:c0680374 r8:c067ff0c r7:c06c3ccc r6:c06c3ccc r5:ee0f5300
     r4:fffffff8
    [<c00cf02c>] (search_binary_handler) from [<c00cf5a4>]
(do_execveat_common+0x418/0x5c4)
     r10:c0679318 r9:ed9d5040 r8:00000000 r7:00000001 r6:ee13a000 r5:00000000
     r4:ee0f5300 r3:c067c8b8
    [<c00cf18c>] (do_execveat_common) from [<c00cf784>] (do_execve+0x34/0x3c)
     r10:00000000 r9:00000000 r8:00000000 r7:00000000 r6:00000000 r5:c0679290
     r4:c0679318
    [<c00cf750>] (do_execve) from [<c000a5c8>] (run_init_process+0x28/0x30)
    [<c000a5a0>] (run_init_process) from [<c000a5e4>]
(try_to_run_init_process+0x14/0x40)
     r5:c05ca7cd r4:c06a6000
    [<c000a5d0>] (try_to_run_init_process) from [<c04b5544>]
(kernel_init+0x80/0xec)
     r5:c04b54c4 r4:c06a6000
    [<c04b54c4>] (kernel_init) from [<c000fc88>] (ret_from_fork+0x14/0x2c)
     r4:00000000 r3:ee04e000
    Code: b4c02001 e26cc004 e041100c e2511008 (54802004)
    ---[ end trace 807fed3702987ba4 ]---
    Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Reverting commit 0db805aa8c96f0ea ("ARM: software-based priviledged-no-access
support") fixes it.

Another board-specific config that has CONFIG_ARM_LPAE=y runs fine on the
same hardware. Disabling CONFIG_ARM_LPAE breaks it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
