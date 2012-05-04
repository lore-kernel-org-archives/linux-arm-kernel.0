From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 19:23:07 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <4FA3F308.6030900@ti.com>
 <CAJe_ZhfFhZVG4gyaaVUgeQedJiSE=zj9nE28XCNH9DkPVgqj=A@mail.gmail.com>
Message-ID: <201205041923.07620.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Jassi Brar wrote:
> I see this requires a client driver to specify a particular req_line on a
> particular dma controller. I am not sure if this is most optimal.
> 
> I think such client->req_line map should be provided to the dmac controller
> driver via its dt node in some format. The dmac driver could then populate
> a dma_chan, or similar, only for that req_line and not for the unused one
> which otherwise could also have served the same client.
> 
> Ideally the I2C driver should simply ask, say, a channel for TX and another
> for RX, everything else should already be setup via dmac's dt nodes.

If I understand you correctly, you think we can generalize the dma-request
data in a way that we don't need to pass a specific dma engine phandle.
I very much doubt this is possible, given how different the requirements
are for each of the engines we support. You really need to pass a specific
phandle so that we can find the code that can interpret the data in a
meaningful way.

It would be nice though if we could support your scenario where multiple
dma engines are available that can be used by a single client.
I've already mentioned that I think we can provide multiple channel
definitions and let the driver request each of them until one succeeds,
but that does require extra code inside of each driver that might need
to do this.
Another alternative would be to change the binding so that it can deal
with multiple distinct dmaengine instances using a single device node.

Given the example from exynos5250.dtsi, which currently contains this
fragment:

                pdma0: pdma at 121A0000 {
                        compatible = "arm,pl330", "arm,primecell";
                        reg = <0x121A0000 0x1000>;
                        interrupts = <0 34 0>;
                };

                pdma1: pdma at 121B0000 {
                        compatible = "arm,pl330", "arm,primecell";
                        reg = <0x121B0000 0x1000>;
                        interrupts = <0 35 0>;
                };

                mdma0: pdma at 10800000 {
                        compatible = "arm,pl330", "arm,primecell";
                        reg = <0x10800000 0x1000>;
                        interrupts = <0 33 0>;
                };

                mdma1: pdma at 11C10000 {
                        compatible = "arm,pl330", "arm,primecell";
                        reg = <0x11C10000 0x1000>;
                        interrupts = <0 124 0>;
                };

We could transform it into one node with multiple children:

	dma: dma-engines {
                compatible = "arm,pl330-multi", "arm,primecell";
		#dma-cells = <3>;
		#address-cells = <1>;
		#size-cells = <1>;
		ranges;

                pdma at 121A0000 {
                        compatible = "arm,pl330", "arm,primecell";
			arm,pl330-instance = <0>;
                        reg = <0x121A0000 0x1000>;
                        interrupts = <0 34 0>;
                };

                pdma at 121B0000 {
                        compatible = "arm,pl330", "arm,primecell";
			arm,pl330-instance = <1>;
                        reg = <0x121B0000 0x1000>;
                        interrupts = <0 35 0>;
                };

                pdma at 10800000 {
                        compatible = "arm,pl330", "arm,primecell";
			arm,pl330-instance = <2>;
                        reg = <0x10800000 0x1000>;
                        interrupts = <0 33 0>;
                };

                pdma at 11C10000 {
                        compatible = "arm,pl330", "arm,primecell";
			arm,pl330-instance = <3>;
                        reg = <0x11C10000 0x1000>;
                        interrupts = <0 124 0>;
                };
	};

This way, a client would just point to the dma-engines device node
that cover all of the actual engines, and the pl330 code registers
the four devices with the dmaengine layer.

	Arnd
