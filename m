From: linux@roeck-us.net (Guenter Roeck)
Date: Thu, 09 Oct 2014 06:24:13 -0700
Subject: [PATCH 03/44] hibernate: Call have_kernel_poweroff instead of
 checking pm_power_off
In-Reply-To: <20141009103254.GB6787@amd>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
 <1412659726-29957-4-git-send-email-linux@roeck-us.net>
 <20141009103254.GB6787@amd>
Message-ID: <54368C7D.5040402@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/2014 03:32 AM, Pavel Machek wrote:
> On Mon 2014-10-06 22:28:05, Guenter Roeck wrote:
>> Poweroff handlers may now be installed with register_poweroff_handler.
>> Use the new API function have_kernel_poweroff to determine if a poweroff
>> handler has been installed.
>>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Len Brown <len.brown@intel.com>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   kernel/power/hibernate.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index a9dfa79..20353c5 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -602,7 +602,7 @@ static void power_down(void)
>>   	case HIBERNATION_PLATFORM:
>>   		hibernation_platform_enter();
>>   	case HIBERNATION_SHUTDOWN:
>> -		if (pm_power_off)
>> +		if (have_kernel_poweroff())
>>   			kernel_power_off();
>>   		break;
>
> poweroff -> power_off.
>
As mentioned in my other reply, that was on purpose to distinguish
existing functions from poweroff handler functions.

> But if you are playing with this, anyway... does it make sense to
> introduce kernel_power_off() that just works, no need to check
> have_..?
> 									Pavel

I am trying not to change existing behavior.

kernel_power_off is an existing function which does some cleanup
before calling machine_power_off which in turn calls do_kernel_poweroff
(or currently pm_power_off and may do some other machine specific stuff.

Sure, poweroff handling could be unified further. We could decide to
enter an endless loop if machine_power_off() returns, or we could decide
to dump a warning or panic in this case. But that is all separate from
the issue I am trying to solve here, which is to provide a capability to
register more than one poweroff handler. It would also not be that simple,
since some architectures call machine_power_off() directly from various
places.

Guenter
