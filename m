From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Aug 2016 17:55:23 +0100
Subject: [PATCH 0/2] add interworking support to Thumb2 kernel
In-Reply-To: <CAKv+Gu8dwTsHmk7nH-_Ogn-B8S=gkftFPUeABq7hYDC+SSx0Qg@mail.gmail.com>
References: <1471679131-3570-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160820162317.GX1041@n2100.armlinux.org.uk>
 <CAKv+Gu8dwTsHmk7nH-_Ogn-B8S=gkftFPUeABq7hYDC+SSx0Qg@mail.gmail.com>
Message-ID: <20160820165523.GY1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2016 at 06:36:44PM +0200, Ard Biesheuvel wrote:
> No, that is not the point. The point is to lift the requirement that a
> Thumb2 kernel must implement all its exported or modularised functions
> in Thumb2, not only in the core kernel but also in modules themselves.
> For example, the crypto modules I contributed contain .S core
> implementations, and building those in Thumb2 requires tweaking the
> implementations so that the assembler accepts it as Thumb2 code. There
> are examples in the tree (sha1-v4 and aes-v4) where we had to add ugly
> workarounds so that the code would build (and it was still broken for
> a while). So in general, it would be preferable to have a single ARM
> implementation for both modes. Also, it will become less likely for
> the multi_v7_defconfig to break inadvertently due to the addition of
> low level platform code with asm components that turn out not to build
> in Thumb2.

Right, so we're talking _purely_ about assembly level stuff here.

However, what I would point out is that some people will want to build
their kernel as definitely ARM-only or definitely Thumb2-only.  While
A-class accepts either, other class CPUs do not.  If we allow
interworking, then we start breaking that.

We do already support CPUs that only enter the kernel in Thumb2 mode or
only enter in ARM mode, because the CPU has no support for the other
instruction set.

> So with these patches, it is no longer necessary for core helper
> routines coded in assembler (or built in ARM mode for other reasons)
> to go out of their way so that the assembler can turn them in both ARM
> and Thumb2 code.

I'm not sure what "core helper routines" you're referring to - all C
functions will be built according to whether we want ARM mode or Thumb2
mode.  We aren't going to end up with a mixture for C functions within
the kernel.

> I think there may be a performance benefit in some cases as well,
> although this is anecdotal hearsay. The primary benefit of Thumb2 is
> code size, and multi_v7_defconfig is a couple of MBs smaller when
> built in Thumb2. In any case, lifting the restriction only affects
> configurations that set CONFIG_THUMB2_KERNEL globally, and THUMB2
> modules can still only be loaded into a THUMB2 kernel (due to the
> THUMB2 tag in the version string).
> 
> Oh, and the first patch is arguably a bugfix. An exported ARM function
> will not be rejected atm, but called in Thumb2 mode.

Sorry, I don't see it as a bug fix at all - I see it as a regression
causing change for those classes of CPU which only accept one or
other of the ISAs.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
