From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 14 Jan 2015 09:31:30 +0100
Subject: [PATCH v2 1/5] irqchip: add dumb demultiplexer implementation
In-Reply-To: <alpine.DEB.2.11.1501132153210.5526@nanos>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-2-git-send-email-boris.brezillon@free-electrons.com>
 <alpine.DEB.2.11.1501132153210.5526@nanos>
Message-ID: <20150114093130.3923a89a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Tue, 13 Jan 2015 22:00:55 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Tue, 13 Jan 2015, Boris Brezillon wrote:
> > +	ret = irq_set_handler_data(irq, demux);
> > +	if (ret) {
> > +		pr_err("Failed to assign handler data\n");
> > +		goto err_free_domain;
> > +	}
> > +
> > +	irq_set_chained_handler(irq, irq_dumb_demux_handler);
> > +
> > +	/*
> > +	 * Disable the src irq (automatically enabled by
> > +	 * irq_set_chained_handler) to prevent irqs from happening while
> > +	 * nobody requested any of the demuxed irqs.
> > +	 */
> > +	disable_irq(irq);
> 
> We rather prevent the startup of the irq line right away.

Yep, the comment was here to draw the attention, since I wasn't sure
modifying core code was the best solution.
Anyway I agree that keeping the src_irq disabled when registering the
chained handler is better than doing it afterwards.

> 
> enum {
>      IRQ_CHAINED_NONE,
>      IRQ_CHAINED_STARTUP,
>      IRQ_CHAINED_NOSTARTUP,
> };
> 
> -__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chained,
> -                  const char *name);
> +__irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int chained_mode,
> +                  const char *name);
> 
> {
> ....
>         if (handle != handle_bad_irq && chained_mode) {
>                 irq_settings_set_noprobe(desc);
>                 irq_settings_set_norequest(desc);
>                 irq_settings_set_nothread(desc);
> -               irq_startup(desc, true);
> +               if (chained_mode == IRQ_CHAINED_STARTUP)
> +                       irq_startup(desc, true);
> 	}
> ....
> }
> 
> Hmm?

I'm fine with this approach, with a static inline helper:

static inline void
irq_set_chained_handler_nostartup(unsigned int irq,
				  irq_flow_handler_t handle)
{
	__irq_set_handler(irq, handle, IRQ_CHAINED_NOSTARTUP, NULL);
}

Anyway, I'll wait a clear decision regarding which approach should be
taken (see my answer to Rob) before sending a new version.

Thanks for your reviews.

Best Regards,

Boris


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
