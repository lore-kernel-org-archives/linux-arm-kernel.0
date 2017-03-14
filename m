From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 14 Mar 2017 19:26:46 +0100
Subject: [PATCH v5 15/39] [media] v4l2: add a frame interval error event
In-Reply-To: <20170313104538.GF21222@n2100.armlinux.org.uk>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-16-git-send-email-steve_longerbeam@mentor.com>
 <5b0a0e76-2524-4140-5ccc-380a8f949cfa@xs4all.nl>
 <ec05e6e0-79f2-2db2-bde9-4aed00d76faa@gmail.com>
 <6b574476-77df-0e25-a4d1-32d4fe0aec12@xs4all.nl>
 <5d5cf4a4-a4d3-586e-cd16-54f543dfcce9@gmail.com>
 <aa6a5a1d-18fd-8bed-a349-2654d2d1abe0@xs4all.nl>
 <20170313104538.GF21222@n2100.armlinux.org.uk>
Message-ID: <20170314182646.GB3744@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-03-13 10:45:38, Russell King - ARM Linux wrote:
> On Mon, Mar 13, 2017 at 11:02:34AM +0100, Hans Verkuil wrote:
> > On 03/11/2017 07:14 PM, Steve Longerbeam wrote:
> > > The event must be user visible, otherwise the user has no indication
> > > the error, and can't correct it by stream restart.
> > 
> > In that case the driver can detect this and call vb2_queue_error. It's
> > what it is there for.
> > 
> > The event doesn't help you since only this driver has this issue. So nobody
> > will watch this event, unless it is sw specifically written for this SoC.
> > 
> > Much better to call vb2_queue_error to signal a fatal error (which this
> > apparently is) since there are more drivers that do this, and vivid supports
> > triggering this condition as well.
> 
> So today, I can fiddle around with the IMX219 registers to help gain
> an understanding of how this sensor works.  Several of the registers
> (such as the PLL setup [*]) require me to disable streaming on the
> sensor while changing them.
> 
> This is something I've done many times while testing various ideas,
> and is my primary way of figuring out and testing such things.
> 
> Whenever I resume streaming (provided I've let the sensor stop
> streaming at a frame boundary) it resumes as if nothing happened.  If I
> stop the sensor mid-frame, then I get the rolling issue that Steve
> reports, but once the top of the frame becomes aligned with the top of
> the capture, everything then becomes stable again as if nothing happened.
> 
> The side effect of what you're proposing is that when I disable streaming
> at the sensor by poking at its registers, rather than the capture just
> stopping, an error is going to be delivered to gstreamer, and gstreamer
> is going to exit, taking the entire capture process down.
> 
> This severely restricts the ability to be able to develop and test
> sensor drivers.

Well, but kernel should do what is best for production, not what is
best for driver debugging.

And yes, I guess you can have #ifdef or module parameter or something
switching for behaviour you prefer when you are debugging. But for
production, vb2_queue_error() seems to be the right solution.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170314/b79f73d5/attachment-0001.sig>
