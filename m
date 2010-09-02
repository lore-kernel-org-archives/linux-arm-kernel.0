From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 17:07:08 +0100
Subject: [PATCH 3/3] mach-ux500: Added nomadik mtu timer suspend/resume
	hooks.
In-Reply-To: <1283412633-9883-3-git-send-email-jonas.aberg@stericsson.com>
References: <1283412633-9883-1-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-2-git-send-email-jonas.aberg@stericsson.com>
	<1283412633-9883-3-git-send-email-jonas.aberg@stericsson.com>
Message-ID: <20100902160708.GS26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 09:30:33AM +0200, Jonas Aaberg wrote:
>  struct sys_timer ux500_timer = {
> -	.init	= ux500_timer_init,
> +	.init	 = ux500_timer_init,
> +#ifdef CONFIG_PM
> +	.suspend = nmdk_timer_suspend,
> +	.resume  = nmdk_timer_resume,
> +#endif

It would be better to use the callbacks from the clocksource/clockevent
code so that if your timers aren't being used, they can be shutdown for
power saving.

In any case, with clockevents support enabled, these suspend/resume
callbacks will not be called.
