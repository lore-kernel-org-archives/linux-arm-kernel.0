From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Aug 2014 06:53:02 -0700
Subject: [PATCH v3] irqchip: gic: Allow gic_arch_extn hooks to call into
 scheduler
In-Reply-To: <alpine.LFD.2.11.1408122205060.6061@knanqh.ubzr>
References: <1407891264-4826-1-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.11.1408122205060.6061@knanqh.ubzr>
Message-ID: <20140813135300.GC32301@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12, Nicolas Pitre wrote:
> On Tue, 12 Aug 2014, Stephen Boyd wrote:
> > 
> > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > index 7c131cf7cc13..c1dc65209899 100644
> > --- a/drivers/irqchip/irq-gic.c
> > +++ b/drivers/irqchip/irq-gic.c
> > @@ -81,6 +81,11 @@ static DEFINE_RAW_SPINLOCK(irq_controller_lock);
> >  #define NR_GIC_CPU_IF 8
> >  static u8 gic_cpu_map[NR_GIC_CPU_IF] __read_mostly;
> >  
> > +#ifdef CONFIG_BL_SWITCHER
> > +/* Synchronize switching CPU interface and sending SGIs */
> > +static DEFINE_RAW_SPINLOCK(gic_sgi_lock);
> 
> What about ...
> 
> #define sgi_map_lock(flags) raw_spin_lock_irqsave(&gic_sgi_lock, flags)
> #define sgi_map_unlock(flags) raw_spin_unlock_irqrestore(&gic_sgi_lock, 
> flags)
> #else sgi_map_lock(flags) (void)(flags)
> #define sgi_map_unlock(flags) (void)(flags)
> 
> That would avoid some #ifdefs in the main code.

Sure. v4 shortly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
