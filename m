From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 20 Aug 2013 22:48:27 +0000 (UTC)
Subject: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume
 support
In-Reply-To: <87iozfga1t.fsf@kernel.org>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
 <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
 <52038E88.2050604@ti.com> <5203B336.90102@ti.com> <5203C211.7040207@ti.com>
 <87iozfga1t.fsf@kernel.org>
Message-ID: <alpine.DEB.2.02.1308202244350.6426@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi folks,

catching up on this thread.

On 08/06/2013 12:49 PM, Dave Gerlach wrote:

> +
> +static int am33xx_pm_suspend(void)
> +{
> +     int i, j, ret = 0;
> +
> +     int status = 0;
> +     struct platform_device *pdev;
> +     struct omap_device *od;
> +
> +     /*
> +      * By default the following IPs do not have MSTANDBY asserted
> +      * which is necessary for PER domain transition. If the drivers
> +      * are not compiled into the kernel HWMOD code will not change the
> +      * state of the IPs if the IP was not never enabled. To ensure
> +      * that there no issues with or without the drivers being compiled
> +      * in the kernel, we forcefully put these IPs to idle.
> +      */
> +     for (i = 0; i < ARRAY_SIZE(am33xx_mod); i++) {
> +             pdev = to_platform_device(am33xx_mod[i].dev);
> +             od = to_omap_device(pdev);
> +             if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
> +                     omap_device_enable_hwmods(od);
> +                     omap_device_idle_hwmods(od);
> +             }
> +     }

Does this have to be done for every suspend entry, or can it just be done 
once during kernel initialization?

If the latter, shouldn't this be done by hwmod during the initial reset 
and idle of all of these devices, based on a flag?  For example, we had 
this flag for OMAP3630:

 * HWMOD_FORCE_MSTANDBY: Always keep MIDLEMODE bits cleared so that device
 *     is kept in force-standby mode. Failing to do so causes PM problems
 *     with musb on OMAP3630 at least. Note that musb has a dedicated 
register
 *     to control MSTANDBY signal when MIDLEMODE is set to force-standby.


- Paul
