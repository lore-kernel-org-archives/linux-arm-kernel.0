From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Mar 2017 23:06:45 +0000
Subject: [PATCH v4 14/36] [media] v4l2-mc: add a function to inherit
 controls from a pipeline
In-Reply-To: <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
References: <1487211578-11360-1-git-send-email-steve_longerbeam@mentor.com>
 <1487211578-11360-15-git-send-email-steve_longerbeam@mentor.com>
 <20170302160257.GK3220@valkosipuli.retiisi.org.uk>
Message-ID: <20170303230645.GR21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 02, 2017 at 06:02:57PM +0200, Sakari Ailus wrote:
> Hi Steve,
> 
> On Wed, Feb 15, 2017 at 06:19:16PM -0800, Steve Longerbeam wrote:
> > v4l2_pipeline_inherit_controls() will add the v4l2 controls from
> > all subdev entities in a pipeline to a given video device.
> > 
> > Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> > ---
> >  drivers/media/v4l2-core/v4l2-mc.c | 48 +++++++++++++++++++++++++++++++++++++++
> >  include/media/v4l2-mc.h           | 25 ++++++++++++++++++++
> >  2 files changed, 73 insertions(+)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-mc.c b/drivers/media/v4l2-core/v4l2-mc.c
> > index 303980b..09d4d97 100644
> > --- a/drivers/media/v4l2-core/v4l2-mc.c
> > +++ b/drivers/media/v4l2-core/v4l2-mc.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/usb.h>
> >  #include <media/media-device.h>
> >  #include <media/media-entity.h>
> > +#include <media/v4l2-ctrls.h>
> >  #include <media/v4l2-fh.h>
> >  #include <media/v4l2-mc.h>
> >  #include <media/v4l2-subdev.h>
> > @@ -238,6 +239,53 @@ int v4l_vb2q_enable_media_source(struct vb2_queue *q)
> >  }
> >  EXPORT_SYMBOL_GPL(v4l_vb2q_enable_media_source);
> >  
> > +int __v4l2_pipeline_inherit_controls(struct video_device *vfd,
> > +				     struct media_entity *start_entity)
> 
> I have a few concerns / questions:
> 
> - What's the purpose of this patch? Why not to access the sub-device node
>   directly?

What tools are in existance _today_ to provide access to these controls
via the sub-device nodes?

v4l-tools doesn't last time I looked - in fact, the only tool in v4l-tools
which is capable of accessing the subdevices is media-ctl, and that only
provides functionality for configuring the pipeline.

So, pointing people at vapourware userspace is really quite rediculous.

The established way to control video capture is through the main video
capture device, not through the sub-devices.  Yes, the controls are
exposed through sub-devices too, but that does not mean that is the
correct way to access them.

The v4l2 documentation (Documentation/media/kapi/v4l2-controls.rst)
even disagrees with your statements.  That talks about control
inheritence from sub-devices to the main video device, and the core
v4l2 code provides _automatic_ support for this - see
v4l2_device_register_subdev():

        /* This just returns 0 if either of the two args is NULL */
        err = v4l2_ctrl_add_handler(v4l2_dev->ctrl_handler, sd->ctrl_handler, NULL);

which merges the subdev's controls into the main device's control
handler.

So, (a) I don't think Steve needs to add this code, and (b) I think
your statements about not inheriting controls goes against the
documentation and API compatibility with _existing_ applications,
and ultimately hurts the user experience, since there's nothing
existing today to support what you're suggesting in userspace.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
