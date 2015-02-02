From: computersforpeace@gmail.com (Brian Norris)
Date: Sun, 1 Feb 2015 23:57:37 -0800
Subject: [PATCH 2/4] mtd: nand: atmel: Update DT documentation after
 splitting NFC and NAND
In-Reply-To: <1417732214-3292-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1417732214-3292-1-git-send-email-boris.brezillon@free-electrons.com>
 <1417732214-3292-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150202075737.GC3523@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

BTW, this series has a few conflicts with other things I have queued, so
you'll need to refresh.

On Thu, Dec 04, 2014 at 11:30:12PM +0100, Boris Brezillon wrote:
> The NAND and NFC (NAND Flash Controller) were linked together with a
> parent <-> child relationship.
> 
> This model has several drawbacks:
> - it does not allow for multiple NAND chip handling while the controller
>   support multi-chip (even though the driver is not ready yet)
> - it mixes NAND partitions and NFC nodes at the same level (which is a bit
>   disturbing)

I agree that this is disturbing. (FWIW, it also seems a bit disturbing
that atmel_nand.c actually registers two different drivers and the tries
to synchronize them; this seems like it could be handled better, but I'm
not sure how at the moment.)

> - the introduction of the EBI bus implies defining NAND chips under the
>   EBI node, and the ranges available under the EBI node should be
>   restricted to EBI address space, while the NFC references several
>   registers outside of these EBI ranges.

That's an interesting bit. I've actually run across this sort of problem
on other SoCs, where we have a relationship between two pieces of
hardware--the NAND chip and the NAND controller--where the former might
be on one bus (like your EBI bus, with chip selects), and the latter is
part of the top-level MMIO register space.

But can you elaborate here a bit more? Does the NAND chip actually need
to be represented under your EBI bus?

> Move the NFC node outside of the NAND node, to get a more future-proof
> model.

I'm curious if an alternative solution might work, maybe one like the
Allwiner NAND (sunxi-nand) DT, which just reverses the roles; the 'NFC'
is the parent of the NAND chip(s). We've seen this pattern in other
contexts too.

> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  .../devicetree/bindings/mtd/atmel-nand.txt         | 46 ++++++++++++----------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/atmel-nand.txt b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> index 6edc3b6..8896850 100644
> --- a/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/atmel-nand.txt
> @@ -30,15 +30,19 @@ Optional properties:
>    sector size 1024.
>  - nand-bus-width : 8 or 16 bus width if not present 8
>  - nand-on-flash-bbt: boolean to enable on flash bbt option if not present false
> -- Nand Flash Controller(NFC) is a slave driver under Atmel nand flash
> -  - Required properties:
> -    - compatible : "atmel,sama5d3-nfc".
> -    - reg : should specify the address and size used for NFC command registers,
> -            NFC registers and NFC Sram. NFC Sram address and size can be absent
> -            if don't want to use it.
> -    - clocks: phandle to the peripheral clock
> -  - Optional properties:
> -    - atmel,write-by-sram: boolean to enable NFC write by sram.
> +- atmel,nfc: phandle referencing the NAND Flash Controller, if available.

So this seems to clarify one question I had: is the NAND flash
controller required? The previous language didn't make it extremely
clear that the NFC sub-node was optional. But it does appear your code
makes it optional.

> +
> +The NAND Flash Controller (NFC) is an advanced NAND controller and should be
> +used in conjunction with the NAND flash device.
> +Required properties:
> + - compatible : "atmel,sama5d3-nfc".
> + - reg : should specify the address and size used for NFC command registers,
> +         NFC registers and NFC Sram. NFC Sram address and size can be absent
> +         if you don't want to use it.
> + - clocks: phandle to the peripheral clock
> +
> +Optional properties:
> + - atmel,write-by-sram: boolean to enable NFC write by sram.
>  
>  Examples:
>  nand0: nand at 40000000,0 {
> @@ -89,21 +93,23 @@ nand0: nand at 40000000 {
>  };
>  
>  /* for NFC supported chips */
> +nfc: nfc at 70000000 {
> +	compatible = "atmel,sama5d3-nfc";
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	clocks = <&hsmc_clk>
> +	reg = <
> +		0x70000000 0x10000000	/* NFC Command Registers */
> +		0xffffc000 0x00000070	/* NFC HSMC regs */
> +		0x00200000 0x00100000	/* NFC SRAM banks */
> +	>;
> +};
> +
>  nand0: nand at 40000000 {
>  	compatible = "atmel,at91rm9200-nand";
>  	#address-cells = <1>;
>  	#size-cells = <1>;
>  	ranges;
> +	atmel,nfc = <&nfc>;
>          ...
> -        nfc at 70000000 {
> -		compatible = "atmel,sama5d3-nfc";
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		clocks = <&hsmc_clk>
> -		reg = <
> -			0x70000000 0x10000000	/* NFC Command Registers */
> -			0xffffc000 0x00000070	/* NFC HSMC regs */
> -			0x00200000 0x00100000	/* NFC SRAM banks */
> -		>;
> -	};
>  };


Brian
