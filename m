From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 3 Mar 2017 21:17:46 +0200
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <fc8168ef-bf36-b2d9-627b-e4b8c6a5024e@gmail.com>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
 <141eb012-eb24-7558-2bc5-1fe82f6b7b4b@gmail.com>
 <fc8168ef-bf36-b2d9-627b-e4b8c6a5024e@gmail.com>
Message-ID: <20170303191745.GQ3220@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Mar 02, 2017 at 06:12:43PM -0800, Steve Longerbeam wrote:
> 
> 
> On 03/02/2017 03:48 PM, Steve Longerbeam wrote:
> >
> >
> >On 03/02/2017 08:02 AM, Sakari Ailus wrote:
> >>Hi Steve,
> >>
> >>On Wed, Feb 15, 2017 at 06:19:16PM -0800, Steve Longerbeam wrote:
> >>>v4l2_pipeline_inherit_controls() will add the v4l2 controls from
> >>>all subdev entities in a pipeline to a given video device.
> >>>
> >>>Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >>>---
> >>> drivers/media/v4l2-core/v4l2-mc.c | 48
> >>>+++++++++++++++++++++++++++++++++++++++
> >>> include/media/v4l2-mc.h           | 25 ++++++++++++++++++++
> >>> 2 files changed, 73 insertions(+)
> >>>
> >>>diff --git a/drivers/media/v4l2-core/v4l2-mc.c
> >>>b/drivers/media/v4l2-core/v4l2-mc.c
> >>>index 303980b..09d4d97 100644
> >>>--- a/drivers/media/v4l2-core/v4l2-mc.c
> >>>+++ b/drivers/media/v4l2-core/v4l2-mc.c
> >>>@@ -22,6 +22,7 @@
> >>> #include <linux/usb.h>
> >>> #include <media/media-device.h>
> >>> #include <media/media-entity.h>
> >>>+#include <media/v4l2-ctrls.h>
> >>> #include <media/v4l2-fh.h>
> >>> #include <media/v4l2-mc.h>
> >>> #include <media/v4l2-subdev.h>
> >>>@@ -238,6 +239,53 @@ int v4l_vb2q_enable_media_source(struct
> >>>vb2_queue *q)
> >>> }
> >>> EXPORT_SYMBOL_GPL(v4l_vb2q_enable_media_source);
> >>>
> >>>+int __v4l2_pipeline_inherit_controls(struct video_device *vfd,
> >>>+                     struct media_entity *start_entity)
> >>
> >>I have a few concerns / questions:
> >>
> >>- What's the purpose of this patch? Why not to access the sub-device node
> >>  directly?
> >
> >
> >I don't really understand what you are trying to say.<snip>
> >
> 
> Actually I think I understand what you mean now. Yes, the user can
> always access a subdev's control directly from its /dev/v4l-subdevXX.
> I'm only providing this feature as a convenience to the user, so that
> all controls in a pipeline can be accessed from one place, i.e. the
> main capture device node.

No other MC based V4L2 driver does this. You'd be creating device specific
behaviour that differs from what the rest of the drivers do. The purpose of
MC is to provide the user with knowledge of what devices are there, and the
V4L2 sub-devices interface is used to access them in this case.

It does matter where a control is implemented, too. If the pipeline contains
multiple sub-devices that implement the same control, only one of them may
be accessed. The driver calling the function (or even less the function)
would not know which one of them should be ignored.

If you need such functionality, it should be implemented in the user space
instead.

-- 
Regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
