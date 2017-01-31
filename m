From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 31 Jan 2017 22:42:43 +0100
Subject: [PATCH 09/11] drm/panel: Add support for the Raspberry Pi 7"
 Touchscreen.
In-Reply-To: <20170131211702.o2he5o6ktaztmrkx@phenom.ffwll.local>
References: <20161214194621.16499-1-eric@anholt.net>
 <20161214194621.16499-10-eric@anholt.net>
 <20170131210717.GA872@mithrandir.ba.sec>
 <20170131211702.o2he5o6ktaztmrkx@phenom.ffwll.local>
Message-ID: <20170131214241.GE872@mithrandir.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 10:17:02PM +0100, Daniel Vetter wrote:
> On Tue, Jan 31, 2017 at 10:07:19PM +0100, Thierry Reding wrote:
> > On Wed, Dec 14, 2016 at 11:46:19AM -0800, Eric Anholt wrote:
> > > +static int rpi_touchscreen_enable(struct drm_panel *panel)
> > > +{
> > > +	struct rpi_touchscreen *ts = panel_to_ts(panel);
> > > +	int i;
> > > +
> > > +	rpi_touchscreen_i2c_write(ts, REG_POWERON, 1);
> > > +	/* Wait for nPWRDWN to go low to indicate poweron is done. */
> > > +	for (i = 0; i < 100; i++) {
> > > +		if (rpi_touchscreen_i2c_read(ts, REG_PORTB) & 1)
> > > +			break;
> > > +	}
> > 
> > Don't you want to fail when power on doesn't succeed? Seems kind of
> > pointless to continue if the panel doesn't power on.
> 
> kms works under the assumption that even when the sink is dead, the
> display pipe (well, vblanks and pageflips) keep working. There's a patch
> floating around to give userspace more information about what's going
> wrong through an async uevent+read-only property for cases where an
> unresponsive sink is normal, i.e. link training for dp.
> 
> But either way, continuing is generally the right thing to do, there's no
> way to report -EIO from here (because no reasons than that's where
> accidentally ended up with our evolved design ...).

I think this depends on the specific case. I was assuming that if the
panel fails to power up, then any subsequent operations like register
reads or writes would also fail, potentially causing a lot of confusing
error messages that could easily be avoided.

Also, the panel API is usually called from encoder or connector drivers
and propagating error codes might give them a chance of reacting.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170131/c4b5d942/attachment.sig>
