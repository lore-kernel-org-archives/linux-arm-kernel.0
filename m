From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 09:28:43 +0100
Subject: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
In-Reply-To: <20180228022714.30068-2-samuel@sholland.org>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-2-samuel@sholland.org>
Message-ID: <20180228082843.fga47gfrv2g5kmiz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 27, 2018 at 08:27:12PM -0600, Samuel Holland wrote:
> This mailbox hardware is present in several Allwinner sun8i and sun50i
> SoCs. Add a device tree binding for it.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 ++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> new file mode 100644
> index 000000000000..3b3ed7f870a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> @@ -0,0 +1,40 @@
> +Allwinner sunxi Message Box
> +===========================
> +
> +The hardware message box on sunxi SoCs is a two-user mailbox controller
> +containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox channels.
> +An interrupt is raised for received messages, but software must poll to know
> +when a transmitted message has been acknowledged by the remote user.
> +
> +Refer to ./mailbox.txt for generic information about mailbox device-tree
> +bindings.
> +
> +Mailbox Device Node:
> +====================
> +
> +Required properties:
> +--------------------
> +- compatible:		Must be "allwinner,sunxi-msgbox".

The IP change quite often in the Allwinner SoCs, so it would be better
to use a more specific compatible there. IIRC that IP was introduced
with the A31, so what about sun6i-a31-msgbox?

> +- reg:			Contains the mailbox register address range (base
> +			address and length).
> +- clocks:		phandle for the clock controller and specifier.
> +- clock-names:		Must be "bus".
> +- resets:		phandle for the reset controller and specifier.
> +- reset-names:		Must be "bus".
> +- interrupts:		Contains interrupt information for the mailbox.
> +- #mbox-cells		Must be 2 - the indexes of the transmit and receive
> +			channels, respectively.

That would prevent any unidirectional communication, wouldn't it?
Other mailboxes driver seem to have two mbox channels, one for each
direction, which also seem to mimic our DMA bindings (where we are in
pretty much the same situation).

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/8c5b4a06/attachment.sig>
