From: slash.tmp@free.fr (Mason)
Date: Tue, 16 May 2017 13:43:09 +0200
Subject: Asking for guidance in writing IRQ controller driver
In-Reply-To: <99c32a84-c064-06c8-799d-a5aa1794ba0d@free.fr>
References: <99c32a84-c064-06c8-799d-a5aa1794ba0d@free.fr>
Message-ID: <4cf2a2da-a229-8ff4-2d08-6cd2d78fce3f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2017 14:49, Mason wrote:

> In the tango family, there are two revisions of the interrupt controller
> that I want to support, ideally within the same driver.
> 
> Rev 1:
>  Input lines: 64 sources (63 devices + 1 SW)
> Output lines:  3 destinations, connected to GIC lines 2-4
> 
> Sources can be ignored (disabled), or routed to one of
> the 3 destinations. Right now, sources get routed to
> a specific output based on which parent is declared in
> the DT. I think this was described as not quite correct
> in previous discussions?
> 
> As a first approximation, routing everything to irq0 seems
> good enough. I suppose routing something to a different
> output would be useful only when trying to do some kind
> of interrupt load balancing?
> 
> 
> Rev 2: more of everything
>  Input lines: 128 sources (124 devices + 1 SW + 3 reserved for backward-compatibility with Rev 1)
> Output lines:  24 destinations, connected to GIC lines 0-23
> 
> 
> Of course, the register layouts are completely different,
> since the HW designers felt that the solution in rev1
> (cloning register sets for each output) was inadequate
> for rev2.
> 
> The driver I've been using until now is drivers/irqchip/irq-tango.c
> I'm willing to write a new driver from scratch, if necessary.
> 
> IIUC, the DT node for the interrupt controller should just
> mention number of inputs, number of outputs?
> 
> And let user-space assign devices to a specific output?
> (Using what user-space tool?)
> 
> So the driver would initially map everything to output line 0,
> which would interrupt cpu0 (how to change that from user-space?)
> and then individual devices can be moved to other outputs,
> for specific use cases (implemented later as an optimization?)
> 
> 
> I have to give all this a bit more thought before I start coding
> something up.

I'll try to ask specific questions.

It seems clear that I'll need to define an irq_domain.

I have used irq_domain_create_linear() in the past.

But I also see other people use irq_domain_create_hierarchy()
which calls irq_domain_create_linear() but also sets
domain->parent

But now I'm left wondering how the code that doesn't set
domain->parent works... How does the irq framework know
how to "tie" this new domain into the mix... Probably by
walking the DT? So setting the parent is not required then?

Regards.
