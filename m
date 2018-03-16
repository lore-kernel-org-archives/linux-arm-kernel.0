From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 16 Mar 2018 14:57:00 +0100
Subject: [PATCH v3] mtd: nand: marvell: Fix clock resource by adding a
 register clock
In-Reply-To: <20180313103016.7695-1-gregory.clement@bootlin.com>
References: <20180313103016.7695-1-gregory.clement@bootlin.com>
Message-ID: <20180316145700.570da89f@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Tue, 13 Mar 2018 11:30:16 +0100, Gregory CLEMENT
<gregory.clement@bootlin.com> wrote:

> On Armada 7K/8K we need to explicitly enable the register clock. This
> clock is optional because not all the SoCs using this IP need it but at
> least for Armada 7K/8K it is actually mandatory.
> 
> The binding documentation is updated accordingly.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
> Changelog:
> v2 -> v3
>  - Updating the kerneldoc
>  - Renaming unprepare_clk to unprepare_ecc_clk
>  - Adding extra test on the presence of "core" clock to make Boris happy
> 
> v1 -> v2
> 
>  - Removed the unnecessary IS_ERR() call
>  - Skip the reg clock only if it is not present by checking "-ENOENT"
>  - Add a label for uninitializing the reg clock.
> 
>  .../devicetree/bindings/mtd/marvell-nand.txt       |  6 +++-
>  drivers/mtd/nand/marvell_nand.c                    | 34 ++++++++++++++++++----
>  2 files changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/marvell-nand.txt b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> index c08fb477b3c6..4ee9813bf88f 100644
> --- a/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/marvell-nand.txt
> @@ -14,7 +14,11 @@ Required properties:
>  - #address-cells: shall be set to 1. Encode the NAND CS.
>  - #size-cells: shall be set to 0.
>  - interrupts: shall define the NAND controller interrupt.
> -- clocks: shall reference the NAND controller clock.
> +- clocks: shall reference the NAND controller clocks, the second one is
> +  optional but needed for the Armada 7K/8K SoCs
> +- clock-names: mandatory if there is a second clock, in this case the
> +   name must be "core" for the first clock and "reg" for the second
> +   one
>  - marvell,system-controller: Set to retrieve the syscon node that handles
>    NAND controller related registers (only required with the
>    "marvell,armada-8k-nand[-controller]" compatibles).
> diff --git a/drivers/mtd/nand/marvell_nand.c b/drivers/mtd/nand/marvell_nand.c
> index 2196f2a233d6..0e7e8017046a 100644
> --- a/drivers/mtd/nand/marvell_nand.c
> +++ b/drivers/mtd/nand/marvell_nand.c
> @@ -308,6 +308,7 @@ struct marvell_nfc_caps {
>   * @dev:		Parent device (used to print error messages)
>   * @regs:		NAND controller registers
>   * @ecc_clk:		ECC block clock, two times the NAND controller clock

Is this comment "two times the NAND controller clock" still valid?
Shall we reference the "NAND registers clock" instead?

> + * @reg_clk:		Regsiters clock

Typo here: s/Regsiters/Registers/

Thank you,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
