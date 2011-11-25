From: robherring2@gmail.com (Rob Herring)
Date: Fri, 25 Nov 2011 09:19:47 -0600
Subject: GIC irq_start detection breaks 3.2 boot on platforms without PPIs
In-Reply-To: <20111124163548.GC22031@mudshark.cambridge.arm.com>
References: <20111124163548.GC22031@mudshark.cambridge.arm.com>
Message-ID: <CAL_Jsq+xZayXkOy2v7y+BittjRfC85mw-bCMrDFwDJOvnMnS8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Thu, Nov 24, 2011 at 10:35 AM, Will Deacon <will.deacon@arm.com> wrote:
> Hi Rob,
>
> In commit 4294f8baa ("ARM: gic: add irq_domain support"), you define
> irq_start as irq_start = (irq_start & ~31) + 16; (later this was predicated
> on irq_start > 0).
>
> For platforms without any PPIs (i.e. irq_start is passed as a multiple of
> 32) then this leads to IRQs being off by 16. Something like this fixes it:
>

Which platform? I thought I surveyed all the users. I was assuming we
only skip over PPIs on secondary GICs and primary GICs alway have PPIs
allocated. There's not really any cost to always allocating PPIs.

>
> diff --git a/arch/arm/common/gic.c b/arch/arm/common/gic.c
> index 0e6ae47..0c2d077 100644
> --- a/arch/arm/common/gic.c
> +++ b/arch/arm/common/gic.c
> @@ -581,13 +581,16 @@ void __init gic_init(unsigned int gic_nr, int irq_start,
> ? ? ? ? * For primary GICs, skip over SGIs.
> ? ? ? ? * For secondary GICs, skip over PPIs, too.
> ? ? ? ? */
> + ? ? ? domain->hwirq_base = 32;
> ? ? ? ?if (gic_nr == 0) {
> ? ? ? ? ? ? ? ?gic_cpu_base_addr = cpu_base;
> - ? ? ? ? ? ? ? domain->hwirq_base = 16;
> - ? ? ? ? ? ? ? if (irq_start > 0)
> - ? ? ? ? ? ? ? ? ? ? ? irq_start = (irq_start & ~31) + 16;
> - ? ? ? } else
> - ? ? ? ? ? ? ? domain->hwirq_base = 32;
> +
> + ? ? ? ? ? ? ? if ((irq_start & 31) > 0) {
> + ? ? ? ? ? ? ? ? ? ? ? domain->hwirq_base = 16;
> + ? ? ? ? ? ? ? ? ? ? ? if (irq_start != -1)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? irq_start = (irq_start & ~31) + 16;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
>
> ? ? ? ?/*
> ? ? ? ? * Find out how many interrupts are supported.
>
>
> which I can't say I'm especially pleased with but this code is really hard to
> get right!
>

Obviously! The problem is the meaning of irq_start is overloaded. It
defines the number of PPIs and the Linux irq # base.

Otherwise, looks fine.

Rob
