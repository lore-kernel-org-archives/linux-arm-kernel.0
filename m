From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 7 Aug 2018 13:04:27 +0800
Subject: [PATCH v3 05/19] arm64: dts: allwinner: a64: Orange Pi Win:
 Enable USB OTG socket
In-Reply-To: <20180730123137.923-6-andre.przywara@arm.com>
References: <20180730123137.923-1-andre.przywara@arm.com>
 <20180730123137.923-6-andre.przywara@arm.com>
Message-ID: <CAGb2v658e-L98z=Xd7V5NToWUKTr4V+3T6vseFRJ0C=0UJ=BkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2018 at 8:31 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> From: Samuel Holland <samuel@sholland.org>
>
> The Orange Pi Win has a micro USB-B socket, connected to the SoC's
> USB-OTG port. Its power is supplied by the AXP PMIC, and the ID pin is
> connected to GPIO PH9. It can serve both as a host or a client port.
>
> Add the respective DT node to enable it.

This patch is missing vbus detection and vbus-supply for usb0.

The former uses the PMIC's own VBUS detection.

The latter, according to the schematics, is a separate fixed regulator
controlled by the PMIC's N_VBUSEN pin, so it would correspond to the
PMIC's drive_vbus regulator node. Also the commit description is wrong.


ChenYu

> Signed-off-by: Samuel Holland <samuel@sholland.org>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> index a73489850d88..c9cabe987c19 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
> @@ -214,8 +214,13 @@
>         status = "okay";
>  };
>
> +&usb_otg {
> +       dr_mode = "otg";
> +       status = "okay";
> +};
> +
>  &usbphy {
> +       usb0_id_det-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
>         usb1_vbus-supply = <&reg_usb1_vbus>;
>         status = "okay";
>  };
> -
> --
> 2.14.4
>
