From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 12 Jun 2011 11:41:40 -0400 (EDT)
Subject: [PATCH 0/3] patches to allow DTB to be appended to the ARM zImage
In-Reply-To: <20110612115820.GF10283@n2100.arm.linux.org.uk>
References: <1307858800-16712-1-git-send-email-nicolas.pitre@linaro.org>
	<20110612081541.GA10283@n2100.arm.linux.org.uk>
	<20110612083414.GA29516@S2100-06.ap.freescale.net>
	<20110612112219.GD16318@ibawizard.net>
	<20110612115820.GF10283@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1106121051380.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 12 Jun 2011, Russell King - ARM Linux wrote:

> One of the points of Nicolas' patch set is to allow existing boot loaders
> to boot kernels where the hardware description is contained in a DT blob
> encapsulated with the kernel.  That's great but the way things are currently
> setup, it means that the boot loader does nothing more than loading and
> executing - and we lose the _existing_ flexibility for the boot loader to
> pass platform specific information to the kernel.

My stance always has been to preserve ATAG support for legacy platforms.  
I think we have enough work already trying to convert modern platforms 
to DT without bothering with the older ones with non-updatable 
bootloaders.  This ability to append a DTB to the kernel is simply a 
convenience to let people use DT with non DT aware bootloaders, or even 
to override the DTB passed by the bootloader which is unavoidably going 
to be broken in some cases.  Of course the restriction in that case is 
that you'll need to recreate that appended DTB whenever you wish to 
change a parameter.  I don't consider this to be the main mode of 
operation though.

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

No, please let's not go there.  Having competing sources of information 
is the best recipe to madness.  Which one is authoritative?  What if we 
need to have the override going in the other direction?  We should be 
fully with ATAGS, or fully with DT, not a mixture of both.

> This is the only sensible way of maintaining compatibility with the
> existing boot protocol, which is an absolute _must_ if we are going to
> convert some of the existing SoCs (like PXA) to DT and get rid of the
> legacy static descriptions of the on-board devices (which is the whole
> point we're going down this path.)

All the newer PXAs are using U-Boot which is now DT aware.  If a legacy 
bootloader must be used, then it is always possible to add a shim to 
zImage translating selected ATAGs into DT records.  A patch for doing 
just that exists already and was posted on the list by Grant.  However I 
prefer if it is used only when absolutely needed and not by default 
otherwise we lose all possible leverage on bootloader authors to move to 
DT (the fact that the DT append patch still doesn't let you change the 
cmdline live is also part of that leverage).

> It's either that or we'll have to refuse to convert existing SoCs to
> DT to maintain compatibility for existing boards - which makes DT
> support totally pointless.

It is not pointless.  Never it was in the cards to convert old platforms 
first.  The most problematic platforms responsible for the high volume 
of changes that has gone in mainline lately are the modern ones, not PXA 
based ones.  So DT is going to be most effective for the new stuff to 
come.  And realistically that's where we might get developers attention, 
not with those platforms being end-of-lived by their manufacturers.

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

I don't think the DT append patch is suitable for such a usage scenario, 
unless you are ready to swap the appended DTB with another one in that 
case.  Or you simply can just drop the appended DTB in which case the 
kernel will use the ATAGs instead.

If you really want to use DT on that platform and still benefit from the 
ATAG information passed by the bootloader, then you could use the 
translation shim that exists.  That, of course, is assuming that you do 
have DT support for that platform in the kernel which, like I said, is 
unlikely to happen for old platforms unless someone really enthusiastic 
invest some time in the required work.

> Another case: you have a Thecus N2100 acting as a server, with a pair
> of drives setup as raid 1.  You reboot it one day and it refuses to build
> the raid 1 rootfs, and so panics at boot.  You want to change the kernel
> command line so that it mounts root from somewhere else, but because
> you're using a DT based kernel, it ignores you.

My answer: if it isn't broken, don't fix it.  In other words, I have not 
seen huge development activities around the N2100 for quite a while.  
It is not responsible for a significant increase of kernel code anymore, 
if at all. So there is no point moving it to DT especially in a 
production setup.


Nicolas
