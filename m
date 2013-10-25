From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 25 Oct 2013 21:13:35 +0200
Subject: [PATCH 1/2] ARM: s3c64xx: cpuidle: convert to platform driver
In-Reply-To: <6431720.IUjkN7MGOG@thinkpad>
References: <1382685074-16502-1-git-send-email-daniel.lezcano@linaro.org>
 <6431720.IUjkN7MGOG@thinkpad>
Message-ID: <526AC2DF.2020904@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2013 12:39 PM, Tomasz Figa wrote:
> Hi Daniel,
>
> [Sending again, without HTML part. Sorry for the noise.]
>
> On Friday 25 of October 2013 09:11:13 Daniel Lezcano wrote:
>> The driver is tied with the pm low level code making difficult to split
>> the driver into a more arch independent code. The platform driver allows
>> to move the standby callback into the platform data field and use a
>> simple driver with no more dependency on the low level code.
>>
>> The standby callback has a portion of code to set the standby method and
>> the effective cpu_do_idle switching the cpu to the right mode. As this
>> code is redundant in the cpu suspend code, it has been factored out when
>> implementing the standby methdod.
>>
>> By this way, the driver is ready to be moved out to the drivers/cpuidle.
>
> The idea itself is quite good, but unfortunately I have to NAK this. Please
> see details in comments below.
>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   arch/arm/mach-s3c64xx/cpuidle.c |   38
>> ++++++++++++++++---------------------- arch/arm/mach-s3c64xx/pm.c      |
>>    33 ++++++++++++++++++++++++++------- 2 files changed, 42
>> insertions(+), 29 deletions(-)

[ ... ]

>> -
>> -	tmp = __raw_readl(S3C64XX_PWR_CFG);
>> -	tmp &= ~S3C64XX_PWRCFG_CFG_WFI_MASK;
>> -	tmp |= S3C64XX_PWRCFG_CFG_WFI_SLEEP;
>
> Finally note the S3C64XX_PWRCFG_CFG_WFI_SLEEP flag here again.

Ouch ! I missed it. Thanks for spotting the problem.

> I believe it should be visible now what's wrong with this patch. To make
> sure it is, let me explain how the system controller of S3C64xx handles WFI
> requests.
>
> When the CPU issues WFI request to the syscon, it takes an action depending
> on how it is configured. A bit field is there in one of syscon registers
> (S3C64XX_PWR_CFG) that selects what action to perform in case of WFI
> request.
>
> You can program the syscon to ignore the request, enter IDLE mode, enter
> STOP mode or enter SLEEP mode. As the names suggest, for cpuidle, it needs
> to be programmed for IDLE mode and for system-wide sleep it needs to be set
> to SLEEP mode. STOP mode is not very useful as it has mostly the same
> effect that can be achieved by performing fine-grained clock and power
> gating of peripherals manually, so it is unused by Linux.

Yes, this is what I assumed but I missed the CFG_WFI_SLEEP flag, my eyes 
read CFG_WFI_IDLE.

> Now, my take on the issue you are trying to solve would be a bit different.
> Since the S3C64xx does not have any interesting cpuidle modes, just a
> normal, clock-gated WFI mode, it does not need to have a cpuidle driver at
> all. All that is needed is simply setting up the S3C64XX_PWRCFG_CFG_WFI
> field to S3C64XX_PWRCFG_CFG_WFI_IDLE early at boot-up, then set it to
> S3C64XX_PWRCFG_CFG_WFI_SLEEP just before entering the sleep mode and
> restore it back to S3C64XX_PWRCFG_CFG_WFI_IDLE after waking up.

So you are suggesting to remove the cpuidle driver ?

Won't it be worth to add a new WFI_SLEEP state to the cpuidle driver ?

Thanks for the review.

   -- Daniel

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
