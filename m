From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 15:34:28 +0100
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <201106121615.24059.arnd@arndb.de>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
	<201106121615.24059.arnd@arndb.de>
Message-ID: <20110612143428.GI10283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 04:15:23PM +0200, Arnd Bergmann wrote:
> On Sunday 12 June 2011 13:58:20 Russell King - ARM Linux wrote:
> > Exactly my point - I have quite a number of platforms here which will
> > never be able to have a boot loader capable of modifying a DT blob for
> > the kernel.
> > 
> > One of the points of Nicolas' patch set is to allow existing boot loaders
> > to boot kernels where the hardware description is contained in a DT blob
> > encapsulated with the kernel.  That's great but the way things are currently
> > setup, it means that the boot loader does nothing more than loading and
> > executing - and we lose the existing flexibility for the boot loader to
> > pass platform specific information to the kernel.
> > 
> > So, what I'm considering to do is update the boot protocol such that the
> > base address of the DT blob is provided in r3, separately from the ATAG
> > pointer in r2.
> >
> > This means that boot loaders can provide a DT blob (r2 = 0 r3 => DT) or
> > they can provide ATAGs (r2 => atag, r3 = indeterminant).  We can then
> > cater for the situation where we have an ATAG boot loader, but a kernel
> > with an appended DT description (r2 => atag, r3 => DT) and have the ATAG
> > information override the DT for things like memory layout and the command
> > line string.
> 
> But when you have both atag and DT and the atag overrides the DT, that
> means we have incorrect information in the DT, and code might later
> rely on that information.

I don't think you're considering real-world usage scenarios, but instead
concentrating on the use issues.  If you only do that you're boxing
yourself into a corner and will cause a world of pain for folk who would
just like the kernel to be usable.

The information in ATAGs which will either never be in DT or which should
override what is in DT is:

- memory parameters
- command line
- initrd location
- system serial number
- system revision number

Things like the serial number will _never_ be in DT (do you want to build
a DT image unique to each platform?)  initrd location will never be in
DT either (it depends where the boot loader placed it.) ... and so forth.

This is the kind of information which should override whatever is in
DT because the DT contained information could well be wrong or outdated,
and its not the kind of information that anything other than core code
should be dealing with in any case.

> IMHO when we allow passing a DT to a kernel while booting from an
> existing boot loader that only knows about atag, the code that loads
> the DT should be responsible for updating the DT with the atag information,
> not pass two conflicting sets of data into the actual kernel.

So, that means Nicolas' patches which allow a DT to be appended to the
image need to have DT and ATAG parsing in them to update the DT stuff
with the ATAG information.

> > Let me give a situation where this matters: you have a boot loader which
> > loads a kernel from disk and executes it.  You have 256MB of RAM fitted
> > to the machine.  You replace this kernel with a DT-enabled kernel which
> > has the DT blob appended to the kernel.  The DT blob says you have 256MB
> > of RAM.
> > 
> > You remove a 128MB DIMM because its gone faulty.  You try to boot.  The
> > boot loader provides the kernel with an ATAG telling it that there's
> > 128MB of RAM.  However, the kernel ignores the ATAGs and instead looks
> > at the encapsulated DT information which tells it that there's 256MB
> > of RAM.  Your kernel OOPSes.  You reboot, and try passing a command
> > line argument of 'mem=128M'. The kernel again ignores this because its
> > an ATAG.
> > 
> > The result: you can't boot the platform.
> >
> > Another case: your flash has become corrupted, and the kernel won't mount
> > the flash based rootfs.  You want to boot from a root-NFS export to sort
> > the problem out, but the kernel ignores your new command line telling it
> > to do so.
> > 
> > The result: you can't boot the platform.
> > 
> > Another case: you have a Thecus N2100 acting as a server, with a pair
> > of drives setup as raid 1.  You reboot it one day and it refuses to build
> > the raid 1 rootfs, and so panics at boot.  You want to change the kernel
> > command line so that it mounts root from somewhere else, but because
> > you're using a DT based kernel, it ignores you.
> > 
> > The result: you can't boot the platform.
> 
> So we need to at least the command line and the memory layout to be adapted
> in the in-memory DT, from the atags. Any other tags?

See above.
