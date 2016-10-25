From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 25 Oct 2016 12:56:04 +0200
Subject: [RFC] shutdown machine when li-ion battery goes below 3V
In-Reply-To: <20161025105320.GK12154@pali>
References: <20161024212250.GA31336@amd>
 <20161024212932.uhjz752z2cy5hohl@atomide.com>
 <20161024214152.GA32310@amd> <201610242348.47484@pali>
 <20161025102435.GA6916@amd> <20161025105320.GK12154@pali>
Message-ID: <20161025105604.GA25855@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-10-25 12:53:20, Pali Roh?r wrote:
> On Tuesday 25 October 2016 12:24:35 Pavel Machek wrote:
> > On Mon 2016-10-24 23:48:47, Pali Roh?r wrote:
> > > On Monday 24 October 2016 23:41:52 Pavel Machek wrote:
> > > > On Mon 2016-10-24 14:29:33, Tony Lindgren wrote:
> > > > > Also, the shutdown voltage can depend on external devices
> > > > > connected. It could be for example 3.3V depending on eMMC on some
> > > > > devices while devices with no eMMC could have it at 3.0V.
> > > > 
> > > > Actually, I'd like to shutdown at 3.3V or more (like 3.5V), because
> > > > going below that is pretty mean to the battery. But if I set
> > > > threshold too high, GSM activity will push it below that for a very
> > > > short while, and I'll shutdown too soon.
> > > > 
> > > > Ideas welcome...
> > > 
> > > bq27x00 has EDVF flag which means that battery is empty. Maemo with 
> > > bq27x00 driver is configured to issue system shutdown when EDVF is set.
> > > 
> > > Maybe kernel should issue emergency shutdown e.g. after minute or two 
> > > after EDVF flag is set?
> > 
> > Thanks for pointer.
> > 
> > EDVF seems to be exposed as health. ... but only if battery is
> > calibrated, AFAICT.
> 
> No, EDVF is available also for uncalibrated battery. There are EDV1 and
> EDVF flags. Both are set based on battery voltage and some other
> parameters from bq EEPROM.
> 
> >  if (has_ci_flag && (cache.flags & BQ27000_FLAG_CI)) {
> >       dev_info_once(di->dev, "battery is not calibrated! ignoring capacity values\n");
> 
> Yes, it ignores only capacity values (which needs calibration), not
> those raw flags which works also without calibration.
> 
> >       ...
> >       cache.health = -ENODATA;

Take a look at code. Health is not read from hardware unless battery
is calibrated.
								
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161025/61eece66/attachment.sig>
