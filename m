From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 19 Jul 2013 11:26:56 -0400 (EDT)
Subject: [PATCH] [RFC] EHCI: add to memory barrier to updating hw_next
In-Reply-To: <003101ce846d$1a74ffa0$4f5efee0$@lge.com>
Message-ID: <Pine.LNX.4.44L0.1307191119550.1055-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Jul 2013, Gioh Kim wrote:

> > I was going to ask the same question.  This particular piece of code gets
> > executed _only_ when an URB is unlinked.  Not during any other kind of
> > error.
> 
> 
> I've got the problem when I listened to the mp3 file of USB HDD.
> I checked the urb data when the problem occurred, the last-status value of
> urb was EINPROGRESS and 
> urb->unlinked was ECONNRESET. 

Ah, so the URB _was_ unlinked.

> I think the 'stopped' case was occurred by the reset of USB port.
> The block device driver did reset USB port because there is no return from
> USB device.

Okay.

> If I made block device driver could not reset USB port, the EHCI driver
> codes were not executed.
> Finally the halt of HC makes 'stopped' case.

Why was the HC halted?  That should happen only when there is an 
extremely severe error.

> I think halt of the HC might be caused that store-buffer delays command for
> HC.
> When I applied the patch from https://lkml.org/lkml/2011/8/31/344 and added
> a mb() into hw_next updating
> to remove delay of store-buffer, My platform works well.
> 
> Can the store-buffer delay halt HC? Is it possible?

I don't see how.  It could slow things down but it should not cause any 
errors.

> IMHO, if the qTD list is broken the HC think there is no qTD to send.
> So I added mb() at hw_next update code.

At the time when the hw_next update gets executed, what is the value of 
"state"?  It should be QH_STATE_IDLE.

Alan Stern
