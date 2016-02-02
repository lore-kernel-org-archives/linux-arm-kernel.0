From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 2 Feb 2016 12:51:16 -0500 (EST)
Subject: [PATCH 0/3] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454419174-21290-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.20.1602021250200.32766@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Feb 2016, Ard Biesheuvel wrote:

> This series applies on top of today's -next, and addresses an issue with
> the new kallsyms code that is queued there, that enables base relative
> kallsyms tables for all architectures (except IA-64)
> 
> Two issues have surfaced on ARM with the new kallsyms code:
> a) CONFIG_HAVE_TCM creates a virtual region that is too far away for the
>    relative kallsyms code to reach it;
> b) CONFIG_XIP_KERNEL=y kernel symbols are not filtered against PAGE_OFFSET,
>    as is the case for kernels that execute from RAM, resulting in symbols
>    that are out of range.
> 
> Since the way kallsyms deals with XIP kernels on ARM leaves some room for
> improvement regardless of the base relative changes, this series proposes
> a fix that allows the special case to be removed from the kallsyms handling
> entirely.
> 
> Patch #1 moves the .stubs and .vectors section back into the kernel VMA, while
> preserving the guaranteed virtual offset of 4 KB. This results in all symbols
> that kallsyms sees to be in a reasonable interval.
> 
> Patch #2 removes the special case for CONFIG_ARM && !CONFIG_XIP_KERNEL in the
> invocation of scripts/kallsyms
> 
> Patch #3 removes the now unused --page-offset command line argument handling
> from scripts/kallsyms.c
> 
> Note that we may still need to remove ARM from the list of architectures that
> support base relative kallsyms tables if we cannot fix issue a) above, but
> removing this special case seemed like an obvious improvement to me.

For those 3 patches:

Acked-by: Nicolas Pitre <nico@linaro.org>



> 
> Ard Biesheuvel (3):
>   ARM: move .vectors and .stubs sections back into the kernel VMA
>   kallsyms: remove special lower address limit for CONFIG_ARM
>   kallsyms: remove --page-offset command line option
> 
>  arch/arm/kernel/entry-armv.S  |  7 +++--
>  arch/arm/kernel/vmlinux.lds.S | 15 ++++++-----
>  scripts/kallsyms.c            | 27 ++++----------------
>  scripts/link-vmlinux.sh       |  4 ---
>  4 files changed, 16 insertions(+), 37 deletions(-)
> 
> -- 
> 2.5.0
> 
> 
