From: Chris.Brandt@renesas.com (Chris Brandt)
Date: Wed, 3 Feb 2016 20:00:50 +0000
Subject: [PATCH v2 0/4] kallsyms: remove special handling for CONFIG_ARM
In-Reply-To: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1454526297-5269-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <HKXPR06MB056557F78EB9F04F271019C68AD00@HKXPR06MB0565.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 Feb 2016, Ard Biesheuvel wrote:

> This series applies on top of today's -next, and addresses an issue
> with the new kallsyms code that is queued there, that enables base
> relative kallsyms tables for all architectures (except IA-64)
>
> Two issues have surfaced on ARM with the new kallsyms code:
> a) CONFIG_HAVE_TCM creates a virtual region that is too far away for the
>    relative kallsyms code to reach it;
> b) CONFIG_XIP_KERNEL=y kernel symbols are not filtered against PAGE_OFFSET,
>   as is the case for kernels that execute from RAM, resulting in symbols
>   that are out of range.
>
> Since the way kallsyms deals with XIP kernels on ARM leaves some room for
>  improvement regardless of the base relative changes, this series proposes
>  a fix that allows the special case to be removed from the kallsyms
>  handling entirely.
>
> Changes since v1:
> - new patch #4 (optional, RFC)
> - added Nico's ack to #1 - #3
> - use PROVIDE() for vector_fiq_offset since vector_fiq itself is not
>  always
>   defined
> - put __stubs_start/_end inside the section definition so that the
>  value of the
>   start symbol equals the start of the section after alignment
>  (fixes an issue
>   on XIP spotted by Chris)
> 
> Patch #1 moves the .stubs and .vectors section back into the kernel
> VMA, while preserving the guaranteed virtual offset of 4 KB. This
> results in all symbols that kallsyms sees to be in a reasonable interval.
> 
> Patch #2 removes the special case for CONFIG_ARM && !CONFIG_XIP_KERNEL
> in the invocation of scripts/kallsyms
> 
> Patch #3 removes the now unused --page-offset command line argument
> handling from scripts/kallsyms.c
> 
> Patch #4 is included as an RFC, it removes the magic constant 0x1000
> which is the offset between the start of the .vectors section and the
> start of the .stubs section.


For patches 1,2,3:

Tested with ARCH_R7S72100 with CONFIG_XIP_KERNEL=y


Acked-by: Chris Brandt <chris.brandt@renesas.com>
