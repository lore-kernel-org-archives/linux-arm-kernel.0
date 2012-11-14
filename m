From: tony@atomide.com (Tony Lindgren)
Date: Wed, 14 Nov 2012 15:36:45 -0800
Subject: OMAP baseline test results for v3.7-rc5
In-Reply-To: <87obj1f0v8.fsf@deeprootsystems.com>
References: <alpine.DEB.2.00.1211121921160.12551@utopia.booyaka.com>
 <20121112225830.GW6801@atomide.com>
 <87obj1f0v8.fsf@deeprootsystems.com>
Message-ID: <20121114233644.GD6801@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [121113 17:09]:
> Tony Lindgren <tony@atomide.com> writes:
> >
> > Here's one more booting issue I recently ran into:
> >
> >     - If DEBUG_LL and earlyprintk are enabled, and omap-serial.c
> >       is compiled as a module, the kernel boot hangs early as the
> >       clocks for serial port are cut while earlyprintk still uses
> >       the port. This might be regression from v3.6.
> >  
> 
> Can you test if the patch below[1] helps?  With that, it seems to finish
> booting for me (based solely on a ping test.)
> 
> The problem is a race between the late_initcall for omap_device (which
> idles devices that have no drivers) and the late_initcall in
> kernel/printk.c which turns off the earlyconsole.   Any printks
> that happen between this omap_device late initcall and the earlyconsole
> late initcall will crash when accessing the UART.

Yeh that fixes it for me:

Tested-by: Tony Lindgren <tony@atomide.com>
 
> Kevin
> 
> [1]
> 
> diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
> index 7a7d1f2..138114a 100644
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -1275,4 +1275,4 @@ static int __init omap_device_late_init(void)
>  	bus_for_each_dev(&platform_bus_type, NULL, NULL, omap_device_late_idle);
>  	return 0;
>  }
> -late_initcall(omap_device_late_init);
> +late_initcall_sync(omap_device_late_init);
