From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 10 Nov 2015 11:35:05 +0000
Subject: [V3 PATCH] arm64: remove redundant FRAME_POINTER kconfig option
 and force to select it
In-Reply-To: <49B0431C-4FDA-45CB-82AF-FA010197118D@gmail.com>
References: <1447092595-12644-1-git-send-email-yang.shi@linaro.org>
 <20151110103752.GH21606@e104818-lin.cambridge.arm.com>
 <49B0431C-4FDA-45CB-82AF-FA010197118D@gmail.com>
Message-ID: <20151110113505.GI21606@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 07:09:00PM +0800, yalin wang wrote:
> > On Nov 10, 2015, at 18:37, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > 
> > On Mon, Nov 09, 2015 at 10:09:55AM -0800, Yang Shi wrote:
> >> FRAME_POINTER  is defined in lib/Kconfig.debug, it is unnecessary to redefine
> >> it in arch/arm64/Kconfig.debug. Actually, the one defined in arm64 directory
> >> is never used.
> > 
> > That's not true since the arm64 definition seems to take precedence.
> > 
> >> This adds a dependency on DEBUG_KERNEL for building with frame pointers.
> > 
> > It doesn't because arm64 selects ARCH_WANT_FRAME_POINTERS.
> > 
> >> ARM64 depends on frame pointer to get correct stack backtrace and need
> >> FRAME_POINTER kconfig option enabled all the time.
> >> However, currect implementation makes it could be disabled, so force it
> >> to be selected by ARM64.
> >> 
> >> Signed-off-by: Yang Shi <yang.shi@linaro.org>
> > 
> > Patch applied but I changed the commit log slightly. Thanks.
> i have a question,
> why FRAME_POINTER  config must be enabled ?
> and i see ARM arch can  disable this config .
> if i don?t need stack trace dump and the software release is for 
> final product , don?t need debug stack trace log .
> is it possible to disable it for performance reason ?

If you don't need any stack trace, perf etc., in theory you can disable
the option. However, the aarch64 gcc compiler always generates it (I'm
not sure whether the AAPCS mandates it). Anyway, the performance impact
is very small since there are more general purpose registers available
in AArch64 already.

-- 
Catalin
