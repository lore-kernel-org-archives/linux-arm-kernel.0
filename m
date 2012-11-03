From: josh.coombs@gmail.com (Josh Coombs)
Date: Fri, 2 Nov 2012 23:50:00 -0400
Subject: Possible regression in 3.7-rc3 on Marvell Kirkwood
Message-ID: <CAMW5UfaUvgO5NKj1vg9=4tNY4uo3aKh6FNO2Ok861QS8NKwNkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm still trying to nail down the exact cause, but I seem to have
stumbled onto a regression with 3.7-rc3 on my GoFlex Net compared to
3.7-rc2 using the same config.

On rc3 I get a bunch of scheduler bugs, mostly in the swapper, then a
panic.  The panic isn't consistent in the triggering process.  I've
included an example of the crash at the bottom of this email.  Loading
the GFN (doing a git clone of v3.7-rc3 for example) speeds up the
inevitable failure.

I haven't started the process of doing bisects to see which commit is
responsible yet, I want to test with a default config kernel first
which will require a different rootfs than I'm currently using.

I'm open to suggestions on how to debug this further.  I'd also be
curious to know if anyone else is seeing similar on their devices.

Joshua Coombs

[   64.312377] BUG: scheduling while atomic: crond/151/0x40000300
[   79.771862] BUG: scheduling while atomic: swapper/0/0x40000500
[   81.826267] BUG: scheduling while atomic: swapper/0/0x40000500
[   90.330911] BUG: scheduling while atomic: swapper/0/0x40000500
[  105.554243] BUG: scheduling while atomic: swapper/0/0x40000500
[  123.199184] BUG: scheduling while atomic: ksoftirqd/0/3/0x40000500
[  138.204989] BUG: scheduling while atomic: swapper/0/0x40000500
[  174.995737] BUG: scheduling while atomic: swapper/0/0x40000500
[  195.378153] BUG: scheduling while atomic: swapper/0/0x40000500
[  211.334239] BUG: scheduling while atomic: swapper/0/0x40000500
[  212.384170] BUG: scheduling while atomic: swapper/0/0x40000500
[  216.563944] BUG: scheduling while atomic: swapper/0/0x40000500
[  216.884007] BUG: scheduling while atomic: git/614/0x40000500
[  217.153998] BUG: scheduling while atomic: git/614/0x40000500
[  218.853983] BUG: scheduling while atomic: kswapd0/19/0x40000500
[  218.893905] BUG: scheduling while atomic: systemd-journal/68/0x40000500
[  218.935826] BUG: scheduling while atomic: systemd-journal/68/0x40000100
[  221.603951] BUG: scheduling while atomic: kswapd0/19/0x40000500
[  221.653299] BUG: scheduling while atomic: kswapd0/19/0x40000100
[  221.661248] BUG: scheduling while atomic: kswapd0/19/0x40000100
[  221.753701] BUG: scheduling while atomic: git/614/0x40000500
[  225.733440] BUG: scheduling while atomic: git/613/0x40000600
[  225.823719] BUG: scheduling while atomic: kswapd0/19/0x40000500
[  228.563311] BUG: scheduling while atomic: git/614/0x40000500
[  230.023481] BUG: scheduling while atomic: git/613/0x40000500
[  230.856815] BUG: scheduling while atomic: git/613/0x40000600
[  231.833160] BUG: scheduling while atomic: flush-8:0/58/0x40000500
[  231.933192] BUG: scheduling while atomic: kswapd0/19/0x40000500
[  232.003387] BUG: scheduling while atomic: swapper/0/0x40000500
[  240.910363] BUG: scheduling while atomic: git/614/0x40000500
[  241.393191] BUG: scheduling while atomic: git/614/0x40000500
[  241.522874] BUG: scheduling while atomic: git/614/0x40000500
[  243.842504] BUG: scheduling while atomic: swapper/0/0x40000500
[  243.849303] BUG: scheduling while atomic: swapper/0/0x40000500
[  246.832000] BUG: scheduling while atomic: ls/619/0x40000500
[  246.845717] Unable to handle kernel NULL pointer dereference at
virtual address 00000038
[  246.853900] pgd = c71f8000
[  246.856630] [00000038] *pgd=070e4831, *pte=00000000, *ppte=00000000
[  246.862976] Internal error: Oops: 17 [#1] ARM
[  246.867356] Modules linked in: rmd160 hmac blowfish_generic
blowfish_common sr_mod cdrom fbcon bitblit softcursor font udlfb
syscopyarea sysfillrect sysimgblt fb_sys_fops fb hid_generic
snd_usb_audio snd_usbmidi_lib snd_hwdep snd_rawmidi snd_seq_device
snd_pcm snd_page_alloc mct_u232 usbserial usbhid hid snd_timer snd
soundcore orion_wdt mv_cesa cryptodev(O) ipv6 autofs4
[  246.900659] CPU: 0    Tainted: G        W  O  (3.7.0-0-ARCH+ #1)
[  246.906706] PC is at tcp_fastretrans_alert+0x5b0/0xa30
[  246.911874] LR is at tcp_ack+0xbec/0xdf0
[  246.915816] pc : [<c03abe00>]    lr : [<c03acf14>]    psr: 60000013
[  246.915816] sp : c7139b68  ip : 20000013  fp : 00000001
[  246.927350] r10: 00000000  r9 : 00000000  r8 : 00000000
[  246.932599] r7 : 00000001  r6 : 00000000  r5 : 00000000  r4 : c26f0500
[  246.939157] r3 : 00000000  r2 : c05c2720  r1 : 00000003  r0 : c26f0500
[  246.945715] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  246.952882] Control: 0005397f  Table: 071f8000  DAC: 00000015
[  246.958656] Process systemd-journal (pid: 68, stack limit = 0xc71381b8)
[  246.965300] Stack: (0xc7139b68 to 0xc713a000)
2012 Nov  2 17:56:08 alarm [  246.862976] Internal error: Oops: 17 [#1] ARM
201[  246.983204] 9b60:                   00000001 c26f0500 00000001
00000000 00000000 00000000
2 Nov  2 17:56:0[  246.992194] 9b80: 0fa01da8 00000001 00000000
c03acf14 00000000 00000083 c705b200 00000000
8 alarm [  246.9[  247.003023] 9ba0: c7b2d000 c7139c08 00000001
00000001 00000000 00000083 00000000 00000000
58656] Process s[  247.011437] 9bc0: 00000000 00000001 00000000
00000000 00000000 ffffe652 00000000 c26f0590
ystemd-journal ([  247.022250] 9be0: c001223c 00000200 0000238c
00000200 00000020 c26f0500 c70edd80 00000020
pid: 68, stack l[  247.030726] 9c00: c6dbc078 00000020 c05e8440
c05b9aec c05b9038 c03ad5e4 c26f0500 c70edd80
imit = 0xc71381b[  247.041492] 9c20: c6dbc078 c70edd80 c26f0500
c70ec380 c05e8440 c6dbc064 c05b9aec c03b4d24
8)
2012 Nov  2 [  247.050670] 9c40: c7139c8c c7b2d0f8 c0012478 c07a0100
00000002 c000f220 c70edd80 c26f0500
17:56:08 alarm [[  247.060303] 9c60: 00000000 c05e8440 c6dbc064
c03b75a4 00000000 c03438b4 c0343720 00000000
  246.965300] St[  247.069941] 9c80: c05e8440 c78ef4a0 c70edd80
c05e8440 c043dcc0 00000006 00000000 c70edd80
ack: (0xc7139b68[  247.079584] 9ca0: c05e8440 c05b9aec c05b9038
c03977f4 c6dbc064 c05b9014 c70edd80 00400100
[  247.089215] 9cc0: c7000000 00000008 00000000 c0397620 c70edd80
ffffffd4 c05ba058 c05b9014

2012 Nov  2 17:[  247.098848] 9ce0: c70edd80 c036d4ac c70353e0
c03523f0 c7000460 c70edd80 c7b9ea80 c05b9038
56:08 alarm [  2[  247.108482] 9d00: c7000460 c05ed9a0 00000000
00000001 c05ed960 c05ed974 ffffe654 00000000
46.983204] 9b60:[  247.118120] 9d20: c05c2720 c036d624 c036d5a8
c05ed9a0 c05ed960 00000000 0000012c 00000040
                [  247.127756] 9d40: c05ed968 c036f784 c067412c
ffffe654 c067412c 00000001 0000000c c7138000
   00000001 c26f[  247.137390] 9d60: 00000003 00000100 c0674100
00000009 c0674120 c001eeb0 c05c6918 c7b1f600
0500 00000001 00[  247.147026] 9d80: 00013757 c05c6918 00000000
00400100 c7139e04 00000013 00000000 fed20200
000000 00000000 [  247.156664] 9da0: c7139e04 c3180508 c71fad20
051d4187 c70ee7b4 c001f2cc 00002000 c00095ec
00000000
2012 N[  247.166356] 9dc0: c00a3b6c c0012024 00000013 c03fce54
b4942660 b4943000 000000ff 00001000
ov  2 17:56:08 a[  247.175984] 9de0: c0763a80 c70e5580 b4942000
00000001 c3180508 c71fad20 051d4187 c70ee7b4
larm [  246.9921[  247.185607] 9e00: 00000a7d c7139e18 c00a3b6c
c0012024 00000013 ffffffff 000001b4 00000028
94] 9b80: 0fa01d[  247.195248] 9e20: 00000000 c05c3284 00000005
000001b4 b4942000 c0763a80 c70edd80 b4942000
a8 00000001 0000[  247.204883] 9e40: 000005a4 c71f8000 c71fad20
c70ee780 00000029 c70e5580 c70ee7b4 c00a5a3c
0000 c03acf14 00[  247.214521] 9e60: c71fad20 051d4187 c7139fb0
c70e5580 b49428b0 c71b2a20 c70ee780 00000029
000000 00000083 [  247.224207] 9e80: 0000081f c03fe420 c05b9038
c03977f4 c6dbbec4 c05b9014 00000800 00000000
c705b200 0000000[  247.233809] 9ea0: c7000000 00000008 00000000
c0397620 c70edd80 ffffffd4 c05ba058 c05b9014
0
2012 Nov  2 1[  247.243433] 9ec0: c70edd80 c036d4ac c7035358 c03523f0
c7000460 c70edd80 c70edcc0 c05b9038
7:56:08 alarm [ [  247.253071] 9ee0: c7000460 c05ed9a0 00000000
0000081f c05bc750 b49428b0 c7139fb0 0003ed10
 247.003023] 9ba[  247.262004] 9f00: bed5f2cc 001b47f0 00000000
c0008418 c05ed960 00000000 0000012c 00000040
0: c7b2d000 c713[  247.272222] ------------[ cut here ]------------
9c08 00000001 00[  247.277675] WARNING: at net/ipv4/tcp_timer.c:361
tcp_retransmit_timer+0x110/0x6d0()
000001 00000000 [  247.286773] Modules linked in:00000083 0000000
rmd1600 00000000
2012 hmac Nov  2 17:56:08 blowfish_generic alarm [  247.01
blowfish_common1437] 9bc0: 0000 sr_mod0000 00000001 00 cdrom000000
00000000  fbcon00000000 ffffe65 bitblit2 00000000 c26f0 softcursor590
2012 Nov  2 font 17:56:08 alarm  udlfb[  247.022250] 9 syscopyareabe0:
c001223c 00 sysfillrect000200 0000238c  sysimgblt00000200 0000002
fb_sys_fops0 c26f0500 c70ed fbd80 00000020
20 hid_generic12 Nov  2 17:56: snd_usb_audio08 alarm [  247.
snd_usbmidi_lib030726] 9c00: c6 snd_hwdepdbc078 00000020
snd_rawmidic05e8440 c05b9ae snd_seq_devicec c05b9038 c03ad snd_pcm5e4
c26f0500 c70 snd_page_allocedd80
2012 Nov  mct_u232 2 17:56:08 alar usbserialm [  247.041492] usbhid
9c20: c6dbc078  hidc70edd80 c26f050 snd_timer0 c70ec380 c05e8 snd440
c6dbc064 c05 soundcoreb9aec c03b4d24
 orion_wdt2012 Nov  2 17:5 mv_cesa6:08 alarm [  24
cryptodev(O)7.050670] 9c40:  ipv6c7139c8c c7b2d0f autofs48 c0012478
c07a0
100 00000002 c00[  247.373215] [<c000d634>]
(unwind_backtrace+0x0/0xe0) from [<c0017d90>]
(warn_slowpath_common+0x4c/0x64)
0f220 c70edd80 c[  247.384042] [<c0017d90>]
(warn_slowpath_common+0x4c/0x64) from [<c0017dc0>]
(warn_slowpath_null+0x18/0x1c)
26f0500
2012 No[  247.395146] [<c0017dc0>] (warn_slowpath_null+0x18/0x1c) from
[<c03b34d4>] (tcp_retransmit_timer+0x110/0x6d0)
v  2 17:56:08 al[  247.406422] [<c03b34d4>]
(tcp_retransmit_timer+0x110/0x6d0) from [<c03b3af8>]
(tcp_write_timer_handler+0x64/0x168)
arm [  247.06030[  247.418215] [<c03b3af8>]
(tcp_write_timer_handler+0x64/0x168) from [<c03b3c14>]
(tcp_write_timer+0x18/0x90)
3] 9c60: 0000000[  247.429417] [<c03b3c14>]
(tcp_write_timer+0x18/0x90) from [<c0023de4>]
(call_timer_fn+0x2c/0x120)
0 c05e8440 c6dbc[  247.439725] [<c0023de4>] (call_timer_fn+0x2c/0x120)
from [<c00251ac>] (run_timer_softirq+0x1d4/0x244)
064 c03b75a4 000[  247.450386] [<c00251ac>]
(run_timer_softirq+0x1d4/0x244) from [<c001eeb0>]
(__do_softirq+0xa0/0x1fc)
00000 c03438b4 c[  247.460964] [<c001eeb0>] (__do_softirq+0xa0/0x1fc)
from [<c001f2cc>] (irq_exit+0x40/0x8c)
0343720 00000000[  247.470581] [<c001f2cc>] (irq_exit+0x40/0x8c) from
[<c00095ec>] (handle_IRQ+0x64/0x84)

2012 Nov  2 17[  247.479937] [<c00095ec>] (handle_IRQ+0x64/0x84) from
[<c03fce54>] (__irq_svc+0x34/0x78)
:56:08 alarm [  [  247.489390] [<c03fce54>] (__irq_svc+0x34/0x78) from
[<c0045884>] (current_kernel_time+0xc/0x50)
247.069941] 9c80[  247.499532] [<c0045884>]
(current_kernel_time+0xc/0x50) from [<c001dfb8>]
(current_fs_time+0x14/0x30)
: c05e8440 c78ef[  247.510192] [<c001dfb8>]
(current_fs_time+0x14/0x30) from [<c00d04f8>] (touch_atime+0x7c/0x178)
4a0 c70edd80 c05[  247.520337] [<c00d04f8>] (touch_atime+0x7c/0x178)
from [<c00c5de8>] (link_path_walk+0x3a4/0x794)
e8440 c043dcc0 0[  247.530562] [<c00c5de8>]
(link_path_walk+0x3a4/0x794) from [<c00c6aa8>]
(path_lookupat+0x54/0x720)
0000006 00000000[  247.540963] [<c00c6aa8>] (path_lookupat+0x54/0x720)
from [<c00c7194>] (filename_lookup+0x20/0x60)
 c70edd80
2012 [  247.551279] [<c00c7194>] (filename_lookup+0x20/0x60) from
[<c00c8fe4>] (user_path_at_empty+0x54/0x80)
Nov  2 17:56:08 [  247.561944] [<c00c8fe4>]
(user_path_at_empty+0x54/0x80) from [<c00c9020>]
(user_path_at+0x10/0x14)
alarm [  247.079[  247.572354] [<c00c9020>] (user_path_at+0x10/0x14)
from [<c00bbde8>] (sys_faccessat+0x98/0x184)
584] 9ca0: c05e8[  247.582400] [<c00bbde8>] (sys_faccessat+0x98/0x184)
from [<c0008d20>] (ret_fast_syscall+0x0/0x2c)
440 c05b9aec c05[  247.592706] ---[ end trace 121b1f97ee5f2bac ]---
b9038 c03977f4 c[  247.598752] Unable to handle kernel NULL pointer
dereference at virtual address 0000003d
6dbc064 c05b9014[  247.608276] pgd = c26d8000
 c70edd80 004001[  247.612400] [0000003d] *pgd=026ad83100
2012 Nov  2 , *pte=0000000017:56:08 alarm [, *ppte=00000000  247.089215] 9c
c0: c7000000 000[  247.624313] Internal error: Oops: 17 [#2] ARM
[  247.630068] Modules linked in: rmd160 hmac blowfish_generic
blowfish_common sr_mod cdrom fbcon bitblit softcursor font udlfb
syscopyarea sysfillrect sysimgblt fb_sys_fops fb hid_generic
snd_usb_audio snd_usbmidi_lib snd_hwdep snd_rawmidi snd_seq_device
snd_pcm snd_page_alloc mct_u232 usbserial usbhid hid snd_timer snd
soundcore orion_wdt mv_cesa cryptodev(O) ipv6 autofs4
[  247.663399] CPU: 0    Tainted: G        W  O  (3.7.0-0-ARCH+ #1)
[  247.669441] PC is at tcp_enter_frto+0x100/0x224
[  247.673994] LR is at tcp_enter_frto+0xc0/0x224
[  247.678460] pc : [<c03ab4b4>]    lr : [<c03ab474>]    psr: 60000013
[  247.678460] sp : c26c5ce0  ip : 40000013  fp : c05c2720
[  247.689992] r10: c05ef7f8  r9 : 00200200  r8 : c26f0500
[  247.695242] r7 : c03b3bfc  r6 : c26f0734  r5 : 0000000f  r4 : c26f0500
[  247.701800] r3 : 00000000  r2 : c26f0590  r1 : 00000000  r0 : 00000006
[  247.708358] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[  247.715526] Control: 0005397f  Table: 026d8000  DAC: 00000015
[  247.721298] Process syslog-ng (pid: 153, stack limit = 0xc26c41b8)
[  247.727506] Stack: (0xc26c5ce0 to 0xc26c6000)
00008 00000000 c[  247.732113] 9f20: c05ed968 c036f784 c067412c
ffffe654 c067412c 00000001 0000000c c7138000
0397620 c70edd80[  247.741628] 9f40: 00000003 00000100 60000093
00000000 00000010 c001ef8c c05c6918 c7b1f600
 ffffffd4 c05ba0[  247.751298] 5ce0: 00000003 c26f0500 0000000f
c03b38a4 c26f0500 00000000 c26f0500 00000100
58 c05b9014
201[  247.760873] 9f60: 00013756 c05c6918 00000000 00400100 00000000
00000013 00000000 fed20200
2 Nov  2 17:56:0[  247.770498] 5d00: c26f0734 c03b3af8 00000000
c26f0500 00000100 c03b3c14 c0674280 c0023de4
8 alarm [  247.0[  247.780117] 9f80: 00000000 00000006 00002000
00000013 00000000 fed20200 00000000 0001f310
98848] 9ce0: c70[  247.789743] 5d20: c26f0734 c03b3bfc c0674280
c26f0734 c26c5d50 c26f0500 c03b3bfc c00251ac
edd80 c036d4ac c[  247.799359] 9fa0: 00000010 ffffffff 00000000
c03fcfdc 00201050 00000000 00000022 00000000
70353e0 c03523f0[  247.808981] 5d40: a49d4202 00000036 ffffe67d
00000000 c26c5d50 c26c5d50 00000001 00000005
 c7000460 c70edd[  247.818605] 9fc0: b4942898 00000000 b49427f0
00000000 0003ed10 bed5f2cc 001b47f0 00000000
80 c7b9ea80 c05b[  247.828223] 5d60: 00000004 c26c4000 00000001
00000100 c0674100 0000000a c0674120 c001eeb0
9038
2012 Nov  [  247.837846] 9fe0: 000000e8 bed5f2b0 0001f198 0001f310
00000010 ffffffff 00000000 00000000
2 17:56:08 alarm[  247.847467] [<c03abe00>]
(tcp_fastretrans_alert+0x5b0/0xa30) from [<c03acf14>]
(tcp_ack+0xbec/0xdf0)
 [  247.108482] [  247.858048] [<c03acf14>] (tcp_ack+0xbec/0xdf0) from
[<c03ad5e4>] (tcp_rcv_established+0x108/0x5e0)
9d00: c7000460 c[  247.868452] [<c03ad5e4>]
(tcp_rcv_established+0x108/0x5e0) from [<c03b4d24>]
(tcp_v4_do_rcv+0x7c/0x234)
05ed9a0 00000000[  247.879288] [<c03b4d24>] (tcp_v4_do_rcv+0x7c/0x234)
from [<c03b75a4>] (tcp_v4_rcv+0x854/0x8c8)
 00000001 c05ed9[  247.889342] [<c03b75a4>] (tcp_v4_rcv+0x854/0x8c8)
from [<c03977f4>] (ip_local_deliver_finish+0x18c/0x294)
60 c05ed974 ffff[  247.900356] [<c03977f4>]
(ip_local_deliver_finish+0x18c/0x294) from [<c0397620>]
(ip_rcv_finish+0x2e4/0x32c)
e654 00000000
2[  247.911636] [<c0397620>] (ip_rcv_finish+0x2e4/0x32c) from
[<c036d4ac>] (__netif_receive_skb+0x6dc/0x7d8)
012 Nov  2 17:56[  247.922560] [<c036d4ac>]
(__netif_receive_skb+0x6dc/0x7d8) from [<c036d624>]
(process_backlog+0x7c/0x140)
:08 alarm [  247[  247.933574] [<c036d624>]
(process_backlog+0x7c/0x140) from [<c036f784>]
(net_rx_action+0x8c/0x224)
.118120] 9d20: c[  247.943987] [<c036f784>] (net_rx_action+0x8c/0x224)
from [<c001eeb0>] (__do_softirq+0xa0/0x1fc)
05c2720 c036d624[  247.954126] [<c001eeb0>] (__do_softirq+0xa0/0x1fc)
from [<c001f2cc>] (irq_exit+0x40/0x8c)
 c036d5a8 c05ed9[  247.963743] [<c001f2cc>] (irq_exit+0x40/0x8c) from
[<c00095ec>] (handle_IRQ+0x64/0x84)
a0 c05ed960 0000[  247.973099] [<c00095ec>] (handle_IRQ+0x64/0x84)
from [<c03fce54>] (__irq_svc+0x34/0x78)
0000 0000012c 00[  247.982543] [<c03fce54>] (__irq_svc+0x34/0x78) from
[<c0012024>] (feroceon_flush_user_cache_range+0x24/0x40)
000040
2012 Nov[  247.993826] [<c0012024>]
(feroceon_flush_user_cache_range+0x24/0x40) from [<000001b4>] (0x1b4)
  2 17:56:08 ala[  248.003887] 5d80: c05c6138 c05bdde0 000137c5
c05c6138 c7139dd0 00400100 c26c5e0c 00000001
rm [  247.127756[  248.013496] 5da0: c7139dd0 fed20200 c26c5e0c
c141bcc0 c26c4000 c71d7018 50944178 c001f2cc
] 9d40: c05ed968[  248.023113] 5dc0: 00002000 c00095ec c001dfb8
c0045884 40000013 c03fce54 c26c5e30 c705b200
 c036f784 c06741[  248.032726] 5de0: 70018000 c0676b80 c76e07d0
c26c5e48 c26c5e30 c26c4000 c141bcc0 c26c4000
2c ffffe654 c067[  248.042344] 5e00: c71d7018 50944178 c76144c8
c26c5e20 c001dfb8 c0045884 40000013 ffffffff
412c 00000001 00[  248.051956] 5e20: c76e07d0 c26c5e48 c705b200
c001dfb8 c26c5e48 c705b200 c76e07d0 c780abf0
[  248.061571] 5e40: c71d7019 c00d04f8 c26c5f08 0028f3c6 c26c5f08
c00c477c 00000051 c26c5f08

2012 Nov  2 17:[  248.071189] 5e60: 00000001 c00c5de8 00000000
c76e07d0 c780abf0 c141bcc0 c780abf0 c141bcc0
56:08 alarm [  2[  248.080807] 5e80: 0028f3c6 00000003 c71d7015
c71d7010 00000051 c26c5f08 00000000 00000041
47.137390] 9d60:[  248.090424] 5ea0: c71d7010 c712d180 00000000
c00c6aa8 c26c5eb8 00000000 00000000 c0244834
 00000003 000001[  248.100047] 5ec0: 00000000 c71d7000 00000001
00000ff0 00000001 c71d7000 c26c5f08 ffffff9c
00 c0674100 0000[  248.109662] 5ee0: c712d180 c26c4000 00000000
c00c7194 c71d7000 00000001 c26c5f88 ffffff9c
0009 c0674120 c0[  248.119280] 5f00: c712d180 c00c8fe4 c780abf0
c76144c8 c26c5f24 c003b4a8 00000000 00000000
01eeb0 c05c6918 [  248.128899] 5f20: c780abf0 c74e1a18 c76a87d0
00000011 00000002 00000001 00000001 c73008c8
c7b1f600
2012 N[  248.138517] 5f40: 00000002 c74c8780 50944178 c00b9694
c7802300 000000d0 c26c5f78 c3c1d440
ov  2 17:56:08 a[  248.148134] 5f60: c712d180 c6de7980 b6c96c0c
00000000 ffffff9c c00c9020 00000000 b6c96c0c
larm [  247.1470[  248.157757] 5f80: 00000001 c00bbde8 ffffff9c
b6c96c0c b6c96c0c b6ca7950 00049030 00000021
26] 9d80: 000137[  248.167379] Code: e5b23090 e1530002 e59f245c
03a03000 (e5933038)
57 c05c6918 0000[  248.174899] ---[ end trace 121b1f97ee5f2bad ]---
0000 00400100 c7[  248.180926] Kernel panic - not syncing: Fatal
exception in interrupt
139e04 00000013 00000000 fed20200
2012 Nov  2 17:56:08 alarm [  247.156664] 9da0: c7139e04 c3180508
c71fad20 051d4187 c70ee7b4 c001f2cc 00002000 c00095ec
2012 Nov  2 17:56:08 alarm [  247.166356] 9dc0: c00a3b6c c0012024
00000013 c03fce54 b4942660 b4943000 000000ff 00001000
2012 Nov  2 17:56:08 alarm [  247.175984] 9de0: c0763a80 c70e5580
b4942000 00000001 c3180508 c71fad20 051d4187 c70ee7b4
2012 Nov  2 17:56:08 alarm [  247.185607] 9e00: 00000a7d c7139e18
c00a3b6c c0012024 00000013 ffffffff 000001b4 00000028
2012 Nov  2 17:56:08 alarm [  247.195248] 9e20: 00000000 c05c3284
00000005 000001b4 b4942000 c0763a80 c70edd80 b4942000
2012 Nov  2 17:56:08 alarm [  247.204883] 9e40: 000005a4 c71f8000
c71fad20 c70ee780 00000029 c70e5580 c70ee7b4 c00a5a3c
2012 Nov  2 17:56:08 alarm [  247.214521] 9e60: c71fad20 051d4187
c7139fb0 c70e5580 b49428b0 c71b2a20 c70ee780 00000029
2012 Nov  2 17:56:08 alarm [  247.224207] 9e80: 0000081f c03fe420
c05b9038 c03977f4 c6dbbec4 c05b9014 00000800 00000000
2012 Nov  2 17:56:08 alarm [  247.233809] 9ea0: c7000000 00000008
00000000 c0397620 c70edd80 ffffffd4 c05ba058 c05b9014
2012 Nov  2 17:56:08 alarm [  247.243433] 9ec0: c70edd80 c036d4ac
c7035358 c03523f0 c7000460 c70edd80 c70edcc0 c05b9038
2012 Nov  2 17:56:08 alarm [  247.253071] 9ee0: c7000460 c05ed9a0
00000000 0000081f c05bc750 b49428b0 c7139fb0 0003ed10
