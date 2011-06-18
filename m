From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 18 Jun 2011 20:27:22 +0200
Subject: [PATCH 2/3] net/fec: add device tree support
In-Reply-To: <1308410354-21387-3-git-send-email-shawn.guo@linaro.org>
References: <1308410354-21387-1-git-send-email-shawn.guo@linaro.org>
	<1308410354-21387-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <201106182027.22974.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 18 June 2011 17:19:13 Shawn Guo wrote:
> diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
> new file mode 100644
> index 0000000..705111d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
> @@ -0,0 +1,14 @@
> +* Freescale Fast Ethernet Controller (FEC)
> +
> +Required properties:
> +- compatible : should be "fsl,<soc>-fec", "fsl,fec"
> +- reg : address and length of the register set for the device
> +- interrupts : should contain fec interrupt
> +
> +Example:
> +
> +fec at 83fec000 {
> +	compatible = "fsl,imx51-fec", "fsl,fec";
> +	reg = <0x83fec000 0x4000>;
> +	interrupts = <87>;
> +};

How about also adding device_type="network" as required here, so you
inherit the attributes like "local-mac-address".

I would also suggest adding a call to of_get_mac_address() so you
can read the address out of the device tree when it is not configured
in hardware. Today, the driver relies on a module parameter or
platform_data on hardware with a mac address set.

The other information that is currently encoded in platform_data
is the phy mode. How about adding a property that enables RMII mode
when present?

	Arnd
