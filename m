From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 06 Feb 2012 15:10:28 +0100
Subject: [PATCH] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <4F2F9B2C.8030009@stericsson.com>
References: <1328270849-22324-1-git-send-email-daniel.lezcano@linaro.org>
 <4F2F9B2C.8030009@stericsson.com>
Message-ID: <4F2FDF54.8080701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2012 10:19 AM, Rickard Andersson wrote:
> Hi!
>
> Our comments:

Thanks Rickard and Jonas for your comments.

> - function names don't match commit comment disable/enable vs
> recouple/decouple. Decouple is a better name than disable, because GIC
> is not really disabled it is just disconnected.

Ok, that makes sense.

> - there is no reason to place these functions inside the db8500-prcmu.c
> file. There is so much stuff in the PRCMU register base so we can not
> have everything in one file. Why not have it as it is?

Why spread the prcmu code when it is related to the prcmu ?

Linus ? What do you think ?

> - why the gic_mask function?

Because the register has 31 bits reserved which could be used later 
without modifying this function.

> - The original code has been updated and now looks like this:

That is the same code, except the while loop where, if this code 
assumption is correct, means we will do only one iteration in the loop.


Thanks
   -- Daniel

> /* Decouple GIC from the interrupt bus */
> void ux500_pm_gic_decouple(void)
> {
> prcmu_write_masked(PRCM_A9_MASK_REQ,
> PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ,
> PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ);
>
> (void)prcmu_read(PRCM_A9_MASK_REQ);
>
> udelay(GIC_FREEZE_DELAY); /* Wait for the GIC to freeze */
> }
>
> /* Recouple GIC with the interrupt bus */
> void ux500_pm_gic_recouple(void)
> {
> prcmu_write_masked(PRCM_A9_MASK_REQ,
> PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ,
> 0);
> }
>
> BR
> Rickard Andersson& Jonas Aberg
>
>> This patch allows to decouple and recouple the gic from the PRCMU.
>> This is needed to put the A9 core in retention mode with the cpuidle
>> driver.
>>
>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>> ---
>> drivers/mfd/db8500-prcmu.c | 42 ++++++++++++++++++++++++++++++++++++++
>> include/linux/mfd/db8500-prcmu.h | 2 +
>> include/linux/mfd/dbx500-prcmu.h | 16 ++++++++++++++
>> 3 files changed, 60 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
>> index af8e0ef..c708431 100644
>> --- a/drivers/mfd/db8500-prcmu.c
>> +++ b/drivers/mfd/db8500-prcmu.c
>> @@ -528,6 +528,10 @@ static const char
>> *hwacc_ret_regulator_name[NUM_HW_ACC] = {
>>
>> #define PRCMU_PLLDSI_LOCKP_LOCKED 0x3
>>
>> +#define PRCMU_A9_MASK_REQ 0x00000328
>> +#define PRCMU_A9_MASK_REQ_MASK 0x00000001
>> +#define PRCMU_A9_MASK_ACK 0x0000032C
>> +
>> static struct {
>> u8 project_number;
>> u8 api_version;
>> @@ -787,6 +791,44 @@ int db8500_prcmu_set_power_state(u8 state, bool
>> keep_ulp_clk, bool keep_ap_pll)
>> return 0;
>> }
>>
>> +/*
>> + * prcmu_gic_mask - apply the mask to the mask request
>> + * register. This mask has the bits [1-31] reserved and
>> + * the request applies to the bit 0 of this register.
>> + */
>> +static inline void prcmu_gic_mask(u32 mask)
>> +{
>> + u32 val = readl(_PRCMU_BASE + PRCMU_A9_MASK_REQ);
>> + writel((val& ~PRCMU_A9_MASK_REQ_MASK) | mask,
>> + _PRCMU_BASE + PRCMU_A9_MASK_REQ);
>> +}
>> +
>> +/*
>> + * db8500_prcmu_gic_disable - This function decouple the gic
>> + * from the prcmu.
>> + */
>> +void db8500_prcmu_gic_disable(void)
>> +{
>> + prcmu_gic_mask(PRCMU_A9_MASK_REQ_MASK);
>> +
>> + /* Wait for gic mask register update */
>> + while (!(readl(_PRCMU_BASE + PRCMU_A9_MASK_REQ)&
>> + PRCMU_A9_MASK_REQ_MASK))
>> + cpu_relax();
>> +
>> + /* Wait a few cycles for the gic mask completion */
>> + udelay(1);
>> +}
>> +
>> +/*
>> + * db8500_prcmu_gic_enable - This function recouple the gic
>> + * with the prcmu.
>> + */
>> +void db8500_prcmu_gic_enable(void)
>> +{
>> + prcmu_gic_mask(0);
>> +}
>> +
>> /* This function should only be called while mb0_transfer.lock is
>> held. */
>> static void config_wakeups(void)
>> {
>> diff --git a/include/linux/mfd/db8500-prcmu.h
>> b/include/linux/mfd/db8500-prcmu.h
>> index 60d27f7..4a1032c 100644
>> --- a/include/linux/mfd/db8500-prcmu.h
>> +++ b/include/linux/mfd/db8500-prcmu.h
>> @@ -536,6 +536,8 @@ int prcmu_load_a9wdog(u8 id, u32 val);
>>
>> void db8500_prcmu_system_reset(u16 reset_code);
>> int db8500_prcmu_set_power_state(u8 state, bool keep_ulp_clk, bool
>> keep_ap_pll);
>> +void db8500_prcmu_gic_disable(void);
>> +void db8500_prcmu_gic_enable(void);
>> void db8500_prcmu_enable_wakeups(u32 wakeups);
>> int db8500_prcmu_set_epod(u16 epod_id, u8 epod_state);
>> int db8500_prcmu_request_clock(u8 clock, bool enable);
>> diff --git a/include/linux/mfd/dbx500-prcmu.h
>> b/include/linux/mfd/dbx500-prcmu.h
>> index bac942f..a5fee69 100644
>> --- a/include/linux/mfd/dbx500-prcmu.h
>> +++ b/include/linux/mfd/dbx500-prcmu.h
>> @@ -237,6 +237,22 @@ static inline int prcmu_set_power_state(u8 state,
>> bool keep_ulp_clk,
>> keep_ap_pll);
>> }
>>
>> +static inline void prcmu_gic_disable(void)
>> +{
>> + if (machine_is_u5500())
>> + return;
>> + else
>> + return db8500_prcmu_gic_disable();
>> +}
>> +
>> +static inline void prcmu_gic_enable(void)
>> +{
>> + if (machine_is_u5500())
>> + return;
>> + else
>> + return db8500_prcmu_gic_enable();
>> +}
>> +
>> static inline int prcmu_set_epod(u16 epod_id, u8 epod_state)
>> {
>> if (machine_is_u5500())
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
