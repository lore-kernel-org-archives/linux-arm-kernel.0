From: John.Youn@synopsys.com (John Youn)
Date: Sat, 20 Feb 2016 02:55:33 +0000
Subject: [PATCH] usb: move usb_calc_bus_time into common code
References: <1455918064-410571-1-git-send-email-arnd@arndb.de>
 <Pine.LNX.4.44L0.1602191650570.1700-100000@iolanthe.rowland.org>
 <CAD=FV=VjgTUQR-Rw+LWXnNdZhruukaV-+LnXFqNRj-wpcvSJ4w@mail.gmail.com>
Message-ID: <2B3535C5ECE8B5419E3ECBE30077290901DC453B41@US01WEMBX2.internal.synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/19/2016 2:48 PM, Doug Anderson wrote:
> Hi,
> 
> On Fri, Feb 19, 2016 at 1:52 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
>> On Fri, 19 Feb 2016, Arnd Bergmann wrote:
>>
>>> The dwc2 dual-role USB controller driver has started calling
>>> usb_calc_bus_time, and does so regardless of whether it is
>>> being built as a host controller or gadget. In case all
>>
>> Out of curiosity...  Why does dwc2 need to calculate bus times when it
>> is in device mode?
> 
> Hoo boy.  it doesn't.  Nor does it need to properly set the even/odd
> frame in device mode.
> 
> Basically dwc2's "core.c" has a whole bunch of stuff in it that's host
> only and isn't guarded with any #ifdef.  ...yet that file is included
> in gadget-only builds.  It's a bit of a mess.  Take a gander at all of
> the "dwc2_hc_xxx" functions sitting in "drivers/usb/dwc2/core.c".
> 
> Long term that needs to be cleaned up, but such a cleanup is going to
> be a bit of churn so we'd need to schedule it for a time when not much
> else is going on (and presumably it should be done by John or in close
> coordination with him so it can get Acked / landed quickly to avoid
> conflicts?).  To do this we'd have to figure out why some things are
> in "core.c" and some in "hcd.c" and if it makes sense to move them all
> to "hcd.c" or if we need a new "core_hc.c" or something...  All of
> that design predates me.
> 

Yeah, that stuff has been bugging me for a while. I have a branch that
started a lot of clean-ups, but it's never been a great time to merge
it.

> In any case I guess we need a solution for right now, huh?
> 
> One terribly lame hack would be to just make a dummy no-op
> "dwc2_hc_set_even_odd_frame()" if host mode is disabled.  That doesn't
> really fix the root problem of lots of host mode code being compiled
> in a gadget-only driver.  It also adds an ugly "#ifdef".  ...but it
> does get around the current compile error.
> 
> 
> What do folks think?
> 

I think if we can fix it for -next in dwc2 by moving all host code out
of core then we should do it that way. I'll see if I can revive my
patches.

Regards,
John
