From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 12 Jun 2011 16:15:23 +0200
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612115820.GF10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
Message-ID: <201106121615.24059.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 12 June 2011 13:58:20 Russell King - ARM Linux wrote:
> Exactly my point - I have quite a number of platforms here which will
> never be able to have a boot loader capable of modifying a DT blob for
> the kernel.
> 
> One of the points of Nicolas' patch set is to allow existing boot loaders
> to boot kernels where the hardware description is contained in a DT blob
> encapsulated with the kernel.  That's great but the way things are currently
> setup, it means that the boot loader does nothing more than loading and
> executing - and we lose the existing flexibility for the boot loader to
> pass platform specific information to the kernel.
> 
> So, what I'm considering to do is update the boot protocol such that the
> base address of the DT blob is provided in r3, separately from the ATAG
> pointer in r2.
>
> This means that boot loaders can provide a DT blob (r2 = 0 r3 => DT) or
> they can provide ATAGs (r2 => atag, r3 = indeterminant).  We can then
> cater for the situation where we have an ATAG boot loader, but a kernel
> with an appended DT description (r2 => atag, r3 => DT) and have the ATAG
> information override the DT for things like memory layout and the command
> line string.

But when you have both atag and DT and the atag overrides the DT, that
means we have incorrect information in the DT, and code might later
rely on that information.

IMHO when we allow passing a DT to a kernel while booting from an
existing boot loader that only knows about atag, the code that loads
the DT should be responsible for updating the DT with the atag information,
not pass two conflicting sets of data into the actual kernel.

> Let me give a situation where this matters: you have a boot loader which
> loads a kernel from disk and executes it.  You have 256MB of RAM fitted
> to the machine.  You replace this kernel with a DT-enabled kernel which
> has the DT blob appended to the kernel.  The DT blob says you have 256MB
> of RAM.
> 
> You remove a 128MB DIMM because its gone faulty.  You try to boot.  The
> boot loader provides the kernel with an ATAG telling it that there's
> 128MB of RAM.  However, the kernel ignores the ATAGs and instead looks
> at the encapsulated DT information which tells it that there's 256MB
> of RAM.  Your kernel OOPSes.  You reboot, and try passing a command
> line argument of 'mem=128M'. The kernel again ignores this because its
> an ATAG.
> 
> The result: you can't boot the platform.
>
> Another case: your flash has become corrupted, and the kernel won't mount
> the flash based rootfs.  You want to boot from a root-NFS export to sort
> the problem out, but the kernel ignores your new command line telling it
> to do so.
> 
> The result: you can't boot the platform.
> 
> Another case: you have a Thecus N2100 acting as a server, with a pair
> of drives setup as raid 1.  You reboot it one day and it refuses to build
> the raid 1 rootfs, and so panics at boot.  You want to change the kernel
> command line so that it mounts root from somewhere else, but because
> you're using a DT based kernel, it ignores you.
> 
> The result: you can't boot the platform.

So we need to at least the command line and the memory layout to be adapted
in the in-memory DT, from the atags. Any other tags?

	Arnd
