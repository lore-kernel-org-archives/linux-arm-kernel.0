From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Dec 2011 21:34:45 +0000
Subject: buggy usage of pm_idle by omap1 code
In-Reply-To: <20111219173518.GH6464@atomide.com>
References: <alpine.LFD.2.02.1112162208390.2907@xanadu.home>
 <20111219173518.GH6464@atomide.com>
Message-ID: <20111219213445.GL14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 09:35:19AM -0800, Tony Lindgren wrote:
> Good catch. Here's a patch to deal with that issue, want to take this
> into your idle series? I'll try out your idle series today at some
> point.

Two points:

1. It's good practice to call cpu_idle_wait() after modifying pm_idle,
even on UP - it allows static checking of this.

> From: Tony Lindgren <tony@atomide.com>
> Date: Mon, 19 Dec 2011 09:11:11 -0800
> Subject: [PATCH] ARM: OMAP1: Fix pm_idle during suspend
> 
> Commit 9ccdac3662dbf3c75e8f8851a214bdf7d365a4bd ([ARM] idle:
> clean up pm_idle calling, obey hlt_counter) removed a check
> for NULL pm_idle.
> 
> On omap1 the system hits an equivalent of suspend during idle.
> If we are suspending, we need to make sure so we don't call
> omap1_pm_idle during the suspend process.
> 
> Fix this by setting the pm_idle function to a an empty
> function while suspending.

2. what's wrong with calling disable_hlt() to prevent the pm_idle function
being called?  Why solve it this complicated way of changing the pm_idle
pointer when there's some infrastructure which can fix it for you already?

> 
> Reported-by: Nicolas Pitre <nico@fluxnic.net>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/mach-omap1/pm.c b/arch/arm/mach-omap1/pm.c
> index 89ea20c..b551a62 100644
> --- a/arch/arm/mach-omap1/pm.c
> +++ b/arch/arm/mach-omap1/pm.c
> @@ -584,6 +584,9 @@ static void omap_pm_init_proc(void)
>  #endif /* DEBUG && CONFIG_PROC_FS */
>  
>  static void (*saved_idle)(void) = NULL;
> +static void omap1_dummy_idle(void)
> +{
> +}
>  
>  /*
>   *	omap_pm_prepare - Do preliminary suspend work.
> @@ -593,7 +596,7 @@ static int omap_pm_prepare(void)
>  {
>  	/* We cannot sleep in idle until we have resumed */
>  	saved_idle = pm_idle;
> -	pm_idle = NULL;
> +	pm_idle = omap1_dummy_idle;
>  
>  	return 0;
>  }
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
