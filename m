From: tony@atomide.com (Tony Lindgren)
Date: Mon, 19 Dec 2011 15:22:51 -0800
Subject: buggy usage of pm_idle by omap1 code
In-Reply-To: <alpine.LFD.2.02.1112191758520.2907@xanadu.home>
References: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
 <20111219173518.GH6464@atomide.com>
 <20111219213445.GL14542@n2100.arm.linux.org.uk>
 <alpine.LFD.2.02.1112191758520.2907@xanadu.home>
Message-ID: <20111219232251.GV6464@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [111219 14:32]:
> On Mon, 19 Dec 2011, Russell King - ARM Linux wrote:
> 
> > On Mon, Dec 19, 2011 at 09:35:19AM -0800, Tony Lindgren wrote:
> > > Commit 9ccdac3662dbf3c75e8f8851a214bdf7d365a4bd ([ARM] idle:
> > > clean up pm_idle calling, obey hlt_counter) removed a check
> > > for NULL pm_idle.
> > > 
> > > On omap1 the system hits an equivalent of suspend during idle.
> > > If we are suspending, we need to make sure so we don't call
> > > omap1_pm_idle during the suspend process.
> > > 
> > > Fix this by setting the pm_idle function to a an empty
> > > function while suspending.
> > 
> > 2. what's wrong with calling disable_hlt() to prevent the pm_idle function
> > being called?  Why solve it this complicated way of changing the pm_idle
> > pointer when there's some infrastructure which can fix it for you already?
> 
> Absolutely.  I must have been stairing at the whole thing for too long, 
> as I obviously did exactly that already elsewhere.
> 
> So I propose this alternative:
> 
>     ARM: OMAP1: Fix pm_idle during suspend
>     
>     Commit 9ccdac3662dbf3c75e8f8851a214bdf7d365a4bd ([ARM] idle:
>     clean up pm_idle calling, obey hlt_counter) removed a check
>     for NULL pm_idle.
>     
>     Replace the NULL assignment in the OMAP1 code with disable_hlt()
>     to be in sync with the core code and provide the intended behavior.
>     
>     Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>

Yeh this is better. Looks like you beat me to it by few minutes:

Acked-by: Tony Lindgren <tony@atomide.com>
 
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 89ea20ca0c..6c6a2dc554 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -583,8 +583,6 @@ static void omap_pm_init_proc(void)
>  
>  #endif /* DEBUG && CONFIG_PROC_FS */
>  
> -static void (*saved_idle)(void) = NULL;
> -
>  /*
>   *	omap_pm_prepare - Do preliminary suspend work.
>   *
> @@ -592,8 +590,7 @@ static void (*saved_idle)(void) = NULL;
>  static int omap_pm_prepare(void)
>  {
>  	/* We cannot sleep in idle until we have resumed */
> -	saved_idle = pm_idle;
> -	pm_idle = NULL;
> +	disable_hlt();
>  
>  	return 0;
>  }
> @@ -630,7 +627,7 @@ static int omap_pm_enter(suspend_state_t state)
>  
>  static void omap_pm_finish(void)
>  {
> -	pm_idle = saved_idle;
> +	enable_hlt();
>  }
>  
>  
