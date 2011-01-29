From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 29 Jan 2011 10:01:48 +0100
Subject: kernel headers not properly generated on platforms with a mach-
	and a plat- (i.e. mach-mx5, plat-mxc etc.)
In-Reply-To: <AANLkTinUMqxuRADoJKQw93=2nn99-Snk=p0uiTTEUxaO@mail.gmail.com>
References: <AANLkTinUMqxuRADoJKQw93=2nn99-Snk=p0uiTTEUxaO@mail.gmail.com>
Message-ID: <201101291001.48413.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 29 January 2011 01:57:19 Matt Sealey wrote:
> 
> Puzzling over this again, is there some deep dark reason that if I
> create kernel headers (headers_install or headers_check) for MX51
> processors, or anything with a mach- AND a plat-, that the
> plat-foo/include/mach/* headers are not copied into the header tree?

As far as I can tell, the mach/* files cannot possibly be exported,
because the user space headers are by definition machine independent.
Otherwise you would not be guaranteed that applications you build
can run on all systems.

> As a quick example, build any external module (compat-wireless is a
> good example) or libc against the headers alone and not the full
> source and they will complain about asm/memory.h trying to include
> mach/memory.h which does not exist. Doing a little hack to copy those
> files across absolutely fixes it.

memory.h is not exported by make headers_install.

external modules are not built against the exported headers
(linux-libc-dev*.dpkg), but are built against a sparse copy of the
kernel source tree (linux-headers-*.dpkg)

> I know there is a weirdness here: the root arch/arm/Kconfig in my tree
> includes plat-mxc/Kconfig which includes mach-mx5/Kconfig. This is how
> the magic happens, but I can't find any magic that modifies the
> include paths to pick includes from these directories in the first
> place. They don't seem symlinked into the asm-arm/mach directory on a
> kernel build.

look for 'machdirs' in arch/arm/Makefile

> Has anyone even noticed this before (it's quite hard to search for the
> exact situation in freeform text in Google or ML archives, sigh)? Or
> is there a well known solution everyone uses but just never pushes to
> the distribution packagers or so? Is the solution to use the full
> Linux source code (kind of annoying for consumers that need to put
> aside 400MB of disk space for an extracted Linux source when 8MB of
> headers would do) rather than just headers as we have been doing for
> the past few weeks, and off and on for years?

The problem has mostly gone away now: All the important drivers that
used to be external modules are now in the regular upstream kernel
or at least in drivers/staging. In the few cases where the license
prohibits this, you can still package the module to have a
build-dependency on the full kernel sources and put the small
burden of installing them on the packager, but not the end-user.

Of course, if you find a packaging problem with the linux-headers
package, submit a patch for that or open a bug report.

	Arnd
