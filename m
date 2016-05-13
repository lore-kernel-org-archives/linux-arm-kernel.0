From: dianders@chromium.org (Doug Anderson)
Date: Fri, 13 May 2016 14:42:06 -0700
Subject: [PATCH v2 1/2] ARM64: dts: rockchip: add sdhci/emmc for rk3399
In-Reply-To: <1463092552-60696-1-git-send-email-briannorris@chromium.org>
References: <1463092552-60696-1-git-send-email-briannorris@chromium.org>
Message-ID: <CAD=FV=UwtHu+DmJZqeWDQ8B9wMVdKODRignqDdZ4rknnmQru3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 12, 2016 at 3:35 PM, Brian Norris <briannorris@chromium.org> wrote:
> Add description for the SDHCI v5.1 eMMC controller on rk3399. Fix it to
> 200 MHz, to support all supported timing modes.
>
> Note that 'rockchip,rk3399-sdhci-5.1' is not documented; we presumably
> have a compliant Arasan controller, but let's have a rockchip property
> as the canonical backup/precautionary measure. Per Heiko's previous
> suggestion, let's not clutter the arasan doc with it.
>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>
>  * improved commit message
>  * assign eMMC clock to 200 MHz
>
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 46f325a143b0..9980c2eab4e9 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -215,6 +215,19 @@
>                 status = "disabled";
>         };
>
> +       sdhci: sdhci at fe330000 {
> +               compatible = "rockchip,rk3399-sdhci-5.1", "arasan,sdhci-5.1";
> +               reg = <0x0 0xfe330000 0x0 0x10000>;
> +               interrupts = <GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
> +               clocks = <&cru SCLK_EMMC>, <&cru ACLK_EMMC>;
> +               clock-names = "clk_xin", "clk_ahb";
> +               assigned-clocks = <&cru SCLK_EMMC>;
> +               assigned-clock-rates = <200000000>;
> +               phys = <&emmc_phy>;
> +               phy-names = "phy_arasan";
> +               status = "disabled";
> +       };
> +
>         usb_host0_ehci: usb at fe380000 {
>                 compatible = "generic-ehci";
>                 reg = <0x0 0xfe380000 0x0 0x20000>;
> @@ -481,8 +494,18 @@
>         };
>
>         grf: syscon at ff770000 {
> -               compatible = "rockchip,rk3399-grf", "syscon";
> +               compatible = "rockchip,rk3399-grf", "syscon", "simple-mfd";
>                 reg = <0x0 0xff770000 0x0 0x10000>;
> +
> +               #address-cells = <1>;
> +               #size-cells = <1>;
> +
> +               emmc_phy: phy at f780 {
> +                       compatible = "rockchip,rk3399-emmc-phy";
> +                       reg = <0xf780 0x20>;

This is slightly wrong.  It should be:

reg = <0xf780 0x24>;

The status register is at an offset of 0x20 and is 4 bytes big, so we
need room for it.


After that is fixed, feel free to add my Reviewed-by tag.

-Doug
