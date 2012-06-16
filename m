From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 16 Jun 2012 10:35:09 +0800
Subject: How to use linear mapping without DT?
In-Reply-To: <4FDB639D.4060103@atmel.com>
References: <4FD9B4DC.80706@atmel.com>
 <20120615160155.GN31565@S2101-09.ap.freescale.net>
 <4FDB639D.4060103@atmel.com>
Message-ID: <20120616023507.GC29663@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 15, 2012 at 06:32:29PM +0200, ludovic.desroches wrote:
> I've seen your patch series and I am wondering what is the
> difference between these two solutions:
> - not using nr_irqs: you will have NR_IRQS_LEGACY irqdescs allocated
> and you will allocate the irqdescs for your controller just after by
> calling irq_alloc_descs so you will have to manage the
> NR_IRQS_LEGACY offset.
> - using nr_irqs: you will have all your irqdescs allocated and won't
> have to manage the NR_IRQS_LEGACY offset.
> 
First of all, NR_IRQS_LEGACY shifting is a good thing we are actually
looking for because we want to reserve virq number 0 for no-interrupt
case. [1]

Secondly, with .nr_irqs approach, you will have to somehow maintain
irq_base for each irqchip, which is needed when adding legacy domain.
Calling irq_alloc_descs will just return you the irq_base.

Lastly, irq_alloc_descs approach can save irqdesc than .nr_irq in some
cases, where not all the irqchips get instantiated for every single
boot.  That's said, .nr_irqs has to be set the possible maximum numbers
for the machine, while some irqchips, e.g. peripheral/device inside
ones, are not always instantiated.  irq_alloc_descs approach will save
irqdescs for such cases.

Regards,
Shawn

[1] http://thread.gmane.org/gmane.linux.kernel.next/18991/focus=10108
