From: rickard.andersson@stericsson.com (Rickard Andersson)
Date: Thu, 9 Feb 2012 13:19:00 +0100
Subject: [PATCH][V2] ux500 : decouple/recouple gic from the PRCMU
In-Reply-To: <4F33AD37.4060604@linaro.org>
References: <1328782040-7786-1-git-send-email-daniel.lezcano@linaro.org>
 <4F33A555.9040504@stericsson.com> <4F33AD37.4060604@linaro.org>
Message-ID: <4F33B9B4.2090503@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/2012 12:25 PM, Daniel Lezcano wrote:
> On 02/09/2012 11:52 AM, Rickard Andersson wrote:
>> Hi Daniel!
>>
>> Please see my embedded comments.
>>
>> Also should we not keep the functions in pm.c file? I think Linus W
>> advised us not to move stuff around at this stage.
> The pm.c file does not exists for mach-ux500. May be I misunderstood
> Linus but I thought he was saying to that we should "not move stuff
> around" by letting this code in the db8500-prcmu.c file for the moment
> and let Mattias do its cleanups.
On our internal tree we have mach-ux500/pm/pm.c and this file contains 
the decouple-gic functions as well as other power management related 
help functions. By moving the code to drivers/mfd/db8500-prcmu.c I think 
we are moving code around. Especially since it not clear how 
db8500-prcmu.c will be handled in the future, db8500-prcmu.c should most 
likely be split into several parts where one part only handles the 
communication with the PRCMU firmware.
>> BR
>> Rickard
>>> This patch allows to decouple and recouple the gic from the PRCMU.
>>> This is needed to put the A9 core in retention mode with the cpuidle
>>> driver.
>>>
>>> Signed-off-by: Daniel Lezcano<daniel.lezcano@linaro.org>
>>> ---
>>> drivers/mfd/db8500-prcmu.c | 29 +++++++++++++++++++++++++++++
>>> include/linux/mfd/db8500-prcmu.h | 2 ++
>>> include/linux/mfd/dbx500-prcmu.h | 16 ++++++++++++++++
>>> 3 files changed, 47 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
>>> index af8e0ef..70f39a1 100644
>>> --- a/drivers/mfd/db8500-prcmu.c
>>> +++ b/drivers/mfd/db8500-prcmu.c
>>> @@ -787,6 +787,35 @@ int db8500_prcmu_set_power_state(u8 state, bool
>>> keep_ulp_clk, bool keep_ap_pll)
>>> return 0;
>>> }
>>>
>>> +#define PRCMU_A9_MASK_REQ 0x00000328
>>> +#define PRCMU_A9_MASK_REQ_MASK 0x00000001
>>> +#define PRCMU_GIC_DELAY 1
>>> +
>>> +/* This function decouple the gic from the prcmu */
>>> +void db8500_prcmu_gic_decouple(void)
>>> +{
>>> + u32 val = readl(_PRCMU_BASE + PRCMU_A9_MASK_REQ);
>>> +
>>> + /* Set bit 0 register value to 1 */
>>> + writel((val&  ~PRCMU_A9_MASK_REQ_MASK) | PRCMU_A9_MASK_REQ_MASK,
>>> + _PRCMU_BASE + PRCMU_A9_MASK_REQ);
>> No need to AND with ~PRCMU_A9_MASK_REQ_MASK. This is enough:
>>
>> writel((val | PRCMU_A9_MASK_REQ_MASK,
>> _PRCMU_BASE + PRCMU_A9_MASK_REQ);
> Yep, right.
>
>
> [ cut ]
>
>>> +static inline void prcmu_gic_disable(void)
>>> +{
>>> + if (machine_is_u5500())
>>> + return;
>>> + else
>>> + return db8500_prcmu_gic_disable();
>>> +}
>> We have change name of this function in the .c file
>>> +
>>> +static inline void prcmu_gic_enable(void)
>>> +{
>>> + if (machine_is_u5500())
>>> + return;
>>> + else
>>> + return db8500_prcmu_gic_enable();
>>> +}
>> We have change name of this function in the .c file
> Do you want that in db8500-prcmu.c and declare the function in
> db8500-prcmu.h or dbx500-prcmu.h ?
>
>
