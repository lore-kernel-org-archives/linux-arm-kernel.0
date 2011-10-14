From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Oct 2011 22:13:11 +0100
Subject: [PATCH] arm/tegra: select AUTO_ZRELADDR by default
In-Reply-To: <alpine.LFD.2.02.1110141628230.17040@xanadu.home>
References: <1317172068-14872-1-git-send-email-pdeschrijver@nvidia.com>
	<201110141729.41515.arnd@arndb.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173BE1A283@HQMAIL01.nvidia.com>
	<201110141827.53906.arnd@arndb.de>
	<alpine.LFD.2.02.1110141353390.17040@xanadu.home>
	<20111014192057.GT21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110141609510.17040@xanadu.home>
	<20111014201737.GW21648@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1110141628230.17040@xanadu.home>
Message-ID: <20111014211311.GY21648@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 14, 2011 at 04:31:12PM -0400, Nicolas Pitre wrote:
> On Fri, 14 Oct 2011, Russell King - ARM Linux wrote:
> 
> > On Fri, Oct 14, 2011 at 04:14:12PM -0400, Nicolas Pitre wrote:
> > > On Fri, 14 Oct 2011, Russell King - ARM Linux wrote:
> > > 
> > > > On Fri, Oct 14, 2011 at 02:01:07PM -0400, Nicolas Pitre wrote:
> > > > > The way I'm restructuring things around this is that AUTO_ZRELADDR will 
> > > > > always be active by default, just like ARM_PATCH_PHYS_VIRT now.  This 
> > > > > platform specific exclusion thinking is a step backward so I'd prefer if 
> > > > > people would refrain from going there for the moment.
> > > > 
> > > > Are you expecting everyone to change the way they load the zImage
> > > > overnight then?
> > > 
> > > No, of course.  But adding restrictions in the kernel build because 
> > > u-Boot's own image format dictates such restrictions doesn't make sense.  
> > > Those restrictions must be pushed towards the uImage encapsulation step, 
> > > not higher the kernel config hierarchy.
> > 
> > You're not understanding again.
> > 
> > I'm talking about people who _explicitly_ load the zImage at a different
> > address to which the decompressed image ends up.  With AUTO_ZRELADDR=y
> > their setup will break unless they stop that behaviour, which takes
> > away one of the advantages of using the zImage format.
> 
> Would you care to explain where you got this from?  Because I really do 
> not understand what you're saying indeed.

My I point out that it's you who decided that I was talking about u-boot
when I said no such thing in my message.  I merely pointed out about
those people who may be loading the zImage elsewhere in memory and using
that facility to cut down on the boot time.  u-boot can't load zImages
directly.

Yet you started nattering on about uboot - which we know is a pile of
crap for dealing with this stuff.

But ultimately, how people achieve the loading of the zImage is beyond
the scope of what I stated: whether that's not using u-boot but some
other boot loader, or maybe using mkimage outside of the kernel build,
or whatever.

> With AUTO_ZRELADDR=y you _still_ can load zImage to a different location 
> from where the decompressed kernel ends up.

You are correct for some values of 'different location' but not all -
and how can we know _what_ people are doing?  We don't.

#ifdef CONFIG_AUTO_ZRELADDR
                @ determine final kernel image address
                mov     r4, pc
                and     r4, r4, #0xf8000000
                add     r4, r4, #TEXT_OFFSET
#else
                ldr     r4, =zreladdr
#endif

So this means the decompressor _must_ run within the first 128MB chunk
of memory for the resulting kernel to be correctly placed at expected
place - at the beginning of system memory + TEXT_OFFSET.

Can we know that this is always the case?  I don't think so.
Can we expect there to be regressions if we force AUTO_ZRELADDR=y?  We'd
be stupid not to expect them.
