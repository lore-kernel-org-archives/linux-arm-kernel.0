From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 7 Jun 2017 15:31:16 +0300
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <d51acbaa-0dc6-ce5c-5442-62c5c24ad6da@gmail.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170531195821.GA16962@amd>
 <20170601082659.GJ1019@valkosipuli.retiisi.org.uk>
 <755909bf-d1de-e0f3-1569-0d4b16e26817@gmail.com>
 <20170603195139.GA3062@amd>
 <20170603215709.GU1019@valkosipuli.retiisi.org.uk>
 <d51acbaa-0dc6-ce5c-5442-62c5c24ad6da@gmail.com>
Message-ID: <20170607123116.GB1019@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 03, 2017 at 09:46:36PM -0700, Steve Longerbeam wrote:
> 
> 
> On 06/03/2017 02:57 PM, Sakari Ailus wrote:
> >On Sat, Jun 03, 2017 at 09:51:39PM +0200, Pavel Machek wrote:
> >>Hi!
> >>
> >>>>>>+	/* Auto/manual exposure */
> >>>>>>+	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
> >>>>>>+						 V4L2_CID_EXPOSURE_AUTO,
> >>>>>>+						 V4L2_EXPOSURE_MANUAL, 0,
> >>>>>>+						 V4L2_EXPOSURE_AUTO);
> >>>>>>+	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> >>>>>>+					    V4L2_CID_EXPOSURE_ABSOLUTE,
> >>>>>>+					    0, 65535, 1, 0);
> >>>>>
> >>>>>Is exposure_absolute supposed to be in microseconds...?
> >>>>
> >>>>Yes.
> >>>
> >>>According to the docs V4L2_CID_EXPOSURE_ABSOLUTE is in 100 usec units.
> >>>
> >>>  OTOH V4L2_CID_EXPOSURE has no defined unit, so it's a better fit IMO.
> >>>>Way more drivers appear to be using EXPOSURE than EXPOSURE_ABSOLUTE, too.
> >>>
> >>>Done, switched to V4L2_CID_EXPOSURE. It's true, this control is not
> >>>taking 100 usec units, so unit-less is better.
> >>
> >>Thanks. If you know the units, it would be of course better to use
> >>right units...
> >
> >Steve: what's the unit in this case? Is it lines or something else?
> 
> Yes, the register interface for exposure takes lines*16.
> 
> Maybe converting from seconds to lines is as simple as
> framerate * height * seconds. But I'm not sure about that.

The smiapp and a few other drivers are using lines. One option could be to
use lines as the unit and have step as 16.

Then the hblank + vblank controls will be needed, too, to enable the user to
at least figure out the conversion to Si units.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
