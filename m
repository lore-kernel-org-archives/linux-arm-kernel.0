From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 20 Jan 2015 12:13:08 +0100 (CET)
Subject: [PATCH v2 2/2] clocksource: don't suspend/resume when unused
In-Reply-To: <1421427439-11699-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421427439-11699-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1421427439-11699-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <alpine.DEB.2.11.1501201153140.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 16 Jan 2015, Alexandre Belloni wrote:

> There is no point in calling suspend/resume for unused
> clocksources.

That's true, but ....
 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  kernel/time/clocksource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
> index 03cfc5a08e3b..da65b3b73a86 100644
> --- a/kernel/time/clocksource.c
> +++ b/kernel/time/clocksource.c
> @@ -493,7 +493,7 @@ void clocksource_suspend(void)
>  	struct clocksource *cs;
>  
>  	list_for_each_entry_reverse(cs, &clocksource_list, list)
> -		if (cs->suspend)
> +		if (cs->suspend && (cs->flags & CLOCK_SOURCE_USED))
>  			cs->suspend(cs);
>  }
>  
> @@ -505,7 +505,7 @@ void clocksource_resume(void)
>  	struct clocksource *cs;
>  
>  	list_for_each_entry(cs, &clocksource_list, list)
> -		if (cs->resume)
> +		if (cs->resume && (cs->flags & CLOCK_SOURCE_USED))
>  			cs->resume(cs);

I had a deeper look at the clocksources which have a resume
callback. We have implementations, which rely on the resume callback
being called unconditionally. e.g.: arch/x86/kernel/hpet.c. And there
are a few others which have extra PM code in the suspend/resume path
independent of the fact whether the clocksource is enabled or not.

So we really need to make this opt-in with a per clocksource flag.

Thanks,

	tglx
