From: inbox@menno.io (Menno Finlay-Smits)
Date: Wed, 07 Mar 2018 16:58:40 +1300
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <1520297697.4117371.1292731088.7BEDFAAE@webmail.messagingengine.com>
References: <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
 <20180304204115.GD21710@lunn.ch>
 <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180305142846.GJ25189@lunn.ch> <1520265474.2408.8.camel@debian.org>
 <1520297697.4117371.1292731088.7BEDFAAE@webmail.messagingengine.com>
Message-ID: <1520395120.2285859.1294250416.5E5FC747@webmail.messagingengine.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2018, at 13:54, Menno Finlay-Smits wrote:
> On Tue, 6 Mar 2018, at 04:57, Yves-Alexis Perez wrote:
> > On Mon, 2018-03-05 at 15:28 +0100, Andrew Lunn wrote:
> > > Would it be possible to try to reproduce this problem with 4.9.86 on
> > > the hardware reporting the issue?
> > 
> > 4.9.82-1+deb9u3 is currently in the archive. Menno, could you give it a shot?
> 
> Will do. I need to get the NAS back to running Scratch as I went back to 
> Jessie for comparison (similar looking problems there too) but I'll get 
> it done as soon as I can.
> 
> Also, I can confirm that I was indeed copying from an external USB disk 
> with just "rsync -av <source> <dest>".

The problem still happens with 4.9.82-1+deb9u3.

Here's the dump:

[  675.800163] usercopy: kernel memory overwrite attempt detected to c08f83a0 (<wrapped address>) (4294933600 bytes)
[  675.810513] ------------[ cut here ]------------
[  675.815144] kernel BUG at /build/linux-nLLkbA/linux-4.9.82/mm/usercopy.c:75!
[  675.822215] Internal error: Oops - BUG: 0 [#1] ARM
[  675.827020] Modules linked in: ses enclosure scsi_transport_sas uas usb_storage marvell ehci_orion mv643xx_eth mvmdio of_mdio ehci_hcd fixed_phy marvell_cesa libphy des_generic xhci_pci xhci_hcd sg usbcore orion_wdt usb_common m25p80 spi_nor kirkwood_thermal evdev gpio_keys sunrpc ip_tables x_tables ipv6 autofs4 ext4 crc16 jbd2 crc32c_generic fscrypto ecb mbcache sd_mod sata_mv libata scsi_mod
[  675.862376] CPU: 0 PID: 2050 Comm: rsync Not tainted 4.9.0-6-marvell #1 Debian 4.9.82-1+deb9u3
[  675.871022] Hardware name: Marvell Kirkwood (Flattened Device Tree)
[  675.877310] task: c0af32c0 task.stack: c0a7e000
[  675.881857] PC is at __check_object_size+0x120/0x1d8
[  675.886840] LR is at __check_object_size+0x120/0x1d8
[  675.891821] pc : [<c0111d84>]    lr : [<c0111d84>]    psr: 60000013
               sp : c0a7fdb8  ip : 00000000  fp : c0a7ff08
[  675.903339] r10: c0a7e000  r9 : ffff7c60  r8 : c08f83a0
[  675.908579] r7 : c08f0000  r6 : 00000000  r5 : ffff7c60  r4 : c08f83a0
[  675.915128] r3 : c0555080  r2 : c055a3a4  r1 : c05509f0  r0 : 00000065
[  675.921677] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  675.928835] Control: 0005397f  Table: 00b44000  DAC: 00000051
[  675.934599] Process rsync (pid: 2050, stack limit = 0xc0a7e190)
[  675.940538] Stack: (0xc0a7fdb8 to 0xc0a80000)
[  675.944908] fda0:                                                       c04634c4 ffff7c60
[  675.953116] fdc0: 000103a8 ffff7c60 00008000 c0a7fec0 c08f83a0 c0202dd0 00000008 00cfbff0
[  675.961329] fde0: dfc09d00 c08e8000 00000051 00000008 c0a7fec0 00008000 00000008 00000008
[  675.969535] fe00: 00008000 00000000 dead4e40 00008008 c0496ed1 c02fcf5c dead4e40 c0a7fec0
[  675.977749] fe20: c0a7fec0 00000000 00008008 dead4e40 c08be920 c0a7feb8 00000001 00000000
[  675.985964] fe40: c08beb60 c03a2f80 c0a7fe64 00000003 dec8e2e0 00008000 00000008 00008008
[  675.994178] fe60: 5a9f1704 00000000 00000000 00000000 00000000 ffffffff ffffffff 00000000
[  676.002392] fe80: c0ace700 c0a7feb8 dec8e2e0 dec8e2e0 c0a892a0 00cebc48 c0a7e000 00000000
[  676.010607] fea0: 00511e6c c02ef4a8 c0a7ff10 c0a7ff28 dec8e2e0 c02ef548 00000000 00000000
[  676.018821] fec0: 00000001 00000008 00008000 c0a7ff08 00000001 3b9a9904 00000000 00000000
[  676.027035] fee0: 00000040 c0a7ff28 00000000 00000000 c0a892a0 c0a7ff88 00008008 c01144c0
[  676.035249] ff00: 00008008 00000000 00cebc48 00008008 00000001 00000000 00008008 c0a7ff08
[  676.043454] ff20: 00000001 3b9a9904 c0a892a0 00000000 00000000 00000000 00000000 00000000
[  676.051660] ff40: 00000000 00000000 00000000 c0a892a0 00008008 00000000 c0a7ff88 c011512c
[  676.059865] ff60: c0a892a0 00cebc48 00008008 c0a892a0 c0a892a0 00cebc48 00008008 c000f724
[  676.068071] ff80: c0a7e000 c0115fe0 00000000 00000000 00008008 00511e6c bef86848 bef867c8
[  676.076277] ffa0: 00000004 c000f560 00511e6c bef86848 00000004 00cebc48 00008008 00cebc48
[  676.084490] ffc0: 00511e6c bef86848 bef867c8 00000004 0051fa80 00511e84 0050f95c 00511e6c
[  676.092696] ffe0: 00000000 bef8666c 004c5978 b6ef7d1c 40000010 00000004 1fffd871 1fffdc71
[  676.100910] [<c0111d84>] (__check_object_size) from [<c0202dd0>] (copy_page_from_iter+0x2e8/0x3d0)
[  676.109915] [<c0202dd0>] (copy_page_from_iter) from [<c02fcf5c>] (skb_copy_datagram_from_iter+0xfc/0x188)
[  676.119524] [<c02fcf5c>] (skb_copy_datagram_from_iter) from [<c03a2f80>] (unix_stream_sendmsg+0x208/0x2f8)
[  676.129218] [<c03a2f80>] (unix_stream_sendmsg) from [<c02ef4a8>] (sock_sendmsg+0x3c/0x50)
[  676.137430] [<c02ef4a8>] (sock_sendmsg) from [<c02ef548>] (sock_write_iter+0x8c/0xb4)
[  676.145297] [<c02ef548>] (sock_write_iter) from [<c01144c0>] (new_sync_write+0xc0/0xe4)
[  676.153337] [<c01144c0>] (new_sync_write) from [<c011512c>] (vfs_write+0xc0/0x194)
[  676.160941] [<c011512c>] (vfs_write) from [<c0115fe0>] (SyS_write+0x44/0x7c)
[  676.168023] [<c0115fe0>] (SyS_write) from [<c000f560>] (ret_fast_syscall+0x0/0x44)
[  676.175625] Code: e59f10a0 01a01000 e59f009c ebff0495 (e7f001f2)
[  676.181748] ---[ end trace 09357b62c70de3ea ]---

What else can I try? There doesn't appear to be a newer kernel in proposed right now.

- Menno
