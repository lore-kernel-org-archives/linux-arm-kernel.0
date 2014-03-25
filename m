From: holler@ahsoftware.de (Alexander Holler)
Date: Tue, 25 Mar 2014 19:38:59 +0100
Subject: [PATCH v7 2/2] ARM hibernation / suspend-to-disk
In-Reply-To: <CADHgK6vkwjXyJxRcOXjJpJJaR0-YR869NpPZ+CBBS8kEdE0qCQ@mail.gmail.com>
References: <1394016605-24120-1-git-send-email-sebastian.capella@linaro.org>	<1394016605-24120-3-git-send-email-sebastian.capella@linaro.org>	<20140316070917.GA3094@arch.cereza>	<CADHgK6s58EJyJxB-47K8w26H8ZCBFQ2zu7PGAQU9O+2g7=fPwA@mail.gmail.com>	<20140317204410.GA1118@arch.cereza>	<CADHgK6tHngKVZS=jo=VYt3Nt3dhiEmiWr28iDy7q_uR9goBj=Q@mail.gmail.com>	<20140319154434.GA3488@arch.cereza>	<CADHgK6vLB3h0zrdpve=ZyjNu2pe1VYsGxrYgv=2C-JV37vE9tQ@mail.gmail.com>
 <CADHgK6vkwjXyJxRcOXjJpJJaR0-YR869NpPZ+CBBS8kEdE0qCQ@mail.gmail.com>
Message-ID: <5331CD43.1010601@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.03.2014 22:06, schrieb Sebastian Capella:
> On 19 March 2014 13:47, Sebastian Capella <sebastian.capella@linaro.org> wrote:
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index a5f702a..d96b910 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -594,7 +594,8 @@ static void power_down(void)
>>          case HIBERNATION_PLATFORM:
>>                  hibernation_platform_enter();
>>          case HIBERNATION_SHUTDOWN:
>> -               kernel_power_off();
>> +               if (pm_power_off)
>> +                       kernel_power_off();
>>                  break;
>>   #ifdef CONFIG_SUSPEND
>>          case HIBERNATION_SUSPEND:
>>
>>
>> This follows the behavior in the reboot syscall which does it this way
>> also.  I'm testing this now, and it seems work fine.  If this looks
>> good, I can add it as an additional patch.
>
> BTW, one thing I would point out is that kernel_power_off and
> kernel_halt call the same notifier but with different parameters
> (SYS_POWER_OFF and SYS_HALT).
>
> If pm_power_down is null, I dont see why we'd want to notify
> SYS_POWER_OFF before SYS_HALT.  With the previous change I'm assuming
> there's no benefit, so please chime in if you know a reason.

Both states, power off and sys halt, do sound pretty final and I would 
assume something is broken, if power off is called before sys halt or 
vice versa. At least I would never expect that the 
reboot/poweroff/syshalt notifier may be called twice (and thats why the 
heartbeat-trigger may crash).

But just in case, changing that behaviour in ledtrig-heartbeat.c would 
be pretty easy, just remove the heartbeat_reboot_notifier (which plays 
nice and deregisters the trigger on reboot) and use the panic_notifier 
(which doesn't unregister the trigger but just turns off the led) for 
reboot too. Another solution would be to unregister the reboot_notifier 
in the reboot_nofifier itself. I've just seen one watchdog driver 
(drivers/rtc/rtc-m41t80.c) which does that. But I still think such 
shouldn't be necessary (and I haven't had a look at other 
reboot_notifier users).


Regards,

Alexander Holler
