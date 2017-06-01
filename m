From: pavel@ucw.cz (Pavel Machek)
Date: Thu, 1 Jun 2017 10:43:20 +0200
Subject: exposure vs. exposure_absolute was Re: [PATCH v7 16/34] [media] add
 Omnivision OV5640 sensor driver
In-Reply-To: <20170601082659.GJ1019@valkosipuli.retiisi.org.uk>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170531195821.GA16962@amd>
 <20170601082659.GJ1019@valkosipuli.retiisi.org.uk>
Message-ID: <20170601084320.GA16038@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > +	/* Auto/manual exposure */
> > > +	ctrls->auto_exp = v4l2_ctrl_new_std_menu(hdl, ops,
> > > +						 V4L2_CID_EXPOSURE_AUTO,
> > > +						 V4L2_EXPOSURE_MANUAL, 0,
> > > +						 V4L2_EXPOSURE_AUTO);
> > > +	ctrls->exposure = v4l2_ctrl_new_std(hdl, ops,
> > > +					    V4L2_CID_EXPOSURE_ABSOLUTE,
> > > +					    0, 65535, 1, 0);
> > 
> > Is exposure_absolute supposed to be in microseconds...?
> 
> Yes. OTOH V4L2_CID_EXPOSURE has no defined unit, so it's a better fit IMO.
> Way more drivers appear to be using EXPOSURE than EXPOSURE_ABSOLUTE, too.
> 
> Ideally we should have only one control for exposure.

No. N-o. No no no. NO! No. N-o. NONONO. No. NooooooooooOOO!!!!!!!!!!!!!

Sorry, no.

Userspace needs to know exposure times. It is not so important for a
webcam, but it is mandatory for digital camera. As it gets darker,
autogain wants to scale exposure to cca 1/100 sec, then it wants to
scale gain up to maximum, and only then it wants to continue scaling
exposure. (Threshold will be shorter in "sports" mode, perhaps
1/300sec?)

Plus, we want user to be able to manually set exposure parameters.

So... _this_ driver probably should use V4L2_CID_EXPOSURE. (If the
units are not known). But in general we'd prefer drivers using
V4L2_CID_EXPOSURE_ABSOLUTE. Your car has speedometer calibrated in
km/h or mph, not in "% of max", right?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170601/7414ea5a/attachment-0001.sig>
