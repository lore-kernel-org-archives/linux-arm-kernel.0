From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 27 Nov 2014 22:45:02 +0100 (CET)
Subject: [PATCH 3.18-rc4 v11 3/6] irqchip: gic: Make gic_raise_softirq
 FIQ-safe
In-Reply-To: <1417119024-22844-4-git-send-email-daniel.thompson@linaro.org>
References: <1415968543-29469-1-git-send-email-daniel.thompson@linaro.org>
 <1417119024-22844-1-git-send-email-daniel.thompson@linaro.org>
 <1417119024-22844-4-git-send-email-daniel.thompson@linaro.org>
Message-ID: <alpine.DEB.2.11.1411272238190.3961@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Nov 2014, Daniel Thompson wrote:
> It is currently possible for FIQ handlers to re-enter gic_raise_softirq()
> and lock up.
> 
>     	gic_raise_softirq()
> 	   lock(x);
> -~-> FIQ
>         handle_fiq()
> 	   gic_raise_softirq()
> 	      lock(x);		<-- Lockup
> 
> Calling printk() from a FIQ handler can trigger this problem because
> printk() raises an IPI when it needs to wake_up_klogd(). More generally,
> IPIs are the only means for FIQ handlers to safely defer work to less
> restrictive calling context so the function to raise them really needs
> to be FIQ-safe.

That's not really true. irq_work can be used from FIQ/NMI context and
it was specifically designed for that purpose.
 
Now printk is a different issue, but there is work in progress to make
printk safe from FIQ/NMI context as well. This is not an ARM specific
issue. Any architecture which has NMI like facilities has the problem
of doing printk from that context. Steven is working on a mitigation
for that. https://lkml.org/lkml/2014/11/18/1146

Thanks,

	tglx
