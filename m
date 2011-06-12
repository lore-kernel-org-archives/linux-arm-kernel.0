From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 12:58:20 +0100
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612112219.GD16318@ibawizard.net>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612112219.GD16318@ibawizard.net>
Message-ID: <20110612115820.GF10283@n2100.arm.linux.org.uk>
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
> 
> Please note, that there are some boards out there, which use some kind of
> proprietary bootloaders, so you can't update or change them easily. You either
> don't have source code, you're limited by the available space (2KB eeprom) so
> you can't add much more things into that bootloader or you're limited by the
> size of the MBR (yes, even such bootloaders exists).

Exactly my point - I have quite a number of platforms here which will
never be able to have a boot loader capable of modifying a DT blob for
the kernel.

One of the points of Nicolas' patch set is to allow existing boot loaders
to boot kernels where the hardware description is contained in a DT blob
encapsulated with the kernel.  That's great but the way things are currently
setup, it means that the boot loader does nothing more than loading and
executing - and we lose the _existing_ flexibility for the boot loader to
pass platform specific information to the kernel.

So, what I'm considering to do is update the boot protocol such that the
base address of the DT blob is provided in r3, separately from the ATAG
pointer in r2.

This means that boot loaders can provide a DT blob (r2 = 0 r3 => DT) or
they can provide ATAGs (r2 => atag, r3 = indeterminant).  We can then
cater for the situation where we have an ATAG boot loader, but a kernel
with an appended DT description (r2 => atag, r3 => DT) and have the ATAG
information override the DT for things like memory layout and the command
line string.

This is the only sensible way of maintaining compatibility with the
existing boot protocol, which is an absolute _must_ if we are going to
convert some of the existing SoCs (like PXA) to DT and get rid of the
legacy static descriptions of the on-board devices (which is the whole
point we're going down this path.)

It's either that or we'll have to refuse to convert existing SoCs to
DT to maintain compatibility for existing boards - which makes DT
support totally pointless.

Let me give a situation where this matters: you have a boot loader which
loads a kernel from disk and executes it.  You have 256MB of RAM fitted
to the machine.  You replace this kernel with a DT-enabled kernel which
has the DT blob appended to the kernel.  The DT blob says you have 256MB
of RAM.

You remove a 128MB DIMM because its gone faulty.  You try to boot.  The
boot loader provides the kernel with an ATAG telling it that there's
128MB of RAM.  However, the kernel ignores the ATAGs and instead looks
at the encapsulated DT information which tells it that there's 256MB
of RAM.  Your kernel OOPSes.  You reboot, and try passing a command
line argument of 'mem=128M'. The kernel again ignores this because its
an ATAG.

The result: you can't boot the platform.

Another case: your flash has become corrupted, and the kernel won't mount
the flash based rootfs.  You want to boot from a root-NFS export to sort
the problem out, but the kernel ignores your new command line telling it
to do so.

The result: you can't boot the platform.

Another case: you have a Thecus N2100 acting as a server, with a pair
of drives setup as raid 1.  You reboot it one day and it refuses to build
the raid 1 rootfs, and so panics at boot.  You want to change the kernel
command line so that it mounts root from somewhere else, but because
you're using a DT based kernel, it ignores you.

The result: you can't boot the platform.

This behaviour from a DT based kernel is just not acceptable, and it's
also not acceptable to expect platforms to update their boot loaders to
cope with DT.
