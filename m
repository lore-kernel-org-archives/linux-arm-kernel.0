From: vaibhav.bedia@ti.com (Bedia, Vaibhav)
Date: Fri, 1 Feb 2013 09:31:04 +0000
Subject: [PATCH 1/5] ARM: OMAP2+: Display correct system timer name
In-Reply-To: <510B8297.8070305@ti.com>
References: <1359565471-30721-1-git-send-email-jon-hunter@ti.com>
 <1359565471-30721-2-git-send-email-jon-hunter@ti.com>
 <B5906170F1614E41A8A28DE3B8D121433ED07255@DBDE01.ent.ti.com>
 <510B8297.8070305@ti.com>
Message-ID: <B5906170F1614E41A8A28DE3B8D121433ED073A5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 01, 2013 at 14:23:43, Hunter, Jon wrote:
[...]
> >>  
> >> +/* Timer name needs to be big enough to store a string of "timerXX" */
> >> +static char timer_name[10];
> >> +
> > 
> > Why not move this inside omap_dm_timer_init_one()?
> 
> In the non-DT case, the name member of the clocksource/event struct will
> point to this array and so it needs to reside in memory permanently and
> not just temporary. Once we migrate completely to DT then we will be
> able to remove this completely. See following snippet ...
> 
> -		sprintf(name, "timer%d", gptimer_id);
> -		oh_name = name;
> +		sprintf(timer_name, "timer%d", gptimer_id);
> +		*name = timer_name;

Ok. But in case of non-DT boot if someone selects gptimers for both clkevt and
clksrc, both the name members will end up pointing to the same memory location.
To be specific, in the current code the clkevt timer name will point to the clksrc
name. This won't be noticeable during boot since the clkevt name gets printed
before it is over-written.

Regards,
Vaibhav
