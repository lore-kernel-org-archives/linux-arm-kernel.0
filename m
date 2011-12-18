From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Sun, 18 Dec 2011 19:50:37 +0100
Subject: [PATCH 3/7] s3c-hsudc: add a remove function
In-Reply-To: <20111218144319.GU14542@n2100.arm.linux.org.uk>
References: <201112172023.05519.heiko@sntech.de>
 <201112181444.39812.heiko@sntech.de>
 <20111218144319.GU14542@n2100.arm.linux.org.uk>
Message-ID: <201112181950.38993.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 18 Dezember 2011, 15:43:19 schrieb Russell King - ARM Linux:
> On Sun, Dec 18, 2011 at 02:44:39PM +0100, Heiko St?bner wrote:
> > Am Sonntag 18 Dezember 2011, 09:10:48 schrieb Russell King - ARM Linux:
> > > On Sat, Dec 17, 2011 at 08:26:33PM +0100, Heiko St?bner wrote:
> > > > As the driver is also buildable as a module it should need
> > > > a cleanup function for the removal of the module.
> > > 
> > > My guess is that this wasn't implemented because of the embedded struct
> > > device lifetime rules for the gadget - to prevent the unbinding of the
> > > driver.
> > > 
> > > Until the struct device lifetime gets fixed, you must not allow the
> > > module nor the data structure containing the struct device to be
> > > freed.
> > 
> > I understand where this problem comes from (the release method is
> > potentially gone with the module before it is called) but after more
> > reading, I have a hard time believing that a lot of the other gadget
> > drivers would be wrong as well. Some of them since 2009 or possibly
> > earlier.
> > 
> > Gadgets with embedded release methods: langwell_udc, goku_udc, fsl_qe_udc
> > (and fsl_udc_core), amd5536udc, net2280, pch_udc, cil13xxx_udc,
> > dummy_hcd, omap_udc, net2272, mc_udc_core
> > 
> > Gadgets which use the release method from its pdev->dev but also free the
> > struct with the gadget in their remove method: r8a66597-udc, m66592-udc,
> > fusb300_udc. (possibly before the release function is called)
> > 
> > On the other hand, the gets and puts of the udc->gadget.dev should be
> > paired correctly and it's only an intermediate device between the udc
> > and the gadget driver, so that the call to device_unregister in the
> > remove method should put the refcount to 0 and thus init the cleanup
> > (including the call to release) before the module is removed.
> > 
> > So, I am very confused :-).
> 
> Try this patch.  If your system oopses 5 seconds after you remove the
> module, you have a lifetime bug.
I didn't get this far. With your patch the Oopses already happen during the startup of
the system / the loading of the modules.

A bit of the message spew I got during testing with linux-next-20111216:

pgd = c0004000
[bf05b504] *pgd=379af811, *pte=00000000, *ppte=00000000
Internal error: Oops: 7 [#1]
Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core s3c_hsudc
CPU: 0    Not tainted  (3.2.0-rc5-next-20111216+ #32)
PC is at kobject_put+0x18/0x7c
LR is at kobject_del+0x64/0x70
pc : [<c011460c>]    lr : [<c01146f4>]    psr: a0000013
sp : c70bdef0  ip : c70bdf10  fp : c70bdf0c
r10: 00000000  r9 : c0114700  r8 : c7803a00
r7 : c79257a0  r6 : c02e1de0  r5 : c79a0120  r4 : bf05b4a0
r3 : 00000001  r2 : 00000000  r1 : 00000000  r0 : bf05b4a0
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 0005317f  Table: 37014000  DAC: 00000017
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bdef0 to 0xc70be000)
dee0:                                     c79a0100 c79a0120 c02e1de0 c79a0100
df00: c70bdf24 c70bdf10 c01146f4 c0114604 c01365bc c79a0100 c70bdf4c c70bdf28
df20: c01147f0 c01146a0 c0136640 c0136590 c79a0120 c785fd00 00000000 00000009
df40: c70bdf84 c70bdf50 c00318fc c0114710 c02dbf00 c7803a05 c02dbf00 c785fd00
df60: c02dbf00 c785fd00 00000009 c02dbf00 c785fd10 c70bc000 c70bdfbc c70bdf88
df80: c0032570 c00316c0 c7839edc c785fd10 c0032364 c70bdfcc c7839edc c785fd00
dfa0: c0032364 00000000 00000000 00000000 c70bdff4 c70bdfc0 c0037768 c0032374
dfc0: c7839edc 00000000 c785fd00 00000000 c70bdfd0 c70bdfd0 c7839edc c00376e0
dfe0: c0021ac0 00000013 00000000 c70bdff8 c0021ac0 c00376f0 00190021 00024ea8
Backtrace: 
[<c01145f4>] (kobject_put+0x0/0x7c) from [<c01146f4>] (kobject_del+0x64/0x70)
 r4:c79a0100
[<c0114690>] (kobject_del+0x0/0x70) from [<c01147f0>] (kobject_delayed_cleanup+0xf0/0x198)
 r4:c79a0100
[<c0114700>] (kobject_delayed_cleanup+0x0/0x198) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c79a0120
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
Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core s3c_hsudc
CPU: 0    Tainted: G      D       (3.2.0-rc5-next-20111216+ #32)
PC is at kthread_data+0x10/0x18
LR is at wq_worker_sleeping+0x18/0xbc
pc : [<c00371c4>]    lr : [<c0033974>]    psr: 20000093
sp : c70bdb58  ip : c70bdb68  fp : c70bdb64
r10: c70bc000  r9 : c70bdb90  r8 : c02dc500
r7 : c7826000  r6 : c708cb00  r5 : c708cc54  r4 : 00000000
r3 : 00000000  r2 : c02dc500  r1 : 00000000  r0 : c708cb00
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 37014000  DAC: 00000015
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bdb58 to 0xc70be000)
db40:                                                       c70bdb7c c70bdb68
db60: c0033974 c00371c4 c003f760 00000001 c70bdc04 c70bdb80 c0218ebc c003396c
db80: c0406680 c70b4a40 00000664 c001c678 00000168 00000000 c70bdbcc c70bdba8
dba0: c008cb78 c008b680 c0034390 c708cb00 c70b8440 00000001 00000000 c70b4a40
dbc0: c70bdbdc c70bdbd0 c001c678 c708cb00 c70bdc14 c70bdbe0 c0020db4 00000001
dbe0: c70bdc24 c708cb00 c7826000 c708cbd8 c708caf8 c708cbd8 c70bdc14 c70bdc08
dc00: c02194cc c0218dfc c70bdc3c c70bdc18 c0022100 c0219468 00000008 00000001
dc20: c70bdc3c c70bdc24 c70bdc24 c708cc20 c70bdcb4 c70bdc40 c001222c c0021ad0
dc40: c70bc270 0000000b 7269762f 00000000 65000000 62633432 20343030 64343265
dc60: 63303064 35326520 30303430 61302030 30303030 28203331 34643565 34363033
dc80: c0002029 c0217dd8 c027dcbb bf05b504 c70bdea8 00000000 00000007 00000000
dca0: 00000007 00000000 c70bdcdc c70bdcb8 c0013808 c0011f80 00000000 c02d5ccc
dcc0: a0000013 c70bdea8 bf05b504 c708cb00 c70bddf4 c70bdce0 c0013b58 c00137a8
dce0: bf01dfcc bf0200c8 00000000 00000000 c70bddc4 c70bdd00 bf01f58c 00000028
dd00: c70bdd88 00000004 00000001 c708dbb0 00000000 00000004 00000002 c7a7e5e0
dd20: c708cb30 00000000 c708dbb0 00000000 c70bdd6c c70bdd40 c0040e34 c0040b20
dd40: c003f79c c021bf08 c02dc500 c708cb00 000000c3 00000001 00000001 00000001
dd60: c70bdd8c c70bdd70 c003e080 c0040d74 c003fb2c c708db80 00000000 40000093
dd80: c70bddac bf0203b0 00000100 c706d378 c70bddc4 c70bdda0 c0118064 c0117e6c
dda0: 00000001 00000004 00000000 c706d0b0 c02dc500 c706d0b0 00000000 c708cb00
ddc0: c708cb30 00000001 c706d0b0 c02d5ccc a0000013 00000007 c70bdea8 bf05b504
dde0: c0114700 00000000 c70bdea4 c70bddf8 c0008634 c0013838 00000003 00000000
de00: c70bde2c c70bde10 c003e080 c0040d74 c003fb2c c706d080 00000000 80000093
de20: c70bde4c c70bde30 c003fbc0 c003e05c 00000002 c7a73f70 00000bd3 000003e0
de40: c70bde70 c0113dc0 c003fbf8 c7a28780 c7a28730 c031fba0 c70bde98 c70bdec8
de60: c70bde8c c70bde70 c00dda98 c008cabc c7a28780 c7a28780 00020001 c70bde94
de80: c70bdec4 c011460c a0000013 ffffffff c70bdedc c7803a00 c70bdf0c c70bdea8
dea0: c000e458 c0008608 bf05b4a0 00000000 00000000 00000001 bf05b4a0 c79a0120
dec0: c02e1de0 c79257a0 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff c79a0100 c79a0120 c02e1de0 c79a0100
df00: c70bdf24 c70bdf10 c01146f4 c0114604 c01365bc c79a0100 c70bdf4c c70bdf28
df20: c01147f0 c01146a0 c0136640 c0136590 c79a0120 c785fd00 00000000 00000009
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
 r8:c708cb00 r7:bf05b504 r6:c70bdea8 r5:a0000013 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bdea8 to 0xc70bdef0)
dea0:                   bf05b4a0 00000000 00000000 00000001 bf05b4a0 c79a0120
dec0: c02e1de0 c79257a0 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff
 r8:c7803a00 r7:c70bdedc r6:ffffffff r5:a0000013 r4:c011460c
[<c01145f4>] (kobject_put+0x0/0x7c) from [<c01146f4>] (kobject_del+0x64/0x70)
 r4:c79a0100
[<c0114690>] (kobject_del+0x0/0x70) from [<c01147f0>] (kobject_delayed_cleanup+0xf0/0x198)
 r4:c79a0100
[<c0114700>] (kobject_delayed_cleanup+0x0/0x198) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c79a0120
[<c00316b0>] (process_one_work+0x0/0x3a8) from [<c0032570>] (worker_thread+0x20c/0x428)
[<c0032364>] (worker_thread+0x0/0x428) from [<c0037768>] (kthread+0x88/0x90)
[<c00376e0>] (kthread+0x0/0x90) from [<c0021ac0>] (do_exit+0x0/0x670)
 r7:00000013 r6:c0021ac0 r5:c00376e0 r4:c7839edc
Code: e1a0c00d e92dd800 e24cb004 e5903128 (e5130004) 
---[ end trace ddf7f4f6a0de23b9 ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at virtual address fffffffc
pgd = c0004000
[fffffffc] *pgd=37ffe831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#3]
Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core s3c_hsudc
CPU: 0    Tainted: G      D       (3.2.0-rc5-next-20111216+ #32)
PC is at kthread_data+0x10/0x18
LR is at wq_worker_sleeping+0x18/0xbc
pc : [<c00371c4>]    lr : [<c0033974>]    psr: 20000093
sp : c70bd7c0  ip : c70bd7d0  fp : c70bd7cc
r10: c70bc000  r9 : c70bd7f8  r8 : c02dc500
r7 : c00371c8  r6 : c708cb00  r5 : c708cc54  r4 : 00000000
r3 : 00000000  r2 : c02dc500  r1 : 00000000  r0 : c708cb00
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 37014000  DAC: 00000015
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bd7c0 to 0xc70be000)
d7c0: c70bd7e4 c70bd7d0 c0033974 c00371c4 c003f760 0000000b c70bd86c c70bd7e8
d7e0: c0218ebc c003396c c0023cdc 60000013 ffffffff 60000013 c70bd824 c70bd808
d800: c005681c c0056718 0000001e 00000000 f6000000 c70bd894 c70bd834 c70bd828
d820: c0023e4c c00567c0 00000001 000bd838 00000004 0000000b c00371c6 c708cb00
d840: c00371c8 0000000b c00371c6 c708cb00 c00371c8 00000000 00000008 bf000000
d860: c70bd87c c70bd870 c02194cc c0218dfc c70bd8a4 c70bd880 c0021bd4 c0219468
d880: 00000008 bf000000 c70bd8a4 c70bd898 c001e49c c001e99c c70bd91c c70bd8a8
d8a0: c001222c c0021ad0 c70bc270 0000000b 028959e4 00000000 65000000 63306131
d8c0: 20643030 64323965 30303864 34326520 30306263 35652034 31333039 28203832
d8e0: 33313565 34303030 c0002029 c0217dd8 c027dcbb fffffffc c70bdb10 00000000
d900: 00000017 00000000 00000017 00000000 c70bd944 c70bd920 c0013808 c0011f80
d920: c0275aa3 c02d5ccc 20000093 c70bdb10 fffffffc c708cb00 c70bda5c c70bd948
d940: c0013b58 c00137a8 c011b37c c027a96d 00000000 00000670 c70bd9a9 0002340f
d960: c70bd994 00000028 c011a208 c0118ee8 c014b004 c03102e3 c03106b0 c03106b0
d980: c0275aa2 c03106b0 c70bda9c c70bd9a0 c011a584 c011a1d8 c011a550 ff0a0005
d9a0: ffffffff c70bd9b0 5f6f6474 74697865 3078302b 3678302f 30003037 38323478
d9c0: 00003800 31780038 00003839 c70bd9d8 c001e818 c001e70c 00001e0c 00001e0c
d9e0: c70bda1c c70bd9f0 c001f008 c003bd00 00000000 00000000 00000000 0000001f
da00: c70bda72 c03102b2 00000004 00000000 1b478423 c70bda50 c70bda24 c01198cc
da20: c01196d0 65300020 c70bda72 c03102b2 0000ffff c02d5ccc 20000093 00000017
da40: c70bdb10 fffffffc c70bdb90 c70bc000 c70bdb0c c70bda60 c0008634 c0013838
da60: c70bda84 c70bdaae c70bdb97 0000ffff 00000002 00000000 c0281b48 00000007
da80: c70bdb1c c70bda90 c0119ab8 c7826580 00000001 00000007 00000001 c78265b0
daa0: c02dc500 c78265b0 00000000 c708cb00 c708cb30 00000000 c78265b0 00000000
dac0: c70bdafc c70bdad0 c0040e5c c003e004 c003f79c c021bf08 c02dc500 c708cb00
dae0: c7826000 c02dc500 c70bdb90 c00371c4 20000093 ffffffff c70bdb44 c02dc500
db00: c70bdb64 c70bdb10 c000e458 c0008608 c708cb00 00000000 c02dc500 00000000
db20: 00000000 c708cc54 c708cb00 c7826000 c02dc500 c70bdb90 c70bc000 c70bdb64
db40: c70bdb68 c70bdb58 c0033974 c00371c4 20000093 ffffffff c70bdb7c c70bdb68
db60: c0033974 c00371c4 c003f760 00000001 c70bdc04 c70bdb80 c0218ebc c003396c
db80: c0406680 c70b4a40 00000664 c001c678 00000168 00000000 c70bdbcc c70bdba8
dba0: c008cb78 c008b680 c0034390 c708cb00 c70b8440 00000001 00000000 c70b4a40
dbc0: c70bdbdc c70bdbd0 c001c678 c708cb00 c70bdc14 c70bdbe0 c0020db4 00000001
dbe0: c70bdc24 c708cb00 c7826000 c708cbd8 c708caf8 c708cbd8 c70bdc14 c70bdc08
dc00: c02194cc c0218dfc c70bdc3c c70bdc18 c0022100 c0219468 00000008 00000001
dc20: c70bdc3c c70bdc24 c70bdc24 c708cc20 c70bdcb4 c70bdc40 c001222c c0021ad0
dc40: c70bc270 0000000b 7269762f 00000000 65000000 62633432 20343030 64343265
dc60: 63303064 35326520 30303430 61302030 30303030 28203331 34643565 34363033
dc80: c0002029 c0217dd8 c027dcbb bf05b504 c70bdea8 00000000 00000007 00000000
dca0: 00000007 00000000 c70bdcdc c70bdcb8 c0013808 c0011f80 00000000 c02d5ccc
dcc0: a0000013 c70bdea8 bf05b504 c708cb00 c70bddf4 c70bdce0 c0013b58 c00137a8
dce0: bf01dfcc bf0200c8 00000000 00000000 c70bddc4 c70bdd00 bf01f58c 00000028
dd00: c70bdd88 00000004 00000001 c708dbb0 00000000 00000004 00000002 c7a7e5e0
dd20: c708cb30 00000000 c708dbb0 00000000 c70bdd6c c70bdd40 c0040e34 c0040b20
dd40: c003f79c c021bf08 c02dc500 c708cb00 000000c3 00000001 00000001 00000001
dd60: c70bdd8c c70bdd70 c003e080 c0040d74 c003fb2c c708db80 00000000 40000093
dd80: c70bddac bf0203b0 00000100 c706d378 c70bddc4 c70bdda0 c0118064 c0117e6c
dda0: 00000001 00000004 00000000 c706d0b0 c02dc500 c706d0b0 00000000 c708cb00
ddc0: c708cb30 00000001 c706d0b0 c02d5ccc a0000013 00000007 c70bdea8 bf05b504
dde0: c0114700 00000000 c70bdea4 c70bddf8 c0008634 c0013838 00000003 00000000
de00: c70bde2c c70bde10 c003e080 c0040d74 c003fb2c c706d080 00000000 80000093
de20: c70bde4c c70bde30 c003fbc0 c003e05c 00000002 c7a73f70 00000bd3 000003e0
de40: c70bde70 c0113dc0 c003fbf8 c7a28780 c7a28730 c031fba0 c70bde98 c70bdec8
de60: c70bde8c c70bde70 c00dda98 c008cabc c7a28780 c7a28780 00020001 c70bde94
de80: c70bdec4 c011460c a0000013 ffffffff c70bdedc c7803a00 c70bdf0c c70bdea8
dea0: c000e458 c0008608 bf05b4a0 00000000 00000000 00000001 bf05b4a0 c79a0120
dec0: c02e1de0 c79257a0 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff c79a0100 c79a0120 c02e1de0 c79a0100
df00: c70bdf24 c70bdf10 c01146f4 c0114604 c01365bc c79a0100 c70bdf4c c70bdf28
df20: c01147f0 c01146a0 c0136640 c0136590 c79a0120 c785fd00 00000000 00000009
df40: c70bdf84 c70bdf50 c00318fc c0114710 c02dbf00 c7803a05 c02dbf00 c785fd00
df60: c02dbf00 c785fd00 00000009 c02dbf00 c785fd10 c70bc000 c70bdfbc c70bdf88
df80: c0032570 c00316c0 c7839edc c785fd10 c0032364 c70bdfcc c7839edc c785fd00
dfa0: c0032364 00000000 00000000 00000000 c70bdff4 c70bdfc0 c0037768 c0032374
dfc0: c7839edc 00000000 c785fd00 00000001 c70bdfd0 c70bdfd0 c7839edc c00376e0
dfe0: c0021ac0 00000013 00000000 c70bdff8 c0021ac0 c00376f0 00190021 00024ea8
Backtrace: 
[<c00371b4>] (kthread_data+0x0/0x18) from [<c0033974>] (wq_worker_sleeping+0x18/0xbc)
[<c003395c>] (wq_worker_sleeping+0x0/0xbc) from [<c0218ebc>] (__schedule+0xd0/0x37c)
 r4:0000000b
[<c0218dec>] (__schedule+0x0/0x37c) from [<c02194cc>] (schedule+0x74/0x78)
[<c0219458>] (schedule+0x0/0x78) from [<c0021bd4>] (do_exit+0x114/0x670)
[<c0021ac0>] (do_exit+0x0/0x670) from [<c001222c>] (die+0x2bc/0x2fc)
[<c0011f70>] (die+0x0/0x2fc) from [<c0013808>] (__do_kernel_fault+0x70/0x90)
[<c0013798>] (__do_kernel_fault+0x0/0x90) from [<c0013b58>] (do_page_fault+0x330/0x354)
 r8:c708cb00 r7:fffffffc r6:c70bdb10 r5:20000093 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bdb10 to 0xc70bdb58)
db00:                                     c708cb00 00000000 c02dc500 00000000
db20: 00000000 c708cc54 c708cb00 c7826000 c02dc500 c70bdb90 c70bc000 c70bdb64
db40: c70bdb68 c70bdb58 c0033974 c00371c4 20000093 ffffffff
 r8:c02dc500 r7:c70bdb44 r6:ffffffff r5:20000093 r4:c00371c4
[<c00371b4>] (kthread_data+0x0/0x18) from [<c0033974>] (wq_worker_sleeping+0x18/0xbc)
[<c003395c>] (wq_worker_sleeping+0x0/0xbc) from [<c0218ebc>] (__schedule+0xd0/0x37c)
 r4:00000001
[<c0218dec>] (__schedule+0x0/0x37c) from [<c02194cc>] (schedule+0x74/0x78)
[<c0219458>] (schedule+0x0/0x78) from [<c0022100>] (do_exit+0x640/0x670)
[<c0021ac0>] (do_exit+0x0/0x670) from [<c001222c>] (die+0x2bc/0x2fc)
[<c0011f70>] (die+0x0/0x2fc) from [<c0013808>] (__do_kernel_fault+0x70/0x90)
[<c0013798>] (__do_kernel_fault+0x0/0x90) from [<c0013b58>] (do_page_fault+0x330/0x354)
 r8:c708cb00 r7:bf05b504 r6:c70bdea8 r5:a0000013 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bdea8 to 0xc70bdef0)
dea0:                   bf05b4a0 00000000 00000000 00000001 bf05b4a0 c79a0120
dec0: c02e1de0 c79257a0 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff
 r8:c7803a00 r7:c70bdedc r6:ffffffff r5:a0000013 r4:c011460c
[<c01145f4>] (kobject_put+0x0/0x7c) from [<c01146f4>] (kobject_del+0x64/0x70)
 r4:c79a0100
[<c0114690>] (kobject_del+0x0/0x70) from [<c01147f0>] (kobject_delayed_cleanup+0xf0/0x198)
 r4:c79a0100
[<c0114700>] (kobject_delayed_cleanup+0x0/0x198) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c79a0120
[<c00316b0>] (process_one_work+0x0/0x3a8) from [<c0032570>] (worker_thread+0x20c/0x428)
[<c0032364>] (worker_thread+0x0/0x428) from [<c0037768>] (kthread+0x88/0x90)
[<c00376e0>] (kthread+0x0/0x90) from [<c0021ac0>] (do_exit+0x0/0x670)
 r7:00000013 r6:c0021ac0 r5:c00376e0 r4:c7839edc
Code: e1a0c00d e92dd800 e24cb004 e5903128 (e5130004) 
---[ end trace ddf7f4f6a0de23ba ]---
Fixing recursive fault but reboot is needed!
Unable to handle kernel paging request at virtual address fffffffc
pgd = c0004000
[fffffffc] *pgd=37ffe831, *pte=00000000, *ppte=00000000
Internal error: Oops: 17 [#4]
Modules linked in: ohci_hcd leds_s3c24xx usbcore i2c_s3c2410 i2c_core s3c_hsudc
CPU: 0    Tainted: G      D       (3.2.0-rc5-next-20111216+ #32)
PC is at kthread_data+0x10/0x18
LR is at wq_worker_sleeping+0x18/0xbc
pc : [<c00371c4>]    lr : [<c0033974>]    psr: 20000093
sp : c70bd428  ip : c70bd438  fp : c70bd434
r10: c70bc000  r9 : c70bd460  r8 : c02dc500
r7 : c00371c8  r6 : c708cb00  r5 : c708cc54  r4 : 00000000
r3 : 00000000  r2 : c02dc500  r1 : 00000000  r0 : c708cb00
Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0005317f  Table: 37014000  DAC: 00000015
Process kworker/0:1 (pid: 16, stack limit = 0xc70bc270)
Stack: (0xc70bd428 to 0xc70be000)
d420:                   c70bd44c c70bd438 c0033974 c00371c4 c003f760 0000000b
d440: c70bd4d4 c70bd450 c0218ebc c003396c c0023cdc 60000013 ffffffff 60000013
d460: c70bd48c c70bd470 c005681c c0056718 0000001e 00000000 f6000000 c70bd4fc
d480: c70bd49c c70bd490 c0023e4c c00567c0 00000001 000bd4a0 00000004 0000000b
d4a0: c00371c6 c708cb00 c00371c8 0000000b c00371c6 c708cb00 c00371c8 00000000
d4c0: 00000008 bf000000 c70bd4e4 c70bd4d8 c02194cc c0218dfc c70bd50c c70bd4e8
d4e0: c0021bd4 c0219468 00000008 bf000000 c70bd50c c70bd500 c001e49c c001e99c
d500: c70bd584 c70bd510 c001222c c0021ad0 c70bc270 0000000b 00003164 00000000
d520: 65000000 63306131 20643030 64323965 30303864 34326520 30306263 35652034
d540: 31333039 28203832 33313565 34303030 c0002029 c0217dd8 c027dcbb fffffffc
d560: c70bd778 00000000 00000017 00000000 00000017 00000000 c70bd5ac c70bd588
d580: c0013808 c0011f80 c0275aa3 c02d5ccc 20000093 c70bd778 fffffffc c708cb00
d5a0: c70bd6c4 c70bd5b0 c0013b58 c00137a8 c011b37c c027a96d 00000000 00000670
d5c0: c70bd611 00000030 c70bd5fc 00000028 c011a208 c0118ee8 c014b004 c03102e3
d5e0: c03106b0 c03106b0 c0275aa2 c03106b0 c70bd704 c70bd608 c011a584 c011a1d8
d600: c011a550 ff0a0005 ffffffff c70bd618 5f6f6474 74697865 3078302b 3678302f
d620: 30003037 38323478 00003800 31780038 c70bc000 00000000 005b8d80 00000000
d640: c708cb30 c70bd7cc c70bd67c c70bd658 c0040818 c00406b4 00000c00 00155555
d660: c02dfe08 c02dfd74 c70bc000 c708cb30 c70bd69c c70bd674 c70bd674 c708cb00
d680: c70bd7cc c02ddbb0 c031e888 c70bc000 00000000 c708cb00 c70bd7cc c02d5ccc
d6a0: 20000093 00000017 c70bd778 fffffffc c70bd7f8 c70bc000 c70bd774 c70bd6c8
d6c0: c0008634 c0013838 c70bd724 c70bd6d8 c0028b4c c003aa98 00000001 00000001
d6e0: c02ddbb0 c70bd6f0 c031122c c031102c c70bd6f0 c70bd6f0 00000010 00000001
d700: 00000100 c70bc000 00000004 00000001 00000001 00000100 c70bd75c 0000002c
d720: c70bd754 c70bd730 c014b004 c014dc28 c70bd75c c02e6290 00003cd6 0000002d
d740: c02daa48 c02daa50 c70bd764 c70bd758 c014e9ac c00371c4 20000093 ffffffff
d760: c70bd7ac c02dc500 c70bd7cc c70bd778 c000e458 c0008608 c708cb00 00000000
d780: c02dc500 00000000 00000000 c708cc54 c708cb00 c00371c8 c02dc500 c70bd7f8
d7a0: c70bc000 c70bd7cc c70bd7d0 c70bd7c0 c0033974 c00371c4 20000093 ffffffff
d7c0: c70bd7e4 c70bd7d0 c0033974 c00371c4 c003f760 0000000b c70bd86c c70bd7e8
d7e0: c0218ebc c003396c c0023cdc 60000013 ffffffff 60000013 c70bd824 c70bd808
d800: c005681c c0056718 0000001e 00000000 f6000000 c70bd894 c70bd834 c70bd828
d820: c0023e4c c00567c0 00000001 000bd838 00000004 0000000b c00371c6 c708cb00
d840: c00371c8 0000000b c00371c6 c708cb00 c00371c8 00000000 00000008 bf000000
d860: c70bd87c c70bd870 c02194cc c0218dfc c70bd8a4 c70bd880 c0021bd4 c0219468
d880: 00000008 bf000000 c70bd8a4 c70bd898 c001e49c c001e99c c70bd91c c70bd8a8
d8a0: c001222c c0021ad0 c70bc270 0000000b 028959e4 00000000 65000000 63306131
d8c0: 20643030 64323965 30303864 34326520 30306263 35652034 31333039 28203832
d8e0: 33313565 34303030 c0002029 c0217dd8 c027dcbb fffffffc c70bdb10 00000000
d900: 00000017 00000000 00000017 00000000 c70bd944 c70bd920 c0013808 c0011f80
d920: c0275aa3 c02d5ccc 20000093 c70bdb10 fffffffc c708cb00 c70bda5c c70bd948
d940: c0013b58 c00137a8 c011b37c c027a96d 00000000 00000670 c70bd9a9 0002340f
d960: c70bd994 00000028 c011a208 c0118ee8 c014b004 c03102e3 c03106b0 c03106b0
d980: c0275aa2 c03106b0 c70bda9c c70bd9a0 c011a584 c011a1d8 c011a550 ff0a0005
d9a0: ffffffff c70bd9b0 5f6f6474 74697865 3078302b 3678302f 30003037 38323478
d9c0: 00003800 31780038 00003839 c70bd9d8 c001e818 c001e70c 00001e0c 00001e0c
d9e0: c70bda1c c70bd9f0 c001f008 c003bd00 00000000 00000000 00000000 0000001f
da00: c70bda72 c03102b2 00000004 00000000 1b478423 c70bda50 c70bda24 c01198cc
da20: c01196d0 65300020 c70bda72 c03102b2 0000ffff c02d5ccc 20000093 00000017
da40: c70bdb10 fffffffc c70bdb90 c70bc000 c70bdb0c c70bda60 c0008634 c0013838
da60: c70bda84 c70bdaae c70bdb97 0000ffff 00000002 00000000 c0281b48 00000007
da80: c70bdb1c c70bda90 c0119ab8 c7826580 00000001 00000007 00000001 c78265b0
daa0: c02dc500 c78265b0 00000000 c708cb00 c708cb30 00000000 c78265b0 00000000
dac0: c70bdafc c70bdad0 c0040e5c c003e004 c003f79c c021bf08 c02dc500 c708cb00
dae0: c7826000 c02dc500 c70bdb90 c00371c4 20000093 ffffffff c70bdb44 c02dc500
db00: c70bdb64 c70bdb10 c000e458 c0008608 c708cb00 00000000 c02dc500 00000000
db20: 00000000 c708cc54 c708cb00 c7826000 c02dc500 c70bdb90 c70bc000 c70bdb64
db40: c70bdb68 c70bdb58 c0033974 c00371c4 20000093 ffffffff c70bdb7c c70bdb68
db60: c0033974 c00371c4 c003f760 00000001 c70bdc04 c70bdb80 c0218ebc c003396c
db80: c0406680 c70b4a40 00000664 c001c678 00000168 00000000 c70bdbcc c70bdba8
dba0: c008cb78 c008b680 c0034390 c708cb00 c70b8440 00000001 00000000 c70b4a40
dbc0: c70bdbdc c70bdbd0 c001c678 c708cb00 c70bdc14 c70bdbe0 c0020db4 00000001
dbe0: c70bdc24 c708cb00 c7826000 c708cbd8 c708caf8 c708cbd8 c70bdc14 c70bdc08
dc00: c02194cc c0218dfc c70bdc3c c70bdc18 c0022100 c0219468 00000008 00000001
dc20: c70bdc3c c70bdc24 c70bdc24 c708cc20 c70bdcb4 c70bdc40 c001222c c0021ad0
dc40: c70bc270 0000000b 7269762f 00000000 65000000 62633432 20343030 64343265
dc60: 63303064 35326520 30303430 61302030 30303030 28203331 34643565 34363033
dc80: c0002029 c0217dd8 c027dcbb bf05b504 c70bdea8 00000000 00000007 00000000
dca0: 00000007 00000000 c70bdcdc c70bdcb8 c0013808 c0011f80 00000000 c02d5ccc
dcc0: a0000013 c70bdea8 bf05b504 c708cb00 c70bddf4 c70bdce0 c0013b58 c00137a8
dce0: bf01dfcc bf0200c8 00000000 00000000 c70bddc4 c70bdd00 bf01f58c 00000028
dd00: c70bdd88 00000004 00000001 c708dbb0 00000000 00000004 00000002 c7a7e5e0
dd20: c708cb30 00000000 c708dbb0 00000000 c70bdd6c c70bdd40 c0040e34 c0040b20
dd40: c003f79c c021bf08 c02dc500 c708cb00 000000c3 00000001 00000001 00000001
dd60: c70bdd8c c70bdd70 c003e080 c0040d74 c003fb2c c708db80 00000000 40000093
dd80: c70bddac bf0203b0 00000100 c706d378 c70bddc4 c70bdda0 c0118064 c0117e6c
dda0: 00000001 00000004 00000000 c706d0b0 c02dc500 c706d0b0 00000000 c708cb00
ddc0: c708cb30 00000001 c706d0b0 c02d5ccc a0000013 00000007 c70bdea8 bf05b504
dde0: c0114700 00000000 c70bdea4 c70bddf8 c0008634 c0013838 00000003 00000000
de00: c70bde2c c70bde10 c003e080 c0040d74 c003fb2c c706d080 00000000 80000093
de20: c70bde4c c70bde30 c003fbc0 c003e05c 00000002 c7a73f70 00000bd3 000003e0
de40: c70bde70 c0113dc0 c003fbf8 c7a28780 c7a28730 c031fba0 c70bde98 c70bdec8
de60: c70bde8c c70bde70 c00dda98 c008cabc c7a28780 c7a28780 00020001 c70bde94
de80: c70bdec4 c011460c a0000013 ffffffff c70bdedc c7803a00 c70bdf0c c70bdea8
dea0: c000e458 c0008608 bf05b4a0 00000000 00000000 00000001 bf05b4a0 c79a0120
dec0: c02e1de0 c79257a0 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff c79a0100 c79a0120 c02e1de0 c79a0100
df00: c70bdf24 c70bdf10 c01146f4 c0114604 c01365bc c79a0100 c70bdf4c c70bdf28
df20: c01147f0 c01146a0 c0136640 c0136590 c79a0120 c785fd00 00000000 00000009
df40: c70bdf84 c70bdf50 c00318fc c0114710 c02dbf00 c7803a05 c02dbf00 c785fd00
df60: c02dbf00 c785fd00 00000009 c02dbf00 c785fd10 c70bc000 c70bdfbc c70bdf88
df80: c0032570 c00316c0 c7839edc c785fd10 c0032364 c70bdfcc c7839edc c785fd00
dfa0: c0032364 00000000 00000000 00000000 c70bdff4 c70bdfc0 c0037768 c0032374
dfc0: c7839edc 00000000 c785fd00 00000001 c70bdfd0 c70bdfd0 c7839edc c00376e0
dfe0: c0021ac0 00000013 00000000 c70bdff8 c0021ac0 c00376f0 00190021 00024ea8
Backtrace: 
[<c00371b4>] (kthread_data+0x0/0x18) from [<c0033974>] (wq_worker_sleeping+0x18/0xbc)
[<c003395c>] (wq_worker_sleeping+0x0/0xbc) from [<c0218ebc>] (__schedule+0xd0/0x37c)
 r4:0000000b
[<c0218dec>] (__schedule+0x0/0x37c) from [<c02194cc>] (schedule+0x74/0x78)
[<c0219458>] (schedule+0x0/0x78) from [<c0021bd4>] (do_exit+0x114/0x670)
[<c0021ac0>] (do_exit+0x0/0x670) from [<c001222c>] (die+0x2bc/0x2fc)
[<c0011f70>] (die+0x0/0x2fc) from [<c0013808>] (__do_kernel_fault+0x70/0x90)
[<c0013798>] (__do_kernel_fault+0x0/0x90) from [<c0013b58>] (do_page_fault+0x330/0x354)
 r8:c708cb00 r7:fffffffc r6:c70bd778 r5:20000093 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bd778 to 0xc70bd7c0)
d760:                                                       c708cb00 00000000
d780: c02dc500 00000000 00000000 c708cc54 c708cb00 c00371c8 c02dc500 c70bd7f8
d7a0: c70bc000 c70bd7cc c70bd7d0 c70bd7c0 c0033974 c00371c4 20000093 ffffffff
 r8:c02dc500 r7:c70bd7ac r6:ffffffff r5:20000093 r4:c00371c4
[<c00371b4>] (kthread_data+0x0/0x18) from [<c0033974>] (wq_worker_sleeping+0x18/0xbc)
[<c003395c>] (wq_worker_sleeping+0x0/0xbc) from [<c0218ebc>] (__schedule+0xd0/0x37c)
 r4:0000000b
[<c0218dec>] (__schedule+0x0/0x37c) from [<c02194cc>] (schedule+0x74/0x78)
[<c0219458>] (schedule+0x0/0x78) from [<c0021bd4>] (do_exit+0x114/0x670)
[<c0021ac0>] (do_exit+0x0/0x670) from [<c001222c>] (die+0x2bc/0x2fc)
[<c0011f70>] (die+0x0/0x2fc) from [<c0013808>] (__do_kernel_fault+0x70/0x90)
[<c0013798>] (__do_kernel_fault+0x0/0x90) from [<c0013b58>] (do_page_fault+0x330/0x354)
 r8:c708cb00 r7:fffffffc r6:c70bdb10 r5:20000093 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bdb10 to 0xc70bdb58)
db00:                                     c708cb00 00000000 c02dc500 00000000
db20: 00000000 c708cc54 c708cb00 c7826000 c02dc500 c70bdb90 c70bc000 c70bdb64
db40: c70bdb68 c70bdb58 c0033974 c00371c4 20000093 ffffffff
 r8:c02dc500 r7:c70bdb44 r6:ffffffff r5:20000093 r4:c00371c4
[<c00371b4>] (kthread_data+0x0/0x18) from [<c0033974>] (wq_worker_sleeping+0x18/0xbc)
[<c003395c>] (wq_worker_sleeping+0x0/0xbc) from [<c0218ebc>] (__schedule+0xd0/0x37c)
 r4:00000001
[<c0218dec>] (__schedule+0x0/0x37c) from [<c02194cc>] (schedule+0x74/0x78)
[<c0219458>] (schedule+0x0/0x78) from [<c0022100>] (do_exit+0x640/0x670)
[<c0021ac0>] (do_exit+0x0/0x670) from [<c001222c>] (die+0x2bc/0x2fc)
[<c0011f70>] (die+0x0/0x2fc) from [<c0013808>] (__do_kernel_fault+0x70/0x90)
[<c0013798>] (__do_kernel_fault+0x0/0x90) from [<c0013b58>] (do_page_fault+0x330/0x354)
 r8:c708cb00 r7:bf05b504 r6:c70bdea8 r5:a0000013 r4:c02d5ccc
[<c0013828>] (do_page_fault+0x0/0x354) from [<c0008634>] (do_DataAbort+0x3c/0x9c)
[<c00085f8>] (do_DataAbort+0x0/0x9c) from [<c000e458>] (__dabt_svc+0x38/0x60)
Exception stack(0xc70bdea8 to 0xc70bdef0)
dea0:                   bf05b4a0 00000000 00000000 00000001 bf05b4a0 c79a0120
dec0: c02e1de0 c79257a0 c7803a00 c0114700 00000000 c70bdf0c c70bdf10 c70bdef0
dee0: c01146f4 c011460c a0000013 ffffffff
 r8:c7803a00 r7:c70bdedc r6:ffffffff r5:a0000013 r4:c011460c
[<c01145f4>] (kobject_put+0x0/0x7c) from [<c01146f4>] (kobject_del+0x64/0x70)
 r4:c79a0100
[<c0114690>] (kobject_del+0x0/0x70) from [<c01147f0>] (kobject_delayed_cleanup+0xf0/0x198)
 r4:c79a0100
[<c0114700>] (kobject_delayed_cleanup+0x0/0x198) from [<c00318fc>] (process_one_work+0x24c/0x3a8)
 r7:00000009 r6:00000000 r5:c785fd00 r4:c79a0120
[<c00316b0>] (process_one_work+0x0/0x3a8) from [<c0032570>] (worker_thread+0x20c/0x428)
[<c0032364>] (worker_thread+0x0/0x428) from [<c0037768>] (kthread+0x88/0x90)
[<c00376e0>] (kthread+0x0/0x90) from [<c0021ac0>] (do_exit+0x0/0x670)
 r7:00000013 r6:c0021ac0 r5:c00376e0 r4:c7839edc
Code: e1a0c00d e92dd800 e24cb004 e5903128 (e5130004) 
---[ end trace ddf7f4f6a0de23bb ]---
