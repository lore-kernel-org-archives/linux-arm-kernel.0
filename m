From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 3 Nov 2009 21:27:34 -0500
Subject: [PATCH] Fix PXA-27x/3xx interrupts when CONFIG_PXA_HAVE_ISA_IRQS=y
In-Reply-To: <20091103210439.2a6c1f20@taxman.wild-wind.fr.eu.org>
References: <20091103210439.2a6c1f20@taxman.wild-wind.fr.eu.org>
Message-ID: <771cded00911031827m34f36dc7r1bc7e1096bb98690@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 3, 2009 at 3:04 PM, Marc Zyngier <maz@misterjones.org> wrote:
>
> Commit d2c37068429b29d6549cf3486fc84b836689e122 ([ARM] pxa:
> initialize default interrupt priority and use ICHP for IRQ handling)
> broke ISA interrupt support on PXA-27x/3xx.
>
> In such a case, PXA_IRQ(0) != 0, and the IRQ number computed from
> ICHP must be offset by PXA_IRQ(0).
>
> Tested on an Arcom Zeus (PXA-270).
>
> Signed-off-by: Marc Zyngier <maz@misterjones.org>
> ---
> ?arch/arm/mach-pxa/include/mach/entry-macro.S | ? ?3 +++
> ?1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/include/mach/entry-macro.S b/arch/arm/mach-pxa/include/mach/entry-macro.S
> index 2418806..f7eb9d8 100644
> --- a/arch/arm/mach-pxa/include/mach/entry-macro.S
> +++ b/arch/arm/mach-pxa/include/mach/entry-macro.S
> @@ -46,5 +46,8 @@
> ? ? ? ? ? ? ? ?beq ? ? 1001f
> ? ? ? ? ? ? ? ?bic ? ? \irqstat, \irqstat, #0x80000000
> ? ? ? ? ? ? ? ?mov ? ? \irqnr, \irqstat, lsr #16
> +#ifdef CONFIG_PXA_HAVE_ISA_IRQS
> + ? ? ? ? ? ? ? add ? ? \irqnr, \irqnr, #(PXA_IRQ(0))
> +#endif
> ?1001:
> ? ? ? ? ? ? ? ?.endm
> --
> 1.6.0.4
Hi Marc,

I have a question on this. Do you use CONFIG_PXA_HAVE_ISA_IRQS in
pxa270? In my patch, I only enable interrupt priority in pxa27x and
pxa3xx since silicon can support this feature. And this feature isn't
supported by pxa25x.

I also find that CONFIG_PXA_HAVE_ISA_IRQS is only used in pxa25x. Is
it right? So I think that we needn't add this into pxa27x and pxa3xx.
What's your opinion?

Thanks
Haojian
