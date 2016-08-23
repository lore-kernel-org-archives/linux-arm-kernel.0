From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 23 Aug 2016 11:35:26 +0900
Subject: [PATCH 1/2] clk: samsung: exynos5260: Move struct samsung_cmu_info
 to init section
In-Reply-To: <20160823005512.GP6502@codeaurora.org>
References: <1471834185-20249-1-git-send-email-cw00.choi@samsung.com>
 <1471834185-20249-2-git-send-email-cw00.choi@samsung.com>
 <CGME20160823005523epcas1p3993794ba487bb055cbf8a0b247fcb280@epcas1p3.samsung.com>
 <20160823005512.GP6502@codeaurora.org>
Message-ID: <57BBB66E.2060807@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On 2016? 08? 23? 09:55, Stephen Boyd wrote:
> On 08/22, Chanwoo Choi wrote:
>> This patch moves the all samsung_cmu_info struct to initconst section
>> because they are used only in initconst section.
>>
>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5260.c | 350 +++++++++++++++++------------------
>>  1 file changed, 175 insertions(+), 175 deletions(-)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5260.c b/drivers/clk/samsung/clk-exynos5260.c
>> index a43642c36039..fd1d9bfc151b 100644
>> --- a/drivers/clk/samsung/clk-exynos5260.c
>> +++ b/drivers/clk/samsung/clk-exynos5260.c
>> @@ -131,21 +131,21 @@ static const struct samsung_gate_clock aud_gate_clks[] __initconst = {
>>  			EN_IP_AUD, 4, 0, 0),
>>  };
>>  
>> +static const struct samsung_cmu_info aud_cmu __initconst = {
>> +	.mux_clks	= aud_mux_clks,
>> +	.nr_mux_clks	= ARRAY_SIZE(aud_mux_clks),
>> +	.div_clks	= aud_div_clks,
>> +	.nr_div_clks	= ARRAY_SIZE(aud_div_clks),
>> +	.gate_clks	= aud_gate_clks,
>> +	.nr_gate_clks	= ARRAY_SIZE(aud_gate_clks),
>> +	.nr_clk_ids	= AUD_NR_CLK,
>> +	.clk_regs	= aud_clk_regs,
>> +	.nr_clk_regs	= ARRAY_SIZE(aud_clk_regs),
>> +};
>> +
>>  static void __init exynos5260_clk_aud_init(struct device_node *np)
>>  {
>> -	struct samsung_cmu_info cmu = { NULL };
>> -
> 
> I presume this was done this way to save some initdata space by
> only allocating the array that's needed at runtime? I would
> expect to see some more kernel image bloat from this change but
> runtime memory usage would stay the same. Is there any real
> benefit from this patch though?
> 

After this patch, 'struct samsung_cmu_info' size should be added
to kernel image and then the size of deleted code should be removed
from kernel image. I think that it is not bloating.
(struct samsung_cmu_info includes the pointer and integer value.)

This patch make the code more simple and improve the readability.
And, the samsung_cmu_register_on() requires the 'const' type
argument for 'struct samsung_cmu_info'.

Regards,
Chanwoo Choi
