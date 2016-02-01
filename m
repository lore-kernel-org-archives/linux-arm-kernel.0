From: robh@kernel.org (Rob Herring)
Date: Mon, 1 Feb 2016 08:08:28 -0600
Subject: [PATCH v5 1/4] dt-bindings: mailbox: Document Hi6220 mailbox
 driver
In-Reply-To: <1454333687-20421-2-git-send-email-leo.yan@linaro.org>
References: <1454333687-20421-1-git-send-email-leo.yan@linaro.org>
 <1454333687-20421-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20160201140828.GA32412@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2016 at 09:34:44PM +0800, Leo Yan wrote:
> Document DT binding for Hisilicon Hi6220 mailbox driver.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  .../bindings/mailbox/hisilicon,hi6220-mailbox.txt  | 90 ++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> new file mode 100644
> index 0000000..96e6acc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
> @@ -0,0 +1,90 @@
> +Hisilicon Hi6220 Mailbox Driver
> +===============================
> +
> +Hisilicon Hi6220 mailbox supports up to 32 channels. Each channel
> +is unidirectional with a maximum message size of 8 words. I/O is
> +performed using register access (there is no DMA) and the cell
> +raises an interrupt when messages are received.
> +
> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:		Shall be "hisilicon,hi6220-mbox"
> +- reg:			Contains the mailbox register address range (base
> +			address and length); the first item is for IPC
> +			registers, the second item is shared buffer for
> +			slots.
> +- #mbox-cells		Common mailbox binding property to identify the number
> +			of cells required for the mailbox specifier. Should be 1.
> +- interrupts:		Contains the interrupt information for the mailbox
> +			device. The format is dependent on which interrupt
> +			controller the SoCs use.
> +
> +Optional Properties:
> +--------------------
> +- hi6220,mbox-tx-noirq: Flag to allow the client user of this mailbox driver
> +			to send messages without triggering a TX completion
> +			interrupt.

I don't think this belongs in DT. This should be a flag the client 
driver sets when it sends messages.

> +
> +Child Nodes:
> +============
> +A child node is used for representing the actual sub-mailbox device that is
> +used for the communication between the host processor and a remote processor.
> +Each child node should have a unique node name across all the different
> +mailbox device nodes.
> +
> +Required properties:
> +--------------------
> +- hi6220,mbox-tx:	sub-mailbox descriptor property defining Tx channel
> +- hi6220,mbox-rx:	sub-mailbox descriptor property defining Rx channel
> +
> +Sub-mailbox Descriptor Data
> +---------------------------
> +Each of the above hi6220,mbox-tx and hi6220,mbox-rx properties should have 3
> +cells of data that represent the following:
> +    Cell #1 (slot_id) - mailbox slot id used either for transmitting
> +                        (hi6220,mbox-tx) or for receiving (hi6220,mbox-rx)
> +    Cell #2 (dst_irq) - irq identifier index number which used by MCU.
> +    Cell #3 (ack_irq) - irq identifier index number with generating a tx/rx
> +                        interrupt to application processor, mailbox driver
> +                        used this id to acknowledge interrupt.
> +
> +Example:
> +--------
> +
> +	mailbox: mailbox at F7510000 {
> +		#mbox-cells = <1>;
> +		compatible = "hisilicon,hi6220-mbox";
> +		reg = <0x0 0xF7510000 0x0 0x1000>, /* IPC_S */
> +		      <0x0 0x06DFF800 0x0 0x0800>; /* Mailbox */
> +		interrupt-parent = <&gic>;
> +		interrupts = <GIC_SPI 94 IRQ_TYPE_LEVEL_HIGH>;
> +		mbox_stub_clock: mbox_stub_clock {
> +			hi6220,mbox-rx = <0 1 10>;
> +			hi6220,mbox-tx = <1 0 11>;
> +		};
> +	};
> +
> +
> +Mailbox client
> +===============
> +
> +"mboxes" and the optional "mbox-names" (please see
> +Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
> +of the mboxes property should contain a phandle to the mailbox controller
> +device node and second argument is the channel index. It must be 0 (hardware

0? But the example has 1.

> +support only one channel). The equivalent "mbox-names" property value can be
> +used to give a name to the communication channel to be used by the client user.
> +
> +Example:
> +--------
> +
> +	stub_clock: stub_clock {
> +		compatible = "hisilicon,hi6220-stub-clk";
> +		hisilicon,hi6220-clk-sram = <&sram>;
> +		#clock-cells = <1>;
> +		mbox-names = "mbox-tx";
> +		mboxes = <&mailbox 1>;
> +	};
> -- 
> 1.9.1
> 
