From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Wed, 4 Mar 2015 19:01:47 +0530
Subject: [PATCH 2/3] mailbox: dt: Supply bindings for ST's Mailbox IP
In-Reply-To: <1425379283-1567-3-git-send-email-lee.jones@linaro.org>
References: <1425379283-1567-1-git-send-email-lee.jones@linaro.org>
 <1425379283-1567-3-git-send-email-lee.jones@linaro.org>
Message-ID: <CAJe_ZhceYSk5WCcQ2Gj-AOTdbmKPpq=zTd1AJVYh+WaB3yY_Og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 March 2015 at 16:11, Lee Jones <lee.jones@linaro.org> wrote:
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  .../devicetree/bindings/mailbox/sti-mailbox.txt    | 66 ++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
>
> diff --git a/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> new file mode 100644
> index 0000000..c965c13
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sti-mailbox.txt
> @@ -0,0 +1,66 @@
> +ST Microelectronics Mailbox Driver
> +
> +Required properties:
> +- compatible           : Should be "st,stih407-mailbox"
> +- reg                  : Offset and length of the register set for the device
> +- reg-names            : Should contain the reg name "mbox-reg".
> +- st,name              : Name of the mailbox
> +- st,mbox-chans                : Mbox/channels descriptor data private to each channel.
> +                         The 4 cells represent the following data:
> +                               Cell #1 (rx_id) - rx mbox num in an instance.
> +                               Cell #2 (rx_inst) - rx mbox instance num.
> +                               Cell #3 (tx_id) - tx mbox num in an instance.
> +                               Cell #4 (tx_inst) - tx mbox instance num.
> +
> +                         Note that an IP Mailbox is composed by 4 instances and
> +                         each instance is composed by 32 mailboxes.
> +                         You define here the configuration of a channel (at
> +                         framework level).
>
mbox-cells ?

> +
> +Optional properties
> +- st,mbox-rx           : Indicaties if the mailbox can be used as Rx mailbox.
>
isn't this property implied by the presence of interrupts property,
and hence redundant?

> +- st,mbox-rx-id                : If a Rx mailbox is affected to a Tx mailbox (to have
> +                         full-duplex channel), this field indiactes the Id of
> +                         the Rx mailbox to use.
> +- interrupts           : Contains the IRQ line for a RX mailbox.
> +- interrupt-names      : Should contain the interrupt name.
> +
> +Examples:
> +
> +mailbox0: mailbox at 0 {
> +       compatible = "st,stih407-mailbox";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       #mbox-cells = <1>;
> +       reg = <0x8f00000 0x1000>;
> +       reg-names = "mbox-reg";
> +       interrupts = <GIC_SPI 1 IRQ_TYPE_NONE>;
> +       interrupt-names = "mb0_irq";
> +       st,name = "a9";
> +       st,mbox-rx;
> +       st,mbox-rx-id = <0>;
> +       st,mbox-chans = <0 1 0 1>;
> +};
> +
> +mailbox3: mailbox at 3 {
> +       compatible = "st,stih407-mailbox";
> +       #address-cells = <1>;
> +       #size-cells = <1>;
> +       #mbox-cells = <1>;
> +       reg = <0x8f03000 0x100>;
> +       reg-names = "mbox-reg";
> +       st,name = "st231_video";
> +       st,mbox-rx-id = <0>;
> +       st,mbox-chans = <2 1 2 1>;
> +};
> +
> +In this configuration, if you use channel 0 you will have the following
> +configuration:
> +- "chan0_video" will use mailbox0 as Rx mailbox.
> +- "chan0_video" will use instance 1, bit 2 in mailbox0 for rx.
> +- "chan0_video" will use instance 1, bit 2 in mailbox3 for tx.
> +
> +If you declare a channel only for Rx, you have to set magic number 0xff
> +for tx_id and tx_instance.
> +If you declare a channel only for Tx, you have to set magic number 0xff
> +for rx_id and rx_instance.
>
some client node example would look great here
