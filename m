From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 3 Mar 2017 13:45:06 +0200
Subject: [PATCH v4 13/36] [media] v4l2: add a frame timeout event
In-Reply-To: <4b2bcee1-8da0-776e-4455-8d8e7a7abf0a@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-14-git-send-email-steve_longerbeam@mentor.com>
 <20170302155342.GJ3220@valkosipuli.retiisi.org.uk>
 <4b2bcee1-8da0-776e-4455-8d8e7a7abf0a@gmail.com>
Message-ID: <20170303114506.GM3220@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 03:07:21PM -0800, Steve Longerbeam wrote:
> 
> 
> On 03/02/2017 07:53 AM, Sakari Ailus wrote:
> >Hi Steve,
> >
> >On Wed, Feb 15, 2017 at 06:19:15PM -0800, Steve Longerbeam wrote:
> >>Add a new FRAME_TIMEOUT event to signal that a video capture or
> >>output device has timed out waiting for reception or transmit
> >>completion of a video frame.
> >>
> >>Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >>---
> >> Documentation/media/uapi/v4l/vidioc-dqevent.rst | 5 +++++
> >> Documentation/media/videodev2.h.rst.exceptions  | 1 +
> >> include/uapi/linux/videodev2.h                  | 1 +
> >> 3 files changed, 7 insertions(+)
> >>
> >>diff --git a/Documentation/media/uapi/v4l/vidioc-dqevent.rst b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> >>index 8d663a7..dd77d9b 100644
> >>--- a/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> >>+++ b/Documentation/media/uapi/v4l/vidioc-dqevent.rst
> >>@@ -197,6 +197,11 @@ call.
> >> 	the regions changes. This event has a struct
> >> 	:c:type:`v4l2_event_motion_det`
> >> 	associated with it.
> >>+    * - ``V4L2_EVENT_FRAME_TIMEOUT``
> >>+      - 7
> >>+      - This event is triggered when the video capture or output device
> >>+	has timed out waiting for the reception or transmit completion of
> >>+	a frame of video.
> >
> >As you're adding a new interface, I suppose you have an implementation
> >around. How do you determine what that timeout should be?
> 
> The imx-media driver sets the timeout to 1 second, or 30 frame
> periods at 30 fps.

The frame rate is not necessarily constant during streaming. It may well
change as a result of lighting conditions. I wouldn't add an event for this:
this is unreliable and 30 times the frame period is an arbitrary value
anyway. No other drivers do this either.

The user space is generally in control of the frame period (or on some
devices it could be the sensor, too, but *not* the CSI-2 receiver driver),
so detecting the condition of not receiving any frames is more reliably done
in the user space --- if needed.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
