From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 26 Jun 2014 11:52:27 +0200
Subject: [PATCH] ARM: dts: Add mask-tpm-reset to the device tree
In-Reply-To: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
References: <1403774127-21892-1-git-send-email-vikas.sajjan@samsung.com>
Message-ID: <53ABED5B.8010506@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vikas, Doug,

On 26.06.2014 11:15, Vikas Sajjan wrote:
> From: Doug Anderson <dianders@chromium.org>
> 
> The mask-tpm-reset GPIO is used by the kernel to prevent the TPM from
> being reset across sleep/wake.  If we don't set it to anything then
> the TPM will be reset.  U-Boot will detect this as invalid
> and will reset the system on resume time. This GPIO can always be low
> and not hurt anything.  It will get pulled back high again during a
> normal warm reset when it will default back to an input.
> 
> To properly preserve the TPM state across suspend/resume and to make
> the chrome U-Boot happy, properly set the GPIO to mask the
> reset to the TPM.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Vikas Sajjan <vikas.sajjan@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 7649982..8fd990a 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -87,6 +87,18 @@
>  		pinctrl-0 = <&usb301_vbus_en>;
>  		enable-active-high;
>  	};
> +
> +	/* We need GPX0_6 to be low at sleep time; just keep it low always */
> +	mask_tpm_reset_regulator: mask-tpm-reset-regulator {
> +	compatible = "regulator-fixed";
> +	regulator-name = "mask-tpm-reset ";
> +		gpio = <&gpx0 6 0>;
> +		enable-active-low;
> +		regulator-boot-on;
> +		regulator-always-on;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&mask_tpm_reset>;
> +	};

I don't think this pin is supposed to be a real regulator. If I'm right,
you should just add a hog for it, if you don't have a proper driver to
handle it.

>  };
>  
>  &dp {
> @@ -210,6 +222,14 @@
>  
>  
>  &pinctrl_0 {
> +

nit: No need for this blank line.

Best regards,
Tomasz
