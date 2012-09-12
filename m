From: b32955@freescale.com (Huang Shijie)
Date: Wed, 12 Sep 2012 10:28:50 +0800
Subject: [PATCH 6/9] mtd: gpmi: simplify the setting DLL code
In-Reply-To: <504F7E10.8030406@gmail.com>
References: <1347344231-10295-1-git-send-email-b32955@freescale.com>
 <1347344231-10295-7-git-send-email-b32955@freescale.com>
 <504F7E10.8030406@gmail.com>
Message-ID: <504FF362.4070609@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?09?12? 02:08, Vikram Narayanan ??:
> Hello Huang Shijie,
>
> On 9/11/2012 11:47 AM, Huang Shijie wrote:
>> The setting DLL code is a little mess.
>> Just simplify the code and the comments.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
>> drivers/mtd/nand/gpmi-nand/gpmi-lib.c | 22 +++++++++-------------
>> 1 files changed, 9 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c 
>> b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> index 037438a..83c5573 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> @@ -779,30 +779,26 @@ void gpmi_begin(struct gpmi_nand_data *this)
>> writel(BM_GPMI_CTRL1_DLL_ENABLE, gpmi_regs + HW_GPMI_CTRL1_CLR);
>>
>> /* Clear out the DLL control fields. */
>> - writel(BM_GPMI_CTRL1_RDN_DELAY, gpmi_regs + HW_GPMI_CTRL1_CLR);
>> - writel(BM_GPMI_CTRL1_HALF_PERIOD, gpmi_regs + HW_GPMI_CTRL1_CLR);
>> + reg = BM_GPMI_CTRL1_RDN_DELAY | BM_GPMI_CTRL1_HALF_PERIOD;
>> + writel(reg, gpmi_regs + HW_GPMI_CTRL1_CLR);
>>
>> /* If no sample delay is called for, return immediately. */
>> if (!hw.sample_delay_factor)
>> return;
>>
>> - /* Configure the HALF_PERIOD flag. */
>> - if (hw.use_half_periods)
>> - writel(BM_GPMI_CTRL1_HALF_PERIOD,
>> - gpmi_regs + HW_GPMI_CTRL1_SET);
>> + /* Set RDN_DELAY or HALF_PERIOD. */
>> + reg = ((hw.use_half_periods) ? BM_GPMI_CTRL1_HALF_PERIOD : 0)
>> + | BF_GPMI_CTRL1_RDN_DELAY(hw.sample_delay_factor);
>>
>> - /* Set the delay factor. */
>> - writel(BF_GPMI_CTRL1_RDN_DELAY(hw.sample_delay_factor),
>> - gpmi_regs + HW_GPMI_CTRL1_SET);
>> + writel(reg, gpmi_regs + HW_GPMI_CTRL1_SET);
>>
>> - /* Enable the DLL. */
>> + /* At last, we enable the DLL. */
>> writel(BM_GPMI_CTRL1_DLL_ENABLE, gpmi_regs + HW_GPMI_CTRL1_SET);
>>
>> /*
>> * After we enable the GPMI DLL, we have to wait 64 clock cycles before
>> - * we can use the GPMI.
>> - *
>> - * Calculate the amount of time we need to wait, in microseconds.
>> + * we can use the GPMI. Calculate the amount of time we need to wait,
>> + * in microseconds.
>> */
>> clock_period_in_ns = 1000000000 / clk_get_rate(r->clock[0]);
>
> NSEC_PER_SEC macro in the above statement?
thanks. I like this macro.

>
> Don't curse me for commenting about the code that you've not written. 
> As this patch does some cleanups, I'm suggesting this.
>
sorry, I do not understand it very well.
could you tell me in detail what's the "commenting about the code that 
you've not written" meaning?

Which comments do you think is not proper?

Best Regards
Huang Shijie



>
>> dll_wait_time_in_us = (clock_period_in_ns * 64) / 1000;
>
> Regards,
> Vikram
>
