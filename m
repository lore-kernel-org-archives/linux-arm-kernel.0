From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Aug 2015 21:38:16 +0100
Subject: IRQ setup on multicore systems (routing, balancing, etc)
In-Reply-To: <55C387F6.8090708@free.fr>
References: <55C0C102.7050600@free.fr> <55C37A72.2090507@free.fr>
 <20150806152654.GF7557@n2100.arm.linux.org.uk>
 <55C387F6.8090708@free.fr>
Message-ID: <20150806203816.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 06:14:46PM +0200, Mason wrote:
> It doesn't help that the port I'm working on doesn't follow
> "established guidelines". In this case, interrupt routing is
> hard-coded in the platform code:
> 
> static inline void tangox_enable(struct irq_data *data)
> {
> 	int bit = data->irq - IRQ_CONTROLLER_IRQ_BASE;
> #ifdef ENABLE_INTERRUPT_ON_CPU1
> 	if(route_interrupt_to_cpu1(bit))
> 		tangox_fiq_enable(bit);
> 	else
> #endif
> 		tangox_irq_enable(bit);
> }
> 
> (tangox_enable is called in the .irq_startup struct irq_chip callback.)
> 
> Throw weird naming in the mix (I thought FIQ was reserved for
> the secure world, and my Linux runs in non-secure) and my
> confusion level is up to 11.

Looking at the above code, I must say that it looks like the code is on
some kind of drugs.  The code implies that FIQs are routed to CPU1, which
is obviously a totally insane.  I think I'd be as confused as you over
that.

Are you basing your idea that certain interrupts need to be routed to a
certain CPU on this code, or on practical experience?  It may be better
to experiment with the hardware to find out what's possible rather than
rely on hacky undocumented code such as the above.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
