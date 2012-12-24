From: elezegarcia@gmail.com (Ezequiel Garcia)
Date: Sun, 23 Dec 2012 21:50:52 -0300
Subject: [PATCH 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
In-Reply-To: <1356307280-8323-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1356307280-8323-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1356307280-8323-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <CALF0-+VHp+V=d114r_OT8baht_hSi9apmdYrJ3eVQRtEzjDZAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 23, 2012 at 9:01 PM, Ezequiel Garcia
<ezequiel.garcia@free-electrons.com> wrote:
> This patch adds device tree bindings for OMAP OneNAND devices.
> Tested on an OMAP3 3430 IGEPv2 board.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/gpmc-onenand.txt       |   44 ++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.c                         |   44 ++++++++++++++++++++
>  2 files changed, 88 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
>
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> new file mode 100644
> index 0000000..4108f18
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> @@ -0,0 +1,44 @@
> +Device tree bindings for GPMC connected OneNANDs
> +
> +GPMC connected OneNAND (found on OMAP boards) are represented as child nodes of
> +the GPMC controller with a name of "onenand".
> +
> +All timing relevant properties as well as generic gpmc child properties are
> +explained in a separate documents - please refer to
> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +Required properties:
> +
> + - reg:                        The CS line the peripheral is connected to
> +
> +Optional properties:
> +
> + - dma-channel:                DMA Channel index
> +
> +For inline partiton table parsing (optional):
> +
> + - #address-cells: should be set to 1
> + - #size-cells: should be set to 1
> +
> +Example for an OMAP3430 board:
> +
> +       gpmc: gpmc at 6e000000 {
> +               compatible = "ti,omap3430-gpmc";
> +               ti,hwmods = "gpmc";
> +               reg = <0x6e000000 0x1000000>;
> +               interrupts = <20>;
> +               gpmc,num-cs = <8>;
> +               gpmc,num-waitpins = <4>;
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +

Before anyone complains, this is wrong:

> +               onenand at 0 {
> +                       reg = <0>;
> +

It should be "reg = <0 0 0>" of course.

Also, IMHO, I don't like the node to be matched by his name.
Shouldn't we add a "compatible" tag instead?

That way we could describe the device like

flash at xxx {
    compatible = "nand";
}

or

flash at xxx {
    compatible = "onenand";
}

Does this make sense?

Regards,

    Ezequiel
