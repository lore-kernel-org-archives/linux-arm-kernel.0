From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Jun 2017 00:17:41 +0200
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <20170603215709.GU1019@valkosipuli.retiisi.org.uk>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170531195821.GA16962@amd>
 <20170601082659.GJ1019@valkosipuli.retiisi.org.uk>
 <755909bf-d1de-e0f3-1569-0d4b16e26817@gmail.com>
 <20170603195139.GA3062@amd>
 <20170603215709.GU1019@valkosipuli.retiisi.org.uk>
Message-ID: <20170603221741.GA2379@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > According to the docs V4L2_CID_EXPOSURE_ABSOLUTE is in 100 usec units.
> > > 
> > >  OTOH V4L2_CID_EXPOSURE has no defined unit, so it's a better fit IMO.
> > > >Way more drivers appear to be using EXPOSURE than EXPOSURE_ABSOLUTE, too.
> > > 
> > > Done, switched to V4L2_CID_EXPOSURE. It's true, this control is not
> > > taking 100 usec units, so unit-less is better.
> > 
> > Thanks. If you know the units, it would be of course better to use
> > right units...
> 
> Steve: what's the unit in this case? Is it lines or something else?
> 
> Pavel: we do need to make sure the user space will be able to know the unit,
> too. It's rather a case with a number of controls: the unit is known but
> there's no API to convey it to the user.
> 
> The exposure is a bit special, too: granularity matters a lot on small
> values. On most other controls it does not.

Yeah. Basically problem with exposure is that the control is
logarithmic; by using linear scale we got too much resolution at long
times and too little resolution at short times.

(Plus, 100 usec ... n900 can do times _way_ shorter than that.)

Anyway, even u32 gives us enough range, but I so the linear/log
confusion does not matter. But it would be nicer if values were in 10
usec or usec, not 100 usec... 

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170604/6f0aa838/attachment-0001.sig>
