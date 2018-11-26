From: tpiepho@impinj.com (Trent Piepho)
Date: Mon, 26 Nov 2018 17:09:29 +0000
Subject: iMX6 PCIe MSI issues
In-Reply-To: <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
 <CAOMZO5DuZ4ZWk03tnsTx=Vpd8AbnCADMgyyKRuL0F6N3ZmN6qw@mail.gmail.com>
Message-ID: <1543252169.18519.49.camel@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a bug that appeared in 4.14 that will result in an MSI getting
dropped if it occurs during or shortly after that/another MSI interrupt
handler is run.  Obviously, then means one needs to get at least one
MSI to work in the first place to see the bug!

Robert's description also has MSI status set in dwc msi status register
(0x830), that would not be the case for the MSI race.

An interrupt is only passed up to the GIC on a 0->1 transition in the
dwc msi status bit.  We see it's a 1 now, but was the GIC interrupt
enabled when the transition happened?  It's not said below if that was
checked.

Try clearing the status (write a *1* to the bit clear it) in the dwc
msi status register, check that it is now zero, and then see if another
MSI causes it to become set, and does that make it to the GIC?

If it does become set, but no irq to the GIC, then I have no idea what
is there to stop it.  This part of the chip is not documented well.

Also, I think the new irq domain stuff in 4.17 breaks irq accounting to
the GIC chain interrupt (152) to the dwc msi domain.  It'll always show
as zero in /proc/interrupts.  But I've mostly been working in 4.16 so
I'm not sure about the precise interaction of irq domains and
/proc/interrupts yet.

On Mon, 2018-11-26 at 14:31 -0200, Fabio Estevam wrote:
> Adding Trent and Tim (as I think they managed to fix some imx6 MSI
> issues)
> 
> On Fri, Nov 23, 2018 at 8:17 PM Robert Hancock <hancock@sedsystems.ca
> > wrote:
> > 
> > I am working with a custom FPGA PCI Express endpoint connected to
> > an NXP
> > iMX6D processor running the 4.19.2 kernel. It seems happy using
> > INTx
> > interrupts but when trying to enable MSI the device driver is not
> > receiving any interrupts.
> > 
> > From some register poking I have figured out:
> > -the MSI address set on the PCIe device is correctly set in the iMX
> > MSI
> > controller's MSI Controller Address register (0x1ffc820)
> > -the interrupt vectors are enabled in the MSI controller's
> > Interrupt
> > Enable register (0x1ffc828)
> > -the interrupt vectors are not masked in the MSI controller's
> > Interrupt
> > Mask register (0x1ffc82c)
> > -The MSI controller's Interrupt Status register (0x1ffc830) shows
> > that
> > the requested interrupt vectors are pending
> > -In the ARM GIC, vector 152 (for msi_ctrl_int) is enabled in the IS
> > enable register (0x00a01110), but not set in the IS pending
> > (0x00a01210)
> > or IS active (0x00a01310) registers
> > -Vector 152 is not masked in the GPC interrupt mask (0x00a01310)
> > -Vector 152 is not active in the GPC interrupt status (0x00a01310)
> > 
> > So it appears the MSI controller is receiving and recognizing the
> > MSI
> > from the device, but the interrupt is not making it into the GIC
> > for
> > some reason. If I manually set vector 152 to pending in the GIC,
> > the
> > dw_handle_msi_irq handler in pci-designware-host.c does get called
> > along
> > with the interrupt handler(s) for the PCIe device, so it appears
> > the
> > chain from that point on is working:
> > 
> > # devmem 0x00a01210 32 0x1000000
> > 
> > I found someone else reporting this in 2014 with an unknown kernel
> > version on the NXP forums here, but with no resolution listed
> > there:
> > 
> > https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fco
> > mmunity.nxp.com%2Fthread%2F318307&amp;data=02%7C01%7Ctpiepho%40impi
> > nj.com%7Cb1e4af4c58704651bc4e08d653bcaabe%7C6de70f0f73574529a415d8c
> > bb7e93e5e%7C0%7C0%7C636788467119945424&amp;sdata=I1b%2BZ1L99MErNA44
> > JlffTejqZlFSWhSkLeSFmv830Rg%3D&amp;reserved=0
> > 
> > Any ideas on what may be going wrong? My next step may be to try an
> > older kernel version to see if this got broken at some point.
> > 
> > --
> > Robert Hancock
> > Senior Software Developer
> > SED Systems
> > Email: hancock at sedsystems.ca
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > https://na01.safelinks.protection.outlook.com/?url=http%3A%2F%2Flis
> > ts.infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> > kernel&amp;data=02%7C01%7Ctpiepho%40impinj.com%7Cb1e4af4c58704651bc
> > 4e08d653bcaabe%7C6de70f0f73574529a415d8cbb7e93e5e%7C0%7C0%7C6367884
> > 67119945424&amp;sdata=6jndN8yOGxm60y%2B2fUuWTZnNvAs967PL6KnoncXyb6w
> > %3D&amp;reserved=0
