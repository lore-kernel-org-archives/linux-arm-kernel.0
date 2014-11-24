From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 24 Nov 2014 17:01:32 +0000
Subject: [RFC PATCH v2 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <1416605010-10442-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1416605010-10442-4-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
Message-ID: <5473646C.2050705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21/11/14 21:23, Ganapatrao Kulkarni wrote:
> adding devicetree definition for Cavium's Thunder SoC in 2 Node topology.
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
> ---
>  arch/arm64/boot/dts/thunder-88xx-2n.dts  |  88 ++++
>  arch/arm64/boot/dts/thunder-88xx-2n.dtsi | 694 +++++++++++++++++++++++++++++++
>  2 files changed, 782 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dts
>  create mode 100644 arch/arm64/boot/dts/thunder-88xx-2n.dtsi
> 

[...]

> diff --git a/arch/arm64/boot/dts/thunder-88xx-2n.dtsi b/arch/arm64/boot/dts/thunder-88xx-2n.dtsi
> new file mode 100644
> index 0000000..3f217b4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/thunder-88xx-2n.dtsi

[...]

> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <1 13 0xff01>,
> +                            <1 14 0xff01>,
> +                            <1 11 0xff01>,
> +                            <1 10 0xff01>;
> +       };

These "0xff01" cells are bogus (the GICv3 binding only specifies values
1 and 4 for respectively edge and level triggered). My hunch is that
they should be 4, as the timers are likely to be level triggered.

> +
> +       soc {
> +               compatible = "simple-bus";
> +               #address-cells = <2>;
> +               #size-cells = <2>;
> +               ranges;
> +
> +               refclk50mhz: refclk50mhz {
> +                       compatible = "fixed-clock";
> +                       #clock-cells = <0>;
> +                       clock-frequency = <50000000>;
> +                       clock-output-names = "refclk50mhz";
> +               };
> +
> +               gic0: interrupt-controller at 8010,00000000 {
> +                       compatible = "arm,gic-v3";
> +                       #interrupt-cells = <3>;
> +                       #address-cells = <2>;
> +                       #size-cells = <2>;
> +                       #redistributor-regions = <2>;
> +                       ranges;
> +                       interrupt-controller;
> +                       reg = <0x8010 0x00000000 0x0 0x010000>, /* GICD */
> +                             <0x8010 0x80000000 0x0 0x600000>, /* GICR Node 0 */
> +                             <0x9010 0x80000000 0x0 0x600000>; /* GICR Node 1 */
> +                       interrupts = <1 9 0xf04>;
> +                     };

Same here.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
