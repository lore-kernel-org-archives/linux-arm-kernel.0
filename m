From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Nov 2014 10:30:24 +0000
Subject: [PATCH v3 2/2] arm64: Add Juno board device tree.
In-Reply-To: <1415727131-4572-3-git-send-email-Liviu.Dudau@arm.com>
References: <1415727131-4572-1-git-send-email-Liviu.Dudau@arm.com>
 <1415727131-4572-3-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <5475ABC0.3090007@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Liviu,

On 11/11/14 17:32, Liviu Dudau wrote:
> This adds support for ARM's Juno development board (rev 0).
> It enables most of the board peripherals: UART, I2C, USB, MMC and
> 100Mb ethernet. There is no support at the moment for clock setting
> and HDLCD driver which depends on it.
> 
> Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> ---
>  arch/arm64/boot/dts/arm/Makefile              |   1 +
>  arch/arm64/boot/dts/arm/juno-clocks.dtsi      |  45 ++++++
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 129 +++++++++++++++
>  arch/arm64/boot/dts/arm/juno.dts              | 218 ++++++++++++++++++++++++++
>  4 files changed, 393 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/arm/juno-clocks.dtsi
>  create mode 100644 arch/arm64/boot/dts/arm/juno-motherboard.dtsi
>  create mode 100644 arch/arm64/boot/dts/arm/juno.dts
> 

[...]

> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> new file mode 100644
> index 0000000..097ecc4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/arm/juno.dts

[...]

> +       timer {
> +               compatible = "arm,armv8-timer";
> +               interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>,
> +                            <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>,
> +                            <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>,
> +                            <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_EDGE_RISING)>;
> +       };

Sorry, I should have spotted this earlier: all these interrupts are
*level*, not edge. This happens to work because the GIC's config
register is RO for PPIs on Juno, but still...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
