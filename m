From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 14 Oct 2011 13:16:27 -0700
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <20111014201223.GV21648@n2100.arm.linux.org.uk>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<201110141729.41515.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
	<201110141827.53906.arnd@arndb.de>
	<CAOesGMgDwMeVmwo1WJ3tU+ZdjCSJ6F8mY42e_KwTmzAkGQsqmg@mail.gmail.com>
	<20111014192011.GS21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110141549160.17040@xanadu.home>
	<20111014201223.GV21648@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173BE1A365@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Friday, October 14, 2011 2:12 PM:
> On Fri, Oct 14, 2011 at 04:06:21PM -0400, Nicolas Pitre wrote:
> > Currently, U-Boot insists on having a uImage with a fixed absolute load
> > address.  This is currently provided by the zreladdr value, whether or
> > not AUTO_ZRELADDR is set.  I consider this as a persisting uImage
> > limitation.
> >
> > Either u-Boot gets fixed so it can work with plain zImage (and this
> > certainly will happen once the pressure from people wanting a single
> > kernel to work on targets with different load addresses increase.
> > Tegra is one such example.
> >
> > Or we create a u-Boot specific Kconfig menu for uImage options that
> > would be common to all architectures and kick it out from the ARM
> > specific makefile.  This is not solving the u-Boot limitation though.
> >
> > In either cases this is a u-Boot problem that needs fixing on the u-Boot
> > side in the end.
> 
> I don't think that's so with the various flavours of platform specific
> uboot which float around.  For instance, on the OMAP4430 SDP, the
> following commands were used as supplied to load a uImage off the SD
> card into RAM at a different address to which it was built for, and
> execute it at that address:
> 
> mmcinit 0
> fatload mmc 0 0x80300000 uImage
> bootm 80300000
> 
> Whether the 'bootm' command then copied the image and called it there,
> or whether it executed it at 0x80300000 I've no idea - but why then
> load the image at a different address in the first place?

Yes, U-Boot's image handling looks at the image at 80300000, extracts the
"load address" from the image header, memcpy()'s the image to that address,
then jumps to the "entry address" in the image header.

-- 
nvpublic
