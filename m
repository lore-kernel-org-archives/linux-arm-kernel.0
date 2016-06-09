From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 9 Jun 2016 10:44:01 +0200
Subject: [PATCH v3 05/12] ARM: shmobile: r8a7792: add SMP support
In-Reply-To: <7848375.HIECFST0Ua@wasted.cogentembedded.com>
References: <12536856.AsKMEpuejQ@wasted.cogentembedded.com>
 <7848375.HIECFST0Ua@wasted.cogentembedded.com>
Message-ID: <CAMuHMdXe==X8x5Q2Hnm7kPp9THwvqVq95imwGoAQyDQv=8=P3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Wed, Jun 8, 2016 at 11:15 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Add R8A7792 SMP support using the shared APMU code. This SoC has 2 ARM
> Cortex-A15  CPU cores.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>
> ---
> Changes in version 3:
> - new patch.
>
>  arch/arm/mach-shmobile/Makefile        |    1
>  arch/arm/mach-shmobile/r8a7792.h       |    6 +++
>  arch/arm/mach-shmobile/setup-r8a7792.c |    2 +
>  arch/arm/mach-shmobile/smp-r8a7792.c   |   62 +++++++++++++++++++++++++++++++++
>  4 files changed, 71 insertions(+)
>
> Index: renesas/arch/arm/mach-shmobile/Makefile
> ===================================================================
> --- renesas.orig/arch/arm/mach-shmobile/Makefile
> +++ renesas/arch/arm/mach-shmobile/Makefile
> @@ -35,6 +35,7 @@ smp-$(CONFIG_ARCH_SH73A0)     += smp-sh73a0.
>  smp-$(CONFIG_ARCH_R8A7779)     += smp-r8a7779.o headsmp-scu.o platsmp-scu.o
>  smp-$(CONFIG_ARCH_R8A7790)     += smp-r8a7790.o
>  smp-$(CONFIG_ARCH_R8A7791)     += smp-r8a7791.o
> +smp-$(CONFIG_ARCH_R8A7792)     += smp-r8a7792.o
>  smp-$(CONFIG_ARCH_EMEV2)       += smp-emev2.o headsmp-scu.o platsmp-scu.o
>
>  # PM objects
> Index: renesas/arch/arm/mach-shmobile/r8a7792.h
> ===================================================================
> --- /dev/null
> +++ renesas/arch/arm/mach-shmobile/r8a7792.h
> @@ -0,0 +1,6 @@
> +#ifndef __ASM_R8A7792_H__
> +#define __ASM_R8A7792_H__
> +
> +extern const struct smp_operations r8a7792_smp_ops;

For new SMP support, you should no longer add an SoC-specific struct
smp_operations, but rely on the DT "enable-method" property, cfr.
"[PATCH v3 00/09] ARM: shmobile: APMU DT support via SMP Enable method V3"
(http://www.spinics.net/lists/linux-sh/msg45229.html).

That series will no longer apply, but I've been carrying (and rebasing) it in
my local tree for quite a while, as it was related to SYSC cleanup (avoiding
your r8a7792_ca15_scu). But unfortunately that depends on the SYSC node always
be present in DT.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
