From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Jun 2015 22:43:52 +0200
Subject: [PATCH v2 4/9] arm: twr-k70f120m: timer driver for Kinetis SoC
In-Reply-To: <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
References: <1435667250-28299-1-git-send-email-pawelo@king.net.pl>
 <1435667250-28299-5-git-send-email-pawelo@king.net.pl>
Message-ID: <2939807.q7WvOoYzDX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 June 2015 14:27:25 Paul Osmialowski wrote:

> +Example:
> +
> +aliases {
> +	pit0 = &pit0;
> +	pit1 = &pit1;
> +	pit2 = &pit2;
> +	pit3 = &pit3;
> +};
> +
> +pit at 40037000 {
> +	compatible = "fsl,kinetis-pit-timer";
> +	reg = <0x40037000 0x100>;
> +	clocks = <&mcg_pclk_gate 5 23>;
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	ranges;

All the subnodes seem to fall inside of the device's own register
area, so I think it would be nicer to use a specific 'ranges'
property that only translates the registers in question.

>  / {
> +	aliases {
> +		pit0 = &pit0;
> +		pit1 = &pit1;
> +		pit2 = &pit2;
> +		pit3 = &pit3;
> +	};
> +
>  	soc {
> +		pit at 40037000 {
> +			compatible = "fsl,kinetis-pit-timer";
> +			reg = <0x40037000 0x100>;
> +			clocks = <&mcg_pclk_gate 5 23>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +
> +			pit0: timer at 40037100 {
> +				reg = <0x40037100 0x10>;
> +				interrupts = <68>;
> +				status = "disabled";
> +			};

I don't think it's necessary to have both an alias
and a label here. What do you use the alias for?

> +
> +#define KINETIS_PITMCR_PTR(base, reg) \
> +	(&(((struct kinetis_pit_mcr_regs *)(base))->reg))
> +#define KINETIS_PITMCR_RD(be, base, reg) \
> +		((be) ? ioread32be(KINETIS_PITMCR_PTR(base, reg)) \
> +		      : ioread32(KINETIS_PITMCR_PTR(base, reg)))
> +#define KINETIS_PITMCR_WR(be, base, reg, val) do { \
> +		if (be) \
> +			iowrite32be((val), KINETIS_PITMCR_PTR(base, reg)); \
> +		else \
> +			iowrite32((val), KINETIS_PITMCR_PTR(base, reg)); \
> +	} while (0)

These should really be written as inline functions. Can you
explain why you need to deal with a big-endian version of this
hardware? Can you configure the endianess of this register block
and just set it to one of the two at boot time?

> +#define KINETIS_PIT_PTR(base, reg) \
> +	(&(((struct kinetis_pit_channel_regs *)(base))->reg))
> +#define KINETIS_PIT_RD(be, base, reg) \
> +		((be) ? ioread32be(KINETIS_PIT_PTR(base, reg)) \
> +		      : ioread32(KINETIS_PIT_PTR(base, reg)))
> +#define KINETIS_PIT_WR(be, base, reg, val) do { \
> +		if (be) \
> +			iowrite32be((val), KINETIS_PIT_PTR(base, reg)); \
> +		else \
> +			iowrite32((val), KINETIS_PIT_PTR(base, reg)); \
> +	} while (0)
> +#define KINETIS_PIT_SET(be, base, reg, mask) \
> +		KINETIS_PIT_WR(be, base, reg, \
> +			KINETIS_PIT_RD(be, base, reg) | (mask))
> +#define KINETIS_PIT_RESET(be, base, reg, mask) \
> +		KINETIS_PIT_WR(be, base, reg, \
> +			KINETIS_PIT_RD(be, base, reg) & (~(mask)))


Functions again. Also, just pass a pointer to your own data structure
into the function, instead of the 'be' and 'base' values.

The 'set' and 'reset' functions look like they need a spinlock
to avoid races.

	Arnd
