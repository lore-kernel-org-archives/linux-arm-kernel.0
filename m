From: jassisinghbrar@gmail.com (Jassi Brar)
Date: Wed, 16 Dec 2015 09:41:23 +0530
Subject: [PATCH] clocksource: arm_global_timer: Allow DT to specify
 already reset timer counter
In-Reply-To: <5670559A.4050404@linaro.org>
References: <1448429044-10395-1-git-send-email-jaswinder.singh@linaro.org>
 <5670559A.4050404@linaro.org>
Message-ID: <CABb+yY0_JvVV_HG_iU8KJjmwu-nq_Cu5hJ6HBoKZCrZAdJ=rLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 11:32 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On 11/25/2015 06:24 AM, Jassi Brar wrote:
>>
>> The GT counter is common to every core in a cluster. There is a usecase
>> when Linux is spawned by a 'master' firmware/OS running on some core of
>> the same cluster and the GT is used by the both.
>>   Linux, upon boot, resetting the GT counter is obviously fatal to the
>> other OS. So provide a way for DT to tell Linux if it's running in that
>> 'slave' mode and must not reset the counter.
>>
>> Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
>
>
> Hmm, I doubt that is a hardware description.
>
Its a regular 2core-1cluster platform. The master RTOS on cpu0
maintains the lifecycle of Linux on cpu1.

'No_Counter_Reset' is not a h/w thing, I agree, but I don't know how
to better convey that platform specific constraint.

>> diff --git a/drivers/clocksource/arm_global_timer.c
>> b/drivers/clocksource/arm_global_timer.c
>> index a2cb6fa..952bab6 100644
>> --- a/drivers/clocksource/arm_global_timer.c
>> +++ b/drivers/clocksource/arm_global_timer.c
>> @@ -51,6 +51,7 @@ static void __iomem *gt_base;
>>   static unsigned long gt_clk_rate;
>>   static int gt_ppi;
>>   static struct clock_event_device __percpu *gt_evt;
>> +static bool gt_reset_counter;
>
>
> Defining a global static boolean just for a check in the init function is
> ... pointless. Adding a parameter to clocksource_init would make more sense.
>
Yes, indeed.

Thanks.
