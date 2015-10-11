From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 11 Oct 2015 11:54:49 +0200 (CEST)
Subject: [PATCH v5 1/3] initialize each mbigen device node as a interrupt
 controller.
In-Reply-To: <20151010110942.52d34a4b@arm.com>
References: <1443605949-15396-1-git-send-email-majun258@huawei.com>
 <1443605949-15396-2-git-send-email-majun258@huawei.com>
 <alpine.DEB.2.11.1509302242220.4500@nanos> <5610D3BD.1040408@huawei.com>
 <alpine.DEB.2.11.1510091441200.6097@nanos> <5618D3EC.6050501@huawei.com>
 <20151010110942.52d34a4b@arm.com>
Message-ID: <alpine.DEB.2.11.1510111150270.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 10 Oct 2015, Marc Zyngier wrote:
> On Sat, 10 Oct 2015 17:01:32 +0800
> "majun (F)" <majun258@huawei.com> wrote:
> > But there is a problem If i make the structure like you said.
> > 
> > For example, my hardware structure likes below:
> > 
> > uart ------> mbigen --> ITS-pMSI --> ITS --> GIC
> >      virq1
> > 
> > virq1 means the virq number allocted by irq_of_parse_and_map() function
> > when system parse the uart dts node in initializing  stage.
> > 
> > To create a ITS device, I need to call msi_domain_alloc_irqs() function
> > in my mbigen alloc function.
> > 
> > In this function, a new virq number(named as virq2 ) which different from
> > virq1 is allocated.
> > So, this is a big problem.
> 
> I think I see what your problem is:
> - The wired interrupt (uart -> mbigen) is allocated through DT (and
>   must be available early, because of of_platform_populate),
> - The MSI (mgigen -> ITS) is dynamic (and allocated much later,
>   because the device model kicks in after irqchip init, and we cannot
>   allocate MSIs without a device).

Why do we need that wired interrupt at all? 

We can make mbigen the 'msi-parent' of the device and let the
msi_domain_ops::msi_prepare() callback figure out the actual wiring
through device->fwnode.

Thanks,

	tglx
