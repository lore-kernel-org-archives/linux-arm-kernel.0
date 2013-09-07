From: jochen.armkernel@leahnim.org (Jochen De Smet)
Date: Sat, 07 Sep 2013 19:18:22 -0400
Subject: Unhandled prefetch abort on mirabox with 3.11-rc7
In-Reply-To: <20130903155537.GI6617@n2100.arm.linux.org.uk>
References: <52253229.2050103@leahnim.org>
 <20130903104817.GE19598@titan.lakedaemon.net>
 <20130903155537.GI6617@n2100.arm.linux.org.uk>
Message-ID: <522BB43E.7090700@leahnim.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2013 11:55, Russell King - ARM Linux wrote:
> On Tue, Sep 03, 2013 at 06:48:17AM -0400, Jason Cooper wrote:
>
> This is also inside __memzero, which will have been used many times before
> this point, so its highly unlikely that the kernel would have been booted
> if there was a problem here.
>
> so, i'm afraid again, I don't think this is a kernel bug but pointing
> towards a hardware weakness.  The argument against that is you say that
> it's a different (your second) mirabox...  unless it's a generic design
> weakness.
>
> Keep on posting the oopses though, there may be a pattern to them.
Next ones.   Box had been running without issues for a few days on 3.11 
+ Thomas'
patch for the HW PHY polling.

Recompiled the kernel with Willy's patches for the atags MAC passing, 
then got the
three OOPSES below during the reboot; I was still able to log in, just 
rebooted again,
and this time it came up without any issues.

There's one weird timing thing I don't quite understand as well; 
probably unrelated but I
thought I'd mention it anyway.  The failing boot was a simple "reboot" 
command, and
showed this:

[    0.000000] Aurora cache controller enabled
[    0.000000] l2x0: 4 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a086302, 
Cache size: 262144 B
[    0.000000] Console: colour dummy device 80x30
[   39.263382] Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
[   39.353093] pid_max: default: 32768 minimum: 301

The 39 seconds is probably about right from the start of u-boot till 
this point.  In the working boot
afterwards, which was a full powercycle (networked PDU), it shows:

[    0.000000] Aurora cache controller enabled
[    0.000000] l2x0: 4 ways, CACHE_ID 0x00000100, AUX_CTRL 0x1a086302, 
Cache size: 262144 B
[    0.000000] Console: colour dummy device 80x30
[  223.486705] Calibrating delay loop... 1196.85 BogoMIPS (lpj=5984256)
[  223.576415] pid_max: default: 32768 minimum: 301

Don't know where the big difference comes from, or how it gets to 223 
seconds there.


[   48.900325] usbcore: registered new interface driver usbserial
[   48.989303] usbcore: registered new interface driver ftdi_sio
[   49.000135] Unable to handle kernel paging request at virtual address 
f2bc877c
[   49.007379] pgd = eea38000
[   49.010090] [f2bc877c] *pgd=00000000
[   49.013686] Internal error: Oops: 15 [#1] ARM
[   49.018049] Modules linked in: ftdi_sio(+) usbserial autofs4 ext4 
jbd2 mbcache sd_mod usb_storage mmc_block mvsdio xhci_hcd mmc_core 
ehci_orion
[   49.031093] CPU: 0 PID: 840000000 Comm: systemd-udevd Not tainted 
3.11.0-stock4-dirty #34
[   49.039285] task: ef244c00 ti: ef2a0000 task.ti: ef2a0000
[   49.044702] PC is at __task_pid_nr_ns+0x9c/0xa4
[   49.049244] LR is at schedule_tail+0x44/0x64
[   49.053522] pc : [<c0035d30>]    lr : [<c0041bc8>] psr: a0000013
[   49.053522] sp : ef2a1f88  ip : ef2a1f88  fp : ef2a1f94
[   49.065018] r10: 00000000  r9 : 00000000  r8 : 00000000
[   49.070251] r7 : 00000000  r6 : 00000000  r5 : bf000000  r4 : ef2a0000
[   49.076789] r3 : f2bc875c  r2 : c041da86  r1 : 00000000  r0 : ef244c00
[   49.083327] Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[   49.090474] Control: 10c5387d  Table: 2ea38019  DAC: 00000015
[   49.096229] Process systemd-udevd (pid: 840000000, stack limit = 
0xef2a0230)
[   49.103289] Stack: (0xef2a1f88 to 0xef2a2000)
[   49.107656] 1f80:                   ef2a1fac ef2a1f98 c0041bc8 
c0035ca0 00000000 00000000
[   49.115851] 1fa0: 00000000 ef2a1fb0 c000e588 c0041b90 00000000 
00000000 00000000 00000000
[   49.124045] 1fc0: b6f60068 becf26a8 b6e72000 00000078 00000000 
b6f60000 b6fa91c0 becf26e4
[   49.132240] 1fe0: b6f604c0 becf26a8 00000548 b6dccaec 60000010 
01200011 00000000 00000000
[   49.140427] Backtrace:
[   49.142895] [<c0035c94>] (__task_pid_nr_ns+0x0/0xa4) from 
[<c0041bc8>] (schedule_tail+0x44/0x64)
[   49.151705] [<c0041b84>] (schedule_tail+0x0/0x64) from [<c000e588>] 
(ret_from_fork+0x4/0x3c)
[   49.160154]  r5:00000000 r4:00000000
[   49.163759] Code: e5933120 e3530000 15932004 10833202 (15932020)
[   49.169864] ---[ end trace 6a2fed82f0a6e9e4 ]---
[ 49.163759] Code: e5933120 e3530000 15932004 10833202 (15932020)
All code
========
    0:   e5933120        ldr     r3, [r3, #288]  ; 0x120
    4:   e3530000        cmp     r3, #0
    8:   15932004        ldrne   r2, [r3, #4]
    c:   10833202        addne   r3, r3, r2, lsl #4
   10:*  15932020        ldrne   r2, [r3, #32]           <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   15932020        ldrne   r2, [r3, #32]


[   49.497217] Unable to handle kernel paging request at virtual address 
6d14002c
[   49.504471] pgd = c0004000
[   49.507200] [6d14002c] *pgd=00000000
[   49.510797] Internal error: Oops: 15 [#2] ARM
[   49.515161] Modules linked in: ftdi_sio usbserial autofs4 ext4 jbd2 
mbcache sd_mod usb_storage mmc_block mvsdio xhci_hcd mmc_core ehci_orion
[   49.527945] CPU: 0 PID: 840000000 Comm: systemd-udevd Tainted: G      
D      3.11.0-stock4-dirty #34
[   49.537093] task: ef244c00 ti: ef2a0000 task.ti: ef2a0000
[   49.542515] PC is at acct_process+0x28/0x88
[   49.546705] LR is@acct_process+0x20/0x88
[   49.550896] pc : [<c005dcf8>]    lr : [<c005dcf0>] psr: 20000013
[   49.550896] sp : ef2a1da0  ip : ef2a1da0  fp : ef2a1db4
[   49.562392] r10: ef378e40  r9 : ef244c00  r8 : 00000015
[   49.567626] r7 : ef2a0000  r6 : c037a17c  r5 : 6d140000  r4 : ef2a0038
[   49.574164] r3 : ee839800  r2 : ef2a1da0  r1 : ef378e40  r0 : 6d140000
[   49.580702] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[   49.587849] Control: 10c5387d  Table: 2ea7c019  DAC: 00000015
[   49.593604] Process systemd-udevd (pid: 840000000, stack limit = 
0xef2a0230)
[   49.600663] Stack: (0xef2a1da0 to 0xef2a2000)
[   49.605032] 1da0: ef2a0038 00000000 ef2a1dec ef2a1db8 c0020500 
c005dcdc c0400630 00000001
[   49.613227] 1dc0: ef378e70 00000015 ef244c00 c041dd44 ef2a1dec 
ef2a1de0 c001f674 ef2a0000
[   49.621421] 1de0: ef2a1e2c ef2a1df0 c00120a4 c001fe98 ef2a0230 
0000000b 60000193 ef2a0000
[   49.629615] 1e00: c0385da8 f2bc877c 00000015 ef378e40 ef2a1f40 
ef2a1f40 00000000 00000000
[   49.637810] 1e20: ef2a1e44 ef2a1e30 c02e0384 c0011f2c ef2a1f40 
ef378e40 ef2a1e6c ef2a1e48
[   49.646004] 1e40: c0018c68 c02e0324 ef2a1e7c ef2a1e58 00000015 
c0004000 eea38000 00000000
[   49.654199] 1e60: ef2a1e8c ef2a1e70 c02e7008 c0018be4 00000015 
c02e6f94 c04011fc f2bc877c
[   49.662394] 1e80: ef2a1f3c ef2a1e90 c0008428 c02e6fa0 c02e589c 
c02e70f8 ef2a1f44 ef2a1ea8
[   49.670589] 1ea0: c002bfb4 c00213a0 00000011 c02e44b4 c0433d98 
c03fc0cc c041da86 ef2a0018
[   49.678783] 1ec0: 00000000 00000000 c0040e78 c00448e8 00000000 
ef244c00 00000001 ef244c00
[   49.686977] 1ee0: ef2a1f0c ef2a1ef0 c0042dbc c0040e54 00000000 
ef244c00 00000004 ee95f190
[   49.695171] 1f00: c040753c ee95f180 ef244c00 ef2a0000 00000000 
ef244cf4 ef244bf8 c0035d30
[   49.703366] 1f20: a0000013 ffffffff ef2a1f74 00000000 ef2a1f94 
ef2a1f40 c02e54f8 c00083f4
[   49.711560] 1f40: ef244c00 00000000 c041da86 f2bc875c ef2a0000 
bf000000 00000000 00000000
[   49.719755] 1f60: 00000000 00000000 00000000 ef2a1f94 ef2a1f88 
ef2a1f88 c0041bc8 c0035d30
[   49.727949] 1f80: a0000013 ffffffff ef2a1fac ef2a1f98 c0041bc8 
c0035ca0 00000000 00000000
[   49.736143] 1fa0: 00000000 ef2a1fb0 c000e588 c0041b90 00000000 
00000000 00000000 00000000
[   49.744337] 1fc0: b6f60068 becf26a8 b6e72000 00000078 00000000 
b6f60000 b6fa91c0 becf26e4
[   49.752532] 1fe0: b6f604c0 becf26a8 00000548 b6dccaec 60000010 
01200011 00000000 00000000
[   49.760720] Backtrace:
[   49.763192] [<c005dcd0>] (acct_process+0x0/0x88) from [<c0020500>] 
(do_exit+0x674/0x884)
[   49.771295]  r5:00000000 r4:ef2a0038
[   49.774910] [<c001fe8c>] (do_exit+0x0/0x884) from [<c00120a4>] 
(die+0x184/0x238)
[   49.782316]  r7:ef2a0000
[   49.784874] [<c0011f20>] (die+0x0/0x238) from [<c02e0384>] 
(__do_kernel_fault.part.9+0x6c/0x7c)
[   49.793596] [<c02e0318>] (__do_kernel_fault.part.9+0x0/0x7c) from 
[<c0018c68>] (do_sect_fault+0x0/0x18)
[   49.803002]  r7:ef378e40 r3:ef2a1f40
[   49.806612] [<c0018bd8>] (do_bad_area+0x0/0x90) from [<c02e7008>] 
(do_translation_fault+0x74/0xa8)
[   49.815583]  r7:00000000 r6:eea38000 r5:c0004000 r4:00000015
[   49.821299] [<c02e6f94>] (do_translation_fault+0x0/0xa8) from 
[<c0008428>] (do_DataAbort+0x40/0xa0)
[   49.830357]  r7:f2bc877c r6:c04011fc r5:c02e6f94 r4:00000015
[   49.836078] [<c00083e8>] (do_DataAbort+0x0/0xa0) from [<c02e54f8>] 
(__dabt_svc+0x38/0x60)
[   49.844268] Exception stack(0xef2a1f40 to 0xef2a1f88)
[   49.849331] 1f40: ef244c00 00000000 c041da86 f2bc875c ef2a0000 
bf000000 00000000 00000000
[   49.857525] 1f60: 00000000 00000000 00000000 ef2a1f94 ef2a1f88 
ef2a1f88 c0041bc8 c0035d30
[   49.865715] 1f80: a0000013 ffffffff
[   49.869207]  r8:00000000 r7:ef2a1f74 r6:ffffffff r5:a0000013 r4:c0035d30
[   49.875985] [<c0035c94>] (__task_pid_nr_ns+0x0/0xa4) from 
[<c0041bc8>] (schedule_tail+0x44/0x64)
[   49.884790] [<c0041b84>] (schedule_tail+0x0/0x64) from [<c000e588>] 
(ret_from_fork+0x4/0x3c)
[   49.893240]  r5:00000000 r4:00000000
[   49.896844] Code: e593000c ebff5fdf e2505000 089da830 (e595002c)
[   49.902982] ---[ end trace 6a2fed82f0a6e9e5 ]---
[   49.907617] Fixing recursive fault but reboot is needed!
[ 49.896844] Code: e593000c ebff5fdf e2505000 089da830 (e595002c)
All code
========
    0:   e593000c        ldr     r0, [r3, #12]
    4:   ebff5fdf        bl      0xfffd7f88
    8:   e2505000        subs    r5, r0, #0
    c:   089da830        ldmeq   sp, {r4, r5, fp, sp, pc}
   10:*  e595002c        ldr     r0, [r5, #44]   ; 0x2c <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   e595002c        ldr     r0, [r5, #44]   ; 0x2c


[   94.343076] Unable to handle kernel NULL pointer dereference at 
virtual address 00000030
[   94.351200] pgd = ef380000
[   94.353927] [00000030] *pgd=00000000
[   94.357524] Internal error: Oops: 15 [#3] ARM
[   94.361888] Modules linked in: drbd lru_cache dlm sctp configfs raid1 
md_mod iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi 
ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat iptable_mangle ipt_REJECT 
xt_conntrack ebtable_filter ebtables iptable_filter ip_tables ext3 jbd 
ftdi_sio usbserial autofs4 ext4 jbd2 mbcache sd_mod usb_storage 
mmc_block mvsdio xhci_hcd mmc_core ehci_orion
[   94.395978] CPU: 0 PID: 1317 Comm: systemd-journal Tainted: G      
D      3.11.0-stock4-dirty #34
[   94.404865] task: ee9724c0 ti: ee8d2000 task.ti: ee8d2000
[   94.410288] PC is at generic_make_request_checks+0x28/0x2a8
[   94.415873] LR is@generic_make_request+0x18/0xdc
[   94.420759] pc : [<c0138c90>]    lr : [<c013a1c4>] psr: 00000113
[   94.420759] sp : ee8d3b20  ip : 00000000  fp : ee8d3b74
[   94.432257] r10: c0c292c0  r9 : c02e5560  r8 : c02e5560
[   94.437490] r7 : 007126e8  r6 : c02e5560  r5 : ee8d3cd4  r4 : c02e5560
[   94.444027] r3 : 00000000  r2 : 00000000  r1 : 007126e8  r0 : c0400648
[   94.450566] Flags: nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[   94.457713] Control: 10c5387d  Table: 2f380019  DAC: 00000015
[   94.463468] Process systemd-journal (pid: 1317, stack limit = 0xee8d2230)
[   94.470266] Stack: (0xee8d3b20 to 0xee8d4000)
[   94.474635] 3b20: ee8d3b44 ee8d3b30 c0023208 c006f1cc 0000006e 
c040c088 ee8d3b64 ee8d3b48
[   94.482830] 3b40: c000f40c c00231bc 00000074 c0439100 000003ff 
c02e5560 ee8d3cd4 c02e5560
[   94.491024] 3b60: 007126e8 eedb3d74 ee8d3b9c ee8d3b78 c013a1c4 
c0138c74 ee8d3bfc ee8d3b88
[   94.499219] 3b80: 00000000 ee8d3cd4 c02e5560 007126e8 ee8d3bfc 
ee8d3ba0 c013a310 c013a1b8
[   94.507413] 3ba0: c0c292c0 00000001 00001233 00000000 ee8d3c28 
ee8d3bfc ee8d3b38 ee8d3bd4
[   94.515607] 3bc0: c007e9b8 c00e5a3c 60000113 ffffffff c0c292c0 
00000000 ee8d3cd4 00200200
[   94.523801] 3be0: 00100100 eedb3d74 c02e5560 c0c292c0 ee8d3c94 
ee8d3c00 c00e5f80 c013a294
[   94.531996] 3c00: ee8d3c28 ee8d3c1c bf0914f0 00000041 c041d3ec 
bf0914f0 bf07e73c 00001232
[   94.540190] 3c20: 00000000 00000000 00001000 ee8d3c38 c0c292c0 
c00ae344 0010263f 00000000
[   94.548384] 3c40: 00001000 00000000 eed13ac0 eed833a0 ee849800 
ee8d3d10 bf0965dc eedb3d74
[   94.556579] 3c60: ee8d3cac 00000000 000213da eedb3d74 00000001 
ee8d3cd4 00001222 00001232
[   94.564773] 3c80: eedb3d78 00001233 ee8d3cb4 ee8d3c98 bf08fec4 
c00e5e78 00000001 bf08fe7c
[   94.572967] 3ca0: 00000011 00000020 ee8d3d1c ee8d3cb8 c0087bac 
bf08fe88 edd39888 ef28ea40
[   94.581161] 3cc0: 00000018 eedb3d74 00000001 ee8d3cd4 c00d9bcc 
ee8d3cd4 ee8d3cd4 91827364
[   94.589356] 3ce0: ee8d3ce0 ee8d3ce0 ee8d3ce8 ee8d3ce8 60000113 
eedb3d74 00000000 00000fff
[   94.597550] 3d00: 00000000 00001232 ef28ea40 eedb3cb8 ee8d3d34 
ee8d3d20 c0088290 c0087a24
[   94.605744] 3d20: 00000008 00000000 ee8d3d84 ee8d3d38 c00805e0 
c008826c bf09669c c00b4acc
[   94.613939] 3d40: ee8d2020 ef28ea88 ee8d3d6c ed9baac8 ee8d3d98 
eedb3d74 c0bcb500 ed9baac8
[   94.622133] 3d60: 00000029 ef378cc0 b66c7000 00000001 00000000 
ef382d98 ee8d3dd4 ee8d3d88
[   94.630328] 3d80: c0098c24 c00802ac ee8d3db4 00000000 00000000 
00000200 00000029 00001232
[   94.638522] 3da0: b66c7000 00000000 ee8d3dd4 ed9baac8 b66c7000 
ef378cc0 ef378cc0 ed9baac8
[   94.646716] 3dc0: 00000000 ef382d98 ee8d3e24 ee8d3dd8 c009bb34 
c0098bbc 00001232 00000029
[   94.654910] 3de0: 00000000 00000001 ee8d3e34 ee8d3df8 c0044a6c 
c0044734 c0085298 ef380000
[   94.663105] 3e00: 000005b3 b66c7000 ef378cc0 ed9baac8 00000029 
ef382d98 ee8d3e5c ee8d3e28
[   94.671299] 3e20: c009c1bc c009bacc ef382d98 00000029 c02ed834 
00000817 ee8d3fb0 ee8d2020
[   94.679494] 3e40: b66c7000 ef378cc0 ee9724c0 00000029 ee8d3efc 
ee8d3e60 c02e6e54 c009c128
[   94.687688] 3e60: c00418f8 c0041760 a6660000 eeb7fbd0 ef0293c0 
00000000 00000200 00000000
[   94.695882] 3e80: ef378cf0 00000800 ffffffff 00000000 ee8d3ec4 
ee8d3ea0 c02e7088 c000965c
[   94.704077] 3ea0: ffffffff ee84e01c ee9724c0 ef378cc0 00000000 
ee839b80 ee8d3edc ee8d3ec8
[   94.712271] 3ec0: ffffffff ee9724c0 c0405ed0 ef378cc0 ee8d3f7c 
00000817 c02e6bb0 c040121c
[   94.720466] 3ee0: b66c7000 ee8d3fb0 d3a1da08 b6f19430 ee8d3fac 
ee8d3f00 c0008428 c02e6bbc
[   94.728660] 3f00: c041da86 ee8d2020 ee8d3f2c ee8d3f18 c009e168 
c00ae344 ef378cc0 eeb7fc28
[   94.736855] 3f20: ee8d3f6c ee8d3f30 00000013 ef378cf0 a6a61000 
ef378cf0 00000000 00401000
[   94.745049] 3f40: a6660000 c000e6a8 ee8d2000 00000000 ee8d3f6c 
ee8d2010 ee8d2000 c000e6a8
[   94.753244] 3f60: ee8d3fb0 c000e6a8 ee8d2000 00000000 ee8d3f8c 
ee8d3f80 c02e44b4 c02e4070
[   94.761438] 3f80: ee8d3fac ee8d3f90 c0011978 b6ca56d0 a0000010 
ffffffff 002b45f8 00000000
[   94.769633] 3fa0: 00000000 ee8d3fb0 c02e5698 c00083f4 b66c6fe8 
befc0218 ffffffa0 002b2868
[   94.777827] 3fc0: 00000000 7bce025b 78c3ac7d 002b45f8 00000000 
d3a1da08 b6f19430 befc2bb8
[   94.786021] 3fe0: de52a999 befc00cc 70b3b6e5 b6ca56d0 a0000010 
ffffffff 2f7fd821 2f7fdc21
[   94.794209] Backtrace:
[   94.796678] [<c0138c68>] (generic_make_request_checks+0x0/0x2a8) from 
[<c013a1c4>] (generic_make_request+0x18/0xdc)
[   94.807128]  r8:eedb3d74 r7:007126e8 r6:c02e5560 r5:ee8d3cd4 r4:c02e5560
[   94.813902] [<c013a1ac>] (generic_make_request+0x0/0xdc) from 
[<c013a310>] (submit_bio+0x88/0x14c)
[   94.822874]  r7:007126e8 r6:c02e5560 r5:ee8d3cd4 r4:00000000
[   94.828597] [<c013a288>] (submit_bio+0x0/0x14c) from [<c00e5f80>] 
(mpage_readpages+0x114/0x130)
[   94.837382] [<c00e5e6c>] (mpage_readpages+0x0/0x130) from 
[<bf08fec4>] (ext4_readpages+0x48/0x4c [ext4])
[   94.846902] [<bf08fe7c>] (ext4_readpages+0x0/0x4c [ext4]) from 
[<c0087bac>] (__do_page_cache_readahead+0x194/0x274)
[   94.857351]  r6:00000020 r5:00000011 r4:bf08fe7c r3:00000001
[   94.863069] [<c0087a18>] (__do_page_cache_readahead+0x0/0x274) from 
[<c0088290>] (ra_submit+0x30/0x38)
[   94.872401] [<c0088260>] (ra_submit+0x0/0x38) from [<c00805e0>] 
(filemap_fault+0x340/0x3f4)
[   94.880774] [<c00802a0>] (filemap_fault+0x0/0x3f4) from [<c0098c24>] 
(__do_fault+0x74/0x46c)
[   94.889231] [<c0098bb0>] (__do_fault+0x0/0x46c) from [<c009bb34>] 
(handle_pte_fault+0x74/0x65c)
[   94.897948] [<c009bac0>] (handle_pte_fault+0x0/0x65c) from 
[<c009c1bc>] (handle_mm_fault+0xa0/0xd4)
[   94.907016] [<c009c11c>] (handle_mm_fault+0x0/0xd4) from [<c02e6e54>] 
(do_page_fault+0x2a4/0x3e4)
[   94.915907] [<c02e6bb0>] (do_page_fault+0x0/0x3e4) from [<c0008428>] 
(do_DataAbort+0x40/0xa0)
[   94.924456] [<c00083e8>] (do_DataAbort+0x0/0xa0) from [<c02e5698>] 
(__dabt_usr+0x38/0x40)
[   94.932646] Exception stack(0xee8d3fb0 to 0xee8d3ff8)
[   94.937707] 3fa0:                                     b66c6fe8 
befc0218 ffffffa0 002b2868
[   94.945901] 3fc0: 00000000 7bce025b 78c3ac7d 002b45f8 00000000 
d3a1da08 b6f19430 befc2bb8
[   94.954094] 3fe0: de52a999 befc00cc 70b3b6e5 b6ca56d0 a0000010 ffffffff
[   94.960717]  r8:00000000 r7:002b45f8 r6:ffffffff r5:a0000010 r4:b6ca56d0
[   94.967488] Code: e590000c e1b014a1 0a000007 e590c008 (e59c4030)
[   94.973668] ---[ end trace 6a2fed82f0a6e9e6 ]---
[ 94.967488] Code: e590000c e1b014a1 0a000007 e590c008 (e59c4030)
All code
========
    0:   e590000c        ldr     r0, [r0, #12]
    4:   e1b014a1        lsrs    r1, r1, #9
    8:   0a000007        beq     0x2c
    c:   e590c008        ldr     ip, [r0, #8]
   10:*  e59c4030        ldr     r4, [ip, #48]   ; 0x30 <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   e59c4030        ldr     r4, [ip, #48]   ; 0x30


As I was typing up this mail, the machine triple-oopsed again:

[ 1199.620415] Unable to handle kernel paging request at virtual address 
83941e58
[ 1199.627659] pgd = e74a4000
[ 1199.630370] [83941e58] *pgd=00000000
[ 1199.633967] Internal error: Oops: 15 [#1] ARM
[ 1199.638331] Modules linked in: nfsv3 nfs_acl auth_rpcgss oid_registry 
nfsv4 dns_resolver nfs lockd sunrpc sha1_generic drbd lru_cache dlm sctp 
configfs raid1 md_mod iscsi_tcp libiscsi_tcp libiscsi 
scsi_transport_iscsi ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables 
iptable_filter ip_tables ext3 jbd ftdi_sio usbserial autofs4 ext4 jbd2 
mbcache sd_mod usb_storage mmc_block mvsdio xhci_hcd mmc_core ehci_orion
[ 1199.680175] CPU: 0 PID: 9373 Comm: drbd Not tainted 
3.11.0-stock4-dirty #34
[ 1199.687149] task: e9de4800 ti: e98ae000 task.ti: e98ae000
[ 1199.692564] PC is at copy_process.part.66+0x9ac/0xdd0
[ 1199.697629] LR is@recalc_sigpending+0x20/0x70
[ 1199.702255] pc : [<c001e3a0>]    lr : [<c0029bf0>] psr: 20000093
[ 1199.702255] sp : e98aff00  ip : e98afefc  fp : e98aff4c
[ 1199.713751] r10: b6f54068  r9 : e9a09080  r8 : c040594c
[ 1199.718985] r7 : e9a091bc  r6 : c041df00  r5 : e98ae000  r4 : 01200011
[ 1199.725522] r3 : 83941e3c  r2 : e982a1c0  r1 : e9de4800  r0 : 00000000
[ 1199.732061] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[ 1199.739296] Control: 10c5387d  Table: 274a4019  DAC: 00000015
[ 1199.745050] Process drbd (pid: 9373, stack limit = 0xe98ae230)
[ 1199.750892] Stack: (0xe98aff00 to 0xe98b0000)
[ 1199.755262] ff00: e9a091f4 00000000 e9a0917c 00000000 00000000 
00000000 c002a7d8 fffffff4
[ 1199.763456] ff20: e98ae000 01200011 00020200 00000000 00000000 
00000000 e98ae000 00000000
[ 1199.771651] ff40: e98aff8c e98aff50 c001e914 c001da00 e98afefc 
00000000 beb6f928 c015854c
[ 1199.779845] ff60: e98affa4 e98aff70 c002ca10 b6f54068 beb6f8f0 
429e8000 00000078 c000e6a8
[ 1199.788040] ff80: e98affa4 e98aff90 c001ebf8 c001e884 b6f54068 
c000e6a8 00000000 e98affa8
[ 1199.796234] ffa0: c000e500 c001ebe0 b6f54068 beb6f8f0 01200011 
00000000 00000000 00000000
[ 1199.804428] ffc0: b6f54068 beb6f8f0 429e8000 00000078 000d6d64 
b6f54000 00124931 beb6f91c
[ 1199.812621] ffe0: b6f544c0 beb6f8f0 00000000 42942aec 60000010 
01200011 00000000 00000000
[ 1199.820810] Backtrace:
[ 1199.823278] [<c001d9f4>] (copy_process.part.66+0x0/0xdd0) from 
[<c001e914>] (do_fork+0x9c/0x2c4)
[ 1199.832081] [<c001e878>] (do_fork+0x0/0x2c4) from [<c001ebf8>] 
(SyS_clone+0x24/0x2c)
[ 1199.839835]  r8:c000e6a8 r7:00000078 r6:429e8000 r5:beb6f8f0 r4:b6f54068
[ 1199.846611] [<c001ebd4>] (SyS_clone+0x0/0x2c) from [<c000e500>] 
(ret_fast_syscall+0x0/0x30)
[ 1199.854978] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
[ 1199.861089] ---[ end trace 94014f1f108fb76a ]---
[ 1199.854978] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
All code
========
    0:   e5933138        ldr     r3, [r3, #312]  ; 0x138
    4:   e5893138        str     r3, [r9, #312]  ; 0x138
    8:   e59c3004        ldr     r3, [ip, #4]
    c:   e08c3203        add     r3, ip, r3, lsl #4
   10:*  e593201c        ldr     r2, [r3, #28]           <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   e593201c        ldr     r2, [r3, #28]


[ 1283.257094] Unable to handle kernel paging request at virtual address 
84389258
[ 1283.264338] pgd = eaa78000
[ 1283.267049] [84389258] *pgd=00000000
[ 1283.270647] Internal error: Oops: 15 [#2] ARM
[ 1283.275011] Modules linked in: nfsv3 nfs_acl auth_rpcgss oid_registry 
nfsv4 dns_resolver nfs lockd sunrpc sha1_generic drbd lru_cache dlm sctp 
configfs raid1 md_mod iscsi_tcp libiscsi_tcp libiscsi 
scsi_transport_iscsi ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables 
iptable_filter ip_tables ext3 jbd ftdi_sio usbserial autofs4 ext4 jbd2 
mbcache sd_mod usb_storage mmc_block mvsdio xhci_hcd mmc_core ehci_orion
[ 1283.316858] CPU: 0 PID: 10564 Comm: crm_master Tainted: G D      
3.11.0-stock4-dirty #34
[ 1283.325398] task: eaba2180 ti: eabe2000 task.ti: eabe2000
[ 1283.330813] PC is at copy_process.part.66+0x9ac/0xdd0
[ 1283.335877] LR is@recalc_sigpending+0x20/0x70
[ 1283.340504] pc : [<c001e3a0>]    lr : [<c0029bf0>] psr: 20000093
[ 1283.340504] sp : eabe3f00  ip : eabe3efc  fp : eabe3f4c
[ 1283.352000] r10: b6fd8068  r9 : e997a3c0  r8 : c040594c
[ 1283.357233] r7 : e997a4fc  r6 : c041df00  r5 : eabe2000  r4 : 01200011
[ 1283.363771] r3 : 8438923c  r2 : ef039ec0  r1 : eaba2180  r0 : 00000000
[ 1283.370310] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[ 1283.377544] Control: 10c5387d  Table: 2aa78019  DAC: 00000015
[ 1283.383298] Process crm_master (pid: 10564, stack limit = 0xeabe2230)
[ 1283.389749] Stack: (0xeabe3f00 to 0xeabe4000)
[ 1283.394117] 3f00: e997a534 00000000 e997a4bc 00000000 00000000 
00000000 c002a7d8 fffffff4
[ 1283.402311] 3f20: eabe2000 01200011 00020200 00000000 00000000 
00000000 eabe2000 00000000
[ 1283.410506] 3f40: eabe3f8c eabe3f50 c001e914 c001da00 eabe3efc 
00000000 beffbfe0 c015854c
[ 1283.418701] 3f60: eabe3fa4 eabe3f70 c002ca10 b6fd8068 beffbfa8 
429e8000 00000078 c000e6a8
[ 1283.426895] 3f80: eabe3fa4 eabe3f90 c001ebf8 c001e884 b6fd8068 
c000e6a8 00000000 eabe3fa8
[ 1283.435090] 3fa0: c000e500 c001ebe0 b6fd8068 beffbfa8 01200011 
00000000 00000000 00000000
[ 1283.443285] 3fc0: b6fd8068 beffbfa8 429e8000 00000078 000d6d64 
b6fd8000 000d5e7c beffbfd4
[ 1283.451479] 3fe0: b6fd84c0 beffbfa8 00000000 42942aec 60000010 
01200011 00000000 00000000
[ 1283.459668] Backtrace:
[ 1283.462136] [<c001d9f4>] (copy_process.part.66+0x0/0xdd0) from 
[<c001e914>] (do_fork+0x9c/0x2c4)
[ 1283.470941] [<c001e878>] (do_fork+0x0/0x2c4) from [<c001ebf8>] 
(SyS_clone+0x24/0x2c)
[ 1283.478695]  r8:c000e6a8 r7:00000078 r6:429e8000 r5:beffbfa8 r4:b6fd8068
[ 1283.485471] [<c001ebd4>] (SyS_clone+0x0/0x2c) from [<c000e500>] 
(ret_fast_syscall+0x0/0x30)
[ 1283.493838] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
[ 1283.499943] ---[ end trace 94014f1f108fb76b ]---
[ 1283.493838] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
All code
========
    0:   e5933138        ldr     r3, [r3, #312]  ; 0x138
    4:   e5893138        str     r3, [r9, #312]  ; 0x138
    8:   e59c3004        ldr     r3, [ip, #4]
    c:   e08c3203        add     r3, ip, r3, lsl #4
   10:*  e593201c        ldr     r2, [r3, #28]           <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   e593201c        ldr     r2, [r3, #28]


[ 1283.833676] Unable to handle kernel paging request at virtual address 
8532a258
[ 1283.840919] pgd = e9d54000
[ 1283.843630] [8532a258] *pgd=00000000
[ 1283.847226] Internal error: Oops: 15 [#3] ARM
[ 1283.851590] Modules linked in: nfsv3 nfs_acl auth_rpcgss oid_registry 
nfsv4 dns_resolver nfs lockd sunrpc sha1_generic drbd lru_cache dlm sctp 
configfs raid1 md_mod iscsi_tcp libiscsi_tcp libiscsi 
scsi_transport_iscsi ipt_MASQUERADE iptable_nat nf_nat_ipv4 nf_nat 
iptable_mangle ipt_REJECT xt_conntrack ebtable_filter ebtables 
iptable_filter ip_tables ext3 jbd ftdi_sio usbserial autofs4 ext4 jbd2 
mbcache sd_mod usb_storage mmc_block mvsdio xhci_hcd mmc_core ehci_orion
[ 1283.893433] CPU: 0 PID: 10565 Comm: crm_master Tainted: G D      
3.11.0-stock4-dirty #34
[ 1283.901972] task: ef2ecac0 ti: e754c000 task.ti: e754c000
[ 1283.907388] PC is at copy_process.part.66+0x9ac/0xdd0
[ 1283.912453] LR is@recalc_sigpending+0x20/0x70
[ 1283.917079] pc : [<c001e3a0>]    lr : [<c0029bf0>] psr: 20000093
[ 1283.917079] sp : e754df00  ip : e754defc  fp : e754df4c
[ 1283.928575] r10: b6fdd068  r9 : e9dddac0  r8 : c040594c
[ 1283.933809] r7 : e9dddbfc  r6 : c041df00  r5 : e754c000  r4 : 01200011
[ 1283.940346] r3 : 8532a23c  r2 : ef039b80  r1 : ef2ecac0  r0 : 00000000
[ 1283.946885] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM 
Segment user
[ 1283.954119] Control: 10c5387d  Table: 29d54019  DAC: 00000015
[ 1283.959874] Process crm_master (pid: 10565, stack limit = 0xe754c230)
[ 1283.966324] Stack: (0xe754df00 to 0xe754e000)
[ 1283.970692] df00: e9dddc34 00000000 e9dddbbc 00000000 00000000 
00000000 e754c038 fffffff4
[ 1283.978886] df20: 0000000a 01200011 00020200 00000000 00000000 
00000000 e754c000 00000000
[ 1283.987080] df40: e754df8c e754df50 c001e914 c001da00 e754defc 
00000000 e754c000 00000000
[ 1283.995274] df60: e754dfb0 00000000 e754c000 b6fdd068 bea471b8 
429e8000 00000078 c000e6a8
[ 1284.003469] df80: e754dfa4 e754df90 c001ebf8 c001e884 b6fdd068 
60000010 00000000 e754dfa8
[ 1284.011663] dfa0: c000e500 c001ebe0 b6fdd068 bea471b8 01200011 
00000000 00000000 00000000
[ 1284.019857] dfc0: b6fdd068 bea471b8 429e8000 00000078 000d6d64 
b6fdd000 00000000 bea471e4
[ 1284.028051] dfe0: b6fdd4c0 bea471b8 00000000 42942aec 60000010 
01200011 00000000 00000000
[ 1284.036238] Backtrace:
[ 1284.038706] [<c001d9f4>] (copy_process.part.66+0x0/0xdd0) from 
[<c001e914>] (do_fork+0x9c/0x2c4)
[ 1284.047509] [<c001e878>] (do_fork+0x0/0x2c4) from [<c001ebf8>] 
(SyS_clone+0x24/0x2c)
[ 1284.055263]  r8:c000e6a8 r7:00000078 r6:429e8000 r5:bea471b8 r4:b6fdd068
[ 1284.062039] [<c001ebd4>] (SyS_clone+0x0/0x2c) from [<c000e500>] 
(ret_fast_syscall+0x0/0x30)
[ 1284.070406] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
[ 1284.076511] ---[ end trace 94014f1f108fb76c ]---
[ 1284.070406] Code: e5933138 e5893138 e59c3004 e08c3203 (e593201c)
All code
========
    0:   e5933138        ldr     r3, [r3, #312]  ; 0x138
    4:   e5893138        str     r3, [r9, #312]  ; 0x138
    8:   e59c3004        ldr     r3, [ip, #4]
    c:   e08c3203        add     r3, ip, r3, lsl #4
   10:*  e593201c        ldr     r2, [r3, #28]           <-- trapping 
instruction

Code starting with the faulting instruction
===========================================
    0:   e593201c        ldr     r2, [r3, #28]


Reverted back to previous kernel for now; we'll see if it stabilizes again.
Haven't tried updating the other box yet; that's still@3.11-rc7 and 5 
days
uptime without oopses.

J.
