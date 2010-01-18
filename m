From: michael@araneidae.co.uk (Michael Abbott)
Date: Mon, 18 Jan 2010 18:27:19 +0000 (GMT)
Subject: Elusive crash in SMC91X/PXA network code?
Message-ID: <alpine.DEB.1.10.1001181825560.22774@venus.araneidae.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have a crash, that manifests itself in a variety of ways, all of them 
leading to a kernel panic or oops, typically in smc_interrupt or in the 
associated network handling code.  Unfortunately the crash is quite 
elusive, and seems to depend on a hardware specific and out of tree driver 
(which I am busily cutting down to a minimum).

I would be hugely grateful if anybody could cast any light on this at all, 
or suggest any approach to debug this.

Firstly the basics.  The target system is an XCEP board: this has an 
embedded PXA255 processor and works with a target specific FPGA and 
driver; the core XCEP architecture is now in the mainstream kernel as of 
v2.6.32.  The network device for this board is an SMC 91C111.

The bug in question is most reliably forced by transferring a very large 
file over NFS while the embedded driver is performing DMA transfers (from 
FPGA to XCEP RAM); it is also possible to force the crash by sending 
enough UDP packets to the device; I've had no success in forcing the crash 
with any other form of network load.  It can take anything from a few 
seconds to many minutes of such stress for the crash to occur.

The crash can be reproduced on 2.6.27, 2.6.30 and 2.6.32, but 
interestingly enough not on 2.6.20 -- this does tempt thoughts of an 
elusive regression in the SMC driver or elsewhere.  Unfortunately the 
architecture step from .20 to .27 is large enough to make a regression 
test really rather painful, particularly as local patches will need to be 
migrated along with the bisect, but clearly that's an option I'll need to 
consider.

Disabling DMA support on the SMC device (producing a performance penalty 
of only 10%, that device has tiny network buffers) makes the crash much 
more elusive ... but it does crash eventually, maybe overnight.

Finally, here are a couple of crash logs (extracted from the serial log 
of the device):


Unable to handle kernel NULL pointer dereference at virtual address 00000154
pgd = c0018000
[00000154] *pgd=a3bc6031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: testdev [last unloaded: testdev]
CPU: 0    Not tainted  (2.6.30.10-dls #1)
PC is at dev_alloc_skb+0x24/0x44
LR is at dev_alloc_skb+0x1c/0x44
pc : [<c0128674>]    lr : [<c012866c>]    psr: 20000013
sp : c2de9c98  ip : c4878300  fp : c3b01b60
r10: 00000008  r9 : c4878300  r8 : 00000000
r7 : 4003c5f0  r6 : c38ccf00  r5 : c392e820  r4 : 000005f0
r3 : c0252e08  r2 : 00000000  r1 : 00000020  r0 : 000000bc
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a0018000  DAC: 00000015
Process cat (pid: 1834, stack limit = 0xc2de8270)
Stack: (0xc2de9c98 to 0xc2dea000)
9c80:                                                       c392e820 c0108ae8
9ca0: 00200200 c38ccf04 c4878300 000000b3 00000006 000040a8 00011250 0c000300
9cc0: 000005ea c38ccf08 00000000 c38f6da0 00000000 00000000 00000008 c00b5448
9ce0: 00200200 00100100 00013fff c0052a6c c38ad580 c023a098 00000008 c38f6da0
9d00: c024f594 c0054168 00013fff 00000008 00000000 00000100 c2de9dc8 c001e050
9d20: 00200200 ffffffff f2d00000 c001e9f0 c02a9340 c3474eb8 c2de9df8 000000d0
9d40: c02a9340 c2de9df8 c3474eb8 c2de9dc8 c00b5448 00200200 00100100 00013fff
9d60: c02a9378 c2de9d78 c02a9358 c005e220 80000013 ffffffff c3880ec0 c3474e20
9d80: 0000001e 00002000 c3474eb8 00000000 c2de9df8 c00b5210 00000000 00000000
9da0: c38a9f60 c38a9f60 00018000 00001000 00002000 00000000 c3474e20 c00b5bfc
9dc0: 00000000 00000000 c2de9da0 c39fec60 00013b6e c2de9df8 00013b6f 0000001e
9de0: c3474eb8 0000001e c3474ebc c005dd88 00000000 c3880ec0 c02a24d8 c02a9358
9e00: c2de8000 00013b33 00000001 c02a6620 00013b33 00000000 c3474eb8 c3880ec0
9e20: 00000000 c0057f40 0000001e 00000001 c2de9e5c c2de9e40 c0029c0c c2de9f40
9e40: 00000000 c2de9f00 00013b34 c3880f00 c3474e20 00000000 00000000 00013b32
9e60: 00000000 00000001 00000000 00000000 00001000 bedbdce0 00000000 00001000
9e80: 000004ba c2de9eb0 c3880ec0 c2de9f40 c2de9f80 fffffdee c2de8000 00000000
9ea0: 00000000 c0073628 13b33000 00000000 000004ba 0ee71ec4 00000000 00000001
9ec0: ffffffff c3880ec0 00000000 00000000 00000000 00000000 c38be660 c0037a80
9ee0: 00000000 00000000 c2de9ee8 c38be660 c0041cd0 c2de9ef4 c2de9ef4 00000004
9f00: 13b33000 00000000 00000020 c0055388 c024cbe0 c0033dfc 00001000 c00285bc
9f20: c0237408 0000001a 00000000 00000000 00000000 00000000 00000000 00000002
9f40: bedbdce0 00001000 c3880ec0 bedbdce0 00001000 c2de9f80 bedbdce0 c00741ac
9f60: 00000000 00000001 13b32000 13b33000 00000000 c3880ec0 00001000 c00742e4
9f80: 13b33000 00000000 00000000 00000000 4001f4b0 00001000 bedbdce0 00000003
9fa0: c001efc8 c001ee20 4001f4b0 00001000 00000003 bedbdce0 00001000 000829e4
9fc0: 4001f4b0 00001000 bedbdce0 00000003 00000000 00000000 40025000 00000000
9fe0: 00000003 bedbdcb8 00010445 40183f3c 40000010 00000003 00000000 00000000
[<c0128674>] (dev_alloc_skb+0x24/0x44) from [<c0108ae8>] (smc_interrupt+0x594/0xcf4)
[<c0108ae8>] (smc_interrupt+0x594/0xcf4) from [<c0052a6c>] (handle_IRQ_event+0x40/0x114)
[<c0052a6c>] (handle_IRQ_event+0x40/0x114) from [<c0054168>] (handle_edge_irq+0x114/0x154)
[<c0054168>] (handle_edge_irq+0x114/0x154) from [<c001e050>] (asm_do_IRQ+0x50/0x6c)
[<c001e050>] (asm_do_IRQ+0x50/0x6c) from [<c001e9f0>] (__irq_svc+0x30/0xc0)
Exception stack(0xc2de9d30 to 0xc2de9d78)
9d20:                                     c02a9340 c3474eb8 c2de9df8 000000d0
9d40: c02a9340 c2de9df8 c3474eb8 c2de9dc8 c00b5448 00200200 00100100 00013fff
9d60: c02a9378 c2de9d78 c02a9358 c005e220 80000013 ffffffff
[<c001e9f0>] (__irq_svc+0x30/0xc0) from [<c02a9358>] (0xc02a9358)
Code: e3e03000 ebfffce0 e3500000 0a000005 (e5903098)
Kernel panic - not syncing: Fatal exception in interrupt


Unable to handle kernel paging request at virtual address 4003c61d
pgd = c2cd0000
[4003c61d] *pgd=a2ca3031, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#1]
Modules linked in: libera msp
CPU: 0    Not tainted  (2.6.30.10-dls #1)
PC is at smc_interrupt+0x694/0xcf4
LR is at smc_interrupt+0x658/0xcf4
pc : [<c0108be8>]    lr : [<c0108bac>]    psr: 00000013
sp : c2cb7dd8  ip : c3a12020  fp : c3a15cc0
r10: 00000008  r9 : c4878300  r8 : 4003c5f0
r7 : c38ccf00  r6 : c39e8020  r5 : 000005f0  r4 : 000000bc
r3 : 00000000  r2 : 00000000  r1 : e0020000  r0 : 000005ee
Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a2cd0000  DAC: 00000015
Process ioc (pid: 664, stack limit = 0xc2cb6270)
Stack: (0xc2cb7dd8 to 0xc2cb8000)
7dc0:                                                       c38ccc00 c38ccf04
7de0: c4878300 000000b3 00000007 000040a8 4b4c533a 0c000300 000005ea c38ccf08
7e00: 00000040 c38f6da0 00000000 00000000 00000008 00000218 ffffa09b bf011558
7e20: c2cb7ed4 c0052a6c c0242b14 c023a098 00000008 c38f6da0 c024f594 c0054168
7e40: c2cb7ed4 00000008 00000000 00000100 c2cb6000 c001e050 c024cbe0 ffffffff
7e60: f2d00000 c001e9f0 00000000 00000218 00000000 c2cb6000 c2cb6000 bf1a43f4
7e80: 00008040 c2cb6000 00000218 ffffa09b bf011558 c2cb7ed4 c2cb7ed8 c2cb7eb0
7ea0: c01a2c54 c01a2c60 60000013 ffffffff c2cb6000 bf1a43f4 00008040 c2cb6000
7ec0: 00000218 ffffa09b c2cb7eec c2cb7ed8 c01a2f88 c01a2c4c bf0107dc 00000001
7ee0: c38904e0 c2cb7ef0 bf00cc84 c01a2f78 40046c60 00168138 bf01156c bf011558
7f00: 000003c0 00000000 40046c60 00000000 c3894ca0 c002bc7c bf019590 bf019590
7f20: 197e1d3e 00000001 09d0a828 00000001 00000000 00000000 00000000 c38cf2e0
7f40: 00163e38 00007800 c2cb7f80 00163e38 c2cb6000 00000000 00000000 c00741ac
7f60: c001efc8 c2cb6000 00000000 00000000 00000000 c38cf2e0 00007800 c00742e4
7f80: 00000000 00000000 00000002 00000001 001099e0 00163e38 000003c0 00000003
7fa0: c001efc8 c001ee20 001099e0 00163e38 00000009 00163e38 00007800 0001928c
7fc0: 001099e0 00163e38 000003c0 00000003 00125628 001256b8 001255fc 00000000
7fe0: 00000000 40b52d90 400337b4 40033f74 80000010 00000009 a02dc021 a02dc421
[<c0108be8>] (smc_interrupt+0x694/0xcf4) from [<c0052a6c>] (handle_IRQ_event+0x40/0x114)
[<c0052a6c>] (handle_IRQ_event+0x40/0x114) from [<c0054168>] (handle_edge_irq+0x114/0x154)
[<c0054168>] (handle_edge_irq+0x114/0x154) from [<c001e050>] (asm_do_IRQ+0x50/0x6c)
[<c001e050>] (asm_do_IRQ+0x50/0x6c) from [<c001e9f0>] (__irq_svc+0x30/0xc0)
Exception stack(0xc2cb7e68 to 0xc2cb7eb0)
7e60:                   00000000 00000218 00000000 c2cb6000 c2cb6000 bf1a43f4
7e80: 00008040 c2cb6000 00000218 ffffa09b bf011558 c2cb7ed4 c2cb7ed8 c2cb7eb0
7ea0: c01a2c54 c01a2c60 60000013 ffffffff
[<c001e9f0>] (__irq_svc+0x30/0xc0) from [<c01a2c54>] (__schedule+0x14/0x32c)
[<c01a2c54>] (__schedule+0x14/0x32c) from [<c01a2f88>] (schedule+0x1c/0x2c)
[<c01a2f88>] (schedule+0x1c/0x2c) from [<bf00cc84>] (libera_dd_read_specific+0x7c0/0xd10 [libera])
[<bf00cc84>] (libera_dd_read_specific+0x7c0/0xd10 [libera]) from [<c00741ac>] (vfs_read+0xac/0x12c)
[<c00741ac>] (vfs_read+0xac/0x12c) from [<c00742e4>] (sys_read+0x40/0x6c)
[<c00742e4>] (sys_read+0x40/0x6c) from [<c001ee20>] (ret_fast_syscall+0x0/0x2c)
Code: e24cc002 e7891003 e2800002 e5973080 (e5d8a02d)
Kernel panic - not syncing: Fatal exception in interrupt


The first traceback shows the crash with a cut down version of the 
offending driver (here called testdev); the second uses the original 
version of the driver and an auxilliary module (libera, msp).
