From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 8 Mar 2017 14:26:13 +0000
Subject: [PATCH v2 1/2] arm64: tegra: Enable SDHCI controllers on P3110
In-Reply-To: <20170308133944.32568-1-thierry.reding@gmail.com>
References: <20170223173053.19701-7-thierry.reding@gmail.com>
 <20170308133944.32568-1-thierry.reding@gmail.com>
Message-ID: <e105ca4b-1a39-c8e3-7601-b48433628188@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 08/03/17 13:39, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The P3110 processor module wires one of the SDHCI controllers to an on-
> board eMMC and exposes another set of SD/MMC signals on the connector to
> support an external SD/MMC card. A third controller is connected to the
> SDIO pins of an M.2 KEY E connector.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - move SD_CARD_SW_PWR regulator to carrier board (separate patch)
> - move status = "okay" to carrier board
> - fix card-detect GPIO for SDMMC1
> 
>  arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> index 69553bde7ef7..847e7db59b47 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> +++ b/arch/arm64/boot/dts/nvidia/tegra186-p3310.dtsi
> @@ -7,6 +7,8 @@
>  	compatible = "nvidia,p3310", "nvidia,tegra186";
>  
>  	aliases {
> +		sdhci0 = "/sdhci at 3460000";
> +		sdhci1 = "/sdhci at 3400000";
>  		serial0 = &uarta;
>  		i2c0 = "/bpmp/i2c";
>  		i2c1 = "/i2c at 3160000";
> @@ -72,6 +74,29 @@
>  		status = "okay";
>  	};
>  
> +	/* SDMMC1 (SD/MMC) */
> +	sdhci at 3400000 {
> +		cd-gpios = <&gpio TEGRA_MAIN_GPIO(P, 5) GPIO_ACTIVE_LOW>;
> +		wp-gpios = <&gpio TEGRA_MAIN_GPIO(P, 4) GPIO_ACTIVE_LOW>;
> +
> +		vqmmc-supply = <&vddio_sdmmc1>;
> +	};
> +
> +	/* SDMMC3 (SDIO) */
> +	sdhci at 3440000 {
> +		status = "okay";
> +	};
> +
> +	/* SDMMC4 (eMMC) */
> +	sdhci at 3460000 {
> +		status = "okay";
> +		bus-width = <8>;
> +		non-removable;
> +
> +		vqmmc-supply = <&vdd_1v8_ap>;
> +		vmmc-supply = <&vdd_3v3_sys>;
> +	};
> +
>  	hsp at 3c00000 {
>  		status = "okay";
>  	};

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
