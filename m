From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Sep 2016 20:22:58 +0200
Subject: [PATCH 1/2] armv8: aarch32: Execute 32-bit Linux for LayerScape
 platforms
In-Reply-To: <VI1PR0401MB263894265429130B91E7880C8DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
References: <1474597146-33312-1-git-send-email-b18965@freescale.com>
 <2519047.ijr708V79a@wuerfel>
 <VI1PR0401MB263894265429130B91E7880C8DC80@VI1PR0401MB2638.eurprd04.prod.outlook.com>
Message-ID: <4642389.nHAzKPNi96@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, September 23, 2016 4:09:29 PM CEST Stuart Yoder wrote:
> > -----Original Message-----
> > From: Arnd Bergmann [mailto:arnd at arndb.de]
> > Sent: Friday, September 23, 2016 10:58 AM

> > > Really, though, the firmware call thing is an incredibly niche use-case.
> > > Beyond development, the only real benefit of starting an AArch32 kernel
> > > in Hyp is that you can run AArch32 KVM guests, which you can do equally
> > > well (if not better) under an AArch64 kernel.
> > 
> > This was my question earlier in the thread, apparently Alison has
> > another use case in mind, but I don't yet know what that is. If
> > that use case is important enough, we could do it this way.
> > 
> > The only use case I can think of at the moment is boot testing
> > on kernelci.org, which could be used to check whether all the drivers
> > work in 32-bit environments.
> 
> The reason we want aarch32 kernel support is for specific customers that
> have requirements for legacy 32-bit kernel drivers that function on ARMv7
> but for some reason are very problematic to port to a 64-bit kernel.  So,
> the way to ease the 64-bit transition is allow them to run an aarch32 kernel
> and their driver on an ARMv8 SoC.   I don't think we specifically care
> whether the kernel starts at EL2 or EL1.

Thanks for the explanation. Unfortunately I don't think that helps
get this approach upstream, in particular I wouldn't want to add
a platform specific hack just to help a third party not have to fix
their out-of-tree drivers to be 64-bit clean.

If your customer already has a chunk of downstream patches large
enough to be problematic to rebuild for 64-bit, they should be able
to also pick up these two patches, but of course what we really
want is to get drivers upstream and fixed (presumably this would
be an even larger task than just fixing them, so I don't set my
hopes too high here).

I'm still not opposed to making *all* 64-bit platforms available
to 32-bit kernels for testing purposes though, and that would solve
the customer problem too, as would the approach of encapsulating
the kernel in hypervisor stub that implements the PSCI calls
and using MACH_VIRT with the respective layerscape drivers enabled.

	Arnd
