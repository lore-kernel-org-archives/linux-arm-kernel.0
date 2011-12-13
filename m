From: omar.ramirez@ti.com (Ramirez Luna, Omar)
Date: Mon, 12 Dec 2011 19:49:05 -0600
Subject: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called from
 invalid context
In-Reply-To: <20111212230825.GJ32251@atomide.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
 <1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
 <20111209213447.GB31337@atomide.com>
 <CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
 <20111212230825.GJ32251@atomide.com>
Message-ID: <CAB-zwWg76+Si9BXsXQt6-ZL=VL7qJ5YPN5FSC-07y8J8GFX0ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 5:08 PM, Tony Lindgren <tony@atomide.com> wrote:
...
>> @@ -134,22 +134,13 @@ static void omap_dm_timer_reset(struct
>> omap_dm_timer *timer)
>> ?int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>> ?{
>> ...
>> - ? ? ? ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
>> ...
>>
>> All clocks requested are set to 32 KHz first, even with the current
>> approach, there exists another API to set a new source.
>>
>> To be honest I don't know why the clocks are set to 32 KHz first,
>> maybe the default call path for users should be:
>
> You need a functional clock for the timer registers to work
> I believe.

Sounds logic :)

>> omap_dm_timer_request
>
> Yes this would make sense. The omap_timer_list should be protected
> by a mutex. There should not be a need for spinlock there as
> omap_dm_timer_request should be only called during init. If that's
> not the case, the the driver using it is broken.

Ok, I made this patch thinking that 'request' could be called from any
context, but if that is not the case mutex should be fine.

>> omap_dm_timer_set_source (new explicit call)
>> omap_dm_timer_start
>
> Once the timer has been requested, there should not be a need
> for locking as there should be only one timer user using the
> timer specific registers.
>
>> And remove setting the source to 32 KHz by default in omap_dm_timer_request.
>
> That you may need to be able to do anything with the timer :)

Well the intention was for the user to call it explicitly so it didn't
look as a hard coded setting, but I can keep it.

IIUC, mutex should be held instead of spin lock, I can do the change
instead of this patch and see how it goes.

Thanks,

Omar
