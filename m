From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 29 Oct 2015 23:10:31 +0530
Subject: [PATCH v4 4/4] ARM: dts: Add Ethernet chip to SMDK5410
In-Reply-To: <6fed900bf831d8bc23ef56c95417887c3d9a2d07.1446122247.git.p.fedin@samsung.com>
References: <cover.1446122247.git.p.fedin@samsung.com>
 <6fed900bf831d8bc23ef56c95417887c3d9a2d07.1446122247.git.p.fedin@samsung.com>
Message-ID: <CAGcde9HVft2zuVVFaaWwApHkyqttdS_M=Kq=Am_JKOYOnp5V+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

On 29 October 2015 at 18:12, Pavel Fedin <p.fedin@samsung.com> wrote:
> The chip is smsc9115, connected via SROMc bank 3. Additionally, some GPIO
> initialization is required.
>
> Signed-off-by: Pavel Fedin <p.fedin@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5410-smdk5410.dts | 41 +++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5410-smdk5410.dts b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> index cebeaab..311e7be 100644
> --- a/arch/arm/boot/dts/exynos5410-smdk5410.dts
> +++ b/arch/arm/boot/dts/exynos5410-smdk5410.dts
> @@ -61,6 +61,27 @@
>         disable-wp;
>  };
>
> +&pinctrl_0 {
> +       srom_ctl: srom-ctl {
> +               samsung,pins = "gpy0-3", "gpy0-4", "gpy0-5",
> +                              "gpy1-0", "gpy1-1", "gpy1-2", "gpy1-3";
> +               samsung,pin-function = <2>;
> +               samsung,pin-drv = <0>;
> +       };
> +
> +       srom_ebi: srom-ebi {
> +               samsung,pins = "gpy3-0", "gpy3-1", "gpy3-2", "gpy3-3",
> +                              "gpy3-4", "gpy3-5", "gpy3-6", "gpy3-7",
> +                              "gpy5-0", "gpy5-1", "gpy5-2", "gpy5-3",
> +                              "gpy5-4", "gpy5-5", "gpy5-6", "gpy5-7",
> +                              "gpy6-0", "gpy6-1", "gpy6-2", "gpy6-3",
> +                              "gpy6-4", "gpy6-5", "gpy6-6", "gpy6-7";
> +               samsung,pin-function = <2>;
> +               samsung,pin-pud = <3>;
> +               samsung,pin-drv = <0>;
> +       };
> +};
> +
>  &uart0 {
>         status = "okay";
>  };
> @@ -72,3 +93,23 @@
>  &uart2 {
>         status = "okay";
>  };
> +
> +&sromc {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&srom_ctl>, <&srom_ebi>;
> +
> +       ethernet at 07000000 {
> +               compatible = "smsc,lan9115";
> +               reg = <0x07000000 0x10000>;
> +               phy-mode = "mii";
> +               interrupt-parent = <&gpx0>;
> +               interrupts = <5 8>;
> +               reg-io-width = <2>;
> +               smsc,irq-push-pull;
> +               smsc,force-internal-phy;
> +
> +               samsung,srom-bank = <3>;
> +               samsung,srom-data-width = <2>;
> +               samsung,srom-timing = <1 9 12 1 9 1 1>;

I think this is not correct. We can't change binding of "smsc,lan9115"
which is already documented here [1]. These samsung specific srom
properties should be in srom node or its subnode, but not in this way.

[1]: Documentation/devicetree/bindings/net/smsc911x.txt

Thanks,
Pankaj Dubey

> +       };
> +};
> --
> 2.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
