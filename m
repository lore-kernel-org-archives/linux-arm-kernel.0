From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Jul 2013 09:16:36 -0600
Subject: [PATCH V2] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
References: <1374663272-9937-1-git-send-email-josephl@nvidia.com>
Message-ID: <51F292D4.9030208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2013 04:54 AM, Joseph Lo wrote:
> The IRQ trigger type of Palmas MFD device (tps65913) is edge trigger. The
> wrong configuration would cause an interrupt storm when booting the
> system. Fixing it in DT with appropriate interrupt type.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

>  		palmas: tps65913 {
>  			compatible = "ti,palmas";
>  			reg = <0x58>;
> -			interrupts = <0 86 0x4>;
> +			interrupts = <0 86 0x0>;

The legal values for that final cell are:

    - bits[3:0] trigger type and level flags
        1 = low-to-high edge triggered
        2 = high-to-low edge triggered
        4 = active high level-sensitive
        8 = active low level-sensitive

0 isn't one of those values. This patch can't be correct.

BTW, this cell should use the constants from
<dt-bindings/interrupt-controller/irq.h>.
