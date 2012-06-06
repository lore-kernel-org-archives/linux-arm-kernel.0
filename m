From: ww-ml@gmx.de (Wolfgang Wegner)
Date: Wed, 6 Jun 2012 11:26:58 +0200
Subject: MMC issues with 2.6.28 - any known issues?
Message-ID: <20120606092658.GA10530@debian-ww1.dev.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a question for those familiar with "prehistoric kernel versions"
and the MMC stack...

We are working on Telechips TCC8900 hardware and have some very strange
SD/MMC issues. The underlying problem seems to be somehow hardware-
dependent, to the upper layers it shows as read and/or write errors on
the block level.

Apart from the actual transfer errors, the main problem for us is that
when these SD/MMC problems happen, very often a kernel oops with/due to
memory corruption happens that crashes the kernel to various extents.
As we are stuck with the underlying hardware errors, we would like to
try some workaround to at least properly restart the system in case of
an error, so preventing the crash would be desirable. So here go my
questions:

- does anybody know about mmc block layer issues with 2.6.28?
- does anybody have experience how to recover gracefully from
  mmc block device errors?
- any backports/patches in case there are improvements in newer
  kernels?
- of course, if anybody is also working with TCC89xx, contact would
  be greatly appreciated!

Please find below a (more or less typical) example of the actual
oops message.

Best regards,
Wolfgang

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = c00fc000
[00000000] *pgd=00000000
Internal error: Oops: 17 [#1]
Modules linked in: ufsd(P) hpd hdmidrv tcc_dm9000 TCC8900_nand(P)
CPU: 0    Tainted: P            (2.6.28 #32762M)
PC is at tcc_mmc_tasklet_finish+0x24/0xb0
LR is at tcc_mmc_tasklet_finish+0x20/0xb0
pc : [<c032a8c0>]    lr : [<c032a8bc>]    psr: 60000193
sp : c0e0fca0  ip : c0e0fca0  fp : c0e0fcbc
r10: 00000009  r9 : 00000000  r8 : c04e5bc0
r7 : 20000113  r6 : 00000000  r5 : c0e131e0  r4 : 00000000
r3 : 00000000  r2 : 00000001  r1 : 60000113  r0 : 00000000
Flags: nZCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 00c5387d  Table: 46a98008  DAC: 00000017
Process mmcqd (pid: 495, stack limit = 0xc0e0e260)
Stack: (0xc0e0fca0 to 0xc0e10000)
fca0: 00000000 00000014 c0e0e000 00000001 c0e0fcd4 c0e0fcc0 c01423b8 c032a8a8
fcc0: 00000100 00000014 c0e0fd04 c0e0fcd8 c01428a8 c014234c c0e0e000 00000002
fce0: 0000002d 00000000 00000001 c049b950 c0e0e000 00000002 c0e0fd14 c0e0fd08
fd00: c0142980 c0142850 c0e0fd2c c0e0fd18 c011d06c c0142944 ffffffff f0401000
fd20: c0e0fd9c c0e0fd30 c011d9b0 c011d00c 00000001 00000000 000ffcea 00008e22
fd40: c03cb6a4 c5e4ac00 c5e4ad58 c049b950 c0e0e000 00000000 00000002 c0e0fd9c
fd60: c04c4c60 c0e0fd78 c03c812c c03c8170 00000013 ffffffff c0e0fde8 c5e4ac00
fd80: c0e0fe2c 7fffffff c0e0e000 00000000 c0e0fdd4 c0e0fda0 c03c8404 c03c8004
fda0: c0e131e0 00000003 c0e0fe58 c0e0fec4 c0e0fe6c 00000001 c0e0fde8 c5e4ac00
fdc0: c0e0fe2c 7fffffff c0e0fe14 c0e0fdd8 c03c7ed8 c03c83f0 c0e0fdf4 00000001
fde0: c5e4ac00 c01389d4 c0e0fe30 c0e0fe30 c0e0fe58 c0e13000 c0e131e0 c5590400
fe00: c4d0f540 00000001 c0e0fe24 c0e0fe18 c03c7ff4 c03c7e20 c0e0fe54 c0e0fe28
fe20: c03228e8 c03c7fe8 c0e0fe54 00000001 c0e0fde8 c0e0fde8 c0e0fe58 c0e0fe58
fe40: c5591964 c0e0e000 c0e0ffb4 c0e0fe58 c0328378 c03227ac c0e0fe6c c0e0fec4
fe60: c0e0fe98 c0e0fe2c c03229a4 00000012 006da501 00000000 00000000 00000000
fe80: 00000000 000000b5 00000000 ffffff92 c0e0fec4 c0e0fe58 0000000c 00000000
fea0: 00000000 00000000 00000000 00000000 0000049d 00000000 00000000 00000000
fec0: c0e0fe58 05f5e100 00000000 00000200 00000008 ffffffac 00000200 00000000
fee0: c0e0fe98 c0e0fe58 00000001 c0e18c60 c026ccbc c0275ac8 c4ea1630 c4d0f460
ff00: c0e0ff34 c0e0ff10 c0e0ff34 c0e0ff18 c0260998 c02608d4 c4d0f460 c4ea1630
ff20: c4ea1630 c55ee600 c0e0ff54 c0e0ff38 c026cf54 c0265dec c4ea1630 c4d0f460
ff40: c55ee600 00000001 c0e0ff8c c0e0ff58 c026e9b8 c026ced8 c55ee604 c55ee628
ff60: 00000000 00000000 c0e43110 c0e0e000 00000000 c0e43110 c0e0e000 c559196c
ff80: c0e0ffb4 c0e0ff90 c0261ae8 c4d0f540 c5591964 c0e0e000 c559196c c0e43110
ffa0: 00000000 c0e4321c c0e0ffdc c0e0ffb8 c0328d0c c0328254 c5591964 c0328c30
ffc0: 00000000 00000000 00000000 00000000 c0e0fff4 c0e0ffe0 c0151010 c0328c3c
ffe0: 00000000 00000000 00000000 c0e0fff8 c01409f0 c0150fc8 00000000 00000000
Backtrace:
[<c032a89c>] (tcc_mmc_tasklet_finish+0x0/0xb0) from [<c01423b8>] (tasklet_action+0x78/0xc4)
 r7:00000001 r6:c0e0e000 r5:00000014 r4:00000000
[<c0142340>] (tasklet_action+0x0/0xc4) from [<c01428a8>] (__do_softirq+0x64/0xf4)
 r5:00000014 r4:00000100
[<c0142844>] (__do_softirq+0x0/0xf4) from [<c0142980>] (irq_exit+0x48/0x50)
[<c0142938>] (irq_exit+0x0/0x50) from [<c011d06c>] (__exception_text_start+0x6c/0x88)
[<c011d000>] (__exception_text_start+0x0/0x88) from [<c011d9b0>] (__irq_svc+0x30/0xa0)
Exception stack(0xc0e0fd30 to 0xc0e0fd78)
fd20:                                     00000001 00000000 000ffcea 00008e22
fd40: c03cb6a4 c5e4ac00 c5e4ad58 c049b950 c0e0e000 00000000 00000002 c0e0fd9c
fd60: c04c4c60 c0e0fd78 c03c812c c03c8170 00000013 ffffffff
 r5:f0401000 r4:ffffffff
[<c03c7ff8>] (schedule+0x0/0x288) from [<c03c8404>] (schedule_timeout+0x20/0xb8)
 r9:00000000 r8:c0e0e000 r7:7fffffff r6:c0e0fe2c r5:c5e4ac00
r4:c0e0fde8
[<c03c83e4>] (schedule_timeout+0x0/0xb8) from [<c03c7ed8>] (wait_for_common+0xc4/0x150)
 r7:7fffffff r6:c0e0fe2c r5:c5e4ac00 r4:c0e0fde8
[<c03c7e14>] (wait_for_common+0x0/0x150) from [<c03c7ff4>] (wait_for_completion+0x18/0x1c)
[<c03c7fdc>] (wait_for_completion+0x0/0x1c) from [<c03228e8>] (mmc_wait_for_req+0x148/0x188)
[<c03227a0>] (mmc_wait_for_req+0x0/0x188) from [<c0328378>] (mmc_blk_issue_rq+0x130/0x4a0)
 r6:c0e0e000 r5:c5591964 r4:c0e0fe58
[<c0328248>] (mmc_blk_issue_rq+0x0/0x4a0) from [<c0328d0c>] (mmc_queue_thread+0xdc/0xe0)
[<c0328c30>] (mmc_queue_thread+0x0/0xe0) from [<c0151010>] (kthread+0x54/0x80)
[<c0150fbc>] (kthread+0x0/0x80) from [<c01409f0>] (do_exit+0x0/0x6b4)
 r5:00000000 r4:00000000
Code: f10c0080 e28000a0 ebf8700a e5956004 (e5963000)
Kernel panic - not syncing: Fatal exception in interrupt
