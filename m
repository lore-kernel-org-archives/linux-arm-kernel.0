From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Feb 2014 16:42:12 +0100
Subject: [PATCH v7 8/8] ARM: sunxi: Add documentation for driver for
 SD/MMC hosts found on Allwinner sunxi SoCs
In-Reply-To: <20140217100302.15040.56273.stgit@pagira.o2s.ch>
References: <20140217095907.15040.81893.stgit@pagira.o2s.ch>
 <20140217100302.15040.56273.stgit@pagira.o2s.ch>
Message-ID: <20140218154212.GL3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 11:03:02AM +0100, David Lanzend?rfer wrote:
> Signed-off-by: David Lanzend?rfer <david.lanzendoerfer@o2s.ch>
> ---
>  .../devicetree/bindings/mmc/sunxi-mmc.txt          |   32 ++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> new file mode 100644
> index 0000000..5ce8c5e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunxi-mmc.txt
> @@ -0,0 +1,32 @@
> +* Allwinner sunxi MMC controller
> +
> +The highspeed MMC host controller on Allwinner SoCs provides an interface
> +for MMC, SD and SDIO types of memory cards.
> +
> +Supported maximum speeds are the ones of the eMMC standard 4.5 as well
> +as the speed of SD standard 3.0.
> +Absolute maximum transfer rate is 200MB/s
> +
> +Required properties:
> +- compatible: Should be "allwinner,<revision>-<chip>-mmc".
> +  The supported chips include a10, a10s, 13, a20 and a31.

Please use the real compatibles here. It's much easier to search
for. Plus, your driver doesn't support all the SoCs you're mentionning here.

> +- base registers are 0x1000 appart, so the base of mmc1
> +  would be 0x01c0f000+0x1000=0x01c10000(see example)
> +  and so on.

Please provide the real property name to use. No need for an example
here, you have a full-fledged one in a few lines.

> +- clocks requires the reference at the ahb clock gate
> +  with the correct index (mmc0 -> 8, mmc1 -> 9, and so on)
> +  as well as the reference to the correct mod0 clock.

Ditto. Plus, this is not a mod0 clock.

> +- interrupts requires the correct IRQ line
> +  (mmc0 -> 32, mmc1 -> 33, and so on)

Ditto.

> +
> +Examples:
> +
> +mmc0: mmc at 01c0f000 {
> +	compatible = "allwinner,sun5i-a13-mmc";
> +	reg = <0x01c0f000 0x1000>;
> +	clocks = <&ahb_gates 8>, <&mmc0_clk>;
> +	clock-names = "ahb", "mod";

You never talked about the clock-names property, and which clocks were
supposed to be provided.

> +	interrupts = <0 32 4>;
> +	bus-width = <4>;

And you never talked about bus-width either.

> +	status = "disabled";
> +};
> 

Isn't the cd-gpios property requested too?

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/1ecee256/attachment.sig>
