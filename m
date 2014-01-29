From: mikpelinux@gmail.com (Mikael Pettersson)
Date: Wed, 29 Jan 2014 13:34:49 +0100
Subject: Building with gcc 4.6.4
In-Reply-To: <20140128150611.GL15937@n2100.arm.linux.org.uk>
References: <20140128120150.GG15937@n2100.arm.linux.org.uk>
 <21223.49366.479579.145000@gargle.gargle.HOWL>
 <20140128150611.GL15937@n2100.arm.linux.org.uk>
Message-ID: <21224.62825.625591.200853@gargle.gargle.HOWL>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes:
 > On Tue, Jan 28, 2014 at 03:38:14PM +0100, Mikael Pettersson wrote:
 > > Russell King - ARM Linux writes:
 > >  > So, yesterday I built gcc 4.6.4 (mainline) for the autobuilder, and the
 > >  > result is that every build failed with the same error:
 > >  > 
 > >  > scripts/mod/empty.c:1:0: error: FPA is unsupported in the AAPCS
 > >  > 
 > >  > This seems to be because linux-elf targets default to fpe3 in mainline
 > >  > gcc, but specifying -mabi=aapcs-linux switches us into EABI mode where
 > >  > the compiler errors out with the default FPU.
 > >  > 
 > >  > Hence, I believe we need this to ensure that a compatible VFP is
 > >  > selected.  One can argue that building EABI ARMv4 with VFP is silly,
 > >  > but it seems that's what the gcc folk have decided (rightly or
 > >  > wrongly.)
 > >  > 
 > >  > Maybe this is a bug in mainline GCC - which begs the question why
 > >  > (presumably, since no one has picked this up) Linaro's toolchain
 > >  > has fixes but mainline GCC doesn't.
 > >  > 
 > >  > Comments?
 > > 
 > > Perhaps because most ARM EABI toolchains default to soft-float,
 > > and the hardfloat ones usually select v6 or v7 + vfp-d16 or neon
 > > as their defaults, so the archaic FPA is never the default.
 > 
 > soft-float has nothing to do with it, because the kernel always passes
 > -msoft-float.
 > 
 > > Or are you using an OABI toolchain to compile an EABI kernel?
 > 
 > ... which should make no difference what so ever since the kernel should
 > be passing the appropriate options.  That's why we pass -mabi=aapcs-linux
 > to the kernel.

I can reproduce your error with an OABI toolchain (gcc-4.6.4 or 4.7.3,
default configuration options wrt ISA and floating-point model), but
there's no such error with an EABI toolchain.  So it looks like you've
found a GCC bug.

However, the toolchain people considers OABI to be obsolete, it's
unsupported since gcc-4.7.0, gcc-4.6 is EOL, and even gcc-4.7 is
nearing EOL (will probably happen this spring or early summer after
the release of gcc-4.9.0), so I doubt anyone is going to work on
this issue.

/Mikael
