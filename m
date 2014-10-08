From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 8 Oct 2014 19:50:53 +0800
Subject: [PATCH 3/3] irqchip: dw-apb-ictl: add PM support
In-Reply-To: <543523B1.1060002@gmail.com>
References: <1411454100-6814-1-git-send-email-jszhang@marvell.com>
 <1411454100-6814-4-git-send-email-jszhang@marvell.com>
 <542AA336.6070206@gmail.com>
 <alpine.DEB.2.11.1409302351500.4455@nanos>
 <20141008193123.11f42bb0@xhacker> <543523B1.1060002@gmail.com>
Message-ID: <20141008195053.0e8aeaf0@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

On Wed, 8 Oct 2014 04:44:49 -0700
Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com> wrote:

> On 10/08/2014 01:31 PM, Jisheng Zhang wrote:
> > Hi Thomas, Sebastian,
> >
> > On Tue, 30 Sep 2014 14:52:54 -0700
> > Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> On Tue, 30 Sep 2014, Sebastian Hesselbarth wrote:
> >>> On 09/23/2014 08:35 AM, Jisheng Zhang wrote:
> >>>> This patch adds in support for S2R for dw-apb-ictl irqchip driver.
> >>>>
> >>>> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> >>>> ---
> >>>>    drivers/irqchip/irq-dw-apb-ictl.c | 19 +++++++++++++++++++
> >>>>    1 file changed, 19 insertions(+)
> >>>>
> >>>> diff --git a/drivers/irqchip/irq-dw-apb-ictl.c
> >>>> b/drivers/irqchip/irq-dw-apb-ictl.c
> >>>> index c136b67..53bb732 100644
> >>>> --- a/drivers/irqchip/irq-dw-apb-ictl.c
> >>>> +++ b/drivers/irqchip/irq-dw-apb-ictl.c
> >>>> @@ -50,6 +50,21 @@ static void dw_apb_ictl_handler(unsigned int irq,
> >>>> struct irq_desc *desc)
> >>>>    	chained_irq_exit(chip, desc);
> >>>>    }
> >>>>
> >>>> +#ifdef CONFIG_PM
> >>>> +static void dw_apb_ictl_resume(struct irq_data *d)
> >>>> +{
> >>>> +	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
> >>>> +	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> >>>> +
> >>>> +	irq_gc_lock(gc);
> >>>> +	writel_relaxed(~0, gc->reg_base + ct->regs.enable);
> >>>> +	writel_relaxed(*ct->mask_cache, gc->reg_base + ct->regs.mask);
> >>>> +	irq_gc_unlock(gc);
> >>>> +}
> >>>
> >>> I agree with the overall change, but may this also be suited for a
> >>> generic irq_chip helper instead of being a driver specific one?
> >>>
> >>> Maybe Thomas or Jason can comment on this.
> >>
> >> If we have enough similar resume callbacks, yes.
> >>
> >>> Also, now that you are using writel_relaxed, I understand that both
> >>> writes above can happen in any order? Are there any implication we
> >>> have to consider, i.e. do we require any of the registers above to
> >>> be written first?
> >
> > The registers sits at device type memory, the writes should happen in the
> > same order as before.
> 
> Jisheng,
> 
> it is not about the location of the register but, as far as I
> understand, when using {readl,writel}_relaxed the compiler is
> free to reorder the calls. So, if there is a strict order we

The "volatile" in readl/writel relaxed implementations should prevent the
compiler to do reorder. Or I misunderstand something?

Thanks,
Jisheng

> want to ensure, we have to use non-relaxed {readl,writel}.
> 
> The performance penalty of non-relaxed calls can be ignored anyway
> as it is done only once after resume.
> 
> Sebastian
