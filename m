From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 09:41:09 -0700
Subject: [PATCH 07/10] omap2+: Reserve clocksource and timesource and
	initialize dmtimer later
In-Reply-To: <20110627074856.GD23145@atomide.com> (Tony Lindgren's message of
	"Mon, 27 Jun 2011 00:48:57 -0700")
References: <20110620091754.357.56441.stgit@kaulin>
	<20110620092343.357.60445.stgit@kaulin> <87wrgca3dr.fsf@ti.com>
	<20110627074856.GD23145@atomide.com>
Message-ID: <8762nrdy6y.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110623 09:56]:
>> Tony Lindgren <tony@atomide.com> writes:
>> 
>> > There's no need to initialize the dmtimer framework early.
>> 
>> Actually, there is, because it's being used from the early code.
>> 
>> The sys_timer.init functions are called before arch_initcalls, so before
>> omap_dm_timer_init() is called, you have:
>> 
>> omap3_timer_init()
>>     omap2_gp_clockevent_init()
>>         omap_dm_timer_init_one()
>>            omap_dm_timer_request_specific()
>>                
>> 
>> Among other things, the spinlock is taken before it has been initialized
>> in omap_dm_timer_init() (that's how I noticed this problem), but the
>> rest of the init of course hasn't been done either.
>> 
>> Basically, the problem is that this "early init" code is not only using
>> the new macros, but it's also using functions from the "real" driver,
>> which is not yet initialized.
>
> Sounds like you did not apply the previous patch to remove the PM hack?
>
> There's no need to call to omap_dm_timer_request_specific here unless
> you added back the PM hack.

Right, I added it back not noticing that it also removed the
_request_specific call.

Thanks for the clarification,

Kevin
