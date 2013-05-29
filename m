From: jayakumar.lkml@gmail.com (Jaya Kumar)
Date: Wed, 29 May 2013 20:52:43 +0800
Subject: Debugging sporadic kernel panics/oops or full hangs
Message-ID: <CADqH6VwjThkxCKB=CdAt-qQkssAAbh+xD8_brJe2ThC_B1dzag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linux Arm friends,

I'm experiencing some odd behavior on a custom imx508 board running a
vendor derived 2.6.35 (I realize that's frightfully old, but I have to
live with it until I get some time to try to port top of tree to
this). What I was seeing was sudden panics/oops or just complete hangs
(no oops on serial console).

For example, I did:

while (/bin/true) ; do cat /proc/meminfo ; done

and after about 7 mins of running, I suddenly got on oops. I
powercycle, repeat the test, after about 15 mins, another oops, repeat
again, full hang, no oops message. Other times the same board runs the
same test for 3 hours without any trouble.

I ran mtest in uboot for 2 hours and no crash. I then ran memtester in
userspace on the same kernel, memtester 60M, and that too didn't hang
after 2 hours. I'll repeat those tests again just to make sure that
consistently succeeds.

I don't have JTAG setup yet. I'm also going to try turning off various
kernel subsystems (CONFIG_USB, DVFS, etc) to see if that improves
stability in any way. I'd appreciate any advice or suggestions on how
I could debug this further.

Thanks,
jaya

Oops #1:
Unable to handle kernel paging request at virtual address 02a87009
pgd = 80004000
[02a87009] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in:
CPU: 0    Not tainted  (2.6.35.3-899-g9b1a262-gabe3cff-dirty #42)
PC is at vt_console_print+0x8c/0x314
LR is at tasklet_action+0x70/0xb4
pc : [<80220008>]    lr : [<800676ec>]    psr: 20000113
sp : 8057bf10  ip : 8006767c  fp : 00000000
r10: 80599938  r9 : 0000000a  r8 : 00000103
r7 : 00000000  r6 : 00000000  r5 : 80599b00  r4 : 805d9c80
r3 : 80220000  r2 : 02a87001  r1 : 00000014  r0 : 9f0e3800
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8f4e0019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0x8057a2e8)
Stack: (0x8057bf10 to 0x8057c000)
bf00:                                     8057a000 00000001 00000018 805d9c80
bf20: 00000103 80067c94 00000000 00000040 9f336100 00000006 8059bf6c 0000001f
bf40: 00000000 00000001 00000002 00000001 8057a000 0000001f 00000000 80067d60
bf60: 0000001f 80033070 ffffffff a0800000 00000001 80033a8c 8058ae1c 030f3003
bf80: 00000001 00000000 8057a000 8057ea40 805d0d04 8057ea38 70029310 412fc085
bfa0: 0000001f 00000000 00000003 8057bfc0 80034a84 80034a88 60000013 ffffffff
bfc0: 8057a000 80034f6c 805dca60 8002aaf0 8057eae0 80008960 800084e8 00000bac
bfe0: 70000100 8002aaf0 10c53c7d 805d0dd0 8002aaec 70008034 00000000 00000000
[<80220008>] (vt_console_print+0x8c/0x314) from [<00000001>] (0x1)
Code: e353003e 8a000094 e3a01014 e0222391 (e5922008)
---[ end trace 55692addfbf1a0c1 ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<800384ac>] (unwind_backtrace+0x0/0xf0) from [<80425964>] (panic+0x6c/0xe0)
[<80425964>] (panic+0x6c/0xe0) from [<80037388>] (die+0x2b4/0x304)
[<80037388>] (die+0x2b4/0x304) from [<80039328>] (__do_kernel_fault+0x64/0x84)
[<80039328>] (__do_kernel_fault+0x64/0x84) from [<80039508>]
(do_page_fault+0x1c0/0x1d4)
[<80039508>] (do_page_fault+0x1c0/0x1d4) from [<800332b8>]
(do_DataAbort+0x34/0x94)
[<800332b8>] (do_DataAbort+0x34/0x94) from [<80033a2c>] (__dabt_svc+0x4c/0x60)
Exception stack(0x8057bec8 to 0x8057bf10)
bec0:                   9f0e3800 00000014 02a87001 80220000 805d9c80 80599b00
bee0: 00000000 00000000 00000103 0000000a 80599938 00000000 8006767c 8057bf10
bf00: 800676ec 80220008 20000113 ffffffff
[<80033a2c>] (__dabt_svc+0x4c/0x60) from [<80220008>]
(vt_console_print+0x8c/0x314)
[<80220008>] (vt_console_print+0x8c/0x314) from [<00000001>] (0x1)


Oops #2:
Bad mode in data abort handler detected
Internal error: Oops - bad mode: 0 [#1] PREEMPT
last sysfs file: /sys/kernel/uevent_seqnum
Modules linked in:
CPU: 0    Not tainted  (2.6.35.3-899-g9b1a262-gabe3cff-dirty #42)
PC is at 0xffff03a0
LR is at __dabt_svc+0x40/0x60
pc : [<ffff03a0>]    lr : [<80033a20>]    psr: 2000019b
sp : 8057be60  ip : 805db388  fp : 00000000
r10: 0000001f  r9 : 8057a000  r8 : 00000001
r7 : 0000001f  r6 : 805ed40c  r5 : 8057bedc  r4 : ffffffff
r3 : a0000193  r2 : 8022accc  r1 : 00000817  r0 : 805d0d58
Flags: nzCv  IRQs off  FIQs on  Mode UND_32  ISA ARM  Segment kernel
Control: 10c5387d  Table: 8f500019  DAC: 00000017
Process swapper (pid: 0, stack limit = 0x8057a2e8)
Stack: (0x8057be60 to 0x8057c000)
be60: 805d0d58 00000817 8022accc a0000193 ffffffff 8057bedc 805ed40c 0000001f
be80: 00000001 8057a000 0000001f 00000000 805db388 8057be60 80033a20 ffff03a0
bea0: 2000019b ffffffff 00000001 00000604 a0000193 00000000 80585d68 9f0e3800
bec0: 805ed40c 0000001f 00000001 8057a000 0000001f 00000000 805db388 8022c1b8
bee0: 00000001 8022accc a0000193 ffffffff 00000000 80585d68 00000001 0000001f
bf00: 805db388 8057bef4 80585d68 80585d68 00001000 80585d68 00000100 8022cbe0
bf20: 0000001f 00002201 00001000 00002040 9f336100 00000000 00000000 8008ffe8
bf40: 8059bf6c 0000001f 9f336100 00000002 00000001 800920b0 0000001f 00000000
bf60: 00000001 8003306c ffffffff a0800000 00000001 80033a8c 8058ae1c 030f3003
bf80: 00000001 00000000 8057a000 8057ea40 805d0d04 8057ea38 70029310 412fc085
bfa0: 0000001f 00000000 00000003 8057bfc0 80034a84 80034a88 60000013 ffffffff
bfc0: 8057a000 80034f6c 805dca60 8002aaf0 8057eae0 80008960 800084e8 00000bac
bfe0: 70000100 8002aaf0 10c53c7d 805d0dd0 8002aaec 70008034 00000000 00000000
[<80033a20>] (__dabt_svc+0x40/0x60) from [<ffff03a0>] (0xffff03a0)
Code: e2200008 e16ff000 e20ee00f e1a0000d (e79fe10e)
---[ end trace b0cff94de1b66f81 ]---
Kernel panic - not syncing: Fatal exception in interrupt
[<800384ac>] (unwind_backtrace+0x0/0xf0) from [<80425964>] (panic+0x6c/0xe0)
[<80425964>] (panic+0x6c/0xe0) from [<80037388>] (die+0x2b4/0x304)
[<80037388>] (die+0x2b4/0x304) from [<80037414>] (bad_mode+0x3c/0x5c)
[<80037414>] (bad_mode+0x3c/0x5c) from [<80033a20>] (__dabt_svc+0x40/0x60)
[<80033a20>] (__dabt_svc+0x40/0x60) from [<ffff03a0>] (0xffff03a0)
