From: john.stultz@linaro.org (John Stultz)
Date: Tue, 07 May 2013 17:30:52 -0700
Subject: dw_apb_timer_of.c: remove parts that were picoxcell-specific
In-Reply-To: <20130507201126.GA8169@amd.pavel.ucw.cz>
References: <20130426121433.GA16249@amd.pavel.ucw.cz>
 <201305061545.22587.arnd@arndb.de> <20130506155304.GA6645@amd.pavel.ucw.cz>
 <201305062324.17080.arnd@arndb.de> <20130507135752.GA3500@amd.pavel.ucw.cz>
 <51892E5E.8090909@linaro.org> <20130507201126.GA8169@amd.pavel.ucw.cz>
Message-ID: <51899CBC.6020003@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2013 01:11 PM, Pavel Machek wrote:
> It seems we made a mistake when creating dw_apb_timer_of.c:
> picoxcell sched_clock had parts that were not related to
> dw_apb_timer, yet we moved them to dw_apb_timer_of, and tried to
> use them on socfpga.
>
> This results in system where user/system time is not measured
> properly, as demonstrated by
>      
>      time dd if=/dev/urandom of=/dev/zero bs=100000 count=100
>      
> So this patch switches sched_clock to hardware that exists on both
> platforms, and adds missing of_node_put() in dw_apb_timer_init().
>      
> Signed-off-by: Pavel Machek <pavel@denx.de>
> Acked-by: Jamie Iles <jamie@jamieiles.com>

Ok. I'm still not a happy about the general issue of 
sched_clock/clockevent code being in drivers/clocksources (I know, 
everyone is sick of my griping about it :), so reviewing this sucks, but 
at least this patch technically isn't making that issue worse.

Additionally, this is an *ugly* driver in my opinion. Its split between 
arch specific logic in arch/x86/kernel/apb_timer.c, 
arch/arm/mach-picoxcell/common.c, and arch/arm/mach-socfpga/socfpga.c, 
and then arch independent logic in drivers/clocksource/dw_apb_timer.c 
and drivers/clocksource/dw_apb_timer_of.c, but then it seems like much 
of drivers/clocksource/dw_apb_timer_of.c is actually ARM specific.

Are there any plans to clean this up in the future?

Also, next time please run checkpatch.pl to catch trivial issues like 
trailing whitespace. :P

But I've gone ahead and queued this for 3.11.

thanks
-john
