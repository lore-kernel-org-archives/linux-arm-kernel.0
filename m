From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Oct 2010 11:02:11 +0200
Subject: [PATCH 1/6] ARM: Add basic architecture support for
	VIA/WonderMedia 85xx SoC's
In-Reply-To: <AANLkTimkLqrbX+536TD630xFy=y-PxEdksc4sA0gz6fU@mail.gmail.com>
References: <1287608139-21354-1-git-send-email-alchark@gmail.com>
	<201010211401.53001.arnd@arndb.de>
	<AANLkTimkLqrbX+536TD630xFy=y-PxEdksc4sA0gz6fU@mail.gmail.com>
Message-ID: <201010221102.12329.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 October 2010 23:08:39 Alexey Charkov wrote:
> 2010/10/21 Arnd Bergmann <arnd@arndb.de>:
> > On Thursday 21 October 2010, Alexey Charkov wrote:
> > Parsing complex options in general is not ok, but something simpler
> > probably is.
> >
> > Having a Kconfig selected default is probably a good idea. The most
> > simple way to select this at boot time would be to have a list of
> > possible resolutions and pass a table index.
> >
> > Would a __setup() call work for you?
> >
> 
> Should probably be fine. Will it be allowable to accept something like
> "panel=800x480" and strncmp it against a list of recognized values,
> fall back to a Kconfig default on failure and printk the
> possibilities? Just expecting an obscure table index would not be too
> user-friendly, imho.

Sounds reasonable to me.
 
> >> And due to the fact that the framebuffer size calculation is tied to
> >> panel specification, it will boot in any case. The only problem that
> >> one could encounter would be suboptimal display (for example,
> >> offscreen pixmaps to become actually visible on screen if the panel is
> >> taller
> >> than expected, or some corruption in case it is wider).
> >
> > Another option might be to have a submenu with the possible resolutions
> > you want to allow and size the frame buffer for the largest of those,
> > but allow overriding the actual one at boot time.
> >
> 
> In this case display parameters could be parsed in the driver itself,
> but quite some memory will be over-allocated in extreme cases without
> any way to claim it back after boot. Having only 128MB of RAM, is it
> really better?

Well, you could still build a specialized kernel with only support for
one resolution if you care about every byte.

> Cleaned this up in the development repo, thanks. Only left #ifdef's
> for the sections where respective register/interrupt definitions would
> be unavailable due to compiling for a different SoC version, and
> adjusted the conditions accordingly.

Ideally those should also be run-time decisions so you can build a
kernel that works on both. It's all __init code, so it won't eat
up any RAM afterwards.

> >> >> +#ifndef __ASM_ARM_ARCH_IO_H
> >> >> +#define __ASM_ARM_ARCH_IO_H
> >> >> +
> >> >> +#define IO_SPACE_LIMIT 0xffffffff
> >> >> +
> >> >> +#define __io(a)              __typesafe_io(a)
> >> >> +#define __mem_pci(a) (a)
> >> >> +
> >> >> +#endif
> 
> Ok, figuring out better values for the macros would be great!

For the IO_SPACE_LIMIT, just make it 0xffff

For __io, you need to find a place in your virtual address space
and map the real IO space.

According to the VIA source code, the physical I/O window is at
0xd8000000, they also map it to the same address in virtual space
but you can have anywhere convienient.

	Arnd
