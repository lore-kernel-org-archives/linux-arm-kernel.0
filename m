From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 20 Dec 2010 18:59:37 +0530
Subject: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while invalidating
	L2 cache
In-Reply-To: <4D0F553E.1060301@ti.com>
References: <1292712817-24999-1-git-send-email-nm@ti.com>
	<1292712817-24999-6-git-send-email-nm@ti.com>
	<9b48aafcc94e9b69236ed4d934ebd91e@mail.gmail.com>
	<4D0F41BB.2070606@ti.com>
	<eb91f91221d31f1c74366590a4fb0900@mail.gmail.com>
	<4D0F553E.1060301@ti.com>
Message-ID: <e6ba48e58d90204a23a5e948700a5166@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nishanth Menon [mailto:nm at ti.com]
> Sent: Monday, December 20, 2010 6:38 PM
> To: Santosh Shilimkar
> Cc: linux-omap; linux-arm; Jean Pihet; Kevin; Tony
> Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while
> invalidating L2 cache
>
> Santosh Shilimkar had written, on 12/20/2010 06:14 AM, the following:
> >> -----Original Message-----
> >> From: Nishanth Menon [mailto:nm at ti.com]
> >> Sent: Monday, December 20, 2010 5:15 PM
> >> To: Santosh Shilimkar
> >> Cc: linux-omap; linux-arm; Jean Pihet; Kevin; Tony
> >> Subject: Re: [PATCH v4 5/7] OMAP3630: PM: Disable L2 cache while
> >> invalidating L2 cache
> >>
> >> Santosh Shilimkar wrote, on 12/20/2010 01:13 AM:
> >> [..]
> >>>> This is be done according to ARM documentation. Currently this is
> >>>> identified
> >>>> as being needed on OMAP3630 as the disable/enable is done from
> > "public
> >>>> side"
> >>>> while, on OMAP3430, this is done in the "secure side".
> >>> Can you point me to ARM doc which says " for L2 invalidation, the
> >>> controller
> >>> needs to be disabled" ?
> >> please see section 8.3 of the Cortex-A8 TRM
> >>
> > Yes. Have seen it and it doesn't say at least what your patch
> > description is saying.
> See [1]
> To disable the L2 cache, but leave the L1 data cache enabled, use the
> following sequence:
But it's not applicable to this piece of code. Your L1D is
not ON here either.

>     1. Disable the C bit.
> for details on C bit: see [2]
>     2. Clean and invalidate the L1 and L2 caches.
> [...]
> Does this help or do you have a suggestion on how the commit message
> could be improved?
>
Actually it doesn't. My worry is we might be trying to work-around some
OMAP specific issue. But as I said initially we do change the AUXCTRL
configuration and in that case the sequence is correct as per ARM TRM.

So may be you could update the change log something like below.

While coming out of MPU OSWR/OFF states, L2 controller is reseted.
The reset behavior is implementation specific as per ARMv7 TRM and
hence $L2 needs to be invalidated before it's use. Since the
AUXCTRL register is also reconfigured, disable L2 cache before
invalidating it and re-enables it afterwards. This is as per
Cortex-A8 ARM documentation.
Currently this is identified as being needed on OMAP3630 as the
disable/enable is done from "public side" while, on OMAP3430, this
is done in the "secure side".

Regards,
Santosh
