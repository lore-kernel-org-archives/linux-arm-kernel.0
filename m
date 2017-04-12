From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 12 Apr 2017 12:09:32 +0300
Subject: [PATCH v6 17/39] platform: add video-multiplexer subdevice driver
In-Reply-To: <e7368555-1644-4e8f-f355-6b07dc020f90@gmail.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-18-git-send-email-steve_longerbeam@mentor.com>
 <20170404124732.GD3288@valkosipuli.retiisi.org.uk>
 <e7368555-1644-4e8f-f355-6b07dc020f90@gmail.com>
Message-ID: <20170412090932.GS4192@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Tue, Apr 11, 2017 at 05:50:58PM -0700, Steve Longerbeam wrote:
> 
> 
> On 04/04/2017 05:47 AM, Sakari Ailus wrote:
> >Hi Steve, Philipp and Pavel,
> >
> >On Mon, Mar 27, 2017 at 05:40:34PM -0700, Steve Longerbeam wrote:
> >>From: Philipp Zabel <p.zabel@pengutronix.de>
> >>
> >>This driver can handle SoC internal and external video bus multiplexers,
> >>controlled either by register bit fields or by a GPIO. The subdevice
> >>passes through frame interval and mbus configuration of the active input
> >>to the output side.
> >
> >The MUX framework is already in linux-next. Could you use that instead of
> >adding new driver + bindings that are not compliant with the MUX framework?
> >I don't think it'd be much of a change in terms of code, using the MUX
> >framework appears quite simple.
> 
> I would prefer to wait on this, and get what we have merged now so I can
> unload all these patches first.

The DT bindings will be different for this one and if you were using a MUX,
won't they? And you can't remove support for the existing bindings either,
you have to continue to support them going forward.

> 
> Also this is Philipp's driver, so again I would prefer to get this
> merged as-is and then Philipp can address these issues in a future
> patch. But I will add my comments below...

I bet there will be more issues to handle if you were to do the changes
later than now.

...

> >>+static int vidsw_s_stream(struct v4l2_subdev *sd, int enable)
> >>+{
> >>+	struct vidsw *vidsw = v4l2_subdev_to_vidsw(sd);
> >>+	struct v4l2_subdev *upstream_sd;
> >>+	struct media_pad *pad;
> >>+
> >>+	if (vidsw->active == -1) {
> >>+		dev_err(sd->dev, "Can not start streaming on inactive mux\n");
> >>+		return -EINVAL;
> >>+	}
> >>+
> >>+	pad = media_entity_remote_pad(&sd->entity.pads[vidsw->active]);
> >>+	if (!pad) {
> >>+		dev_err(sd->dev, "Failed to find remote source pad\n");
> >>+		return -ENOLINK;
> >>+	}
> >>+
> >>+	if (!is_media_entity_v4l2_subdev(pad->entity)) {
> >>+		dev_err(sd->dev, "Upstream entity is not a v4l2 subdev\n");
> >>+		return -ENODEV;
> >>+	}
> >>+
> >>+	upstream_sd = media_entity_to_v4l2_subdev(pad->entity);
> >>+
> >>+	return v4l2_subdev_call(upstream_sd, video, s_stream, enable);
> >
> >Now that we'll have more than two drivers involved in the same pipeline it
> >becomes necessary to define the behaviour of s_stream() throughout the
> >pipeline --- i.e. whose responsibility is it to call s_stream() on the
> >sub-devices in the pipeline?
> 
> In the case of imx-media, the capture device calls set stream on the
> whole pipeline in the start_streaming() callback. This subdev call is
> actually a NOOP for imx-media, because the upstream entity has already
> started streaming. Again I think this should be removed. It also
> enforces a stream order that some MC drivers may have a problem with.

What I want to say here is that the order in which the different devices in
the pipeline need to be started may not be known in a driver for a
particular part of the pipeline.

In order to avoid trying to have a single point of decision making, the
s_stream() op implemented in sub-device drivers should serve the purpose.
I'll cc you for the documentation patch.

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
