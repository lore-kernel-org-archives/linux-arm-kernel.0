From: robh+dt@kernel.org (Rob Herring)
Date: Thu, 31 May 2018 09:45:02 -0500
Subject: [PATCH v3 2/5] gpio: syscon: rockchip: add GPIO_MUTE support for
 rk3328
In-Reply-To: <1527737273-8387-3-git-send-email-djw@t-chip.com.cn>
References: <1527737273-8387-1-git-send-email-djw@t-chip.com.cn>
 <1527737273-8387-3-git-send-email-djw@t-chip.com.cn>
Message-ID: <CAL_JsqJK4vrmLBeN_ZeGCXAyqshshL16B0KN_+8uvt+=-O9TEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 10:27 PM,  <djw@t-chip.com.cn> wrote:
> From: Levin Du <djw@t-chip.com.cn>
>
> In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec
> mute control, can also be used for general purpose. It is manipulated by
> the GRF_SOC_CON10 register.
>
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
>
> ---
>
> Changes in v3:
> - Change from general gpio-syscon to specific rk3328-gpio-mute
>
> Changes in v2:
> - Rename gpio_syscon10 to gpio_mute in doc
>
> Changes in v1:
> - Refactured for general gpio-syscon usage for Rockchip SoCs.
> - Add doc rockchip,gpio-syscon.txt
>
>  .../bindings/gpio/rockchip,rk3328-gpio-mute.txt    | 28 +++++++++++++++++++
>  drivers/gpio/gpio-syscon.c                         | 31 ++++++++++++++++++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
>
> diff --git a/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
> new file mode 100644
> index 0000000..10bc632
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/rockchip,rk3328-gpio-mute.txt
> @@ -0,0 +1,28 @@
> +Rockchip RK3328 GPIO controller dedicated for the GPIO_MUTE pin.
> +
> +In Rockchip RK3328, the output only GPIO_MUTE pin, originally for codec mute
> +control, can also be used for general purpose. It is manipulated by the
> +GRF_SOC_CON10 register.
> +
> +Required properties:
> +- compatible: Should contain "rockchip,rk3328-gpio-mute".
> +- gpio-controller: Marks the device node as a gpio controller.
> +- #gpio-cells: Should be 2. The first cell is the pin number and
> +  the second cell is used to specify the gpio polarity:
> +    0 = Active high,
> +    1 = Active low.
> +
> +Example:
> +
> +       grf: syscon at ff100000 {
> +               compatible = "rockchip,rk3328-grf", "syscon", "simple-mfd";
> +
> +               gpio_mute: gpio-mute {

Node names should be generic:

gpio {

This also means you can't add another GPIO node in the future and
you'll have to live with "rockchip,rk3328-gpio-mute" covering more
than 1 GPIO if you do need to add more GPIOs.

> +                       compatible = "rockchip,rk3328-gpio-mute";
> +                       gpio-controller;
> +                       #gpio-cells = <2>;
> +               };
> +       };
> +
> +Note: The gpio_mute node should be declared as the child of the GRF (General
> +Register File) node. The GPIO_MUTE pin is referred to as <&gpio_mute 0>.

This is wrong because you should have 2 cells. The phandle doesn't
count as a cell.

Rob
