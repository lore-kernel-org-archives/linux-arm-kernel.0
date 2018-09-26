From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 26 Sep 2018 14:20:19 +1000
Subject: [PATCH 4/4] dma-mapping: clear dev->dma_ops in
 arch_teardown_dma_ops
In-Reply-To: <20180925201619.GB8413@lst.de>
References: <20180827084711.23407-1-hch@lst.de>
 <20180827084711.23407-5-hch@lst.de> <20180922150119.GA14761@roeck-us.net>
 <20180925201619.GB8413@lst.de>
Message-ID: <87r2hgga9o.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph Hellwig <hch@lst.de> writes:

> Looking at the code I think this commit is simply broken for
> architectures not using arch_setup_dma_ops, but instead setting up
> the dma ops through arch specific magic.

I arch_setup_dma_ops() called from of_dma_configure(), but
pci_dma_configure() doesn't call that for this device:

static int pci_dma_configure(struct device *dev)
{
	...
	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
	    bridge->parent->of_node) {
		ret = of_dma_configure(dev, bridge->parent->of_node, true);

bridge->parent is NULL.

So I don't think arch_setup_dma_ops() would help here?

> I'll revert the patch.

Thanks.

cheers
