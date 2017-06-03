From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Sun, 4 Jun 2017 00:57:09 +0300
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <20170603195139.GA3062@amd>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170531195821.GA16962@amd>
 <20170601082659.GJ1019@valkosipuli.retiisi.org.uk>
 <755909bf-d1de-e0f3-1569-0d4b16e26817@gmail.com>
 <20170603195139.GA3062@amd>
Message-ID: <20170603215709.GU1019@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 03, 2017 at 09:51:39PM +0200, Pavel Machek wrote:
> Hi!
> 
> > >>>+	/* Auto/manual exposure */
> > >>>+	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
> > >>>+						 V4L2_CID_EXPOSURE_AUTO,
> > >>>+						 V4L2_EXPOSURE_MANUAL, 0,
> > >>>+						 V4L2_EXPOSURE_AUTO);
> > >>>+	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> > >>>+					    V4L2_CID_EXPOSURE_ABSOLUTE,
> > >>>+					    0, 65535, 1, 0);
> > >>
> > >>Is exposure_absolute supposed to be in microseconds...?
> > >
> > >Yes.
> > 
> > According to the docs V4L2_CID_EXPOSURE_ABSOLUTE is in 100 usec units.
> > 
> >  OTOH V4L2_CID_EXPOSURE has no defined unit, so it's a better fit IMO.
> > >Way more drivers appear to be using EXPOSURE than EXPOSURE_ABSOLUTE, too.
> > 
> > Done, switched to V4L2_CID_EXPOSURE. It's true, this control is not
> > taking 100 usec units, so unit-less is better.
> 
> Thanks. If you know the units, it would be of course better to use
> right units...

Steve: what's the unit in this case? Is it lines or something else?

Pavel: we do need to make sure the user space will be able to know the unit,
too. It's rather a case with a number of controls: the unit is known but
there's no API to convey it to the user.

The exposure is a bit special, too: granularity matters a lot on small
values. On most other controls it does not.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
