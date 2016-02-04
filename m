From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 4 Feb 2016 16:28:10 +0800
Subject: [PATCH v6 1/4] dt-bindings: mailbox: Document Hi6220 mailbox
 driver
In-Reply-To: <20160203204717.GA1713@rob-hp-laptop>
References: <1454407782-24674-1-git-send-email-leo.yan@linaro.org>
 <1454407782-24674-2-git-send-email-leo.yan@linaro.org>
 <20160203204717.GA1713@rob-hp-laptop>
Message-ID: <20160204082810.GA28299@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 02:47:17PM -0600, Rob Herring wrote:
> On Tue, Feb 02, 2016 at 06:09:39PM +0800, Leo Yan wrote:
> > Document DT binding for Hisilicon Hi6220 mailbox driver.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../bindings/mailbox/hisilicon,hi6220-mailbox.txt  | 74 ++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> 
> One nit, otherwise:
> 
> Acked-by: Rob Herring <robh@kernel.org>

Thanks, Rob. I will send a new version to fix them.

Thanks,
Leo Yan

> > 
> > diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> > new file mode 100644
> > index 0000000..8508c8a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> > @@ -0,0 +1,74 @@
> > +Hisilicon Hi6220 Mailbox Driver
> > +===============================
> > +
> > +Hisilicon Hi6220 mailbox supports up to 32 channels. Each channel
> > +is unidirectional with a maximum message size of 8 words. I/O is
> > +performed using register access (there is no DMA) and the cell
> > +raises an interrupt when messages are received.
> > +
> > +Mailbox Device Node:
> > +====================
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:		Shall be "hisilicon,hi6220-mbox"
> > +- reg:			Contains the mailbox register address range (base
> > +			address and length); the first item is for IPC
> > +			registers, the second item is shared buffer for
> > +			slots.
> > +- #mbox-cells:		Common mailbox binding property to identify the number
> > +			of cells required for the mailbox specifier. Must be 3.
> > +			<&phandle slot_id dst_irq ack_irq>
> > +			  phandle: Label name of mailbox controller
> > +			  slot_id: Slot id used either for TX or RX
> > +			  dst_irq: IRQ identifier index number which used by MCU
> > +			  ack_irq: IRQ identifier index number with generating a
> > +			           TX/RX interrupt to application processor,
> > +				   mailbox driver uses it to acknowledge interrupt
> > +- interrupts:		Contains the interrupt information for the mailbox
> > +			device. The format is dependent on which interrupt
> > +			controller the SoCs use.
> > +
> > +Optional Properties:
> > +--------------------
> > +- hi6220,mbox-tx-noirq: Property of MCU firmware's feature, so mailbox driver
> > +			use this flag to ask MCU to enable "automatic idle
> > +			flag" mode or IRQ generated mode to acknowledge a TX
> > +			completion.
> > +
> > +Example:
> > +--------
> > +
> > +	mailbox: mailbox at F7510000 {
> 
> use lowercase for hex
> 
> > +		compatible = "hisilicon,hi6220-mbox";
> > +		reg = <0x0 0xF7510000 0x0 0x1000>, /* IPC_S */
> > +		      <0x0 0x06DFF800 0x0 0x0800>; /* Mailbox */
> 
> and here too.
> 
> > +		interrupt-parent = <&gic>;
> > +		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> > +		#mbox-cells = <3>;
> > +	};
> > +
> > +
> > +Mailbox client
> > +===============
> > +
> > +Required properties:
> > +--------------------
> > +- compatible:		Many (See the client docs).
> > +- mboxes:		Standard property to specify a Mailbox (See ./mailbox.txt)
> > +			Cells must match 'mbox-cells' (See Mailbox Device Node above).
> > +
> > +Optional Properties:
> > +--------------------
> > +- mbox-names:		Name given to channels seen in the 'mboxes' property.
> > +
> > +Example:
> > +--------
> > +
> > +	stub_clock: stub_clock {
> > +		compatible = "hisilicon,hi6220-stub-clk";
> > +		hisilicon,hi6220-clk-sram = <&sram>;
> > +		#clock-cells = <1>;
> > +		mbox-names = "mbox-tx", "mbox-rx";
> > +		mboxes = <&mailbox 1 0 11>, <&mailbox 0 1 10>;
> > +	};
> > -- 
> > 1.9.1
> > 
