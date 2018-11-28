From: k.konieczny@partner.samsung.com (Kamil Konieczny)
Date: Wed, 28 Nov 2018 14:31:12 +0100
Subject: [PATCH 4/4] clk: samsung: exynos5433: add imem clock
In-Reply-To: <5BF5520A.5050500@samsung.com>
References: <20181121120509.18892-1-k.konieczny@partner.samsung.com>
 <CGME20181121120524eucas1p166a26857df78947c9e08f0fb8dbf75e4@eucas1p1.samsung.com>
 <20181121120509.18892-5-k.konieczny@partner.samsung.com>
 <5BF5520A.5050500@samsung.com>
Message-ID: <29a0412e-1209-b633-8a10-f6db8eb8af09@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thank you for your review, see below for answers and questions.

On 21.11.2018 13:39, Chanwoo Choi wrote:
> Hi,
> 
> On 2018? 11? 21? 21:05, Kamil Konieczny wrote:
>> Add imem clock for exynos5433.
> 
> It is diffcult to understand the meaning of 'imem' without the description.
> Please add more detailed description as the patch2 description.
> 

Will this be enough for description:

Add imem clock for exynos5433. This will enable to use crypto Security
SubSystem (in short SSS) and SlimSSS IP blocks.

What do you think ?

>> Signed-off-by: Kamil Konieczny <k.konieczny@partner.samsung.com>
>> ---
>>  drivers/clk/samsung/clk-exynos5433.c   | 123 +++++++++++++++++++++++++
>>  include/dt-bindings/clock/exynos5433.h |  55 +++++++++++
>>  2 files changed, 178 insertions(+)
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
>> index 24c3360db65b..db29cbd1fbdc 100644
>> --- a/drivers/clk/samsung/clk-exynos5433.c
>> +++ b/drivers/clk/samsung/clk-exynos5433.c
>> @@ -2345,6 +2345,129 @@ static const struct samsung_cmu_info fsys_cmu_info __initconst = {
>>  	.clk_name		= "aclk_fsys_200",
>>  };
>>  
>> +/*
>> + * Register offset definitions for CMU_IMEM
>> + *
>> + */
>> +
> 
> Remove unneeded blank line.

ok

> 
>> +#define ENABLE_ACLK_IMEM			0x0800
>> +#define ENABLE_ACLK_IMEM_SSS			0x0808
>> +#define ENABLE_ACLK_IMEM_SLIMSSS		0x080c
>> +#define ENABLE_PCLK_IMEM			0x0900
>> +#define ENABLE_PCLK_IMEM_SSS			0x0904
>> +#define ENABLE_PCLK_IMEM_SLIMSSS		0x0908
> 
> When I checked the registers of IMEM block, there are more registers as following:
> Why do you implement the clocks for only six registers?

I added only those that will be used by crypto block (aes and hash block).
I can add all of them in version 2.

> CLK_ENABLE_ACLK_IMEM			0x0800
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_INT_MEM	0x0804
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_SSS		0x0808
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_SLIMSSS	0x080C
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_RTIC	0x0810
> 
> CLK_ENABLE_ACLK_IMEM_SECURE_SMMU_SSS	0x0814
> [...]
> 
>> +
>> +static const unsigned long imem_clk_regs[] __initconst = {
>> +ENABLE_ACLK_IMEM,
>> +ENABLE_ACLK_IMEM_SSS,
>> +ENABLE_ACLK_IMEM_SLIMSSS,
>> +ENABLE_PCLK_IMEM,
>> +ENABLE_PCLK_IMEM_SSS,
>> +ENABLE_PCLK_IMEM_SLIMSSS,
> 
> Add a tab in front of registers.
> 

ok

>> [...]
>> +static void __init exynos5433_cmu_imem_init(struct device_node *np)
>> +{
>> +	samsung_cmu_register_one(np, &imem_cmu_info);
>> +}
>> +
>> +CLK_OF_DECLARE(exynos5433_cmu_imem, "samsung,exynos5433-cmu-imem",
>> +		exynos5433_cmu_imem_init);
> 
> Except for "samsmung,exynos5433-cmu-atlas/apollo", the remained clock blocks
> were added to exynos5433_cmu_of_match[] table for power management.
> 
> If there is no any h/w issue, add the new entry to exynos5433_cmu_of_match for imem block.

ok, I will add this.

>> [...]

-- 
Best regards,
Kamil Konieczny
Samsung R&D Institute Poland
