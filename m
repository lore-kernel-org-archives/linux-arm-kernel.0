From: swarren@nvidia.com (Stephen Warren)
Date: Tue, 29 Nov 2011 15:22:53 -0800
Subject: [PATCH V2] arm/tegra: convert tegra20 to GIC devicetree binding
In-Reply-To: <4ED567DA.6030601@gmail.com>
References: <1322528052-6516-1-git-send-email-swarren@nvidia.com>
 <4ED4D78A.6000400@ti.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAFADC@HQMAIL01.nvidia.com>
 <4ED51AC4.50303@ti.com> <4ED537FB.1010307@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAFBEA@HQMAIL01.nvidia.com>
 <4ED55BBB.4040805@gmail.com>
 <74CDBE0F657A3D45AFBB94109FB122FF174FDAFC64@HQMAIL01.nvidia.com>
 <4ED567DA.6030601@gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF174FDAFC84@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring wrote at Tuesday, November 29, 2011 4:17 PM:
> On 11/29/2011 04:58 PM, Stephen Warren wrote:
...
> > I've been looking at hooking up the Tegra GPIO controller's IRQ support
> > through device tree. It looks like I need to call irq_domain_add_simple()
> > for the GPIO node to make this work, and I think this needs to be triggered
> > by of_irq_init()'s match table, and hence I need a single of_irq_init()
> > call in Tegra's board-dt.c, which includes both the GIC and GPIO controller
> > entries.
> >
> > Is my understanding here all correct? If so, I will just follow your
> > initial suggestion and have tegra_init_irq() do just:
> 
> Yes, you should have 1 of_irq_init call. Really the irqdomain code
> should go into the gpio code.

It sounds like you're saying:

* The of_irq_init() call doesn't have to include all the IRQ controllers
  in the system.
* So, it's fine for the Tegra GPIO controller's probe() function to
  simply call irq_domain_add_simple() for itself.

Is that correct? If so, I'll gladly add the call to the GPIO controller
and leave just the GIC to be handled via of_irq_init().

The only issue here is the usual device ordering issue; if the Tegra GPIO
controller doesn't probe before devices that use it, then the IRQ domain
won't exist. But, this is true for the interrupts themselves, so nothing
new there.

> Do you use generic irqchip for gpio?

No, it's custom code. Some of the code could probably use the generic
code, but there is some additional functionality beyond that.

> If
> so, I'm working on a patch adding irqdomain to generic irqchip. I still
> need to debug a problem with it and have been too busy to get back to it.

-- 
nvpublic
