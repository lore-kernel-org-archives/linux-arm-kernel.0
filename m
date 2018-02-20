From: niklas.cassel@axis.com (Niklas Cassel)
Date: Tue, 20 Feb 2018 22:29:45 +0100
Subject: [PATCH 7/8] ARM: dts: artpec: add disabled node for PCIe
 endpoint mode
In-Reply-To: <20180220170049.22809-8-niklas.cassel@axis.com>
References: <20180220170049.22809-1-niklas.cassel@axis.com>
 <20180220170049.22809-8-niklas.cassel@axis.com>
Message-ID: <20180220212945.GA30339@axis.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 06:00:48PM +0100, Niklas Cassel wrote:
> The PCIe controller in the artpec6 SoC supports both root complex and
> endpoint mode, however, the controller can only be used in one of the
> modes.
> 
> Both pci nodes are disabled by default. A DTS file can enable one of
> them, depending on what mode it wants to run.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> ---
>  arch/arm/boot/dts/artpec6.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/artpec6.dtsi b/arch/arm/boot/dts/artpec6.dtsi
> index 1c46df0c03ce..8d02d210574a 100644
> --- a/arch/arm/boot/dts/artpec6.dtsi
> +++ b/arch/arm/boot/dts/artpec6.dtsi
> @@ -154,6 +154,10 @@
>  		interrupt-affinity = <&cpu0>, <&cpu1>;
>  	};
>  
> +	/*
> +	 * Both pci nodes cannot be enabled at the same time,
> +	 * leave the unwanted node as disabled.
> +	 */
>  	pcie: pcie at f8050000 {
>  		compatible = "axis,artpec6-pcie", "snps,dw-pcie";
>  		reg = <0xf8050000 0x2000
> @@ -181,6 +185,22 @@
>  		status = "disabled";
>  	};
>  
> +	pcie_ep: pcie_ep at f8050000 {
> +		compatible = "axis,artpec6-pcie-ep", "snps,dw-pcie";
> +		reg = <0xf8050000 0x2000
> +		       0xf8051000 0x2000
> +		       0xf8040000 0x1000
> +		       0xc0000000 0x20000000>;
> +		reg-names = "dbi", "dbi2", "phy", "addr_space";
> +		num-ib-windows = <6>;
> +		num-ob-windows = <2>;
> +		num-lanes = <2>;
> +		interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "msi";

Actually, interrupts and interrupt-names are not needed in EP mode,
so these two properties should be removed.

Will send out a V2 to fix this, but in the meantime, feel free to
review the rest of the patch series.

> +		axis,syscon-pcie = <&syscon>;
> +		status = "disabled";
> +	};
> +
>  	pinctrl: pinctrl at f801d000 {
>  		compatible = "axis,artpec6-pinctrl";
>  		reg = <0xf801d000 0x400>;
> -- 
> 2.14.2
> 
