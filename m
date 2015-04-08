From: bjorn@kryo.se (Bjorn Andersson)
Date: Wed, 8 Apr 2015 10:48:47 -0700
Subject: [PATCH v4 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <1426676484-21812-2-git-send-email-marc.zyngier@arm.com>
References: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>
 <1426676484-21812-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <CAJAp7Ogq+4Km=H1o3q3M8F1ntMo3nf=Xt92HSW0N+3OeVaGbSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 4:01 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> There is a number of cases where a kernel subsystem may want to
> introspect the state of an interrupt at the irqchip level:
>
> - When a peripheral is shared between virtual machines,
>   its interrupt state becomes part of the guest's state,
>   and must be switched accordingly. KVM on arm/arm64 requires
>   this for its guest-visible timer
> - Some GPIO controllers seem to require peeking into the
>   interrupt controller they are connected to to report
>   their internal state
>
> This seem to be a pattern that is common enough for the core code
> to try and support this without too many horrible hacks. Introduce
> a pair of accessors (irq_get_irqchip_state/irq_set_irqchip_state)
> to retrieve the bits that can be of interest to another subsystem:
> pending, active, and masked.
>
> - irq_get_irqchip_state returns the state of the interrupt according
>   to a parameter set to IRQCHIP_STATE_PENDING, IRQCHIP_STATE_ACTIVE,
>   IRQCHIP_STATE_MASKED or IRQCHIP_STATE_LINE_LEVEL.
> - irq_set_irqchip_state similarly sets the state of the interrupt.
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Tested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---

Sorry for bothering you Thomas, but we have a couple of driver for the
Qualcomm platforms that depends on this patch (the line level part).
Could you please have a look at it?

Thanks,
Bjorn
