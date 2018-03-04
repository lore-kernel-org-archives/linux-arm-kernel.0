From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 4 Mar 2018 19:42:29 +0100
Subject: Bug#887873: linux-image-4.9.0-5-marvell: frequent "usercopy:
 kernel memory overwrite attempt detected" on QNAP NAS (ARM)
In-Reply-To: <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
References: <151652931598.757.4527606947579667082.reportbug@massive.lan>
 <20180304174157.ajom7whbo7pr3qb4@jirafa.cyrius.com>
Message-ID: <20180304184229.GC21710@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2018 at 06:41:57PM +0100, Martin Michlmayr wrote:
> A Debian user reported the following issue on QNAP TS-119P II with
> 4.9.65:
> 
> * Menno Finlay-Smits <inbox@menno.io> [2018-01-21 23:08]:
> > Rsyncing files between 2 HDDs on a QNAP 119p with a fresh, minimal install of
> > stretch NAS (armel) causes the kernel to fail after ~20mins with a kernel
> > memory overwrite attempt (full error below). 
> > 
> > This happens reliably for any large rsync attempt. I have about 1TB of data to
> > copy between these 2 HDDs and have not managed to copy more than ~2% of the
> > total amount.
> > 
> > ** Kernel log:
> > 
> > [ 2775.213733] usercopy: kernel memory overwrite attempt detected to c29454e0 (<wrapped address>) (4294802208 bytes)

Not seen this before.

My first thought is that this actually looks like a userspace
problem. Userspace is passing 4294802208 bytes to the kernel. But the
kernel should of already sanity checked that before trying to copy it
into kernel space. This is also a Unix domain socket, which sounds odd
for rsync. And this is all generic code, nothing specific to kirkwood.

Has there been any similar reports on other targets?

    Andrew

> > [ 2775.224095] ------------[ cut here ]------------
> > [ 2775.228728] kernel BUG at /build/linux-myVvPm/linux-4.9.65/mm/usercopy.c:75!
> > [ 2775.235800] Internal error: Oops - BUG: 0 [#1] ARM
> > [ 2775.240604] Modules linked in: marvell ehci_orion mvmdio mv643xx_eth ehci_hcd of_mdio fixed_phy xhci_pci xhci_hcd marvell_cesa des_generic sg usbcore libphy m25p80 spi_nor orion_wdt usb_common kirkwood_thermal evdev gpio_keys ip_tables x_tables ipv6 autofs4 ext4 crc16 jbd2 crc32c_generic fscrypto ecb mbcache sd_mod sata_mv libata scsi_mod
> > [ 2775.271023] CPU: 0 PID: 601 Comm: rsync Not tainted 4.9.0-5-marvell #1 Debian 4.9.65-3+deb9u2
> > [ 2775.279582] Hardware name: Marvell Kirkwood (Flattened Device Tree)
> > [ 2775.285870] task: c0d496c0 task.stack: d5ffe000
> > [ 2775.290418] PC is at __check_object_size+0x120/0x1d8
> > [ 2775.295401] LR is at __check_object_size+0x120/0x1d8
> > [ 2775.300382] pc : [<c0111908>]    lr : [<c0111908>]    psr: 60000013
> >                sp : d5fffdb8  ip : 00000000  fp : d5ffff08
> > [ 2775.311908] r10: d5ffe000  r9 : fffd7b20  r8 : c29454e0
> > [ 2775.317148] r7 : c291d000  r6 : 00000000  r5 : fffd7b20  r4 : c29454e0
> > [ 2775.323697] r3 : c0554fa0  r2 : c055a20c  r1 : c055094c  r0 : 00000065
> > [ 2775.330247] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> > [ 2775.337405] Control: 0005397f  Table: 14810000  DAC: 00000051
> > [ 2775.343168] Process rsync (pid: 601, stack limit = 0xd5ffe190)
> > [ 2775.349020] Stack: (0xd5fffdb8 to 0xd6000000)
> > [ 2775.353390] fda0:                                                       c04623b8 fffd7b20
> > [ 2775.361598] fdc0: 000294e8 fffd7b20 00001000 d5fffec0 c29454e0 c0202360 00000008 008eafe8
> > [ 2775.369812] fde0: dfc4a380 c291c000 00000051 69000008 d5fffec0 00008000 00000008 00000008
> > [ 2775.378026] fe00: 00001000 00000000 c0c26b40 00001008 c0495cf7 c02fc3d0 c0c26b40 d5fffec0
> > [ 2775.386240] fe20: d5fffec0 00000000 00008008 c0c26b40 df782d80 d5fffeb8 00000001 00000000
> > [ 2775.394445] fe40: df782b40 c03a21d0 d5fffe64 00000003 de65b2c0 00008000 00000008 00008008
> > [ 2775.402651] fe60: 5a644f89 00000000 00000000 00000000 00000000 ffffffff ffffffff 00000000
> > [ 2775.410866] fe80: d2bebb80 d5fffeb8 de65b2c0 de65b2c0 df79caa0 008c1b00 d5ffe000 00000000
> > [ 2775.419080] fea0: 00512e6c c02ee92c d5ffff10 d5ffff28 de65b2c0 c02ee9cc 00000000 00000000
> > [ 2775.427294] fec0: 00000001 00000008 00008000 d5ffff08 00000001 3b9aa9ee 00000000 00000000
> > [ 2775.435499] fee0: 00000040 d5ffff28 00000000 00000000 df79caa0 d5ffff88 00008008 c0114048
> > [ 2775.443705] ff00: 00008008 00000000 008c1b00 00008008 00000001 00000000 00008008 d5ffff08
> > [ 2775.451909] ff20: 00000001 3b9aa9ee df79caa0 00000000 00000000 00000000 00000000 00000000
> > [ 2775.460116] ff40: 00000000 00000000 00000000 df79caa0 00008008 00000000 d5ffff88 c0114cb4
> > [ 2775.468321] ff60: df79caa0 008c1b00 00008008 df79caa0 df79caa0 008c1b00 00008008 c000f704
> > [ 2775.476527] ff80: d5ffe000 c0115b68 00000000 00000000 00008008 00512e6c bedfb878 bedfb7f8
> > [ 2775.484733] ffa0: 00000004 c000f560 00512e6c bedfb878 00000004 008c1b00 00008008 008c1b00
> > [ 2775.492947] ffc0: 00512e6c bedfb878 bedfb7f8 00000004 00520a80 00512e84 0051095c 00512e6c
> > [ 2775.501161] ffe0: 00000000 bedfb69c 004c6978 b6ea3d1c 40000010 00000004 0000624f 0000624f
> > [ 2775.509384] [<c0111908>] (__check_object_size) from [<c0202360>] (copy_page_from_iter+0x2e8/0x3d0)
> > [ 2775.518388] [<c0202360>] (copy_page_from_iter) from [<c02fc3d0>] (skb_copy_datagram_from_iter+0xfc/0x188)
> > [ 2775.527997] [<c02fc3d0>] (skb_copy_datagram_from_iter) from [<c03a21d0>] (unix_stream_sendmsg+0x208/0x2f8)
> > [ 2775.537691] [<c03a21d0>] (unix_stream_sendmsg) from [<c02ee92c>] (sock_sendmsg+0x3c/0x50)
> > [ 2775.545903] [<c02ee92c>] (sock_sendmsg) from [<c02ee9cc>] (sock_write_iter+0x8c/0xb4)
> > [ 2775.553771] [<c02ee9cc>] (sock_write_iter) from [<c0114048>] (new_sync_write+0xc0/0xe4)
> > [ 2775.561810] [<c0114048>] (new_sync_write) from [<c0114cb4>] (vfs_write+0xc0/0x194)
> > [ 2775.569414] [<c0114cb4>] (vfs_write) from [<c0115b68>] (SyS_write+0x44/0x7c)
> > [ 2775.576497] [<c0115b68>] (SyS_write) from [<c000f560>] (ret_fast_syscall+0x0/0x38)
> > [ 2775.584098] Code: e59f10a0 01a01000 e59f009c ebff04bf (e7f001f2)
> > [ 2775.590218] ---[ end trace 9c6c6370c712b384 ]---
> 
> > 
> > ** Network status:
> > *** IP interfaces and addresses:
> > 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
> >     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >     inet 127.0.0.1/8 scope host lo
> >        valid_lft forever preferred_lft forever
> >     inet6 ::1/128 scope host 
> >        valid_lft forever preferred_lft forever
> > 2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
> >     link/ether 00:08:9b:c8:50:26 brd ff:ff:ff:ff:ff:ff
> >     inet 192.168.164.3/24 brd 192.168.164.255 scope global eth0
> >        valid_lft forever preferred_lft forever
> >     inet6 fe80::208:9bff:fec8:5026/64 scope link 
> >        valid_lft forever preferred_lft forever
> > 
> > *** Device statistics:
> > Inter-|   Receive                                                |  Transmit
> >  face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
> >     lo:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
> >   eth0:  667374    2622    0    0    0     0          0         0   420218    1869    0    0    0     0       0          0
> > 
> 
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
