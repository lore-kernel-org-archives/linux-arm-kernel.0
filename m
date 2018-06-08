From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 08 Jun 2018 16:58:31 -0700
Subject: [PATCH] ARM64: dts: meson-gx: fix ATF reserved memory region
In-Reply-To: <20180607205514.36631-1-khilman@baylibre.com> (Kevin Hilman's
 message of "Thu, 7 Jun 2018 13:55:14 -0700")
References: <20180607205514.36631-1-khilman@baylibre.com>
Message-ID: <7hefhgygns.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@baylibre.com> writes:

> Vendor firmware/uboot has different reserved regions depending on
> firmware version, but current codebase reserves the same regions on
> GXL and GXBB, so move the additional reserved memory region to common
> .dtsi.
>
> Found when putting a recent vendor u-boot on meson-gxbb-p200.
>
> Recommended-by: Neil Armstrong <narmstrong@baylibre.com>

oops, this should've been the more common "Suggested-by".  Fixed, and
then...

> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

...added a Cc:stable and applied to v4.18/fixes.

Kevin

> ---
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi  | 6 ++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 8 --------
>  2 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> index b003f324ca31..b8dc4dbb391b 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
> @@ -35,6 +35,12 @@
>  			no-map;
>  		};
>  
> +		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
> +		secmon_reserved_alt: secmon at 5000000 {
> +			reg = <0x0 0x05000000 0x0 0x300000>;
> +			no-map;
> +		};
> +
>  		linux,cma {
>  			compatible = "shared-dma-pool";
>  			reusable;
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index 27538eea547b..c87a80e9bcc6 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -13,14 +13,6 @@
>  / {
>  	compatible = "amlogic,meson-gxl";
>  
> -	reserved-memory {
> -		/* Alternate 3 MiB reserved for ARM Trusted Firmware (BL31) */
> -		secmon_reserved_alt: secmon at 5000000 {
> -			reg = <0x0 0x05000000 0x0 0x300000>;
> -			no-map;
> -		};
> -	};
> -
>  	soc {
>  		usb0: usb at c9000000 {
>  			status = "disabled";
