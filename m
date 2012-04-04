From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 4 Apr 2012 12:02:30 +0200
Subject: [PATCH] ARM: fix __io macro for PCMCIA
In-Reply-To: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
References: <1333509112-1555-1-git-send-email-robherring2@gmail.com>
Message-ID: <CAGhQ9Vw_Bz3NW3maAt-epP5Bd3svUALBG=1dfg2_tuD0a=PtRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 4, 2012 at 5:11 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> With commit c334bc1 (ARM: make mach/io.h include optional), PCMCIA was
> broken as PCMCIA depends on __io() being just a cast. This needs a better
> fix with a fixed i/o address mapping, but for now we just restore things
> to the previous behavior.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: Joachim Eastwood <joachim.eastwood@jotron.com>
> Cc: Paul Parsons <lost.distance@yahoo.com>
> ---
> ?arch/arm/include/asm/io.h | ? ?6 ++++--
> ?1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
> index df0ac0b..00262a4 100644
> --- a/arch/arm/include/asm/io.h
> +++ b/arch/arm/include/asm/io.h
> @@ -118,6 +118,8 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
> ?*/
> ?#ifdef CONFIG_NEED_MACH_IO_H
> ?#include <mach/io.h>
> +#elif defined(CONFIG_PCCARD)
> +#define __io(a) ? ? ? ? ? ? ? ?__typesafe_io(a)
> ?#else
> ?#define __io(a) ? ? ? ? ? ? ? ?({ (void)(a); __typesafe_io(0); })
> ?#endif
> @@ -134,9 +136,9 @@ static inline void __iomem *__typesafe_io(unsigned long addr)
> ?* readb() et.al. on such platforms.
> ?*/
> ?#ifndef IO_SPACE_LIMIT
> -#if defined(CONFIG_PCMCIA_SOC_COMMON) || defined(CONFIG_PCMCIA_SOC_COMMON_MODULE)
> +#if defined(CONFIG_PCCARD)
> ?#define IO_SPACE_LIMIT ((resource_size_t)0xffffffff)
> -#elif defined(CONFIG_PCI) || defined(CONFIG_ISA) || defined(CONFIG_PCCARD)
> +#elif defined(CONFIG_PCI) || defined(CONFIG_ISA)
> ?#define IO_SPACE_LIMIT ((resource_size_t)0xffff)
> ?#else
> ?#define IO_SPACE_LIMIT ((resource_size_t)0)
> --
> 1.7.5.4

This doesn't work on my AT91RM9200 board. It still fails with the same
error as without this patch.
  [   80.500000] pata_pcmcia: probe of 0.0 failed with error -12

regards
Joachim Eastwood

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
