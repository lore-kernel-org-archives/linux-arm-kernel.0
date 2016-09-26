From: jason.jin@nxp.com (Jason Jin)
Date: Mon, 26 Sep 2016 09:58:35 +0000
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <4642389.nHAzKPNi96@wuerfel>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <2519047.ijr708V79a@wuerfel>
 <VI1PR0401MB263894265429130B91E7880C8DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
 <4642389.nHAzKPNi96@wuerfel>
Message-ID: <DB4PR04MB26568C0647A1C01F0CA98B9E9CD0@DB4PR04MB265.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
> platforms
> 
> On Friday, September 23, 2016 4:09:29 PM CEST Stuart Yoder wrote:
> > > -----Original Message-----
> > > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > > Sent: Friday, September 23, 2016 10:58 AM
> 
> > > > Really, though, the firmware call thing is an incredibly niche use-case.
> > > > Beyond development, the only real benefit of starting an AArch32
> > > > kernel in Hyp is that you can run AArch32 KVM guests, which you
> > > > can do equally well (if not better) under an AArch64 kernel.
> > >
> > > This was my question earlier in the thread, apparently Alison has
> > > another use case in mind, but I don't yet know what that is. If that
> > > use case is important enough, we could do it this way.
> > >
> > > The only use case I can think of at the moment is boot testing on
> > > kernelci.org, which could be used to check whether all the drivers
> > > work in 32-bit environments.
> >
> > The reason we want aarch32 kernel support is for specific customers
> > that have requirements for legacy 32-bit kernel drivers that function
> > on ARMv7 but for some reason are very problematic to port to a 64-bit
> > kernel.  So, the way to ease the 64-bit transition is allow them to run an
> aarch32 kernel
> > and their driver on an ARMv8 SoC.   I don't think we specifically care
> > whether the kernel starts at EL2 or EL1.
> 
> Thanks for the explanation. Unfortunately I don't think that helps get this
> approach upstream, in particular I wouldn't want to add a platform specific
> hack just to help a third party not have to fix their out-of-tree drivers to be 64-
> bit clean.
> 
> If your customer already has a chunk of downstream patches large enough to
> be problematic to rebuild for 64-bit, they should be able to also pick up these
> two patches, but of course what we really want is to get drivers upstream and
> fixed (presumably this would be an even larger task than just fixing them, so I
> don't set my hopes too high here).
> 
> I'm still not opposed to making *all* 64-bit platforms available to 32-bit kernels
> for testing purposes though, and that would solve the customer problem too,
> as would the approach of encapsulating the kernel in hypervisor stub that
> implements the PSCI calls and using MACH_VIRT with the respective layerscape
> drivers enabled.
> 
[Jason] Thanks for all the comments regarding to the ARMv8 32bit kernel patches.
 I'd like to provide some comment from this thread.

To run the 32bit kernel on ARMv8, we also provided some patches to u-boot. The
same U-boot image will be used to boot up the 64bit and 32bit kernel. With u-boot
patches, bootm will automatically identify the kernel image, if it's 32bit kernel image,
u-boot will change the ES to AArch32 EL2 and boot up the 32bit kernel. So we do
not need to wrap the 32bit image with 64bit bootup protocol.

Our FW set the u-boot to EL2 and did not have the 'NEW' SMC call to switch the 
AArch64(EL2) to AArch32(EL2) at this moment, so this patch set did not rely on
the FW and did not  implement the PSCI for secondary core bootup.

I agree with Robin that maybe it's not necessary to support the Hyp for ARMv8 AArch32,
so we can boot up the 32bit kernel with EL1 directly. With this assumption, I think we
can switch to FW and PSCI for SMP easily and drop the spin table patches.

Thanks all for the suggestion. We'll try the "Generic DT based system" instead of
introducing a new platform to support the 32bit kernel. And rely on the dtb built
from ARM64 to bootup the system. Not sure at this moment if some minor update
patches still needed for ARMv8.

Jason
> 	Arnd
