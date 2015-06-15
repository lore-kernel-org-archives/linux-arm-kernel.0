From: sudeep.holla@arm.com (Sudeep Holla)
Date: Mon, 15 Jun 2015 10:01:47 +0100
Subject: [PATCH v2 1/1] irqchip: exynos-combiner: Save IRQ enable set
 on suspend
In-Reply-To: <557E82BC.7080203@collabora.co.uk>
References: <1434087795-13990-1-git-send-email-javier.martinez@collabora.co.uk>	<557AB00C.5040606@arm.com>	<557AC23D.8040602@collabora.co.uk>	<557AC85E.5070705@arm.com>	<557AD728.7090908@collabora.co.uk>	<557B34A7.4090507@collabora.co.uk>
 <CAD=FV=UQF+n8AjSXYajqUb0qswcoUrSgnsasV82JaS3dBtNO8Q@mail.gmail.com>
 <557E82BC.7080203@collabora.co.uk>
Message-ID: <557E947B.3030804@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 15/06/15 08:46, Javier Martinez Canillas wrote:
[...]

>
> Sudeep, so we may need something like $subject after all from Doug's
> explanations since the combiner chip state is lost during a S2R. I know
> that it adds more duplicated code (others irqchip drivers do the same)
> and it may not scale well if a chip has many registers but is the best
> solution I could came with.
>

OK

> If you have a suggestion for a better alternative, I can give a try and
> write the patch. But I think $subject could also land to fix this issue
> since is a very non intrusive change and later can be changed once the
> irqchip core supports this use case.
>

Agreed. But I would suggest also to add MASK_ON_SUSPEND and set_irq_wake
also and then you can restore iff it's non-zero as irq core will take
care of most of the non-wakeup sources. Because I am planning to push
MASK_ON_SUSPEND to GIC and it will break this combiner if it assumes the
combiner interrupts are always on in GIC. Implement set_irq_wake as
enable_irq_wake (comb_irq_to_GIC).

Regards,
Sudeep
