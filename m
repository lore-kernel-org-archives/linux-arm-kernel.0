From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 11 Mar 2017 00:30:09 +0100
Subject: [PATCH v5 15/39] [media] v4l2: add a frame interval error event
In-Reply-To: <ec05e6e0-79f2-2db2-bde9-4aed00d76faa@gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-16-git-send-email-steve_longerbeam@mentor.com>
 <5b0a0e76-2524-4140-5ccc-380a8f949cfa@xs4all.nl>
 <ec05e6e0-79f2-2db2-bde9-4aed00d76faa@gmail.com>
Message-ID: <20170310233008.GC6540@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 2017-03-10 10:37:21, Steve Longerbeam wrote:
> Hi Hans,
> 
> On 03/10/2017 04:03 AM, Hans Verkuil wrote:
> >On 10/03/17 05:52, Steve Longerbeam wrote:
> >>Add a new FRAME_INTERVAL_ERROR event to signal that a video capture or
> >>output device has measured an interval between the reception or transmit
> >>completion of two consecutive frames of video that is outside the nominal
> >>frame interval by some tolerance value.
> >
> >Reading back what was said on this I agree with Sakari that this doesn't
> >belong here.
> >
> >Userspace can detect this just as easily (if not easier) with a timeout.
> >
> 
> 
> Unfortunately measuring frame intervals from userland is not accurate
> enough for i.MX6.
> 
> The issue here is that the IPUv3, specifically the CSI unit, can
> permanently lose vertical sync if there are truncated frames sent
> on the bt.656 bus. We have seen a single missing line of video cause
> loss of vertical sync. The only way to correct this is to shutdown
> the IPU capture hardware and restart, which can be accomplished
> simply by restarting streaming from userland.
> 
> There are no other indicators from the sensor about these short
> frame events (believe me, we've exhausted all avenues with the ADV718x).
> And the IPUv3 DMA engine has no status indicators for short frames
> either. So the only way to detect them is by measuring frame intervals.
> 
> The intervals have to be able to resolve a single line of missing video.
> With a PAL video source that requires better than 58 usec accuracy.
> 
> There is too much uncertainty to resolve this at user level. The
> driver is able to resolve this by measuring intervals between hardware
> interrupts as long as interrupt latency is reasonably low, and we
> have another method using the i.MX6 hardware input capture support
> that can measure these intervals very accurately with no errors
> introduced by interrupt latency.

Requiring < 58 usec interrupt latency for correct operation is a
little too optimistic, no?
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170311/c974b353/attachment-0001.sig>
