From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 21:22:24 +0900
Subject: [PATCH 3/4] ARM: mach-shmobile: r8a7779: Minimal setup using DT
In-Reply-To: <1359597051-32700-4-git-send-email-horms+renesas@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-4-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CANqRtoTM9d0kviajg8Og=6u=sqzKFBA=sgsKKoMLHXpz=QFOMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, Jan 31, 2013 at 10:50 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Allow a minimal setup of the r8a7779 SoC using a flattened device tree.
> In particular, configure the i2c and ethernet controllers using a
> flattened device tree.
>
> SCI serial controller and TMU clock source, whose drivers do not yet
> support configuration using a flattened device tree, are still configured
> using C code in order to allow booting of a board with this SoC.
>
> The ethernet controller also requires a regulator which is a board property.
> A sample snippet DT for the marzen board is as follows:
>
> /dts-v1/;
> /include/ "r8a7779.dtsi"
>
> / {
>         fixedregulator3v3: fixedregulator at 0 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "fixed-3.3V";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>                 regulator-boot-on;
>                 regulator-always-on;
>         };
> };
>
> &lan0 {
>         vddvario-supply = <&fixedregulator3v3>;
>         vdd33a-supply = <&fixedregulator3v3>;
> };
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7779.dtsi               |   45 ++++++++++++++++++++
>  arch/arm/mach-shmobile/include/mach/common.h |    2 +
>  arch/arm/mach-shmobile/setup-r8a7779.c       |   58 +++++++++++++++++++++++---
>  3 files changed, 99 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index eadc12e..9564040 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -37,4 +37,49 @@
>                  reg = <0xf0001000 0x1000>,
>                        <0xf0000100 0x100>;
>          };
> +
> +       i2c0: i2c at 0xffc70000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "renesas,rmobile-iic";
> +               reg = <0xffc70000 0x1000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 79 0x4>;
> +       };
> +
> +       i2c1: i2c at 0xffc71000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "renesas,rmobile-iic";
> +               reg = <0xffc71000 0x1000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 82 0x4>;
> +       };
> +
> +       i2c2: i2c at 0xffc72000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "renesas,rmobile-iic";
> +               reg = <0xffc72000 0x1000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 80 0x4>;
> +       };
> +
> +       i2c3: i2c at 0xffc73000 {
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +               compatible = "renesas,rmobile-iic";
> +               reg = <0xffc73000 0x1000>;
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 81 0x4>;
> +       };
> +
> +       lan0: lan0 at 18000000 {
> +               compatible = "smsc,lan9220", "smsc,lan9115";
> +               reg = <0x18000000 0x100>;
> +               phy-mode = "mii";
> +               interrupt-parent = <&gic>;
> +               interrupts = <0 28 0x4>;
> +               reg-io-width = <4>;
> +       };
>  };

Simon, thanks for your efforts on this DT reference implementation.

The lan0 snippet above seems incorrect. If I understand the code above
correctly then it is written to be specific to the r8a7779 SoC. I
suspect so because it is located in the SoC-specific dtsi file. The
smsc ethernet controller is a board specific property - so it should
instead be located in r8a7779-marzen-reference.dts.

In the future, feel free to ask if you are unsure which bits that are
SoC specific properties and which that belong to the board.

Thanks,

/ magnus
