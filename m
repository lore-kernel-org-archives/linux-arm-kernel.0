From: matt@genesi-usa.com (Matt Sealey)
Date: Fri, 28 Jan 2011 18:57:19 -0600
Subject: kernel headers not properly generated on platforms with a mach- and a
	plat- (i.e. mach-mx5, plat-mxc etc.)
Message-ID: <AANLkTinUMqxuRADoJKQw93=2nn99-Snk=p0uiTTEUxaO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey guys,

Puzzling over this again, is there some deep dark reason that if I
create kernel headers (headers_install or headers_check) for MX51
processors, or anything with a mach- AND a plat-, that the
plat-foo/include/mach/* headers are not copied into the header tree?

As a quick example, build any external module (compat-wireless is a
good example) or libc against the headers alone and not the full
source and they will complain about asm/memory.h trying to include
mach/memory.h which does not exist. Doing a little hack to copy those
files across absolutely fixes it.

I know there is a weirdness here: the root arch/arm/Kconfig in my tree
includes plat-mxc/Kconfig which includes mach-mx5/Kconfig. This is how
the magic happens, but I can't find any magic that modifies the
include paths to pick includes from these directories in the first
place. They don't seem symlinked into the asm-arm/mach directory on a
kernel build.

My first thought is to modify the Debian packaging so it manually
hacks those files in to get it working, but my major concern is you
would have to do this for every platform and machine combination where
this occurs, and this is obviously a kernel problem not a packaging
problem.

Has anyone even noticed this before (it's quite hard to search for the
exact situation in freeform text in Google or ML archives, sigh)? Or
is there a well known solution everyone uses but just never pushes to
the distribution packagers or so? Is the solution to use the full
Linux source code (kind of annoying for consumers that need to put
aside 400MB of disk space for an extracted Linux source when 8MB of
headers would do) rather than just headers as we have been doing for
the past few weeks, and off and on for years?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
