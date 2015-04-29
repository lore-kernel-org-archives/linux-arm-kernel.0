From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Wed, 29 Apr 2015 17:48:11 +0200
Subject: [PATCH 1/5] clocksource: st_lpc: Add LPC timer as a clocksource.
In-Reply-To: <alpine.DEB.2.11.1504211153580.13914@nanos>
References: <1429267823-8879-1-git-send-email-peter.griffin@linaro.org>
 <1429267823-8879-2-git-send-email-peter.griffin@linaro.org>
 <alpine.DEB.2.11.1504211153580.13914@nanos>
Message-ID: <5540FD3B.1040702@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Thomas,

On 04/21/2015 11:56 AM, Thomas Gleixner wrote:
> On Fri, 17 Apr 2015, Peter Griffin wrote:
>> +/* Low Power Timer */
>> +#define LPC_LPT_LSB_OFF		0x400
>> +#define LPC_LPT_MSB_OFF		0x404
>> +#define LPC_LPT_START_OFF	0x408
>> +
>> +struct st_lpc {
>> +	struct clk *clk;
>> +	void __iomem *iomem_cs;
>> +};
>> +
>> +static struct st_lpc *st_lpc;
>> +
>> +static u64 notrace st_lpc_counter_read(void)
>> +{
>> +	u64 counter;
>> +	u32 lower;
>> +	u32 upper, old_upper;
>> +
>> +	upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
>> +	do {
>> +		old_upper = upper;
>> +		lower = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_LSB_OFF);
>> +		upper = readl_relaxed(st_lpc->iomem_cs + LPC_LPT_MSB_OFF);
>> +	} while (upper != old_upper);
>> +
>> +	counter = upper;
>> +	counter <<= 32;
>> +	counter |= lower;
>> +	return counter;
>
> What's the point of this exercise? The kernel can handle 32bit
> clocksources nicely. So why do you want to artificially expand them to
> 64bit by adding useless loops and hoops to a hotpath?

I agree we should use only the lower 32 bits.
This timer is moreover clocked at a slow rate (30MHz), so we won't have 
too much interrupts.

Peter, doing that, you could use something like this directly:
clocksource_mmio_init(st_lpc->iomem_cs + LPC_LPT_LSB_OFF, 
"st_lpc_timer", rate,
             200, 24, clocksource_mmio_readl_down);

Thanks,
Maxime

>
> Thanks,
>
> 	tglx
