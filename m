From: robherring2@gmail.com (Rob Herring)
Date: Mon, 12 Jan 2015 08:14:46 -0600
Subject: [PATCH v2 00/21] irqchip: gic: killing gic_arch_extn and co,
 slowly
In-Reply-To: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
References: <1420652576-22309-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAL_JsqLLGn1mZr7eNuLA1=M7BcwFRdOQ6xQGo+bbc2aScAVrnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 7, 2015 at 11:42 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> The gic_arch_extn hack that a number of platform use has been nagging
> me for too long. It is only there for the benefit of a few platform,
> and yet it impacts all GIC users. Moreover, it gives people the wrong
> idea ("let's use it to put some new custom hack in there"...).
>
> But now that stacked irq domains have landed in -next, the time has
> come for gic_arch_extn to meet the Big Bit Bucket.

[...]

> - This actively *breaks* existing setups. Once you boot a new kernel
>   with an old DT, suspend/resume *will* be broken. Old kernels on a
>   new DT won't even boot! You've been warned. This really outline the
>   necessity of actually describing the HW in device trees...

Just to be clear, you need some agreement from the maintainers of
those platforms before doing this. It doesn't appear there is
disagreement, but I don't see any explicit agreement either.

This seems to model the interrupts as chained, but at least for some
cases aren't these auxiliary controllers in parallel to the GIC? In
other words, do the they require configuration for interrupts to work
for the normal non-wakeup use? I'm not sure that the h/w is being
modeled any more accurately if that is the case. However, we don't
really have a way to describe an interrupt line is connected to 2
interrupt parents in DT, so I'm not sure what else you could do here.

Rob
