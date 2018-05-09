From: jeffy.chen@rock-chips.com (JeffyChen)
Date: Wed, 09 May 2018 10:21:34 +0800
Subject: [RESEND PATCH] pinctrl: rockchip: Disable interrupt when changing
 it's capability
In-Reply-To: <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
References: <20180503065553.7762-1-jeffy.chen@rock-chips.com>
 <20180507221511.GA6448@rodete-desktop-imager.corp.google.com>
 <5AF0FF18.1050905@rock-chips.com>
 <20180508015623.GA61455@rodete-desktop-imager.corp.google.com>
 <CAD=FV=W_v+aoNT09k-2exVABTFzOp0heY-XWcLi95uPisZhiGQ@mail.gmail.com>
Message-ID: <5AF25B2E.8080901@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 05/09/2018 03:46 AM, Doug Anderson wrote:
> One note is that in the case Brian points at (where we need to
> simulate EDGE_BOTH by swapping edges) we purposely ignored the TRM and
> we needed to do that to avoid losing interrupts.  For details, see
> commit 53b1bfc76df2 ("pinctrl: rockchip: Avoid losing interrupts when
> supporting both edges").  We did this because:
>
> 1. We believed that the IP block in Rockchip SoCs has nearly the same
> logic as "gpio-dwapb.c" and that's what "gpio-dwapb.c" did.
>

hmm, but i saw the gpio-dwapb.c actually toggle trigger after handle 
irq, which might avoid the race Brian mentioned:
+               generic_handle_irq(gpio_irq);
+               irq_status &= ~BIT(hwirq);
+
+               if ((irq_get_trigger_type(gpio_irq) & IRQ_TYPE_SENSE_MASK)
+                       == IRQ_TYPE_EDGE_BOTH)
+                       dwapb_toggle_trigger(gpio, hwirq);


and i also saw ./qcom/pinctrl-msm.c do the 
toggle(msm_gpio_update_dual_edge_pos) at the end of 
msm_gpio_irq_set_type and msm_gpio_irq_ack, that seems can avoid the 
polarity races too.

> 2. We were actually losing real interrupts and this was the only way
> we could figure out how to fix it.
>
> When I tested that back in the day I was fairly convinced that we
> weren't losing any interrupts in the EDGE_BOTH case after my fix, but
> I certainly could have messed up.
>
>
> For the EDGE_BOTH case it was important not to lose an interrupt
> because, as you guys are talking about, we could end up configured the
> wrong way.  I think in your case where you're just picking one
> polarity losing an interrupt shouldn't matter since it's undefined
> exactly if an edge happens while you're in the middle of executing
> rockchip_irq_set_type().  Is that right?

right, so we now have 2 cases: rockchip_irq_demux/ rockchip_irq_set_type

if i'm right about the spurious irq(only happen when set rising for a 
high gpio, or set falling for a low gpio), then:

1/ rockchip_irq_demux
it's important to not losing irqs in this case, maybe we can

a) ack irq
b) update polarity for edge both irq

we don't need to disable irq in b), since we would not hit the spurious 
irq cases here(always check gpio level to toggle it)


2/ rockchip_irq_set_type
it's important to not having spurious irqs

so we can disable irq during changing polarity only in these case:
((rising && gpio is heigh) || (falling && gpio is low))

i'm still confirming the spurious irq with IC guys.

>
>
> -Doug
>
>
>
