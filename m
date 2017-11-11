From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Sat, 11 Nov 2017 15:24:47 +0100
Subject: [PATCH] ARM: dts: imx6: Remove unneeded address-cells/size-cells
In-Reply-To: <1510348378-18150-1-git-send-email-festevam@gmail.com>
References: <1510348378-18150-1-git-send-email-festevam@gmail.com>
Message-ID: <62f3cb01-ff85-0fe0-2afa-0fe4732a7421@rwth-aachen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

(I'm sorry if I've missed some recipients or broke the email thread but
I got Fabio's email from the infradead archive.)

On 11/10/2017 10:12 PM, festevam at gmail.com (Fabio Estevam) wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> According to Documentation/devicetree/bindings/mtd/jedec,spi-nor.txt:
> 
> "- #address-cells, #size-cells : Must be present if the device has
> sub-nodes representing partitions."
> 
> Remove the occurrences of #address-cells/size-cells where no sub-nodes
> representing partitions are present.

This results in a regression for those devices where U-Boot is supposed
to inject the partition sub-nodes. For example, this is the case for
cm-fx6 module based devices like the Utilite Pro.

Linux fails to parse the partitions and reports:
[    9.330881] spi0.0: error parsing ofpart partition
/soc/aips-bus at 2000000/spba-bus at 2000000/ecspi at 2008000/m25p80 at 0/partition at 0
(/soc/aips-bus at 2000000/spba-bus at 2000000/ecspi at 2008000/m25p80 at 0)
[    9.330887] mtd: failed to find partitions; one or more parsers
reports errors (-22)

Also, the documentation does not forbid the #address-cells/size-cells if
no partitions are present.

So, please, drop this patch (or exclude at least the cm-fx6 related change).

Thanks!
Christopher

> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx6q-cm-fx6.dts           | 2 --
>  arch/arm/boot/dts/imx6q-mccmon6.dts          | 2 --
>  arch/arm/boot/dts/imx6qdl-aristainetos.dtsi  | 2 --
>  arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi | 2 --
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     | 2 --
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi       | 2 --
>  arch/arm/boot/dts/imx6sl-evk.dts             | 2 --
>  arch/arm/boot/dts/imx6sx-sdb-reva.dts        | 4 ----
>  arch/arm/boot/dts/imx6sx-sdb.dts             | 4 ----
>  9 files changed, 22 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-cm-fx6.dts b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> index bc7587c..5df84e2 100644
> --- a/arch/arm/boot/dts/imx6q-cm-fx6.dts
> +++ b/arch/arm/boot/dts/imx6q-cm-fx6.dts
> @@ -194,8 +194,6 @@
>  	status = "okay";
>  
>  	m25p80 at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "st,m25p", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6q-mccmon6.dts b/arch/arm/boot/dts/imx6q-mccmon6.dts
> index cab36f4..9636e15 100644
> --- a/arch/arm/boot/dts/imx6q-mccmon6.dts
> +++ b/arch/arm/boot/dts/imx6q-mccmon6.dts
> @@ -90,8 +90,6 @@
>  	status = "okay";
>  
>  	s25sl032p: flash at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "jedec,spi-nor";
>  		spi-max-frequency = <40000000>;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
> index 7d64075..d8f578c 100644
> --- a/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-aristainetos.dtsi
> @@ -106,8 +106,6 @@
>  	status = "okay";
>  
>  	flash: m25p80 at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "micron,n25q128a11", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> index 1b18728..5875252 100644
> --- a/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi
> @@ -136,8 +136,6 @@
>  	status = "okay";
>  
>  	flash: m25p80 at 1 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "micron,n25q128a11", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <1>;
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index 4fa2fac..828a9a5 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -200,8 +200,6 @@
>  	status = "disabled"; /* pin conflict with WEIM NOR */
>  
>  	flash: m25p80 at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "st,m25p32", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> index 0a50705..acb0292 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
> @@ -196,8 +196,6 @@
>  	status = "okay";
>  
>  	flash: m25p80 at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "st,m25p32", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
> index 60600b4..03a2240 100644
> --- a/arch/arm/boot/dts/imx6sl-evk.dts
> +++ b/arch/arm/boot/dts/imx6sl-evk.dts
> @@ -123,8 +123,6 @@
>  	status = "okay";
>  
>  	flash: m25p80 at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "st,m25p32", "jedec,spi-nor";
>  		spi-max-frequency = <20000000>;
>  		reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6sx-sdb-reva.dts b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> index e3533e7..ebbed57 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb-reva.dts
> @@ -127,16 +127,12 @@
>  
>  	flash0: s25fl128s at 0 {
>  		reg = <0>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "spansion,s25fl128s", "jedec,spi-nor";
>  		spi-max-frequency = <66000000>;
>  	};
>  
>  	flash1: s25fl128s at 1 {
>  		reg = <1>;
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "spansion,s25fl128s", "jedec,spi-nor";
>  		spi-max-frequency = <66000000>;
>  	};
> diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-sdb.dts
> index 6dd9beb..4b7481a 100644
> --- a/arch/arm/boot/dts/imx6sx-sdb.dts
> +++ b/arch/arm/boot/dts/imx6sx-sdb.dts
> @@ -113,16 +113,12 @@
>  	status = "okay";
>  
>  	flash0: n25q256a at 0 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "micron,n25q256a", "jedec,spi-nor";
>  		spi-max-frequency = <29000000>;
>  		reg = <0>;
>  	};
>  
>  	flash1: n25q256a at 1 {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
>  		compatible = "micron,n25q256a", "jedec,spi-nor";
>  		spi-max-frequency = <29000000>;
>  		reg = <1>;
> 
