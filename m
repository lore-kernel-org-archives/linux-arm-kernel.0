From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Jan 2011 15:29:54 +0000
Subject: kernel headers not properly generated on platforms with a
	mach- and a plat- (i.e. mach-mx5, plat-mxc etc.)
In-Reply-To: <AANLkTikW2vSteZZqM8og+_bJLgSgnr+cpKoEez4n9-kO@mail.gmail.com>
References: <AANLkTinUMqxuRADoJKQw93=2nn99-Snk=p0uiTTEUxaO@mail.gmail.com>
	<20110129094331.GB28403@n2100.arm.linux.org.uk>
	<AANLkTikW2vSteZZqM8og+_bJLgSgnr+cpKoEez4n9-kO@mail.gmail.com>
Message-ID: <20110129152954.GA7237@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 29, 2011 at 08:57:54AM -0600, Matt Sealey wrote:
> Okay so it's a Debian packaging problem then. To get dkms and similar
> to work properly with just -headers there are a bunch of hacks (it
> installs a pre-prepped kernel tree up to the point it's needed to get
> that to work) and this would have to be handled.

What Fedora does is the kernel-headers package contains the userspace
headers (/usr/include/{asm,linux,...}) which correspond with the headers
which were used to build glibc.

The kernel package, containing the kernel binary and modules, contains
a link from /lib/modules/$version/build to the kernel development tree
in /usr/src/kernels/$version

The kernel-devel package contains a cut-down kernel tree, including the
Kconfigs, Makefiles, include files, scripts (and pre-built binaries
in scripts/) and a .config - in other words, a prepared kernel source
tree with most of the .c files missing.

I'm not sure what debian do, but they should be doing something similar.
They should not be stuffing the userspace headers package with any header
file which isn't exported by 'make headers_install'.

Hope that's of some use.
