From: balbi@ti.com (Felipe Balbi)
Date: Wed, 28 Oct 2015 12:16:16 -0500
Subject: MUSB peripheral DMA regression caused by driver core runtime PM
 change
In-Reply-To: <20151028171441.GE3078@atomide.com>
References: <20151021234134.GQ3078@atomide.com>
 <20151022180216.GT3078@atomide.com> <20151022230133.GV3078@atomide.com>
 <562A2D0D.3060104@ti.com> <20151023163957.GW3078@atomide.com>
 <877fmdcyzi.fsf@saruman.tx.rr.com> <20151028171441.GE3078@atomide.com>
Message-ID: <878u6m52xr.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Tony Lindgren <tony@atomide.com> writes:
> * Felipe Balbi <balbi@ti.com> [151023 09:48]:
>> 
>> Hi,
>> 
>> Tony Lindgren <tony@atomide.com> writes:
>> > From: Tony Lindgren <tony@atomide.com>
>> > Date: Fri, 23 Oct 2015 09:03:22 -0700
>> > Subject: [PATCH] usb: musb: omap2430: Fix regression caused by driver core
>> >  change
>> >
>> > Commit ddef08dd00f5 ("Driver core: wakeup the parent device before trying
>> > probe") started automatically ensuring the parent device is enabled when
>> > the child gets probed.
>> >
>> > This however caused a regression for MUSB omap2430 interface as the
>> > runtime PM for the parent device needs the child initialized to access
>> > the MUSB hardware registers.
>> >
>> > Let's delay the enabling of PM runtime for the parent until the child
>> > has been properly initialized as suggested in an earlier patch by
>> > Grygorii Strashko <grygorii.strashko@ti.com>.
>> >
>> > In addition to delaying pm_runtime_enable, we now also need to make sure
>> > the parent is enabled during omap2430_musb_init. We also want to propagate
>> > an error from omap2430_runtime_resume if struct musb is not initialized.
>> >
>> > Note that we use pm_runtime_put_noidle here for both the child and parent
>> > to prevent an extra runtime_suspend/resume cycle.
>> >
>> > Let's also add some comments to avoid confusion between the
>> > two different devices.
>> >
>> > Fixes: ddef08dd00f5 ("Driver core: wakeup the parent device before
>> > trying probe")
>> > Suggested-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>> 
>> I'm fine with this patch to fix this v4.3 regression. Greg, do you want
>> a pull request or can you take this in as a patch ? In any case:
>> 
>> Acked-by: Felipe Balbi <balbi@ti.com>
>
> OK no response for a few days, so I'll pick this up into
> omap-for-v4.3/fixes as I have another fix there too.

all right, thanks


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151028/23b223db/attachment.sig>
