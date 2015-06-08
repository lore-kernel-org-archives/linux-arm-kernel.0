From: rjui@broadcom.com (Ray Jui)
Date: Mon, 8 Jun 2015 10:10:49 -0700
Subject: [PATCH 4/6] clocksource: bcm_kona: Migrate to new 'set-state'
 interface
In-Reply-To: <5575C33A.1080102@broadcom.com>
References: <cover.1433768426.git.viresh.kumar@linaro.org>
 <37f46a2101da7435343810d9fa94cfae716c377a.1433768426.git.viresh.kumar@linaro.org>
 <5575BE20.6020102@broadcom.com> <20150608162242.GA4198@linux>
 <5575C33A.1080102@broadcom.com>
Message-ID: <5575CC99.8010600@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Forgot to ACK the patch...

On 6/8/2015 9:30 AM, Ray Jui wrote:
> This patch looks fine to me.
> 
> Thanks,
> 
> Ray
> 
> On 6/8/2015 9:22 AM, Viresh Kumar wrote:
>> On 08-06-15, 09:09, Ray Jui wrote:
>>> There's a typo here. It's "kona" not "cona"
>>
>> Crap, how does this look:
>>
>> From: Viresh Kumar <viresh.kumar@linaro.org>
>> Date: Fri, 27 Feb 2015 13:39:52 +0530
>> Subject: [PATCH] clocksource: bcm_kona: Migrate to new 'set-state' interface
>>
>> Migrate bcm_kona driver to the new 'set-state' interface provided by
>> the clockevents core, the earlier 'set-mode' interface is marked
>> obsolete now.
>>
>> This also enables us to implement callbacks for new states of clockevent
>> devices, for example: ONESHOT_STOPPED.
>>
>> Cc: Florian Fainelli <f.fainelli@gmail.com>
>> Cc: Ray Jui <rjui@broadcom.com>
>> Cc: Scott Branden <sbranden@broadcom.com>
>> Cc: bcm-kernel-feedback-list at broadcom.com
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  drivers/clocksource/bcm_kona_timer.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
>> index f1e33d08dd83..9df3f1e3fd0e 100644
>> --- a/drivers/clocksource/bcm_kona_timer.c
>> +++ b/drivers/clocksource/bcm_kona_timer.c
>> @@ -127,25 +127,25 @@ static int kona_timer_set_next_event(unsigned long clc,
>>  	return 0;
>>  }
>>  
>> -static void kona_timer_set_mode(enum clock_event_mode mode,
>> -			     struct clock_event_device *unused)
>> +static int kona_timer_shutdown(struct clock_event_device *evt)
>>  {
>> -	switch (mode) {
>> -	case CLOCK_EVT_MODE_ONESHOT:
>> -		/* by default mode is one shot don't do any thing */
>> -		break;
>> -	case CLOCK_EVT_MODE_UNUSED:
>> -	case CLOCK_EVT_MODE_SHUTDOWN:
>> -	default:
>> -		kona_timer_disable_and_clear(timers.tmr_regs);
>> -	}
>> +	kona_timer_disable_and_clear(timers.tmr_regs);
>> +	return 0;
>> +}
>> +
>> +static int kona_timer_set_oneshot(struct clock_event_device *evt)
>> +{
>> +	/* By default mode is one shot, don't do any thing */
>> +	return 0;
>>  }
>>  
>>  static struct clock_event_device kona_clockevent_timer = {
>>  	.name = "timer 1",
>>  	.features = CLOCK_EVT_FEAT_ONESHOT,
>>  	.set_next_event = kona_timer_set_next_event,
>> -	.set_mode = kona_timer_set_mode
>> +	.set_state_shutdown = kona_timer_shutdown,
>> +	.set_state_oneshot = kona_timer_set_oneshot,
>> +	.tick_resume = kona_timer_shutdown,
>>  };
>>  
>>  static void __init kona_timer_clockevents_init(void)
>>

Acked-by: Ray Jui <rjui@broadcom.com>
