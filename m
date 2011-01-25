From: ccross@android.com (Colin Cross)
Date: Mon, 24 Jan 2011 19:03:42 -0800
Subject: [PATCH 1/5] ARM: gic: Add hooks for architecture specific
	extensions
In-Reply-To: <1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
	<1295859080-15259-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <AANLkTikT=muk5A8MkSe0dXvE-GPsfMn4Am7KuOndvBdi@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 12:51 AM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> Few architectures combine the GIC with an external interrupt controller.
> On such systems it may be necessary to update both the GIC registers
> and the external controller's registers to control IRQ behavior.
>
> This can be addressed in couple of possible methods.
> ?1. ? ? Export common GIC routines along with 'struct irq_chip gic_chip'
> ? ? ? ?and allow architectures to have custom function by override.
>
> ?2. ? ? Provide architecture specific function pointer hooks
> ? ? ? ?within GIC library and leave platforms to add the necessary
> ? ? ? ?code as part of these hooks.
>
> First one might be non-intrusive but have few shortcomings like arch needs
> to have there own custom gic library. Locks used should be common since it
> caters to same IRQs etc. Maintenance point of view also it leads to
> multiple file fixes.
>
> The second probably is cleaner and portable. It ensures that all the
> common GIC infrastructure is not touched and also provides archs to
> address their specific issue.

This method would work for most of Tegra's needs, although we would
need gic_set_type and gic_ack_irq to have arch extensions as well.
However, it does not allow for irq_retrigger, which can be implemented
on Tegra.
