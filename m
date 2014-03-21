From: robherring2@gmail.com (Rob Herring)
Date: Fri, 21 Mar 2014 10:03:39 -0500
Subject: [PATCH 03/20] mmc: mmci: Update DT documentation
In-Reply-To: <1395404057-27835-4-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
 <1395404057-27835-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAL_JsqJbaxayELNt+d1VSfFyD58eRYQM=d15RaFcFQKbot3iaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 7:14 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Document how to configure the regulator supplies and add an example of
> a typical mmci DT node.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/devicetree/bindings/mmc/mmci.txt |   35 ++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
> index 2b584ca..d167562 100644
> --- a/Documentation/devicetree/bindings/mmc/mmci.txt
> +++ b/Documentation/devicetree/bindings/mmc/mmci.txt
> @@ -9,7 +9,38 @@ by mmc.txt and the properties used by the mmci driver.
>  Required properties:
>  - compatible             : contains "arm,pl18x", "arm,primecell".
>  - arm,primecell-periphid : contains the PrimeCell Peripheral ID.

This should not be required. This is only for if the peripheral ID is
wrong in the h/w.

> +- vmmc-supply            : phandle to the regulator device tree node.

You cannot add new required properties as that breaks the ABI. The
exception is if you *know* it is okay to break all users of this
binding.

>  Optional properties:
> -- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable
> -- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable
> +- mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
> +- mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
> +- vqmmc-supply           : phandle to the regulator device tree node.

Is this a standard property? If not, explain what vmmc and vgmmc are
for and what the difference is.

> +
> +Example:
> +
> +sdi0_per1 at 80126000 {
> +       compatible = "arm,pl18x", "arm,primecell";
> +       arm,primecell-periphid = <0x10480180>;

Drop this from the example.

> +       reg = <0x80126000 0x1000>;
> +       interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
> +
> +       dmas = <&dma 29 0 0x2>, /* Logical - DevToMem */
> +              <&dma 29 0 0x0>; /* Logical - MemToDev */
> +       dma-names = "rx", "tx";
> +
> +       clocks = <&prcc_kclk 1 5>, <&prcc_pclk 1 5>;
> +       clock-names = "sdi", "apb_pclk";
> +
> +       max-frequency = <100000000>;
> +       bus-width = <4>;
> +       mmc-cap-sd-highspeed;
> +       mmc-cap-mmc-highspeed;
> +       cd-gpios  = <&gpio2 31 0x4>; // 95
> +
> +       vmmc-supply = <&ab8500_ldo_aux3_reg>;
> +       vqmmc-supply = <&vmmci>;
> +
> +       pinctrl-names = "default", "sleep";
> +       pinctrl-0 = <&sdi0_default_mode>;
> +       pinctrl-1 = <&sdi0_sleep_mode>;
> +};
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
