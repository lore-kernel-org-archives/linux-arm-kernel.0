From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 18 Jun 2018 08:53:37 +0000
Subject: [PATCH v2 2/4] dt-bindings: mailbox: provide imx-mailbox
 documentation
In-Reply-To: <20180615095107.24610-3-o.rempel@pengutronix.de>
References: <20180615095107.24610-1-o.rempel@pengutronix.de>
 <20180615095107.24610-3-o.rempel@pengutronix.de>
Message-ID: <9d436d3a9c534b0c7af339aa13e91c1293a55503.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-06-15 at 11:51 +0200, Oleksij Rempel wrote:
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/mailbox/imx-mailbox.txt          | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/imx-mailbox.txt

A recent patch was posted which adds a similar but different binding
for the MU on 8qm/8qxp SOCs:

https://patchwork.kernel.org/patch/10468885/

Looking at manuals side-by-side the hardware seems to be the same so
there should be a single binding. Right?

That series I pointed to uses the MU to implement a communication with
a special "SCU" core which runs NXP firmware for handling details like
power management. However imx8 socs also have other MUs and M4 cores
for customers to use pretty exactly like they would on 7d.

The hardware exposes a very generic interface and my impression is that
 drivers for the MU are actually highly specific to what is on the
other side of the MU. For example your driver code seems to be mapping
the 4 MU registers to separate "channels" but for SCU messages are
written in all registers in a round-robin way.

Shouldn't your MU-using driver be a separate node which references the
MU by phandle? Like in this patch:

https://patchwork.kernel.org/patch/10468887/

> diff --git a/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
> new file mode 100644
> index 000000000000..1577b86f1206
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/imx-mailbox.txt
> @@ -0,0 +1,35 @@
> +i.MX Messaging Unit
> +===================
> +
> +The i.MX Messaging Unit (MU) contains two register sets: "A" and "B". In most
> +cases they are accessible from all Processor Units. On one hand, at least for
> +mailbox functionality, it makes no difference which application or processor is
> +using which set of the MU. On other hand, the register sets for each of the MU
> +parts are not identical.
> +
> +Required properties:
> +- compatible :	Shell be one of:
> +                    "fsl,imx7s-mu-a" and "fsl,imx7s-mu-b" for i.MX7S or i.MX7D
> +- reg :		physical base address of the mailbox and length of
> +		memory mapped region.
> +- #mbox-cells:	Common mailbox binding property to identify the number
> +		of cells required for the mailbox specifier. Should be 1.
> +- interrupts :	The interrupt number
> +- clocks     :  phandle to the input clock.
> +
> +Example:
> +	mu0a: mailbox at 30aa0000 {
> +		compatible = "fsl,imx7s-mu-a";
> +		reg = <0x30aa0000 0x28>;
> +		interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX7D_MU_ROOT_CLK>;
> +		#mbox-cells = <1>;
> +	};
> +
> +	mu0b: mailbox at 30ab0000 {
> +		compatible = "fsl,imx7s-mu-b";
> +		reg = <0x30ab0000 0x28>;
> +		interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&clks IMX7D_MU_ROOT_CLK>;
> +		#mbox-cells = <1>;
> +	};
