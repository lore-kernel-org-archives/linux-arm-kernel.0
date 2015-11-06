From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 6 Nov 2015 12:50:02 +0000
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <20151106123008.GK6087@arm.com>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
 <20151106123008.GK6087@arm.com>
Message-ID: <20151106125002.GA8116@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 12:30:09PM +0000, Will Deacon wrote:
> On Wed, Nov 04, 2015 at 09:37:51AM -0800, Yang Shi wrote:
> > FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
> > it in arch/arm64/Kconfig.debug.
> 
> It might be worth noting that this adds a dependency on DEBUG_KERNEL
> for building with frame pointers. I'm ok with that (it appears to be
> enabled in defconfig and follows the vast majority of other archs) but
> it is a change in behaviour.
> 
> With that:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

The code in arch/arm64/kernel/stacktrace.c assumes we have frame
pointers regardless of FRAME_POINTER. Depending on what the compiler
decides to use x29 for, we could get some weird fake unwinding and/or
dodgy memory accesses.

I think we should first audit the uses of frame pointers to ensure that
they are guarded for !FRAME_POINTER.

Thanks,
Mark.
