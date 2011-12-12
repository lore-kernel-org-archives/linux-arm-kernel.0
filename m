From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2011 15:08:26 -0800
Subject: [PATCH 1/2] ARM: OMAP: dmtimer: fix sleeping function called
 from invalid context
In-Reply-To: <CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
References: <1322194370-8073-1-git-send-email-omar.ramirez@ti.com>
 <1322194370-8073-2-git-send-email-omar.ramirez@ti.com>
 <20111209213447.GB31337@atomide.com>
 <CAB-zwWjHPzTT5QYZt9DvDcM9ny5VML3mDw3-rQRuBr-fcxYMvQ@mail.gmail.com>
Message-ID: <20111212230825.GJ32251@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ramirez Luna, Omar <omar.ramirez@ti.com> [111209 13:38]:
> On Fri, Dec 9, 2011 at 3:34 PM, Tony Lindgren <tony@atomide.com> wrote:
> >> + ? ? ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> ...
> >> ?EXPORT_SYMBOL_GPL(omap_dm_timer_request);
> >
> > This does not seem right.. It seems that you're hardcoding the source
> > clock to 32 KiHz clock while other sources are available too?
> 
> Agree, but... (below)
> 
> >> + ? ? ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> ...
> > And here too?
> 
> Agree but that is the default behavior set by dm timer framework:
> 
> @@ -134,22 +134,13 @@ static void omap_dm_timer_reset(struct
> omap_dm_timer *timer)
>  int omap_dm_timer_prepare(struct omap_dm_timer *timer)
>  {
> ...
> -       ret = omap_dm_timer_set_source(timer, OMAP_TIMER_SRC_32_KHZ);
> ...
> 
> All clocks requested are set to 32 KHz first, even with the current
> approach, there exists another API to set a new source.
> 
> To be honest I don't know why the clocks are set to 32 KHz first,
> maybe the default call path for users should be:

You need a functional clock for the timer registers to work
I believe.

> omap_dm_timer_request

Yes this would make sense. The omap_timer_list should be protected
by a mutex. There should not be a need for spinlock there as
omap_dm_timer_request should be only called during init. If that's
not the case, the the driver using it is broken.

> omap_dm_timer_set_source (new explicit call)
> omap_dm_timer_start

Once the timer has been requested, there should not be a need
for locking as there should be only one timer user using the
timer specific registers.
 
> And remove setting the source to 32 KHz by default in omap_dm_timer_request.

That you may need to be able to do anything with the timer :)

Regards,

Tony
