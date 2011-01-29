From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Jan 2011 09:43:31 +0000
Subject: kernel headers not properly generated on platforms with a
	mach- and a plat- (i.e. mach-mx5, plat-mxc etc.)
In-Reply-To: <AANLkTinUMqxuRADoJKQw93=2nn99-Snk=p0uiTTEUxaO@mail.gmail.com>
References: <AANLkTinUMqxuRADoJKQw93=2nn99-Snk=p0uiTTEUxaO@mail.gmail.com>
Message-ID: <20110129094331.GB28403@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 28, 2011 at 06:57:19PM -0600, Matt Sealey wrote:
> Puzzling over this again, is there some deep dark reason that if I
> create kernel headers (headers_install or headers_check) for MX51
> processors, or anything with a mach- AND a plat-, that the
> plat-foo/include/mach/* headers are not copied into the header tree?

headers_install does not install headers for building modules.  It
installs headers for use by userspace - specifically your libc.  These
headers purposely do not contain any platform specifics because those
are not part of the userspace API.  They also have various kernel
specific information stripped out of them.

They are completely unsuitable for building anything kernel-related.

> As a quick example, build any external module (compat-wireless is a
> good example) or libc against the headers alone and not the full
> source and they will complain about asm/memory.h trying to include
> mach/memory.h which does not exist. Doing a little hack to copy those
> files across absolutely fixes it.

asm/memory.h is not part of headers_install.

> I know there is a weirdness here: the root arch/arm/Kconfig in my tree
> includes plat-mxc/Kconfig which includes mach-mx5/Kconfig. This is how
> the magic happens, but I can't find any magic that modifies the
> include paths to pick includes from these directories in the first
> place. They don't seem symlinked into the asm-arm/mach directory on a
> kernel build.

We don't use symlinks anymore when dealing with header file directories.

You can only build modules against the kernel source.  Building external
modules is documented in Documentation/kbuild/modules.txt.  This requires
more than just the kernel headers - it requires a preconfigured kernel
tree, which if you're using modversions, has already been built.
