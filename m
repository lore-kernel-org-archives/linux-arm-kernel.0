From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 23 Aug 2016 12:07:30 +0200
Subject: [PATCH 1/2] clk: samsung: exynos5260: Move struct samsung_cmu_info
 to init section
In-Reply-To: <57BBB66E.2060807@samsung.com>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
 <1471834185-20249-2-git-send-email-cw00.choi@samsung.com>
 <CGME20160823005523epcas1p3993794ba487bb055cbf8a0b247fcb280@epcas1p3.samsung.com>
 <20160823005512.GP6502@codeaurora.org> <57BBB66E.2060807@samsung.com>
Message-ID: <84e40b9b-1e08-24e0-f1ef-60b38b760ae6@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2016 04:35 AM, Chanwoo Choi wrote:
>>>  
>>> +static const struct samsung_cmu_info aud_cmu __initconst = {
>>> +	.mux_clks	= aud_mux_clks,
>>> +	.nr_mux_clks	= ARRAY_SIZE(aud_mux_clks),
>>> +	.div_clks	= aud_div_clks,
>>> +	.nr_div_clks	= ARRAY_SIZE(aud_div_clks),
>>> +	.gate_clks	= aud_gate_clks,
>>> +	.nr_gate_clks	= ARRAY_SIZE(aud_gate_clks),
>>> +	.nr_clk_ids	= AUD_NR_CLK,
>>> +	.clk_regs	= aud_clk_regs,
>>> +	.nr_clk_regs	= ARRAY_SIZE(aud_clk_regs),
>>> +};
>>> +
>>>  static void __init exynos5260_clk_aud_init(struct device_node *np)
>>>  {
>>> -	struct samsung_cmu_info cmu = { NULL };
>>> -
>>
>> I presume this was done this way to save some initdata space by
>> only allocating the array that's needed at runtime? I would
>> expect to see some more kernel image bloat from this change but
>> runtime memory usage would stay the same. Is there any real
>> benefit from this patch though?
>>
> 
> After this patch, 'struct samsung_cmu_info' size should be added
> to kernel image and then the size of deleted code should be removed
> from kernel image. I think that it is not bloating.
> (struct samsung_cmu_info includes the pointer and integer value.)
> 
> This patch make the code more simple and improve the readability.
> And, the samsung_cmu_register_on() requires the 'const' type
> argument for 'struct samsung_cmu_info'.

I checked stripped object files and it seems with the patch there
is some saving of the kernel image size. Exactly 784 bytes, which
makes zImage smaller by 480 bytes.

The patch increases .init.rodata section size by 780 bytes but 
decreases .init.text section size by 1564 bytes.  Looks like 
a static initializer is cheaper.

$ ls -l  drivers/clk/samsung/clk-exynos5260.o

< -rw-rw-r-- 1 snawrocki snawrocki 29100 Aug 23 11:35 drivers/clk/samsung/clk-exynos5260.o
---
> -rw-rw-r-- 1 snawrocki snawrocki 28316 Aug 23 11:32 drivers/clk/samsung/clk-exynos5260.o


The section size differences are as below:
15c15
<   3 .init.text    000006b8  00000000  00000000  00000034  2**2
---
>   3 .init.text    0000009c  00000000  00000000  00000034  2**2
25c25
<   8 .init.rodata  00003f6c  00000000  00000000  00002f20  2**2
---
>   8 .init.rodata  00004278  00000000  00000000  00002904  2**2

So the saving is rather insignificant but the patch doesn't make
things worse and I'd say it might be worth applying.

--
Thanks, 
Sylwester
