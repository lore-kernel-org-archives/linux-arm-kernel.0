From: jonas.aberg@stericsson.com (Jonas Aaberg)
Date: Mon, 6 Sep 2010 09:27:43 +0200
Subject: [PATCH 3/3] mach-ux500: Added nomadik mtu timer suspend/resume
	hooks.
In-Reply-To: <20100902160708.GS26319@n2100.arm.linux.org.uk>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-3-git-send-email-jonas.aberg@stericsson.com>
	<20100902160708.GS26319@n2100.arm.linux.org.uk>
Message-ID: <4C8497EF.50306@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/2010 06:07 PM, Russell King - ARM Linux wrote:
> On Thu, Sep 02, 2010 at 09:30:33AM +0200, Jonas Aaberg wrote:
>>  struct sys_timer ux500_timer = {
>> -	.init	= ux500_timer_init,
>> +	.init	 = ux500_timer_init,
>> +#ifdef CONFIG_PM
>> +	.suspend = nmdk_timer_suspend,
>> +	.resume  = nmdk_timer_resume,
>> +#endif
> 
> It would be better to use the callbacks from the clocksource/clockevent
> code so that if your timers aren't being used, they can be shutdown for
> power saving.

I agree. For clockevents, I suppose you get CLOCK_EVT_MODE_SHUTDOWN/UNUSED
when the clockevent isn't used, but for clocksource, I don't get how it is supposed
to work. When a clocksource is registered or changed, clocksource.c:clock_select() 
is called, but it does not look like the clocksources involved get informed about 
the change, if there is any change.

> 
> In any case, with clockevents support enabled, these suspend/resume
> callbacks will not be called.

Ok. Thanks for your comments!

BR,
 Jonas
