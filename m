From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Aug 2013 10:58:30 +0100
Subject: [PATCHv2 1/9] ARM: kirkwood: convert d2net_v2 to DT
In-Reply-To: <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1375369655-1310-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1375369655-1310-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130813095830.GI27165@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 01, 2013 at 04:07:27PM +0100, Thomas Petazzoni wrote:
> This commit completely converts the d2net_v2 Kirkwood board to use a
> Device Tree representation.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/Makefile              |   1 +
>  arch/arm/boot/dts/kirkwood-d2net-v2.dts | 231 ++++++++++++++++++++++++++++++++
>  arch/arm/mach-kirkwood/Kconfig          |   7 -
>  arch/arm/mach-kirkwood/Makefile         |   2 +-
>  arch/arm/mach-kirkwood/d2net_v2-setup.c | 231 --------------------------------
>  5 files changed, 233 insertions(+), 239 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-d2net-v2.dts
>  delete mode 100644 arch/arm/mach-kirkwood/d2net_v2-setup.c
> 

[...]

> +       regulators {
> +               compatible = "simple-bus";
> +               pinctrl-0 = <&pmx_sata_power>;
> +               pinctrl-names = "default";
> +               #address-cells = <1>;
> +               #size-cells = <0>;

That's not really a simple-bus if there's no mapping to the parent's
address space (and it represents a completely different concept of
address).

Could you explain what the pinctrl's doing here? I couldn't see what
code would be handling that given the node will get probed as a
simple-bus and the regulator-fixed binding doesn't mention anything
about the parent node.

> +
> +               sata0_power: regulator at 1 {
> +                       compatible = "regulator-fixed";
> +                       reg = <1>;

Do we even need the unit-address?

> +                       regulator-name = "SATA0 Power";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       enable-active-high;
> +                       regulator-always-on;
> +                       regulator-boot-on;
> +                       gpio = <&gpio0 16 0>;
> +               };
> +       };
> +};

Thanks,
Mark.
