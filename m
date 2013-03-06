From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Mar 2013 11:28:56 +0000
Subject: [PATCH] ARM: bcm281xx: Add L2 cache enable code
In-Reply-To: <5136F816.2070909@broadcom.com>
References: <1362451632-18806-1-git-send-email-csd@broadcom.com>
 <201303060631.03782.arnd@arndb.de> <5136F816.2070909@broadcom.com>
Message-ID: <201303061128.57127.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013, Christian Daudt wrote:
> On 13-03-05 10:31 PM, Arnd Bergmann wrote:
> > On Tuesday 05 March 2013, Christian Daudt wrote:
> >> On 13-03-05 01:01 AM, Arnd Bergmann wrote:
> >>> On Tuesday 05 March 2013, Christian Daudt wrote:
> >>> For other firmware interfaces like this, we tend to list the specific commands
> >>> that the firmware understands. If you think there might be different versions
> >>> to consider, you might want to model this like
> >>>
> >>> Documentation/devicetree/bindings/arm/psci.txt
> >> This interface is stable and in shipping products at this time, and so
> >> the api will remain constant.
> > But what about future products? Wouldn't they be able to extend the
> > current interface in a compatible way?
>
> It is highly unlikely that for this family we will be extending that API 
> but even if that is done, it can just added #defines in the C header. Is 
> DT seen as the way to define Software APIs going forward ? It should be 
> trivial to implement this, I'm just trying to understand where the line 
> is drawn between describing APIs in DT vs C headers going forward.

We tend to do it in cases where the software has no other way to find out
what interfaces are supported. I guess if it becomes necessary, we can
use a different "compatible" value for an extended future version of this,
but that scales only to so many different variants.

> >> It was originally in init_machine section but I was told that that was
> >> too late and init_irq would be better, and I saw that highbank also has
> >> it in init_irq. I agree that it is unrelated to irq - is there a better
> >> place to put this in ?
> > IMHO the later the better. Do you know what issues were caused  by having it
> > in init_machine?
> This is some feedback I got a while back:
> "From kernel 3.4 on-wards i think ( if i remember correctly) cache sync
> might be called before your board_init function and you might have to do 
> this in init_irq. "
> 
> I just looked through where l2x0_of_init is currently called and here's 
> the list:
> early_initcall (exynos4, omap2, sirf, ux500)
> init_irq (highbank, imx6q)
> init_machine (socfpga, v2m_dt_init)
> 
> so seems to be everywhere :) So I can move it back to init_machineif 
> that's where itshould be.

Hmm, let's try to solve this another time, I don't think there is an easy
answer. Maybe we really need a common entry point for the cache
controller setup, or move it completely out of platform specific code
for the case where it can be probed from DT.

Thanks for doing the research!

	Arnd
