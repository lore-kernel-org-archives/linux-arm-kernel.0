From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 27 Aug 2012 15:46:43 -0700
Subject: [PATCH v3 3/3] ARM: dts: Add nodes for dw_mmc controllers for
 Samsung Exynos5250 platforms
In-Reply-To: <1345982371-26483-4-git-send-email-thomas.abraham@linaro.org>
References: <1345982371-26483-1-git-send-email-thomas.abraham@linaro.org>
 <1345982371-26483-4-git-send-email-thomas.abraham@linaro.org>
Message-ID: <503BF8D3.9060507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/12 04:59, Thomas Abraham wrote:
> Add device nodes for the four instances of dw_mmc controllers in Exynos5250
> and enable instance 0 and 2 for the smdk5250 board.
>
> Signed-off-by: Thomas Abraham<thomas.abraham@linaro.org>
> ---
>   arch/arm/boot/dts/exynos5250-smdk5250.dts |   57 ++++++++++++++++++++++++++++-
>   arch/arm/boot/dts/exynos5250.dtsi         |   32 ++++++++++++++++
>   2 files changed, 88 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 8a5e348..6dc9faf 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -16,12 +16,19 @@
>   	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
>   	compatible = "samsung,smdk5250", "samsung,exynos5250";
>
> +	aliases {
> +		mshc0 =&mshc_0;
> +		mshc1 =&mshc_1;
> +		mshc2 =&mshc_2;
> +		mshc3 =&mshc_3;
> +	};
> +
>   	memory {
>   		reg =<0x40000000 0x80000000>;
>   	};
>
>   	chosen {
> -		bootargs = "root=/dev/ram0 rw ramdisk=8192 console=ttySAC1,115200";
> +		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";

Yes, we need to sort out the 'bootargs' for using uart2 as a console, 
but you know, this should be separated :-)

>   	};
>
>   	i2c at 12C60000 {
> @@ -72,6 +79,54 @@
>   		status = "disabled";
>   	};
>
> +	mshc_0: dwmmc0 at 12200000 {

How about to keep the consistent naming? dwmmc or dw_mmc? I think, 
'dw_mmc' makes more sense?

> +		num-slots =<1>;
> +		supports-highspeed;
> +		broken-cd;
> +		fifo-depth =<0x80>;
> +		card-detect-delay =<200>;
> +		samsung,dw-mshc-sdr-timing =<2 3 3>;
> +		samsung,dw-mshc-ddr-timing =<1 2 3>;

We need to think again the name of dw-mshc-sdr-timing, dw-mshc-ddr-timing?

[...]

> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 004aaa8..f69e389 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -182,6 +182,38 @@
>   		#size-cells =<0>;
>   	};
>
> +	dwmmc0 at 12200000 {
> +		compatible = "samsung,exynos5250-dw-mshc";

I'm not sure, 'exynos5250-dw-mshc' is right here. Because it is just 
dw_mmc controller on exynos5250. So...hmm...

[...]

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
