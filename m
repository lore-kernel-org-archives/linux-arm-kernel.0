From: grygorii.strashko@linaro.org (Grygorii.Strashko@linaro.org)
Date: Fri, 24 Apr 2015 13:52:15 +0300
Subject: [PATCH] mmc: core: add missing pm event in mmc_pm_notify to fix
 hib restore
In-Reply-To: <CAPDyKFqA5Wvod_0J-52FJ9Vktt1kdq7H7c9UcX-daJ0hazWU+Q@mail.gmail.com>
References: <1429785823-16939-1-git-send-email-grygorii.strashko@linaro.org>
 <CAPDyKFqA5Wvod_0J-52FJ9Vktt1kdq7H7c9UcX-daJ0hazWU+Q@mail.gmail.com>
Message-ID: <553A205F.6020608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2015 04:19 PM, Ulf Hansson wrote:
> On 23 April 2015 at 12:43,  <grygorii.strashko@linaro.org> wrote:
>> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>>
>> The PM_RESTORE_PREPARE is not handled now in mmc_pm_notify(),
>> as result mmc_rescan() could be scheduled and executed at
>> late hibernation restore stages when MMC device is suspended
>> already - which, in turn, will lead to system crash on TI dra7-evm board:
>>
>> WARNING: CPU: 0 PID: 3188 at drivers/bus/omap_l3_noc.c:148 l3_interrupt_handler+0x258/0x374()
>> 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER1_P3 (Idle): Data Access in User mode during Functional access
>>
>> Hence, add missed PM_RESTORE_PREPARE PM event in mmc_pm_notify().
>>
>> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>
> 
> Huh, that was an old bug you found. :-)

oh yes. it's happened thanks to HW issue on my board which
generates a flood of SDCD IRQs :)

It's the worst case ever to track wrong/missed PM notifiers (

> 
> I have applied it for fixes and added the below fixes tag.
> 
> Fixes: 4c2ef25fe0b8 (mmc: fix all hangs related to mmc/sd card
> insert/removal during suspend/resume)

Thanks. 

-- 
regards,
-grygorii
