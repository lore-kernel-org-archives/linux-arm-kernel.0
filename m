From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 13:24:18 +0100 (BST)
Subject: [PATCH 2/8] arm: orion5x: Add clk support for mv88f5181
In-Reply-To: <20160826113437.GA12692@Red>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-3-git-send-email-jm@lentin.co.uk>
 <20160826113437.GA12692@Red>
Message-ID: <alpine.DEB.2.11.1608261256170.19980@marmot.wormnet.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 26 Aug 2016, LABBE Corentin wrote:

> Hello
>
> I have some minor comments below
>
> [...]
>> +
>> +static u32 __init mv88f5181_get_tclk_freq(void __iomem *sar)
>> +{
>> +	u32 opt = (readl(sar) >> SAR_MV88F5181_TCLK_FREQ) &
>> +		SAR_MV88F5181_TCLK_FREQ_MASK;
>
> Checkpatch complain about a missing blank line after declaration.
> And spliting the read and the & operation will prevent this line breaking

It isn't here, although I'm not arguing the line is missing. Is there an 
extra switch I'm missing?

>> +	if (opt == 0)
>> +		return 133333333;
>> +	else if (opt == 1)
>> +		return 150000000;
>> +	else if (opt == 2)
>> +		return 166666667;
>> +	else
>> +		return 0;
>> +}
>
> Why not using a switch here ?

If you look at this in context[0], this is one of several code-as-config 
declarations, none of which use a switch. IMO it's more useful to make the 
similarity as obvious as possible if this is ever refactored.

Obviously the rest of the file could also be refactored with switch 
statements, but instead of doing that it seems more tempting to move the 
config into the DT binding, e.g.

   cpu-freq-addr = <4>;
   cpu-freq-mask = <0xf>;
   cpu-freqs = <0 333333333 400000000 400000000 500000000>;
   clk-ratios = <0 1 1 2 1 2 1 3 1 3>;

...this is completely off the top of my head mind, so could easily be 
missing something obvious / some prior art.

[0] http://lxr.free-electrons.com/source/drivers/clk/mvebu/orion.c

>> +
>> +#define SAR_MV88F5181_CPU_FREQ       4
>> +#define SAR_MV88F5181_CPU_FREQ_MASK  0xf
>> +
>> +static u32 __init mv88f5181_get_cpu_freq(void __iomem *sar)
>> +{
>> +	u32 opt = (readl(sar) >> SAR_MV88F5181_CPU_FREQ) &
>> +		SAR_MV88F5181_CPU_FREQ_MASK;
>> +	if (opt == 0)
>> +		return 333333333;
>> +	else if (opt == 1 || opt == 2)
>> +		return 400000000;
>> +	else if (opt == 3)
>> +		return 500000000;
>> +	else
>> +		return 0;
>> +}
>
> Same comments
>
>> +
>> +static void __init mv88f5181_get_clk_ratio(void __iomem *sar, int id,
>> +					   int *mult, int *div)
>> +{
>> +	u32 opt = (readl(sar) >> SAR_MV88F5181_CPU_FREQ) &
>> +		SAR_MV88F5181_CPU_FREQ_MASK;
>> +	if (opt == 0 || opt == 1) {
>> +		*mult = 1;
>> +		*div  = 2;
>> +	} else if (opt == 2 || opt == 3) {
>> +		*mult = 1;
>> +		*div  = 3;
>> +	} else {
>> +		*mult = 0;
>> +		*div  = 1;
>> +	}
>> +}
>
> Same comments
>
> Regards
>
>

-- 
Jamie Lentin
