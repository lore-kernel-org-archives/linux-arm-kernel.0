From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 9 Nov 2015 15:58:40 +0000
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <563CE9AA.8050905@linaro.org>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
 <20151106123008.GK6087@arm.com> <20151106125002.GA8116@leverpostej>
 <20151106162109.GZ7637@e104818-lin.cambridge.arm.com>
 <20151106162538.GU6087@arm.com> <563CE21A.6060803@linaro.org>
 <20151106173558.GC7637@e104818-lin.cambridge.arm.com>
 <563CE5BB.2080701@linaro.org>
 <20151106175119.GD7637@e104818-lin.cambridge.arm.com>
 <563CE9AA.8050905@linaro.org>
Message-ID: <20151109155840.GD21606@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 09:55:54AM -0800, Shi, Yang wrote:
> On 11/6/2015 9:51 AM, Catalin Marinas wrote:
> >On Fri, Nov 06, 2015 at 09:39:07AM -0800, Shi, Yang wrote:
> >>On 11/6/2015 9:35 AM, Catalin Marinas wrote:
> >>>On Fri, Nov 06, 2015 at 09:23:38AM -0800, Shi, Yang wrote:
> >>>>On 11/6/2015 8:25 AM, Will Deacon wrote:
> >>>>>However, the patch would allow one to
> >>>>>disable FRAME_POINTERS (not sure it has any effect on the aarch64 gcc
> >>>>>though).
> >>>>
> >>>>No, it doesn't. Actually, FRAME_POINTER could be disabled regardless of the
> >>>>patch.
> >>>
> >>>In which case I suggest that we always select it just as a clearer
> >>>statement that the feature cannot be disabled (and you never know what
> >>>the compiler people decide to do in the future).
> >>
> >>Do you mean select FRAME_POINTER in ARCH_WANT_FRAME_POINTERS?
> >>
> >>Yes, we could, but this may cause other architectures which select
> >>ARCH_WANT_FRAME_POINTERS to have FRAME_POINTER selected too.
> >
> >This would have been the ideal option, something like:
> >
> >--- a/lib/Kconfig.debug
> >+++ b/lib/Kconfig.debug
> >@@ -322,7 +322,7 @@ config ARCH_WANT_FRAME_POINTERS
> >  	help
> >
> >  config FRAME_POINTER
> >-	bool "Compile the kernel with frame pointers"
> >+	bool "Compile the kernel with frame pointers" if !ARCH_WANT_FRAME_POINTERS
> >  	depends on DEBUG_KERNEL && \
> >  		(CRIS || M68K || FRV || UML || \
> >  		 AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || \
> >
> >But, as you said, we would need to check the other architectures
> >selecting ARCH_WANT_FRAME_POINTERS.
> 
> How about:
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1d1521c..709255a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -319,6 +319,7 @@ config DEBUG_SECTION_MISMATCH
>  #
>  config ARCH_WANT_FRAME_POINTERS
>         bool
> +       select FRAME_POINTER if ARM64
>         help
> 
>  config FRAME_POINTER
> 
> If other architectures want the same behavior, they could easily append to
> the is statement. If all arches which selects ARCH_WANT_FRAME_POINTERS, the
> if statement could be just removed.

I prefer the select in the ARM64 Kconfig entry as below:

> >--- a/arch/arm64/Kconfig
> >+++ b/arch/arm64/Kconfig
> >@@ -27,6 +27,7 @@ config ARM64
> >  	select CPU_PM if (SUSPEND || CPU_IDLE)
> >  	select DCACHE_WORD_ACCESS
> >  	select EDAC_SUPPORT
> >+	select FRAME_POINTER
> >  	select GENERIC_ALLOCATOR
> >  	select GENERIC_CLOCKEVENTS
> >  	select GENERIC_CLOCKEVENTS_BROADCAST
> >

-- 
Catalin
