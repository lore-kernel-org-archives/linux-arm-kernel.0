From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Dec 2011 20:33:32 +0100
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <20111218190102.GW14542@n2100.arm.linux.org.uk>
References: <201112172023.05519.heiko@sntech.de>
 <201112181950.38993.heiko@sntech.de>
 <20111218190102.GW14542@n2100.arm.linux.org.uk>
Message-ID: <201112182033.33640.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 18 Dezember 2011, 20:01:02 schrieben Sie:
> On Sun, Dec 18, 2011 at 07:50:37PM +0100, Heiko St?bner wrote:
> > I didn't get this far. With your patch the Oopses already happen during
> > the startup of the system / the loading of the modules.
> 
> > A bit of the message spew I got during testing with linux-next-20111216:
> In some way, this is a good thing because it's showing that there's
> problems with kobject lifetime rules.
> 
> The #2 and further oops dumps are a result of corrupting the work
> queues as a result of #1, so #2 onwards should be ignored.
> 
> I suspect if you avoid loading the s3c_hsudc module these will go away.

nope :-), same faults happen even if s3c-hsudc is not present at all.
So it seems, this delayed cleanup poses problems for other drivers as well.



Unable to handle kernel paging request at virtual address bf055504
pgd = c0004000
[bf055504] *pgd=3703b811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1]
Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core
CPU: 0    Not tainted  (3.2.0-rc5-next-20111216+ #32)
PC is at kobject_put+0x18/0x7c
LR is at kobject_del+0x64/0x70
pc : [<c011460c>]    lr : [<c01146f4>]    psr: a0000013
sp : c70bdef0  ip : c70bdf10  fp : c70bdf0c
r10: 00000000  r9 : c0114700  r8 : c7803a00
r7 : c7043200  r6 : c02e1de0  r5 : c70e5d20  r4 : bf0554a0
r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : bf0554a0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 37994000  DAC: 00000017
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bdef0 to 0xc70be000)
dee0:                                     c70e5d00 c70e5d20 c02e1de0 c70e5d00
df00: c70bdf24 c70bdf10 c01146f4 c0114604 c01365bc c70e5d00 c70bdf4c c70bdf28
df20: c01147f0 c01146a0 c0427c38 c785fd00 c70e5d20 c785fd00 00000000 00000009
df40: c70bdf84 c70bdf50 c00318fc c0114710 c02dbf00 c7803a05 c02dbf00 c785fd00
df60: c02dbf00 c785fd00 00000009 c02dbf00 c785fd10 c70bc000 c70bdfbc c70bdf88
df80: c0032570 c00316c0 c7839edc c785fd10 c0032364 c70bdfcc c7839edc c785fd00
dfa0: c0032364 00000000 00000000 00000000 c70bdff4 c70bdfc0 c0037768 c0032374
dfc0: c7839edc 00000000 c785fd00 00000000 c70bdfd0 c70bdfd0 c7839edc c00376e0
dfe0: c0021ac0 00000013 00000000 c70bdff8 c0021ac0 c00376f0 00190021 00024ea8
Backtrace: 
[<c01145f4>] (kobject_put+0x0/0x7c) from [<c01146f4>] (kobject_del+0x64/0x70)
 r4:c70e5d00
[<c0114690>] (kobject_del+0x0/0x70) from [<c01147f0>] (kobject_delayed_cleanup+0xf0/0x198)
 r4:c70e5d00
[<c0114700>] (kobject_delayed_cleanup+0x0/0x198) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c70e5d20
[<c00316b0>] (process_one_work+0x0/0x3a8) from [<c0032570>] (worker_thread+0x20c/0x428)
[<c0032364>] (worker_thread+0x0/0x428) from [<c0037768>] (kthread+0x88/0x90)
[<c00376e0>] (kthread+0x0/0x90) from [<c0021ac0>] (do_exit+0x0/0x670)
 r7:00000013 r6:c0021ac0 r5:c00376e0 r4:c7839edc
Code: e24cb004 e24dd00c e2504000 0a000013 (e5d43064) 
---[ end trace ddf7f4f6a0de23b8 ]---
Unable to handle kernel paging request at virtual address fffffffc
pgd = c0004000
[fffffffc] *pgd=37ffe831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#2]
Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core
CPU: 0    Tainted: G      D       (3.2.0-rc5-next-20111216+ #32)
PC is at kthread_data+0x10/0x18
LR is at wq_worker_sleeping+0x18/0xbc
pc : [<c00371c4>]    lr : [<c0033974>]    psr: 20000093
sp : c70bdb58  ip : c70bdb68  fp : c70bdb64
r10: c70bc000  r9 : c70bdb90  r8 : c02dc500
r7 : c7826000  r6 : c708cb00  r5 : c708cc54  r4 : 00000000
r3 : 00000000  r2 : c02dc500  r1 : 00000000  r0 : c708cb00
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 37994000  DAC: 00000015
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bdb58 to 0xc70be000)
db40:                                                       c70bdb7c c70bdb68
db60: c0033974 c00371c4 c003f760 00000001 c70bdc04 c70bdb80 c0218ebc c003396c
db80: c0406680 c70b4a40 000005fb c001c678 00000168 00000000 c70bdbcc c70bdba8
dba0: c008cb78 c008b680 c0034390 c708cb00 c70b8440 00000001 00000000 c70b4a40
dbc0: c70bdbdc c70bdbd0 c001c678 c708cb00 c70bdc14 c70bdbe0 c0020db4 00000001
dbe0: c70bdc24 c708cb00 c7826000 c708cbd8 c708caf8 c708cbd8 c70bdc14 c70bdc08
dc00: c02194cc c0218dfc c70bdc3c c70bdc18 c0022100 c0219468 00000008 00000001
dc20: c70bdc3c c70bdc24 c70bdc24 c708cc20 c70bdcb4 c70bdc40 c001222c c0021ad0
dc40: c70bc270 0000000b 7269762f 00000000 65000000 62633432 20343030 64343265
dc60: 63303064 35326520 30303430 61302030 30303030 28203331 34643565 34363033
dc80: c0002029 c0217dd8 c027dcbb bf055504 c70bdea8 00000000 00000007 00000000
dca0: 00000007 00000000 c70bdcdc c70bdcb8 c0013808 c0011f80 00000000 c02d5ccc
dcc0: a0000013 c70bdea8 bf055504 c708cb00 c70bddf4 c70bdce0 c0013b58 c00137a8
dce0: bf017fcc bf01a0c8 00000000 00000000 c70bddc4 c70bdd00 bf01958c 00000028
dd00: c70bdd88 00000004 00000001 c708dbb0 00000000 00000004 00000002 c798e280
dd20: c708cb30 00000000 c708dbb0 00000000 c70bdd6c c70bdd40 c0040e34 c0040b20
dd40: c003f79c c021bf08 c70bc000 00000000 005b8d80 00000000 c708cb30 c70bdee4
dd60: c70bdd94 c70bdd70 c0040818 c00406b4 c02dc500 c708cb30 c02dfe08 c02dfd74
dd80: c70bc000 c708cb30 c70bddb4 c70bdd8c c70bdd8c c708cb00 c70bdee4 c02ddbb0
dda0: c031e888 c70bc000 00000000 c708cb00 c70bdee4 c02ddbb0 c031e888 00000000
ddc0: c70bddec c70bddd0 c00290cc c02d5ccc a0000013 00000007 c70bdea8 bf055504
dde0: c0114700 00000000 c70bdea4 c70bddf8 c0008634 c0013838 c02ddbb0 c70bde08
de00: c031122c 8033002f c70bde08 c70bde08 c003fb2c 00000001 00000100 c78059c0
de20: c0417760 c793beb0 00001056 c00dda98 c0114700 00000000 c70bde6c c70bde48
de40: c008cb78 c008b680 c70bde74 c793beb0 c793be60 c031fba0 c70bde98 c70bdec8
de60: c70bde8c c70bde70 c00dda98 c008cabc c793beb0 c793beb0 00020001 c70bde94
de80: c70bdec4 c011460c a0000013 ffffffff c70bdedc c7803a00 c70bdf0c c70bdea8
dea0: c000e458 c0008608 bf0554a0 00000000 00000000 00000001 bf0554a0 c70e5d20
dec0: c02e1de0 c7043200 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff c70e5d00 c70e5d20 c02e1de0 c70e5d00
df00: c70bdf24 c70bdf10 c01146f4 c0114604 c01365bc c70e5d00 c70bdf4c c70bdf28
df20: c01147f0 c01146a0 c0427c38 c785fd00 c70e5d20 c785fd00 00000000 00000009
df40: c70bdf84 c70bdf50 c00318fc c0114710 c02dbf00 c7803a05 c02dbf00 c785fd00
df60: c02dbf00 c785fd00 00000009 c02dbf00 c785fd10 c70bc000 c70bdfbc c70bdf88
df80: c0032570 c00316c0 c7839edc c785fd10 c0032364 c70bdfcc c7839edc c785fd00
dfa0: c0032364 00000000 00000000 00000000 c70bdff4 c70bdfc0 c0037768 c0032374
dfc0: c7839edc 00000000 c785fd00 00000001 c70bdfd0 c70bdfd0 c7839edc c00376e0
dfe0: c0021ac0 00000013 00000000 c70bdff8 c0021ac0 c00376f0 00190021 00024ea8
Backtrace: 
[<c00371b4>] (kthread_data+0x0/0x18) from [<c0033974>] (wq_worker_sleeping+0x18/0xbc)
[<c003395c>] (wq_worker_sleeping+0x0/0xbc) from [<c0218ebc>] (__schedule+0xd0/0x37c)
 r4:00000001
[<c0218dec>] (__schedule+0x0/0x37c) from [<c02194cc>] (schedule+0x74/0x78)
[<c0219458>] (schedule+0x0/0x78) from [<c0022100>] (do_exit+0x640/0x670)
[<c0021ac0>] (do_exit+0x0/0x670) from [<c001222c>] (die+0x2bc/0x2fc)
[<c0011f70>] (die+0x0/0x2fc) from [<c0013808>] (__do_kernel_fault+0x70/0x90)
[<c0013798>] (__do_kernel_fault+0x0/0x90) from [<c0013b58>] (do_page_fault+0x330/0x354)
 r8:c708cb00 r7:bf055504 r6:c70bdea8 r5:a0000013 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bdea8 to 0xc70bdef0)
dea0:                   bf0554a0 00000000 00000000 00000001 bf0554a0 c70e5d20
dec0: c02e1de0 c7043200 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff
 r8:c7803a00 r7:c70bdedc r6:ffffffff r5:a0000013 r4:c011460c
[<c01145f4>] (kobject_put+0x0/0x7c) from [<c01146f4>] (kobject_del+0x64/0x70)
 r4:c70e5d00
[<c0114690>] (kobject_del+0x0/0x70) from [<c01147f0>] (kobject_delayed_cleanup+0xf0/0x198)
 r4:c70e5d00
[<c0114700>] (kobject_delayed_cleanup+0x0/0x198) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c70e5d20
[<c00316b0>] (process_one_work+0x0/0x3a8) from [<c0032570>] (worker_thread+0x20c/0x428)
[<c0032364>] (worker_thread+0x0/0x428) from [<c0037768>] (kthread+0x88/0x90)
[<c00376e0>] (kthread+0x0/0x90) from [<c0021ac0>] (do_exit+0x0/0x670)
 r7:00000013 r6:c0021ac0 r5:c00376e0 r4:c7839edc
Code: e1a0c00d e92dd800 e24cb004 e5903128 (e5130004) 
---[ end trace ddf7f4f6a0de23b9 ]---
