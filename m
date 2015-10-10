From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat, 10 Oct 2015 11:09:42 +0100
Subject: [PATCH v5 1/3] initialize each mbigen device node as a
 interrupt controller.
In-Reply-To: <5618D3EC.6050501@huawei.com>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos>
 <5610D3BD.1040408@huawei.com>
 <alpine.DEB.2.11.1510091441200.6097@nanos>
 <5618D3EC.6050501@huawei.com>
Message-ID: <20151010110942.52d34a4b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Oct 2015 17:01:32 +0800
"majun (F)" <majun258@huawei.com> wrote:

> 
> 
> ? 2015/10/9 21:47, Thomas Gleixner ??:
> > On Sun, 4 Oct 2015, majun (F) wrote:
> >>>> +	info->reg_offset = get_mbigen_vec_reg_addr(info->nid, info->local_pin_offset);
> >>>
> >>> So you fill in a structure with 5 fields and the only information
> [...]
> >> On the other hand, it's a interrupt controller for the devices
> >> connected to it.(handled in current patch).
> >>
> >> To bind these two different irqs, I made a data sutruce named
> >> mbigen_irq_data which contains some information of this irq,
> >> including private index, pin_offset, nid, and local_pin_offset.
> >>
> >> All these information can help us to find the corresponding reg addr
> >> and msi_irq quickly.
> > 
> > This is completely wrong. Why would you need two linux virq numbers
> > for one interrupt?
> > 
> > This needs to be expressed in one hierarchy. mbigen is just a
> > translator between wired interrupts and MSI, nothing else.
> > 
> > So the hierarchy is:
> > 
> >   mbigen -> ITS-MSI -> ITS -> GIC
> 
> I think maybe you mean: mbigen -> ITS-pMSI -> ITS- > GIC
> 
> But there is a problem If i make the structure like you said.
> 
> For example, my hardware structure likes below:
> 
> uart ------> mbigen --> ITS-pMSI --> ITS --> GIC
>      virq1
> 
> virq1 means the virq number allocted by irq_of_parse_and_map() function
> when system parse the uart dts node in initializing  stage.
> 
> To create a ITS device, I need to call msi_domain_alloc_irqs() function
> in my mbigen alloc function.
> 
> In this function, a new virq number(named as virq2 ) which different from
> virq1 is allocated.
> So, this is a big problem.

I think I see what your problem is:
- The wired interrupt (uart -> mbigen) is allocated through DT (and
  must be available early, because of of_platform_populate),
- The MSI (mgigen -> ITS) is dynamic (and allocated much later,
  because the device model kicks in after irqchip init, and we cannot
  allocate MSIs without a device).

So we end-up with two virqs that need to be reconciled one way or
another. Is that an accurate description of your problem?

This is a silly situation, because there is no multiplexing at all
(there is exactly one wired interrupt per MSI). It is just that we
don't have the infrastructure to connect the two virtual interrupts.

Thomas, what would you think of extending the MSI layer a bit so that
instead of allocating the virqs dynamically, we could take an
optional array of virqs that would be used? It should be pretty easy to
hack this into msi_domain_alloc_irqs(), and modify the existing callers
(or have a separate entry point altogether). I'm still a bit fuzzy on
how we stitch the domains themselves (we need to set ->parent on
allocating the MSIs, which leaves it being a NULL pointer until then),
but I think there is a way. Something like:

int msi_domain_alloc_stitch_irqs(struct irq_domain *domain,
				 struct irq_domain *parent,
				 struct device *dev,
				 int *virqs, int nvecs);

Naming is crap, but you'll get the idea. Thoughts?

> If we want to use the hierarchy structure, I think
> 
> mbigen -> ITS -> GIC
> 
> maybe is a possible way .
> 
> The only problem is I need to do some change in ITS driver.
> 
> I mean move its_create_device() and its_find_device() into
>  its_irq_domain_alloc()
> 
> But this solution is similar to my v3 patch.

And that was really bad. Let's not go back there.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
