From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 26 Mar 2013 21:46:13 +0100
Subject: [RFCv1 07/11] irqchip: armada-370-xp: add MSI support to
 interrupt controller driver
In-Reply-To: <201303261838.23246.arnd@arndb.de>
References: <1364316746-8702-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201303261707.41563.arnd@arndb.de> <20130326181754.33b89559@skate>
 <201303261838.23246.arnd@arndb.de>
Message-ID: <20130326214613.30fbdddf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Tue, 26 Mar 2013 18:38:22 +0000, Arnd Bergmann wrote:

> >     Note that both the parent and the child node need to have the
> >     'interrupt-controller' empty property:
> >     
> >       * The interrupt-controller property is needed in the main
> >     interrupt controller node (interrupt-controller at d0020000)
> > because the of_irq_init() function skips nodes that are matching
> > the given compatible string, but that don't have the
> > interrupt-controller property.
> >     
> >      * The interrupt-controller property is needed in the child
> >     interrupt controller node (main-intc at d0020000) otherwise the
> >     resolution done by of_irq_map_one() doesn't work.
> 
> If you add compatible properties to the children, that would work
> I suppose.

To which children? Only to the main-intc children? If so,
armada_370_xp_mpic_of_init() would be called with a 'device_node *'
that points to the main-intc, correct? Then it would have to go back up
in the Device Tree to find the msi node? It's doable of course, but
sounds strange, no?

To me, the topology of the hardware is really that a single device
provides two features: the main interrupt controller and the MSI
interrupt controller. But I will adapt to whatever DT binding you
propose.

> > So really, the thing is that irq_domain_add_linear() registers an
> > IRQ domain on a specific DT node, and then irq_find_host() finds
> > back an IRQ domain from a given DT node. So if you have two IRQ
> > domains registered on the same DT node, then you don't know which
> > one will be used.
> > 
> > So if I do the two irq_domain_add_linear() (one for MPIC, one for
> > MSI) on one single DT node, when the timer driver will request its
> > interrupt, it turns out that the MSI IRQ domain is used and not the
> > MPIC IRQ domain, even though the timer has <&mpic> as its interrupt
> > parent.
> 
> I still wonder if the real solution shouldn't instead be to make the
> irq domain code MSI aware. For instance, you don't really need a
> cell to describe an interrupt because the interrupt number is
> not a hardware property. So an MSI using device doesn't really
> needs an "msis" or "interrupts" property, just an "msi-parent",
> and we can add code to handle as a separate domain even if you
> have a single device node that can do both level and message
> interrupts.

So the msi-parent property should point to the single mpic node? But
then the IRQ domain for MSI cannot be registered on this single MPIC
node. Then, what would be the first argument of:

        armada_370_xp_msi_domain =
                irq_domain_add_linear(msi_node, PCI_MSI_DOORBELL_NR,
                                      &armada_370_xp_msi_irq_ops, NULL);

and how would the PCIe driver get a pointer to this IRQ domain? (In the
currently proposed code, it just does a irq_find_host(), which sounded
very simple and straightforward).

To clarify: I really don't mind reworking the code, but unfortunately
"make the IRQ domain code MSI aware" is too vague for me to understand
the direction you're thinking of.

Thanks for your review and comments!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
