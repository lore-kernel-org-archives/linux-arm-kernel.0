From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 11 Aug 2010 08:25:32 +0100
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100811110448S.fujita.tomonori@lab.ntt.co.jp>
References: <m3sk2m433u.fsf@intrepid.localdomain>
	<20100811110448S.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100811072532.GA21511@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 11:06:00AM +0900, FUJITA Tomonori wrote:
> On Tue, 10 Aug 2010 22:36:21 +0200
> Krzysztof Halasa <khc@pm.waw.pl> wrote:
> 
> > 6fee48cd330c68332f9712bc968d934a1a84a32a broke
> > pci_set_consistent_dma_mask() on IXP4xx and most probably PXA. Affected
> > devices are e.g. IDE controller (CS5536-based: disk inaccessible) and
> > e1000 ethernet ("Detected Tx Unit Hang").
> 
> Sorry about that.
> 
> > The attached patch makes it work again, though I'm not sure it's the
> > best solution.
> 
> I think that we should avoid adding "#ifdef CONFIG_DMABOUNCE" to a
> generic place.
> 
> Why the above patch breaks dmabounce.c? We can't set dev->coherent_dma_mask?

It doesn't break dmabounce.

What it breaks is the fact that a PCI device which can do 32-bit DMA is
connected to a PCI bus which can only access the first 64MB of memory
through the host bridge, but the system has more than 64MB available.

Allowing a 32-bit DMA mask means that dmabounce can't detect that memory
above 64MB needs to be bounced to memory below the 64MB boundary.
