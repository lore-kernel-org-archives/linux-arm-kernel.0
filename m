From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 24 Aug 2015 22:02:32 +0800
Subject: [RESEND PATCH] clk: rockchip: disable init state before mmc card
 initialization
In-Reply-To: <120036049.vlT25D4un8@phil>
References: <1440404863-14350-1-git-send-email-shawn.lin@rock-chips.com>
 <120036049.vlT25D4un8@phil>
Message-ID: <55DB23F8.1000704@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/8/24 18:01, Heiko Stuebner wrote:
> Hi Shawn,
>
> Am Montag, 24. August 2015, 16:27:43 schrieb Shawn Lin:
>> mmc host controller's IO input/output timing is unpredictable if
>> bootloader execute tuning for HS200 mode. It might make kernel failed
>> to initialize mmc card in identification mode. The root cause is
>> tuning phase and degree setting for HS200 mode in bootloader aren't
>> applicable to that of identification mode in kernel stage. Anyway, we
>> can't force all bootloaders to disable tuning phase and degree setting
>> before into kernel. Simply disable it in rockchip_clk_register_mmc.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> ---
>>
>>   drivers/clk/rockchip/clk-mmc-phase.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-mmc-phase.c
>> b/drivers/clk/rockchip/clk-mmc-phase.c index e9f8df32..ae21592 100644
>> --- a/drivers/clk/rockchip/clk-mmc-phase.c
>> +++ b/drivers/clk/rockchip/clk-mmc-phase.c
>> @@ -38,6 +38,9 @@ static unsigned long rockchip_mmc_recalc(struct clk_hw
>> *hw, #define ROCKCHIP_MMC_DEGREE_MASK 0x3
>>   #define ROCKCHIP_MMC_DELAYNUM_OFFSET 2
>>   #define ROCKCHIP_MMC_DELAYNUM_MASK (0xff << ROCKCHIP_MMC_DELAYNUM_OFFSET)
>> +#define ROCKCHIP_MMC_INIT_STATE_DISABLE (0x1)
>> +#define ROCKCHIP_MMC_INIT_STATE_SHIFT (1)
>> +#define ROCKCHIP_MMC_INIT_STATE_MASK  (0x1)
>
> you don't need the "()" around primitive values. Also I don't think you need
> the second MASK attribute, doing
> 	writel(HIWORD_UPDATE(ROCKCHIP_MMC_INIT_STATE_DISABLE,
> 				     ROCKCHIP_MMC_INIT_STATE_DISABLE,
> 				     mmc_clock->shift),
>
> should be enough. And thirdly I'm undecided about the naming of the constant.
> The manual describes the init_state as "Assert init_state to soft reset the
> CLKGEN.", so I guess I'd prefer
>
> 	ROCKCHIP_MMC_INIT_STATE_RESET

Thanks, Heiko.

Actually, I'm either not so sure how to naming this bit since if we are 
used to calling a bit, reset bit, which I thought it should at least do 
some reset either to state machine or to register value. But obvious it 
doesn't. Moreover, Assert/Dis-assert seems like disable/enable from my 
point. Anyway, ROCKCHIP_MMC_INIT_STATE_RESET is okay for me, but I think 
I should add some comments for these code.

>
> or so
>
>>
>>   #define PSECS_PER_SEC 1000000000000LL
>>
>> @@ -119,6 +122,21 @@ static const struct clk_ops rockchip_mmc_clk_ops = {
>>   	.set_phase	= rockchip_mmc_set_phase,
>>   };
>>
>> +static void rockchip_clk_mmc_disable_init(struct rockchip_mmc_clock
>
> I guess similar to the thoughts above, simply name this
> 	rockchip_clk_mmc_reset()
>
> or alternatively just do the reset in rockchip_clk_register_mmc directly:
>
> if (mmc_clock->shift == ROCKCHIP_MMC_INIT_STATE_SHIFT))
> 	writel(HIWORD_UPDATE(ROCKCHIP_MMC_INIT_STATE_DISABLE,
> 				     ROCKCHIP_MMC_INIT_STATE_MASK,
> 			     mmc_clock->shift),
> 	       mmc_clock->reg);
>
> as the pr_debug does not really serve a purpose.
>

Okay, rockchip_clk_mmc_reset is coming in v2 :)

>
> Heiko
>
>> *mmc_clock) +{
>> +	if (mmc_clock->shift != ROCKCHIP_MMC_INIT_STATE_SHIFT)
>> +		return;
>> +
>> +	writel(HIWORD_UPDATE(ROCKCHIP_MMC_INIT_STATE_DISABLE,
>> +			     ROCKCHIP_MMC_INIT_STATE_MASK,
>> +			     mmc_clock->shift),
>> +	       mmc_clock->reg);
>> +
>> +	pr_debug("%s: clear mmc init state to %d", __func__,
>> +		 (readl(mmc_clock->reg) >> (mmc_clock->shift)) &
>> +		 ROCKCHIP_MMC_INIT_STATE_MASK);
>> +}
>> +
>>   struct clk *rockchip_clk_register_mmc(const char *name,
>>   				const char *const *parent_names, u8 num_parents,
>>   				void __iomem *reg, int shift)
>> @@ -139,6 +157,8 @@ struct clk *rockchip_clk_register_mmc(const char *name,
>>   	mmc_clock->reg = reg;
>>   	mmc_clock->shift = shift;
>>
>> +	rockchip_clk_mmc_disable_init(mmc_clock);
>> +
>>   	if (name)
>>   		init.name = name;
>
>
>
>


-- 
Best Regards
Shawn Lin
