From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Jul 2016 20:34:43 +0300
Subject: [PATCH v0 03/10] arm: orion5x: Add clk support for mv88f5181
In-Reply-To: <1468679348-10522-4-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1468679348-10522-4-git-send-email-jm@lentin.co.uk>
Message-ID: <ed490090-c127-3f4f-d923-2d04918d00cb@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/16/2016 5:29 PM, Jamie Lentin wrote:

> Referring to values in the u-boot port, add support for the mv88f5181
>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>

[...]
> diff --git a/drivers/clk/mvebu/orion.c b/drivers/clk/mvebu/orion.c
> index fd12956..a6e5bee 100644
> --- a/drivers/clk/mvebu/orion.c
> +++ b/drivers/clk/mvebu/orion.c
> @@ -21,6 +21,76 @@ static const struct coreclk_ratio orion_coreclk_ratios[] __initconst = {
>  };
>
>  /*
> + * Orion 5181
> + */
> +
> +#define SAR_MV88F5181_TCLK_FREQ      8
> +#define SAR_MV88F5181_TCLK_FREQ_MASK 0x3
> +
> +static u32 __init mv88f5181_get_tclk_freq(void __iomem *sar)
> +{
> +	u32 opt = (readl(sar) >> SAR_MV88F5181_TCLK_FREQ) &
> +		SAR_MV88F5181_TCLK_FREQ_MASK;
> +	if (opt == 0)
> +		return 133333333;
> +	else if (opt == 1)
> +		return 150000000;
> +	else if (opt == 2)
> +		return 166666667;

    Do you know about the *switch* statement? :-)

> +	else
> +		return 0;
> +}
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

    Asks to be a *switch* as well...

> +	else
> +		return 0;
> +}
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

     This one too...

[...]

MBR, Sergei
