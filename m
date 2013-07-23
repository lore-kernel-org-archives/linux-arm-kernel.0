From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Tue, 23 Jul 2013 20:13:23 +0530
Subject: [PATCH] ARM: dts: tegra114: dalmore: fix the irq trigger type
 of Palmas MFD device
In-Reply-To: <1374574191-24396-1-git-send-email-josephl@nvidia.com>
References: <1374574191-24396-1-git-send-email-josephl@nvidia.com>
Message-ID: <51EE968B.1050103@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 July 2013 03:39 PM, Joseph Lo wrote:
> The IRQ trigger type of Palmas MFD device (tps65913) is low-level
> sensitive. The wrong configuration would cause an interrupt storm
> when booting the system. Fixing it in DT with appropriate interrupt
> type.
>
> Cc: Laxman Dewangan <ldewangan@nvidia.com>
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
>   arch/arm/boot/dts/tegra114-dalmore.dts | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> index 76529e4..70b9d0c 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -840,7 +840,7 @@
>   		palmas: tps65913 {
>   			compatible = "ti,palmas";
>   			reg = <0x58>;
> -			interrupts = <0 86 0x4>;
> +			interrupts = <0 86 0x8>;
>   

This fails as GIC does not support the interrupt flag of 8.

[   13.007755] genirq: Setting trigger mode 8 for irq 118 failed 
(gic_set_type+0x0/0xf0)
[   13.009152] palmas 1-0058: Irq flag is 0x00000000


I did not get the interrupt storm and even interrupt is not working on tot.
Two ways to resolve this:
- Change the interrupt flag to 0 from 4. Or
- Remove the nvidia,invert-interrupt; for PMC node.
