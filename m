From: michael@araneidae.co.uk (Michael Abbott)
Date: Fri, 15 Oct 2010 13:46:58 +0100 (BST)
Subject: Mysterious SMC network device crash
Message-ID: <alpine.DEB.1.10.1010151345150.19649@venus.araneidae.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm writing to ask whether anybody can cast any light on the oops described in
this e-mail.  I'm looking after around 200 embedded ARM systems, and around
about once a month one of them (at random) panics or oopses.  Just a few days
ago I've had two oopses with *exactly* the same call sequence recorded on the
stack; I attach both of them with my best analysis.  (I have to say that this
is exceptional, I've never seen this oops before, but it seems a promising one
to ask about.)

In brief it appears from the traceback that the kernel is in the middle of a
send system call dispatching a network packet to the attached SMSC LAN91C111
device: the top of the valid stack is a call to __raw_writesl (streaming
packet data to a fixed device address) ... and the rest of the stack is
garbage I cannot begin to explain!  I presume an interrupt has occurred and
somehow misfired, but how only the interrupt part of the stack can contain
such strange data is a mystery.

The device in question is an XCEP board, consisting of an ARM PXA255 with 64MB
RAM, 32MB flash, and an SMSC LAN91C111 network device, attached to custom
hardware with an FPGA.  So many candidates for failure...

The two loaded modules are locally built: the msp module talks over the SSP
bus to a system sensor, and the libera driver talks to the main FPGA on the
mother board, and is very busy.

So here is the oops:


Unable to handle kernel paging request at virtual address 38130000
pgd = c3988000
[38130000] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in: libera msp
CPU: 0    Not tainted  (2.6.30.9-dls #1)
PC is at 0x38130000
LR is at 0x38130000
pc : [<38130000>]    lr : [<38130000>]    psr: 60000013
sp : c2d2ba88  ip : 6179ffff  fp : 00000008
r10: c3872c00  r9 : c2d6d876  r8 : 000005ea
r7 : c3872f00  r6 : c4878300  r5 : 000005e8  r4 : fd1c0000
r3 : d9b5ffff  r2 : 00000000  r1 : c2d6de50  r0 : c4878308
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a3988000  DAC: 00000015
Process ioc (pid: 1896, stack limit = 0xc2d2a270)
Stack: (0xc2d2ba88 to 0xc2d2c000)
ba80:                   8d2f0000 57c7ffff d14a0000 b3edffff 73abffff 7f720000
baa0: 84610000 18f5feff 190e0000 4ef8ffff c4c0ffff 9d020000 106b0000 39ca0000
bac0: 957d0000 3dc7ffff 9b3b0100 91ba0000 d90bffff c01a0000 fb3e0100 d9c40000
bae0: 9368ffff 5fa1ffff 49190100 25eaffff 6658ffff 7077ffff 879e0000 fa6effff
bb00: 723b0000 20c90000 eb1d0000 85e2ffff b1190000 346f0000 8b5affff fea7ffff
bb20: 827c0000 ab1d0000 2285ffff dc7a0000 5e900000 2e55ffff 5f8bffff f22f0100
bb40: d6150000 63affeff a5a30000 e30a0300 f7faffff 820cffff 0e4d0000 fe710000
bb60: c2d6d878 c01093dc 48d9ffff c3a19268 c0126ae4 c3872c00 00000010 c3a19268
bb80: 0000000c c3872c00 c3957900 c01ae304 00000000 c01096f0 c0253120 c38f94a0
bba0: c3a19268 c3957900 c3872c00 c012e6d0 00000001 c024cc18 c38f94a0 00000000
bbc0: c3957900 c3a19268 c3872c00 c2d2a000 c3957900 c013c0a4 00000000 1425e721
bbe0: c3872c00 c38f94a0 00000000 c3a19268 c3872c00 c2d0a334 00000000 c3a19268
bc00: c2d269e0 c012eb04 0000000e c2d0a320 c3a19268 0000000e 00000000 c014a22c
bc20: c3a19268 c2d269e0 c3a19268 1425e721 c3a1928c c014817c c2d6d884 c0149c60
bc40: 00000020 c2d0fc20 c2d0fc20 00000000 c025351c 00000000 c2d0fc20 70cc17ac
bc60: 00000000 c013a174 c2cbec30 c2d269e0 c2d0fc20 c01601a0 70cc17ac 000013c8
bc80: 00000002 c2d269e0 00000406 c39a7e84 00000000 00000004 00000004 c2d347e0
bca0: c2d6d898 c2d6d898 c2d269e0 c3a19268 1425e721 c3a1928c 0000fa80 00000020
bcc0: c2d26a4c c015b230 00000000 00000004 00000002 00000000 1425e721 014b0929
bce0: 00000000 00000000 c2d269e0 c3a191c0 c2d269e0 000005a8 000005a8 c3a191c0
bd00: 0000fa80 c3a191e4 c2d26a4c c015d7e8 c2d269e0 c0158b98 00000001 00000004
bd20: 000005a8 00000000 0000000f c2d2a000 c2d269e0 c015a688 0002d4cb c3a191c0
bd40: 000000d0 c3a191c0 c2d269e0 000005a8 00000000 00000000 c2d2a000 00000000
bd60: 4730b6a8 c015d938 000000d0 00000000 00000000 c015177c c2d2bdac 000c029e
bd80: 0019cdca c2d2bf68 00000000 00000000 000005a8 000016a0 00000980 c2d26a4c
bda0: c2d2a000 00000000 c2d2bddc 00000000 7fffffff 000005a8 00000001 00000000
bdc0: 00000000 c2d2bf4c 00002020 00000000 c2d2a000 00000000 47661c30 c01207a0
bde0: c346ad24 00000000 00000000 00000001 ffffffff 00000000 00000000 00000000
be00: 00000000 00000000 c3a06640 c346ad30 00000000 00000000 c2d2be5c c3a06640
be20: c0041cd0 c2d2be24 c2d2be24 c002acb4 00000020 60000013 c2d2be70 c2d26c88
be40: c0252ed4 c2cbec44 c2cbec30 00000002 c2d2be7c c2d2be60 c002ad24 c002ac84
be60: 00000000 70cc17ac 00000000 c2d269e0 c3866740 c0122bd8 c2d269e0 00002020
be80: c346ad20 000013c8 00000000 c2d2bf4c c0244be0 c3866740 c0252ed4 c025351c
bea0: 00000008 c0242b08 c0253130 c0145744 c2d2bf74 c346ad20 00000000 4730a008
bec0: 00002020 c0120a78 c3872c00 c004db64 ffffffff c2d2bf08 c3866740 c0253110
bee0: c3872c00 00000000 00000008 c012d8e0 c3866740 c00453bc 4cb47e76 00000001
bf00: c0242b20 1425e721 00000040 00000000 c0242b04 c012d9a0 c2cbec20 c0242b20
bf20: 00000040 0000000c 0000012c c0242b04 c0242b14 1425e723 c0253120 c012df90
bf40: 00000042 c2d2a000 00000100 00000000 00000000 c2d2bf68 00000001 00000000
bf60: 00000000 00000000 4730a008 00002020 00000001 fffffff7 00000000 00000000
bf80: 00000000 003f3020 00000121 c001efc8 00000000 c0120ab4 00000000 00000000
bfa0: 00000000 c001ee20 00000000 00000000 0000001a 4730a008 00002020 00000000
bfc0: 00000000 00000000 003f3020 00000121 003f3084 000e4b10 00000000 47661c30
bfe0: 00000002 47661be8 40033774 400345a4 60000010 0000001a 33cc33c4 394c3bc4
Code: bad PC value.
Kernel panic - not syncing: Fatal exception in interrupt


Here is my decoding of this stack frame.  It looks like the top 54 words of
the stack are complete garbage, in particular there's no sensible program
counter saved.  The rest of the stack looks sensible, and I've marked each
entry point with a description of its stack frame use: variable size in bytes
+ saved registers.

Because the top of the stack was trashed I've had to unravel the stack from
the bottom, and of course the numerous indrect calls made this more difficult!
However, everything fits together, so I believe it.


???:  This ought to be an interrupt frame, but it looks sad.
                      8d2f0000 57c7ffff d14a0000 b3edffff 73abffff 7f720000
    84610000 18f5feff 190e0000 4ef8ffff c4c0ffff 9d020000 106b0000 39ca0000
    957d0000 3dc7ffff 9b3b0100 91ba0000 d90bffff c01a0000 fb3e0100 d9c40000
    9368ffff 5fa1ffff 49190100 25eaffff 6658ffff 7077ffff 879e0000 fa6effff
    723b0000 20c90000 eb1d0000 85e2ffff b1190000 346f0000 8b5affff fea7ffff
    827c0000 ab1d0000 2285ffff dc7a0000 5e900000 2e55ffff 5f8bffff f22f0100
    d6150000 63affeff a5a30000 e30a0300 f7faffff 820cffff 0e4d0000 fe710000

__raw_writesl+??? (r4,lr).  This is pure assembler and makes no calls, and so
should be the top of the stack, except for any interrupt frame.  This code is
performing a burst write to a register on the SMSC LAN91C111 network device.
    c2d6d878 c01093dc

smc_hardware_send_pkt+0x194 (#12, r4-fp,lr), call to __raw_writesl:
                      48d9ffff c3a19268 c0126ae4 c3872c00 00000010 c3a19268
    0000000c c3872c00 c3957900 c01ae304 00000000 c01096f0

smc_hard_start_xmit+0x1b4, (#4, r4-r7,lr), call to smc_hardware_send_pkt:
                                                          c0253120 c38f94a0
    c3a19268 c3957900 c3872c00 c012e6d0

dev_hard_start_xmit+0x1e0, (#8, r4-sl,lr), indirect call:
                                        00000001 c024cc18 c38f94a0 00000000
    c3957900 c3a19268 c3872c00 c2d2a000 c3957900 c013c0a4

__qdisc_run+0xe8 (#12, r4-fp,lr), call to dev_hard_start_xmit:
                                                          00000000 1425e721
    c3872c00 c38f94a0 00000000 c3a19268 c3872c00 c2d0a334 00000000 c3a19268
    c2d269e0 c012eb04

dev_queue_xmit+0x270 (#4, r4-r7,lr), call to __qdisc_run:
                      0000000e c2d0a320 c3a19268 0000000e 00000000 c014a22c

ip_finish_output+0x204 (r4-r8,lr), indirect call:
    c3a19268 c2d269e0 c3a19268 1425e721 c3a1928c c014817c

ip_local_out+0x24 (r4,lr), indirect call:
                                                          c2d6d884 c0149c60

ip_queue_xmit+0x2f0 (#100, r4-fp,lr), call to _ip_local_out:
    00000020 c2d0fc20 c2d0fc20 00000000 c025351c 00000000 c2d0fc20 70cc17ac
    00000000 c013a174 c2cbec30 c2d269e0 c2d0fc20 c01601a0 70cc17ac 000013c8
    00000002 c2d269e0 00000406 c39a7e84 00000000 00000004 00000004 c2d347e0
    c2d6d898 c2d6d898 c2d269e0 c3a19268 1425e721 c3a1928c 0000fa80 00000020
    c2d26a4c c015b230

tcp_transmit_skb+0x664 (#36, r4-fp,lr), indirect call:
                      00000000 00000004 00000002 00000000 1425e721 014b0929
    00000000 00000000 c2d269e0 c3a191c0 c2d269e0 000005a8 000005a8 c3a191c0
    0000fa80 c3a191e4 c2d26a4c c015d7e8

tcp_write_xmit+0x8bc (#52, r4-fp,lr): call to tcp_transmit_skb
                                        c2d269e0 c0158b98 00000001 00000004
    000005a8 00000000 0000000f c2d2a000 c2d269e0 c015a688 0002d4cb c3a191c0
    000000d0 c3a191c0 c2d269e0 000005a8 00000000 00000000 c2d2a000 00000000
    4730b6a8 c015d938

tcp_push_one+0x40 (#12, lr), call to tcp_write_xmit:
                      000000d0 00000000 00000000 c015177c

tcp_sendmsg+0x874 (#68, r4-fp,lr), call to tcp_push_one:
                                                          c2d2bdac 000c029e
    0019cdca c2d2bf68 00000000 00000000 000005a8 000016a0 00000980 c2d26a4c
    c2d2a000 00000000 c2d2bddc 00000000 7fffffff 000005a8 00000001 00000000
    00000000 c2d2bf4c 00002020 00000000 c2d2a000 00000000 47661c30 c01207a0

sock_sendmsg+0xa0 (#212, r4-r7,lr), indirect call:
    c346ad24 00000000 00000000 00000001 ffffffff 00000000 00000000 00000000
    00000000 00000000 c3a06640 c346ad30 00000000 00000000 c2d2be5c c3a06640
    c0041cd0 c2d2be24 c2d2be24 c002acb4 00000020 60000013 c2d2be70 c2d26c88
    c0252ed4 c2cbec44 c2cbec30 00000002 c2d2be7c c2d2be60 c002ad24 c002ac84
    00000000 70cc17ac 00000000 c2d269e0 c3866740 c0122bd8 c2d269e0 00002020
    c346ad20 000013c8 00000000 c2d2bf4c c0244be0 c3866740 c0252ed4 c025351c
    00000008 c0242b08 c0253130 c0145744 c2d2bf74 c346ad20 00000000 4730a008
    00002020 c0120a78

sys_sendto+0xb0 (#180, r4-8,sl,lr), call to sock_sendmsg:
                      c3872c00 c004db64 ffffffff c2d2bf08 c3866740 c0253110
    c3872c00 00000000 00000008 c012d8e0 c3866740 c00453bc 4cb47e76 00000001
    c0242b20 1425e721 00000040 00000000 c0242b04 c012d9a0 c2cbec20 c0242b20
    00000040 0000000c 0000012c c0242b04 c0242b14 1425e723 c0253120 c012df90
    00000042 c2d2a000 00000100 00000000 00000000 c2d2bf68 00000001 00000000
    00000000 00000000 4730a008 00002020 00000001 fffffff7 00000000 00000000
    00000000 003f3020 00000121 c001efc8 00000000 c0120ab4

sys_send+0x18 (#12, lr), call to sys_sendto:
                                                          00000000 00000000
    00000000 c001ee20

ret_fast_syscall:
                      00000000 00000000 0000001a 4730a008 00002020 00000000
    00000000 00000000 003f3020 00000121 003f3084 000e4b10 00000000 47661c30
    00000002 47661be8 40033774 400345a4 60000010 0000001a 33cc33c4 394c3bc4


I cannot come up with a persuasive theory of what is happening here.

My best theory is that, somehow, the network device has briefly interfered
with writes to the memory by the processor.  I don't find this particularly
plausible.

Intruigingly, this particular oops happened again a few hours later on a
completely different machine, with the same call sequence, ending with the
following oops:

Unable to handle kernel paging request at virtual address 16410100
pgd = c2e54000
[16410100] *pgd=00000000
Internal error: Oops: 0 [#1]
Modules linked in: libera msp [last unloaded: msp]
CPU: 0    Not tainted  (2.6.30.9-dls #1)
PC is at 0x16410100
LR is at 0x16410100
pc : [<16410100>]    lr : [<16410100>]    psr: 60000013
sp : c3a79a08  ip : 47e7ffff  fp : 00000008
r10: c38bcc00  r9 : c2d2d076  r8 : 000005ea
r7 : c38bcf00  r6 : c4878300  r5 : 000005e8  r4 : 0dffffff
r3 : 37f2ffff  r2 : 00000000  r1 : c2d2d650  r0 : c4878308
Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a2e54000  DAC: 00000015
Process ioc (pid: 22499, stack limit = 0xc3a78270)
Stack: (0xc3a79a08 to 0xc3a7a000)
9a00:                   bccfffff 1d4a0000 06480000 ddb00000 c2b6ffff b3aeffff
9a20: 7d890000 a25b0000 051d0000 45fcffff 92440000 54b4ffff 5c7b0000 2c890000
9a40: e2030000 bbccffff 80b90000 2f300000 5cf1ffff 09c5ffff 4e040000 d57bffff
9a60: 6c2d0000 68740000 61fbffff 1ba5ffff 07c50000 ecaa0000 e486ffff 7b640000
9a80: 53330000 5f040000 7e430000 14ac0000 7a52ffff 2f8cffff 505e0000 041f0000
9aa0: f83fffff 86dcffff eaae0000 6740ffff 8b170000 4f660000 3b0c0000 294bffff
9ac0: 1a8b0000 21640000 cecdffff ee5c0000 f0190000 a8eaffff 1a450000 88870000
9ae0: f8f4ffff d668ffff 1d950000 20540000 9feeffff a0790000 5ff5ffff 8ea2ffff
9b00: 01faffff 85060100 9692ffff 4ac9ffff a5a80000 aa200000 25a6ffff 03620000
9b20: a2370000 0c90ffff 69570000 7c1e0000 ed70ffff 794fffff c17b0000 c295ffff
9b40: 9593ffff d5e50000 ebcaffff 3758ffff bcdbffff e34b0000 ea58ffff 295affff
9b60: c2d2d078 c01093dc c38bcc00 c3bbf548 c01ae304 c38bcc00 00000010 c3bbf548
9b80: 0000000c c38bcc00 c38f9900 c01ae304 00000000 c01096f0 00000000 c38774a0
9ba0: c3bbf548 c38f9900 c38bcc00 c012e6d0 00000001 c3a78000 c38774a0 00000000
9bc0: c38f9900 c3bbf548 c38bcc00 c3a78000 c38f9900 c013c0a4 00000000 67cca19d
9be0: c38bcc00 c38774a0 00000000 c3bbf548 c38bcc00 c2dec4f4 00000000 c3bbf548
9c00: c3980460 c012eb04 0000000e c2dec4e0 c3bbf548 0000000e 00000000 c014a22c
9c20: c3bbf548 c3980460 c3bbf548 67cca19d c3bbf56c c014817c c2d2d084 c0149c60
9c40: c2d528e0 c01601a0 8acc17ac 00000000 00000002 00000006 c0244be0 c2d528e0
9c60: c0252ed4 c025351c 00000008 c0242b08 c0253130 c0145744 00000000 c2d4b230
9c80: 00000002 c3980460 00000406 c3b9e8c4 00000000 00000004 00000004 c2c852c0
9ca0: c2d2d098 c2d2d098 c3980460 c3bbf548 67cca19d c3bbf56c 0000fa80 00000020
9cc0: c39804cc c015b230 00000000 00000004 00000002 00000000 67cca19d 02764767
9ce0: 00000000 00000000 c3980460 c3bbf4a0 c3980460 000005a8 000005a8 c3bbf4a0
9d00: 0000fa80 c3bbf4c4 c39804cc c015d7e8 c3980460 c0158b98 00000001 00000004
9d20: 000005a8 00000000 00000010 c3a78000 c3980460 c015a688 00000008 c3bbf4a0
9d40: 000000d0 c3bbf4a0 c3980460 000005a8 00000000 00000000 c3a78000 00000000
9d60: 472eb100 c015d938 000000d0 00000000 00000000 c015177c c3a79dac 003ddedc
9d80: 0019a8b4 c3a79f68 00000000 00000000 000005a8 000010f8 00000f28 c39804cc
9da0: c3a78000 00000000 c3a79ddc 00000000 7fffffff 000005a8 00000001 00000000
9dc0: 00000000 c3a79f4c 00002020 00000000 c3a78000 00000000 474e1c30 c01207a0
9de0: c34720c4 00000000 00000000 00000001 ffffffff 00000000 00000000 00000000
9e00: 00000000 00000000 c38c0960 c34720d0 00000000 00000000 c3a79e5c c38c0960
9e20: c0041cd0 c3a79e24 c3a79e24 c002acb4 00000020 60000013 c3a79e70 c3980708
9e40: c0252ed4 c2d4b844 c2d4b830 00000002 c3a79e7c c3a79e60 c002ad24 c002ac84
9e60: 00000000 8acc17ac 00000000 c3980460 c2e83540 c0122bd8 c3980460 00002020
9e80: c34720c0 000013c8 00000000 c3a79f4c c0244be0 c2e83540 c0252ed4 c025351c
9ea0: 00000008 c0242b08 c0253130 c0145744 c3a79f74 c34720c0 00000000 472ea008
9ec0: 00002020 c0120a78 c38bcc00 c004db64 ffffffff c3a79f08 c2e83540 c0253110
9ee0: c38bcc00 00000000 00000008 c012d8e0 c2e83540 c00453bc 4cb4cb11 00000001
9f00: c0242b20 67cca19d 00000040 00000000 c0242b04 c012d9a0 c2d4b820 c0242b20
9f20: 00000040 0000000c 0000012c c0242b04 c0242b14 67cca19f c0253120 c012df90
9f40: 00000042 c3a78000 00000100 00000000 00000000 c3a79f68 00000001 00000000
9f60: 00000000 00000000 472ea008 00002020 00000001 fffffff7 00000000 00000000
9f80: 00000000 003f31b8 00000121 c001efc8 00000000 c0120ab4 00000000 00000000
9fa0: 00000000 c001ee20 00000000 00000000 0000001a 472ea008 00002020 00000000
9fc0: 00000000 00000000 003f31b8 00000121 003f321c 000e4b10 00000000 474e1c30
9fe0: 00000002 474e1be8 40033774 400345a4 60000010 0000001a 00000000 00000000
Code: bad PC value.
Kernel panic - not syncing: Fatal exception in interrupt


By the way, how does the kernel know that it's in an interrupt?  None of the
registers hold this information, I guess it must be somewhere in the task
control block.  If so, it wouldn't hurt to include a dump of the control block
in the oops dump.
