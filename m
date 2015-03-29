From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sun, 29 Mar 2015 12:20:33 +0200
Subject: Fwd: Ask for help: ARM: mvebu: add NAND support for dove
In-Reply-To: <551714F8.2050401@gmail.com>
References: <551713D8.3060809@gmail.com> <551714F8.2050401@gmail.com>
Message-ID: <5517D1F1.6000309@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.03.2015 21:54, Gabriel Dobato wrote:
> I am trying to set the Nand in a CM-510 Compulab based board (4.0-rc5).
>
> As pxa3xx-nand driver supports NFCv1 (PXA3xx) and NFCv2 (Armada 370/XP),
> I think that it should work more or less with Dove SoC (NFCv1) that is
> similar enough.

Gabriel,

I haven't compared Dove NFC with the one from PXA3xx or Armada 370/XP
in detail, yet. I doubt that it will be fully compatible with Armada
370/XP as you state it is NFCv2 above.

> Until now, I've only added the correspondent node in dove.dtsi and the
> partitions in dove-cm-a510.dts ( it should be updated in the patch
> series that Sebastian Hesselbarth submitted ) :

We'll deal with it as soon as the i2c-mux thing is worked out.

> ---
>   arch/arm/boot/dts/dove-cm-a510.dts | 17 +++++++++++++++++
>   arch/arm/boot/dts/dove.dtsi        | 16 ++++++++++++++++
>   2 files changed, 33 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dove-cm-a510.dts
> b/arch/arm/boot/dts/dove-cm-a510.dts
> index 50c0d69..36cf10d 100644
> --- a/arch/arm/boot/dts/dove-cm-a510.dts
> +++ b/arch/arm/boot/dts/dove-cm-a510.dts
> @@ -36,3 +36,20 @@
>   &i2c0 {
>            status = "okay";
>   };
> +
> +&nand  {
> +          status = "okay";
> +          num-cs = <1>;
> +          partition at 0 {
> +                 label = "uImage";
> +                 reg = <0x000000000000 0x000000400000>;

#address-cells and #size-cells of &nand below is <1> each, so above
should be 32b values. If it would be 64b it would have to be split
into two 32b values anyway.

> +          };
> +          partition at 400000 {
> +                 label = "Rootfs";
> +                 reg = <0x000000400000 0x00001FC00000>;
> +          };
> +};
> +
> +
> +
> +

Please avoid adding extra whitespaces.

> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index a5441d5..7e71f45 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -380,6 +380,22 @@
>                                  status = "disabled";
>                          };
>
> +                       nand: nand at c0000 {
> +                                compatible = "marvell,armada370-nand";

As said above, I doubt Dove NFC is fully compatible with Armada 370 NFC.
Ezequiel can tell for sure, as he probably knows Marvell NFC best.

> +                                #address-cells = <1>;
> +                                #size-cells = <1>;
> +                                reg= <0xc0000 0x60>;
> +                                interrupts = <3>;
> +                                clocks = <&core_clk 0>;

There is a clock gate for NFC, check Dove FS, Clock Gating Control
register, bit 10. Above should be:

	clocks = <&gate_clk 10>;

> +                                pinctrl-0 = <&pmx_nand>;
> +                                pinctrl-names = "default";
> +                                marvell,nand-keep-config;
> +                                marvell,nand-enable-arbiter;

I haven't checked the foo-arbiter property, but are you sure it is
available on Dove?

Sebastian

> +                                nand-on-flash-bbt;
> +                        };
> +
> +
> +
>                          thermal: thermal-diode at d001c {
>                                  compatible = "marvell,dove-thermal";
>                                  reg = <0xd001c 0x0c>, <0xd005c 0x08>;
