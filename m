From: d-gerlach@ti.com (Dave Gerlach)
Date: Fri, 23 Aug 2013 09:56:15 -0500
Subject: [PATCHv3 8/9] ARM: OMAP2+: AM33XX: Basic suspend resume support
In-Reply-To: <alpine.DEB.2.02.1308202244350.6426@utopia.booyaka.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
 <1375811376-49985-9-git-send-email-d-gerlach@ti.com>
 <CA+Bv8XbK+=pvG+bbvfCtS2Rtg-YoAhuUbWjSro9m4xWjw=Cr8A@mail.gmail.com>
 <52038E88.2050604@ti.com> <5203B336.90102@ti.com> <5203C211.7040207@ti.com>
 <87iozfga1t.fsf@kernel.org>
 <alpine.DEB.2.02.1308202244350.6426@utopia.booyaka.com>
Message-ID: <5217780F.30004@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/20/2013 05:48 PM, Paul Walmsley wrote:
>
> Hi folks,
>
> catching up on this thread.
>
> On 08/06/2013 12:49 PM, Dave Gerlach wrote:
>
>> +
>> +static int am33xx_pm_suspend(void)
>> +{
>> +     int i, j, ret = 0;
>> +
>> +     int status = 0;
>> +     struct platform_device *pdev;
>> +     struct omap_device *od;
>> +
>> +     /*
>> +      * By default the following IPs do not have MSTANDBY asserted
>> +      * which is necessary for PER domain transition. If the drivers
>> +      * are not compiled into the kernel HWMOD code will not change the
>> +      * state of the IPs if the IP was not never enabled. To ensure
>> +      * that there no issues with or without the drivers being compiled
>> +      * in the kernel, we forcefully put these IPs to idle.
>> +      */
>> +     for (i = 0; i < ARRAY_SIZE(am33xx_mod); i++) {
>> +             pdev = to_platform_device(am33xx_mod[i].dev);
>> +             od = to_omap_device(pdev);
>> +             if (od->_driver_status != BUS_NOTIFY_BOUND_DRIVER) {
>> +                     omap_device_enable_hwmods(od);
>> +                     omap_device_idle_hwmods(od);
>> +             }
>> +     }
>
> Does this have to be done for every suspend entry, or can it just be done
> once during kernel initialization?
>
> If the latter, shouldn't this be done by hwmod during the initial reset
> and idle of all of these devices, based on a flag?  For example, we had
> this flag for OMAP3630:
>
>   * HWMOD_FORCE_MSTANDBY: Always keep MIDLEMODE bits cleared so that device
>   *     is kept in force-standby mode. Failing to do so causes PM problems
>   *     with musb on OMAP3630 at least. Note that musb has a dedicated
> register
>   *     to control MSTANDBY signal when MIDLEMODE is set to force-standby.
>

Hi,
Unfortunately this does have to be done at some point after every 
suspend/resume cycle because while the IPs are idled during initial 
reset, after a suspend cycle the context loss when no driver is bound 
causes MSTANDBY to be unasserted again which as mentioned breaks the PER 
power domain transition during the next suspend attempt.

The current plan for this is somewhat similar to what you mentioned, all 
of the troublesome modules will be flagged in hwmod and when the hwmods 
are loaded they are tracked if no driver gets bound and then idled post 
resume by a pm_notifier.

Regards,
Dave

>
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
