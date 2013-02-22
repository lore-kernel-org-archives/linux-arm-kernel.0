From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 22 Feb 2013 16:32:48 +0530
Subject: too many timer retries happen when do local timer swtich with
 broadcast timer
In-Reply-To: <20130222103149.GC12140@e102568-lin.cambridge.arm.com>
References: <CAB4PhKevqf0e4nzYraE9ZTAFbPCFfNpguAnPoVpJh-FFe2TAZA@mail.gmail.com>
 <alpine.LFD.2.02.1302201400400.22263@ionos>
 <CAB4PhKfxPcyQfpM2Ra1OxsyYhS5fnkjtPy=uYgxFHim1rOdoug@mail.gmail.com>
 <alpine.LFD.2.02.1302211015270.22263@ionos>
 <CAB4PhKf+Z-TK4KGDZm1kYOWibg=e2Ehnhjxt_oTbFq9eqouAjA@mail.gmail.com>
 <alpine.LFD.2.02.1302211436300.22263@ionos> <51263975.20906@ti.com>
 <alpine.LFD.2.02.1302212214020.22263@ionos> <5127436E.4040100@ti.com>
 <alpine.LFD.2.02.1302221122290.22263@ionos>
 <20130222103149.GC12140@e102568-lin.cambridge.arm.com>
Message-ID: <51275058.7010809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 February 2013 04:01 PM, Lorenzo Pieralisi wrote:
> On Fri, Feb 22, 2013 at 10:24:00AM +0000, Thomas Gleixner wrote:
>> On Fri, 22 Feb 2013, Santosh Shilimkar wrote:
>>> BTW, Lorenzo off-list mentioned to me about warning in boot-up
>>> which I missed while testing your patch. It will take bit more
>>> time for me to look into it and hence thought of reporting it.
>>>
>>> [    2.186126] ------------[ cut here ]------------
>>> [    2.190979] WARNING: at kernel/time/tick-broadcast.c:501
>>> tick_broadcast_oneshot_control+0x1c0/0x21c()
>>
>> Which one is that? tick_broadcast_pending or tick_force_broadcast_mask ?
>
> It is the tick_force_broadcast_mask and I think that's because on all
> systems we are testing, the broadcast timer IRQ is a thundering herd,
> all CPUs get out of idle at once and try to get out of broadcast mode
> at more or less the same time.
>
So the issue comes ups only when the idle state used where CPU wakeup
more or less at same time as Lorenzo mentioned. I have two platforms
where I could test the patch and see the issue only with one platform.

Yesterday I didn't notice the warning because it wasn't seen on that
platform :-) OMAP4 idle entry and exit in deep state is staggered
between CPUs and hence the warning isn't seen. On OMAP5 though,
there is an additional C-state where idle entry/exit for CPU
isn't staggered and I see the issue in that case.

Actually the broad-cast code doesn't expect such a behavior
from CPUs since only the broad-cast affine CPU should wake
up and rest of the CPU should be woken up by the broad-cast
IPIs.

Regards,
Santosh
