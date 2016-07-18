From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 18 Jul 2016 20:45:23 +0300
Subject: [PATCH] ARM: dts: keystone: specify usb mode explicitly
In-Reply-To: <20160628094245.9521-1-grygorii.strashko@ti.com>
References: <20160628094245.9521-1-grygorii.strashko@ti.com>
Message-ID: <578D15B3.1040705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,
On 06/28/2016 12:42 PM, Grygorii Strashko wrote:
> The USB OTG mode is not supported by Kestone 2 devices, as result, the
> USB devices enumeration and detection will not work properly when
> kernel is built with CONFIG_USB_DWC3_DUAL_ROLE=y (default for multi
> platform build):
>   - it's required to load gadget drivers manually to make host mode
> work and this confuses current Keystone 2 users
>   - device mode is not working, because port can't detect and switch to
> peripheral/host mode dynamically.
>
> Hence, specify usb mode explicitly in DT: usb0 = "host" for all KS2
> devices and usb1 = "peripheral" for K2E.
>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Do you expect any additional actions from my side relate to this patch?

> ---
>   arch/arm/boot/dts/keystone-k2e-evm.dts  | 12 ++++++++++--
>   arch/arm/boot/dts/keystone-k2e.dtsi     |  4 ++--
>   arch/arm/boot/dts/keystone-k2hk-evm.dts |  6 +++++-
>   arch/arm/boot/dts/keystone-k2l-evm.dts  |  6 +++++-
>   arch/arm/boot/dts/keystone.dtsi         |  4 ++--
>   5 files changed, 24 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/boot/dts/keystone-k2e-evm.dts b/arch/arm/boot/dts/keystone-k2e-evm.dts
> index 4c32ebc..ae1ebe7 100644
> --- a/arch/arm/boot/dts/keystone-k2e-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2e-evm.dts
> @@ -47,18 +47,26 @@
>   	status = "okay";
>   };
>
> -&usb {
> +&keystone_usb0 {
>   	status = "okay";
>   };
>
> +&usb0 {
> +	dr_mode = "host";
> +};
> +
>   &usb1_phy {
>   	status = "okay";
>   };
>
> -&usb1 {
> +&keystone_usb1 {
>   	status = "okay";
>   };
>
> +&usb1 {
> +	dr_mode = "peripheral";
> +};
> +
>   &i2c0 {
>   	dtt at 50 {
>   		compatible = "at,24c1024";
> diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
> index 96b349f..3540a1d 100644
> --- a/arch/arm/boot/dts/keystone-k2e.dtsi
> +++ b/arch/arm/boot/dts/keystone-k2e.dtsi
> @@ -61,7 +61,7 @@
>   			status = "disabled";
>   		};
>
> -		usb1: usb at 25000000 {
> +		keystone_usb1: usb at 25000000 {
>   			compatible = "ti,keystone-dwc3";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> @@ -74,7 +74,7 @@
>   			dma-ranges;
>   			status = "disabled";
>
> -			dwc3 at 25010000 {
> +			usb1: dwc3 at 25010000 {
>   				compatible = "synopsys,dwc3";
>   				reg = <0x25010000 0x70000>;
>   				interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
> diff --git a/arch/arm/boot/dts/keystone-k2hk-evm.dts b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> index b38b344..2156ff9 100644
> --- a/arch/arm/boot/dts/keystone-k2hk-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2hk-evm.dts
> @@ -83,10 +83,14 @@
>   	status = "okay";
>   };
>
> -&usb {
> +&keystone_usb0 {
>   	status = "okay";
>   };
>
> +&usb0 {
> +	dr_mode = "host";
> +};
> +
>   &aemif {
>   	cs0 {
>   		#address-cells = <2>;
> diff --git a/arch/arm/boot/dts/keystone-k2l-evm.dts b/arch/arm/boot/dts/keystone-k2l-evm.dts
> index 7f9c2e9..056b42f 100644
> --- a/arch/arm/boot/dts/keystone-k2l-evm.dts
> +++ b/arch/arm/boot/dts/keystone-k2l-evm.dts
> @@ -32,10 +32,14 @@
>   	status = "okay";
>   };
>
> -&usb {
> +&keystone_usb0 {
>   	status = "okay";
>   };
>
> +&usb0 {
> +	dr_mode = "host";
> +};
> +
>   &i2c0 {
>   	dtt at 50 {
>   		compatible = "at,24c1024";
> diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
> index e34b226..96c9943 100644
> --- a/arch/arm/boot/dts/keystone.dtsi
> +++ b/arch/arm/boot/dts/keystone.dtsi
> @@ -188,7 +188,7 @@
>   			status = "disabled";
>   		};
>
> -		usb: usb at 2680000 {
> +		keystone_usb0: usb at 2680000 {
>   			compatible = "ti,keystone-dwc3";
>   			#address-cells = <1>;
>   			#size-cells = <1>;
> @@ -201,7 +201,7 @@
>   			dma-ranges;
>   			status = "disabled";
>
> -			dwc3 at 2690000 {
> +			usb0: dwc3 at 2690000 {
>   				compatible = "synopsys,dwc3";
>   				reg = <0x2690000 0x70000>;
>   				interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
>


-- 
regards,
-grygorii
