From: david@gibson.dropbear.id.au (David Gibson)
Date: Tue, 21 Jun 2011 11:40:59 +1000
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612112219.GD16318@ibawizard.net>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612112219.GD16318@ibawizard.net>
Message-ID: <20110621014059.GN16214@yookeroo.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 01:22:19PM +0200, Petr ?tetiar wrote:
> Shawn Guo <shawn.guo@freescale.com> [2011-06-12 16:34:15]:
> 
> > On Sun, Jun 12, 2011 at 09:15:41AM +0100, Russell King - ARM Linux wrote:
> > > 
> > > One thing which has been bugging me for some time is that the DT stuff
> > > completely overrides the ATAGs.  This is wrong with solutions like this.
> > > 
> > > We have a set of perfectly good boot loaders which provide correct
> > > information to the kernel via ATAGs.  If we start moving everything
> > > over to DT, then we run into a problem because the ATAGs are ignored -
> > > stuff such as the RAM size and command line passed from the boot loader
> > > will be entirely ignored, instead these having to be encoded into the
> > > kernel at build time.
> > > 
> > What u-boot does right now is replacing the parameters in dtb with
> > its for those it's interested in, for example command line is one,
> > before it passes dtb to kernel.
> 
> If I understand it all correctly, there must be some 'legacy bootloader
> support' added to the kernel, layer which would convert the ATAGs to the DT.
> Or something like that.

More likely combine the ATAGs information with a skeleton DT, but yes,
you probably want something like this.  On powerpc, this role is
usually taken by the zImage wrapper code, sitting between the platform
firmware and the kernel proper.  However, there's no inherent reason
it couldn't be early code in the vmlinux instead.  Just as long as
there is a well defined point after which the DT information is
authoritative.

> Please note, that there are some boards out there, which use some kind of
> proprietary bootloaders, so you can't update or change them easily. You either
> don't have source code, you're limited by the available space (2KB eeprom) so
> you can't add much more things into that bootloader or you're limited by the
> size of the MBR (yes, even such bootloaders exists).

Right.  Sams situation on powerpc - and indeed there are lots of
crappy proprietary bootloaders each with their own whacky way of
conveying the scraps of information they give you.  For this reason we
have a variety of platform-specific bootwrappers which handle these
bootloaders, transforming their information into DT form for the
kernel proper to consume.

No reason you can't do the same thing on ARM, whether the glue
wrappers are wrappers as such, or special early pieces of kernel code.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
