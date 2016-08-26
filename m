From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Fri, 26 Aug 2016 13:34:37 +0200
Subject: [PATCH 2/8] arm: orion5x: Add clk support for mv88f5181
In-Reply-To: <1472203264-21089-3-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-3-git-send-email-jm@lentin.co.uk>
Message-ID: <20160826113437.GA12692@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

I have some minor comments below

[...]
> +
> +static u32 __init mv88f5181_get_tclk_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5181_TCLK_FREQ) &
> +		SAR_MV88F5181_TCLK_FREQ_MASK;

Checkpatch complain about a missing blank line after declaration.
And spliting the read and the & operation will prevent this line breaking

> +	if (opt == 0)
> +		return 133333333;
> +	else if (opt == 1)
> +		return 150000000;
> +	else if (opt == 2)
> +		return 166666667;
> +	else
> +		return 0;
> +}

Why not using a switch here ?

> +
> +#define SAR_MV88F5181_CPU_FREQ       4
> +#define SAR_MV88F5181_CPU_FREQ_MASK  0xf
> +
> +static u32 __init mv88f5181_get_cpu_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5181_CPU_FREQ) &
> +		SAR_MV88F5181_CPU_FREQ_MASK;
> +	if (opt == 0)
> +		return 333333333;
> +	else if (opt == 1 || opt == 2)
> +		return 400000000;
> +	else if (opt == 3)
> +		return 500000000;
> +	else
> +		return 0;
> +}

Same comments

> +
> +static void __init mv88f5181_get_clk_ratio(void __iomem *sar, int id,
> +					   int *mult, int *div)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5181_CPU_FREQ) &
> +		SAR_MV88F5181_CPU_FREQ_MASK;
> +	if (opt == 0 || opt == 1) {
> +		*mult = 1;
> +		*div  = 2;
> +	} else if (opt == 2 || opt == 3) {
> +		*mult = 1;
> +		*div  = 3;
> +	} else {
> +		*mult = 0;
> +		*div  = 1;
> +	}
> +}

Same comments

Regards
