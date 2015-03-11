From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 11 Mar 2015 10:03:45 +0100
Subject: [PATCH 2/4] soc: Mediatek: Add SCPSYS power domain driver
In-Reply-To: <1426043791.24243.9.camel@mtksdaap41>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-3-git-send-email-s.hauer@pengutronix.de>
 <7h61a94zy0.fsf@deeprootsystems.com>
 <20150310094142.GD24885@pengutronix.de>
 <1426043791.24243.9.camel@mtksdaap41>
Message-ID: <20150311090345.GR24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 11, 2015 at 11:16:31AM +0800, James Liao wrote:
> Hi,
> 
> On Tue, 2015-03-10 at 10:41 +0100, Sascha Hauer wrote:
> > On Mon, Mar 09, 2015 at 02:35:03PM -0700, Kevin Hilman wrote:
> > > Sascha Hauer <s.hauer@pengutronix.de> writes:
> > > 
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > 
> > > A bit of a changelog here would be useful describing this driver, that
> > > it's only covering part of the device (e.g. power controller) with more
> > > to come, dependency on the syscon driver, etc.
> > > 
> > > > +/*
> > > > + * The Infracfg unit has bus protection bits. We enable the bus protection
> > > > + * for disabled power domains so that the system does not hang when some unit
> > > > + * accesses the bus while in power down.
> > > > + */
> > > 
> > > Hmm, why don't you want to know if some device is accessing another
> > > device which is in a domain that is powered down?   Seems like this is a
> > > good way to hide real bugs.
> > 
> > How I understand it the system just hangs on erroneous accesses without
> > these protection bits enabled, so enabling them at least makes sure we
> > can output something.
> > I must admit though that my understanding of these bits is quite limited
> > and the only user of this driver I have available here (audio) doesn't
> > make use of these protection bits, so I can't test here.
> > 
> > James, could you shed some light on this issue?
> 
> I asked our designer about the bus protection feature, here is his
> response:
> 
> "
> It's for unexpected signal glitch in Power switch process.
> 
> During Power switch process, we have clock switch, reset, isolation
> enable/disable and  power switch involved where the transition of
> asynchronous reset and  isolation is the most critical one,  which have
> risk to introduce a unexpected short period signal transition from
> MTCMOS?s interface to other alive HW . 
> "
> 
> That means it protects unexpected bus accessing from HW, not from SW. So
> it will not hide bugs from wrong SW access.

Ok, thanks for clarifying. This means we should enable this feature
sooner or later. Since the audio driver which is likely the first user
of this driver doesn't need the protection bits I think we have some
time and can add the protection bits once the clock patches have been
merged.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
