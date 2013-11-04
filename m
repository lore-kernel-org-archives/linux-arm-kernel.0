From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 4 Nov 2013 14:29:30 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <1704730.RnIqE1USnv@wuerfel>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <2443024.JdDKnfkC18@wuerfel> <5277CD33.6030003@wwwdotorg.org>
 <1704730.RnIqE1USnv@wuerfel>
Message-ID: <20131104212930.GB9638@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 04, 2013 at 09:43:22PM +0100, Arnd Bergmann wrote:

> /*
>  * this lists all properties we access from the driver. The list
>  * is interpreted by devm_probe() and can be programmatically
>  * verified to match the binding.
>  */
> static const struct devm_probe foo_probe_list[] = {
> 	DEVM_ALLOC(foo_priv),
> 	DEVM_IOMAP(foo_priv, regs, 0, 0),
> 	DEVM_PROP_BOOL(foo_priv, oldstyle_dma, "foo,oldstyle-dma"),
> 	DEVM_DMA_SLAVE(foo_priv, rxdma, "rx");
> 	DEVM_DMA_SLAVE(foo_priv, txdma, "tx");
> 	DEVM_GPIO(foo_priv, gpio, 0);
> 	DEVM_IRQ_NAMED(foo_priv, irq, foo_irq_handler, "fifo", IRQF_SHARED),
> 	{},
> };

Drivers are required to gain control of, and disable the device before
they bind and enable things like DMA or interrupts.

At the very least the action list above needs an explicit callback to
do that step..

> static int foo_probe(struct platform_device *dev)
> {
> 	int ret;
> 
> 	ret = devm_probe(dev->dev, foo_probe_list);

Some subsystems (like net) have the core system allocate the private
data, and some subsystem (like tpm) steal the drvdata for use in the
core, drivers can't touch it.

Regards,
Jason
