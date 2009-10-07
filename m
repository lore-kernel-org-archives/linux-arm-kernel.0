From: marco.hoefle@nanotronic.ch (hoefle marco)
Date: Wed, 07 Oct 2009 13:45:55 +0200
Subject: Kernel update to 2.6.31.1 on pxa270: udev and usb storage
	cause kernel Oops
In-Reply-To: <20091005225222.GB792@kroah.com>
References: <1254213562.5586.13.camel@wks02-lin.nanotronic.local>
	<20091003124832.GA15525@n2100.arm.linux.org.uk>
	<20091005225222.GB792@kroah.com>
Message-ID: <1254915955.26123.7.camel@wks02-lin.nanotronic.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2009-10-05 at 15:52 -0700, Greg KH wrote:
> On Sat, Oct 03, 2009 at 01:48:32PM +0100, Russell King - ARM Linux wrote:
> > I think you need to report this to the USB/udev people.
> > 
> > On Tue, Sep 29, 2009 at 10:39:22AM +0200, hoefle marco wrote:
> > > Hello,
> > > we use Kernel 2.6.30.4 on a PXA270 platform (from Phytec). It works good
> > > with all peripherals on the Phytec board. 
> > > For an old Sandisk device (diskonchip) we have a driver ported to 2.6.3x
> > > as the block device driver API has changed. We thought it will be a wise
> > > decision to do the porting already to 2.6.3x. 
> > > However, when using the latest Kernel (and the previous one 2.6.30) with
> > > all the drivers we used in 2.6.30.4 udev and usb storage seem not to
> > > work any more.
> > > Does anybody have an idea why?

It looks that more things which worked with 2.6.30.4 do not work with
the latest stable 2.6.31.2 kernel. I get also a Kernel oops when
rebooting the system.

What I did to get there:
I disabled udevd and made the important device nodes static. This
allowed to boot into the system. I also disabled unnecessary things like
USB support and the tffs disk-on-chip driver.
Starting udevd manually does cause the same kernel oops as described at
the beginning of this thread.

In addition I get that oops when rebooting the system:

/ # reboot
The system is going down NOW!
Sending SIGTERM to all processes
Sending SIGKILL to all processes
Requesting system reboot
Unable to handle kernel paging request at virtual address 20726590
pgd = c39a0000
[20726590] *pgd=00000000
Internal error: Oops: f5 [#2]
Modules linked in:
CPU: 0    Tainted: G      D     (2.6.31.2 #3)
PC is at device_shutdown+0x34/0xbc
LR is at kernel_restart_prepare+0x2c/0x3c
pc : [<c0159314>]    lr : [<c00466b0>]    psr: 20000013
sp : c39c9e4c  ip : c39c9e64  fp : c39c9e60
r10: 40025000  r9 : c39c8000  r8 : c0022064
r7 : 00000000  r6 : fee1dead  r5 : c02f5ca0  r4 : 3d207955
r3 : 20726570  r2 : c3802c60  r1 : c001e308  r0 : c001e308
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 0000397f  Table: a39a0000  DAC: 00000015
Process init (pid: 456, stack limit = 0xc39c8270)
Stack: (0xc39c9e4c to 0xc39ca000)
9e40:                            00000000 28121969 c39c9e70 c39c9e64
c00466b0 
9e60: c01592ec c39c9e84 c39c9e74 c0046700 c0046690 01234567 c39c9fa4
c39c9e88 
9e80: c0046820 c00466f8 c389a1ec 00000001 c389a0d8 c39c9eb8 c39c9ea4
c0032d38 
9ea0: c0032c10 00000005 bd05720b 0087e0c1 00000000 c389a10c c389a0e0
00000000 
9ec0: c389a0e0 c389a1ec 00000001 c389a0d8 c39c9f00 c39c9ee0 c0033914
c003199c 
9ee0: 00000000 c383f0d4 c02cbba0 c39c9f20 c39c9efc c004f6dc c00261a4
c39d001c 
9f00: c389a0e0 00000015 c389a0e0 c389a1ec c383f0a0 c39c9f34 c39c9f24
c004f7b4 
9f20: c004f6b4 00000000 c39c9f68 c39c9f38 c0021e80 c004f7a0 c389a268
c39c8000 
9f40: 00000011 c389a0e0 c39c9f6c c389a1ec c389a1ec 00000001 c389a0d8
c39c9f80 
9f60: c39c9f6c c003ad84 c022a2b8 c39c9f6c c39c9f6c c39c9f94 c39c9f84
c003ae48 
9f80: c003a800 c39c8000 00000000 00000000 00000000 00000058 00000000
c39c9fa8 
9fa0: c0021ec0 c0046758 00000000 00000000 fee1dead 28121969 01234567
00000000 
9fc0: 00000000 00000000 00000000 000c3c20 00000000 00000001 40025000
00000064 
9fe0: 000c3418 befb3a70 00092364 4015c01c 60000010 fee1dead 00000000
00000000 
Backtrace: 
[<c01592e0>] (device_shutdown+0x0/0xbc) from [<c00466b0>]
(kernel_restart_prepare+0x2c/0x3c)
 r5:28121969 r4:00000000
[<c0046684>] (kernel_restart_prepare+0x0/0x3c) from [<c0046700>]
(kernel_restart+0x14/0x48)
[<c00466ec>] (kernel_restart+0x0/0x48) from [<c0046820>] (sys_reboot
+0xd4/0x1ac)
 r4:01234567
[<c004674c>] (sys_reboot+0x0/0x1ac) from [<c0021ec0>] (ret_fast_syscall
+0x0/0x2c)
 r7:00000058 r6:00000000 r5:00000000 r4:00000000
Code: ea00000f e5913040 e3530000 0a000002 (e5933020) 
---[ end trace c0e3a36da3f952db ]---

 
