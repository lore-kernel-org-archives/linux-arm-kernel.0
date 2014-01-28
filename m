From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 15:06:11 +0000
Subject: Building with gcc 4.6.4
In-Reply-To: <21223.49366.479579.145000@gargle.gargle.HOWL>
References: <20140128120150.GG15937@n2100.arm.linux.org.uk>
 <21223.49366.479579.145000@gargle.gargle.HOWL>
Message-ID: <20140128150611.GL15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 03:38:14PM +0100, Mikael Pettersson wrote:
> Russell King - ARM Linux writes:
>  > So, yesterday I built gcc 4.6.4 (mainline) for the autobuilder, and the
>  > result is that every build failed with the same error:
>  > 
>  > scripts/mod/empty.c:1:0: error: FPA is unsupported in the AAPCS
>  > 
>  > This seems to be because linux-elf targets default to fpe3 in mainline
>  > gcc, but specifying -mabi=aapcs-linux switches us into EABI mode where
>  > the compiler errors out with the default FPU.
>  > 
>  > Hence, I believe we need this to ensure that a compatible VFP is
>  > selected.  One can argue that building EABI ARMv4 with VFP is silly,
>  > but it seems that's what the gcc folk have decided (rightly or
>  > wrongly.)
>  > 
>  > Maybe this is a bug in mainline GCC - which begs the question why
>  > (presumably, since no one has picked this up) Linaro's toolchain
>  > has fixes but mainline GCC doesn't.
>  > 
>  > Comments?
> 
> Perhaps because most ARM EABI toolchains default to soft-float,
> and the hardfloat ones usually select v6 or v7 + vfp-d16 or neon
> as their defaults, so the archaic FPA is never the default.

soft-float has nothing to do with it, because the kernel always passes
-msoft-float.

> Or are you using an OABI toolchain to compile an EABI kernel?

... which should make no difference what so ever since the kernel should
be passing the appropriate options.  That's why we pass -mabi=aapcs-linux
to the kernel.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
