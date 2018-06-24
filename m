From: pbrobinson@gmail.com (Peter Robinson)
Date: Sun, 24 Jun 2018 10:24:41 +0100
Subject: Crash in netlink/sk_filter_trim_cap on ARMv7 on 4.18rc1
In-Reply-To: <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
Message-ID: <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> I'm seeing this netlink/sk_filter_trim_cap crash on ARMv7 across quite
>> a few ARMv7 platforms on Fedora with 4.18rc1. I've tested RPi2/RPi3
>> (doesn't happen on aarch64), AllWinner H3, BeagleBone and a few
>> others, both LPAE/normal kernels.
>>
>> I'm a bit out of my depth in this part of the kernel but I'm wondering
>> if it's known, I couldn't find anything that looked obvious on a few
>> mailing lists.
>>
>> Peter
>
> Hi Peter
>
> Could you provide symbolic information ?

I passed in through scripts/decode_stacktrace.sh is that what you were after:

[    8.673880] Internal error: Oops: a06 [#10] SMP ARM
[    8.673949] ---[ end trace 049df4786ea3140a ]---
[    8.678754] Modules linked in:
[    8.678766] CPU: 1 PID: 206 Comm: systemd-udevd Tainted: G      D
        4.18.0-0.rc1.git0.1.fc29.armv7hl+lpae #1
[    8.678769] Hardware name: Allwinner sun8i Family
[    8.678781] PC is at sk_filter_trim_cap ()
[    8.678790] LR is at   (null)
[    8.709463] pc : lr : psr: 60000013 ()
[    8.715722] sp : c996bd60  ip : 00000000  fp : 00000000
[    8.720939] r10: ee79dc00  r9 : c12c9f80  r8 : 00000000
[    8.726157] r7 : 00000000  r6 : 00000001  r5 : f1648000  r4 : 00000000
[    8.732674] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
[    8.739193] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    8.746318] Control: 30c5387d  Table: 6e7bc880  DAC: ffe75ece
[    8.752055] Process systemd-udevd (pid: 206, stack limit = 0x(ptrval))
[    8.758574] Stack: (0xc996bd60 to 0xc996c000)
[    8.762929] bd60: 00000000 ee7ad0c0 006000c0 00000000 00000000
c0a64ab8 ee7ad240 ee7ad240
[    8.771098] bd80: ee7ad0c0 00000000 00000000 00000000 c12c9f80
c0abbb8c ef001a00 00000001
[    8.779267] bda0: ee722400 00000000 00000002 00000000 00000001
ee79dc64 c996bf70 00000002
[    8.787435] bdc0: ee7ad0c0 00000000 c996bf68 0000008b ee722400
00000008 00000000 c0abbc88
[    8.795604] bde0: 006000c0 00000000 00000000 00000002 00000002
c0abdfb0 006000c0 00000000
[    8.803772] be00: c98ce580 00000000 000000ce 00000000 00000000
00000000 c124ebf4 c996bf68
[    8.811941] be20: eead4c40 c996be58 00000040 00000000 eead4c40
00000000 00000000 c0a5d198
[    8.820110] be40: c996bf68 00000000 c996be58 c0a5d958 00000000
00000000 ee78c2c0 7fff0000
[    8.828278] be60: c996be90 c996beec ffff0000 000000a0 00000000
c05103ac bef897e4 00000028
[    8.836447] be80: 004ee0a8 00000063 00000000 004f3820 00000128
40000028 b6c9a548 00000000
[    8.844615] bea0: 0000000d 00000000 bef897b8 00000000 00000000
00000000 00000010 00000000
[    8.852784] bec0: 00000002 00000000 004f3820 00000000 c996bfb0
00000128 bef897b8 00000000
[    8.860953] bee0: 00000000 c0510450 00000000 00000000 c120eaa4
b6deca00 c996bfb0 30c5387d
[    8.869122] bf00: 004f38d8 bef89720 bef89728 c0434e94 00000000
c05e0290 ee4e6010 00000ff0
[    8.877291] bf20: ee4e6010 00000ff0 ee4e6000 00000000 00000000
c0506354 eead4c40 bef897b8
[    8.885460] bf40: 00000000 00000128 c0401324 c996a000 00000128
c0a5e6d4 00000000 00000000
[    8.893628] bf60: 00000000 fffffff7 c996beb8 0000000c 00000001
00000000 00000000 c996be88
[    8.901796] bf80: 00000000 c0429ac0 00000000 00000000 00000040
00000000 00000000 004f3820
[    8.909965] bfa0: bef897b8 c04012e8 00000000 004f3820 0000000d
bef897b8 00000000 00000000
[    8.918134] bfc0: 00000000 004f3820 bef897b8 00000128 00000063
004eae70 004f4078 00000000
[    8.926302] bfe0: b6f60ad4 bef89780 b6da5780 b6c9a548 60000010
0000000d 00000000 00000000
[    8.934488] (sk_filter_trim_cap) from netlink_broadcast_filtered ()
[    8.943963] (netlink_broadcast_filtered) from netlink_broadcast ()
[    8.953174] (netlink_broadcast) from netlink_sendmsg ()
[    8.961608] (netlink_sendmsg) from sock_sendmsg ()
[    8.969432] (sock_sendmsg) from ___sys_sendmsg ()
[    8.977343] (___sys_sendmsg) from __sys_sendmsg ()
[    8.985170] (__sys_sendmsg) from __sys_trace_return ()
[    8.993247] Exception stack(0xc996bfa8 to 0xc996bff0)
[    8.998294] bfa0:                   00000000 004f3820 0000000d
bef897b8 00000000 00000000
[    9.006463] bfc0: 00000000 004f3820 bef897b8 00000128 00000063
004eae70 004f4078 00000000
[    9.014629] bfe0: b6f60ad4 bef89780 b6da5780 b6c9a548
[ 9.019680] Code: 1afffff7 e59c0000 e5830000 e3520000 (e584800c)
All code
========
   0:   1afffff7        .word   0x1afffff7
   4:   e59c0000        .word   0xe59c0000
   8:   e5830000        .word   0xe5830000
   c:   e3520000        .word   0xe3520000
  10:*  e584800c        .word   0xe584800c              <-- trapping instruction

Code starting with the faulting instruction
===========================================
   0:   e584800c        .word   0xe584800c
[    9.025823] ---[ end trace 049df4786ea3140b ]---
