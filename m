From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Mar 2017 16:35:47 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <1490027347.2917.97.camel@pengutronix.de>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170318192258.GL21222@n2100.armlinux.org.uk>
 <aef6c412-5464-726b-42f6-a24b7323aa9c@mentor.com>
 <20170319121402.GS21222@n2100.armlinux.org.uk>
 <1490016016.2917.68.camel@pengutronix.de>
 <20170320154339.GN21222@n2100.armlinux.org.uk>
 <1490027347.2917.97.camel@pengutronix.de>
Message-ID: <20170320163547.GP21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 20, 2017 at 05:29:07PM +0100, Philipp Zabel wrote:
> According to the documentation [1], you are doing the right thing:
> 
>     The struct v4l2_subdev_frame_interval pad references a non-existing
>     pad, or the pad doesn?t support frame intervals.
> 
> But v4l2_subdev_call returns -ENOIOCTLCMD if the g_frame_interval op is
> not implemented at all, which is turned into -ENOTTY by video_usercopy.
> 
> [1] https://linuxtv.org/downloads/v4l-dvb-apis/uapi/v4l/vidioc-subdev-g-frame-interval.html#return-value

Thanks for confirming.

> > Maybe something like the following would be a better idea?
> > 
> >  utils/media-ctl/media-ctl.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/utils/media-ctl/media-ctl.c b/utils/media-ctl/media-ctl.c
> > index f61963a..a50a559 100644
> > --- a/utils/media-ctl/media-ctl.c
> > +++ b/utils/media-ctl/media-ctl.c
> > @@ -81,22 +81,22 @@ static void v4l2_subdev_print_format(struct media_entity *entity,
> >  	struct v4l2_mbus_framefmt format;
> >  	struct v4l2_fract interval = { 0, 0 };
> >  	struct v4l2_rect rect;
> > -	int ret;
> > +	int ret, err_fi;
> >  
> >  	ret = v4l2_subdev_get_format(entity, &format, pad, which);
> >  	if (ret != 0)
> >  		return;
> >  
> > -	ret = v4l2_subdev_get_frame_interval(entity, &interval, pad);
> > -	if (ret != 0 && ret != -ENOTTY)
> > -		return;
> > +	err_fi = v4l2_subdev_get_frame_interval(entity, &interval, pad);
> 
> Not supporting frame intervals doesn't warrant a visible error message,
> I think -EINVAL should also be ignored above, if the spec is to be
> believed.
> 
> >  
> >  	printf("\t\t[fmt:%s/%ux%u",
> >  	       v4l2_subdev_pixelcode_to_string(format.code),
> >  	       format.width, format.height);
> >  
> > -	if (interval.numerator || interval.denominator)
> > +	if (err_fi == 0 && (interval.numerator || interval.denominator))
> >  		printf("@%u/%u", interval.numerator, interval.denominator);
> > +	else if (err_fi != -ENOTTY)
> > +		printf("@<error: %s>", strerror(-err_fi));
> 
> Or here.

I don't mind which - I could change this to:

	else if (err_fi != -ENOTTY && err_fi != -EINVAL)

Or an alternative would be to print an error (ignoring ENOTTY and EINVAL)
to stderr at the "v4l2_subdev_get_frame_interval" callsite and continue
on (ensuring that interval is zeroed).

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
