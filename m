From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Mar 2013 18:38:22 +0000
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <20130326181754.33b89559@skate>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303261707.41563.arnd@arndb.de> <20130326181754.33b89559@skate>
Message-ID: <201303261838.23246.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 March 2013, Thomas Petazzoni wrote:

> 
> I've tried to explain that in the commit log of PATCH 6, which says:
> 
>     However, we need the driver to expose two different IRQ domains: one
>     for the main interrupt controller itself, and one for the MSI
>     interrupt controller. In order to achieve this, we will create two
>     subnodes in the interrupt-controller at d0020000 node: one subnode for
>     the main interrupt controller, and one subnode for the MSI interrupt
>     controller. The two irq domains can't be registered on the same DT
>     node, otherwise when irq_find_host() gets used by of_irq_map_one()
>     to resolve IRQs of devices, they may find the MSI interrupt
>     controller instead of the main interrupt controller.

Right, I should have read the commit log better ...

>     Note that both the parent and the child node need to have the
>     'interrupt-controller' empty property:
>     
>       * The interrupt-controller property is needed in the main
>     interrupt controller node (interrupt-controller at d0020000) because
>     the of_irq_init() function skips nodes that are matching the given
>        compatible string, but that don't have the interrupt-controller
>        property.
>     
>      * The interrupt-controller property is needed in the child
>     interrupt controller node (main-intc at d0020000) otherwise the
>     resolution done by of_irq_map_one() doesn't work.

If you add compatible properties to the children, that would work
I suppose.

> So really, the thing is that irq_domain_add_linear() registers an IRQ
> domain on a specific DT node, and then irq_find_host() finds back an
> IRQ domain from a given DT node. So if you have two IRQ domains
> registered on the same DT node, then you don't know which one will be
> used.
> 
> So if I do the two irq_domain_add_linear() (one for MPIC, one for MSI)
> on one single DT node, when the timer driver will request its
> interrupt, it turns out that the MSI IRQ domain is used and not the
> MPIC IRQ domain, even though the timer has <&mpic> as its interrupt
> parent.

I still wonder if the real solution shouldn't instead be to make the
irq domain code MSI aware. For instance, you don't really need a
cell to describe an interrupt because the interrupt number is
not a hardware property. So an MSI using device doesn't really
needs an "msis" or "interrupts" property, just an "msi-parent",
and we can add code to handle as a separate domain even if you
have a single device node that can do both level and message
interrupts.

	Arnd
