From: dwalker@codeaurora.org (Daniel Walker)
Date: Tue, 18 Jan 2011 13:00:20 -0800
Subject: [PATCH] drivers: mmc: msm: update to new arm pfn_to_dma API
In-Reply-To: <20110118204446.GL16980@n2100.arm.linux.org.uk>
References: <1295373844-27713-1-git-send-email-dwalker@codeaurora.org>
	<20110118182826.GI16980@n2100.arm.linux.org.uk>
	<1295382134.26904.7.camel@c-dwalke-linux.qualcomm.com>
	<20110118204446.GL16980@n2100.arm.linux.org.uk>
Message-ID: <1295384420.26904.56.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-01-18 at 20:44 +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 18, 2011 at 12:22:14PM -0800, Daniel Walker wrote:
> > On Tue, 2011-01-18 at 18:28 +0000, Russell King - ARM Linux wrote:
> > > On Tue, Jan 18, 2011 at 10:04:04AM -0800, Daniel Walker wrote:
> > > > The page_to_dma() API call was removed. It caused this build
> > > > failure,
> > > 
> > > Because it's an API internal interface.  Don't use it.  Why is this
> > > driver poking about in API internals all over the place?
> > 
> > If it's internal why is this driver able to call it?
> 
> Many things end up like that in the kernel because of the need to balance
> accessibility of stuff from header files and efficiency of implementation
> with access.
> 
> We could stuff them into a separate header file, move all the DMA API
> implementation into a .c file, and prevent drivers from being able to
> inline those functions.  They then have to have the overhead of saving
> call frames onto stack, etc.  Is that something you think would be
> beneficial?

I don't know .. If it's accessible to drivers you should assume they
will use it, broken or not.

> But then how would we prevent drivers including that separate header
> file and regaining access to them?
> 
> Answer: you can't.  So why bother making things less efficient when
> there's zero benefit from doing so?

That's fine, but still if it's accessible to driver you need to assume
they can/will use it (potentially) ..

> There is this comment directly above their definitions:
> /*
>  * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
>  * functions used internally by the DMA-mapping API to provide DMA
>  * addresses. They must not be used by drivers.
>  */
> which was preceded by this:
> /*
>  * page_to_dma/dma_to_virt/virt_to_dma are architecture private functions
>  * used internally by the DMA-mapping API to provide DMA addresses. They
>  * must not be used by drivers.
>  */

That's all fine an dandy , but this driver is using them. You can't just
pretend that it's not using them, and hence break the build.

Have you considered renaming to __dma_to_pfn ?

> I have little sympathy for drivers breaking when they use stuff which is
> explicitly documented that they should not use - and when there's proper
> well known APIs (DMA-mapping) provided.

This needs to be caught in a different way, you can't just break the
driver.. AFAIK this driver went through the review process, and no one
caught this. The driver does in fact work, and is used.

> Can I also assume you've already read that comment, as you'd have had to
> find the change to locate what the new function is called?

No, I didn't read it .. I just reviewed your changes to see how to
convert to the new usage..

> > > That is completely broken.  Please use the official APIs - it's not
> > > hard.  Here's how to do it correctly:
> > 
> > Can you make this into a patch and send it to David Brown ?
> 
> After I've done everything else I've got to do... which could be some
> time.
> 
> > > and when you use writel() etc afterwards, those non-cacheable writes to
> > > box-> will be ordered with your device write.
> > > 
> > > So that's a NAK for your original patch.
> > 
> > Are you given us alternative to my fix yet? I didn't see any of your
> > comments touching that area?
> 
> I'm merely reporting the fact, based on a comment in the driver.  I've
> not looked any further to see how the driver works or what else it does,
> or even whether it gets it right.  Do I take it from your comment that
> the driver doesn't use writel et.al. ?

Just greping the driver I found at least one writel() .. I'm not really
concerned with that tho. I use this driver, I need this driver to work.
You broke the driver, and your NAK'ing the fix ..

We can fix all the issues that your bringing up, but the driver should
still work while we're doing that.

Daniel


-- 

Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
