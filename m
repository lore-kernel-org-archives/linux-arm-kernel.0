From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Feb 2014 09:52:12 +0000
Subject: [PATCH RFC 07/31] mmc: sdhci: push card_tasklet into threaded
 irq handler
In-Reply-To: <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
References: <20140218150801.GD21483@n2100.arm.linux.org.uk>
 <E1WFmIk-0006m0-Ah@rmk-PC.arm.linux.org.uk>
 <20140218175703.GJ21483@n2100.arm.linux.org.uk>
 <CAKohpoknX=acZHJeydwv6XRKFHTD4DM84xfCJ=56NrRfJnBOOA@mail.gmail.com>
 <20140219094322.GR21483@n2100.arm.linux.org.uk>
 <CAKohpomfHxWBF5m4D6iqod4a3gw2BU1W6nXMkEOg+YA+izYr=g@mail.gmail.com>
Message-ID: <20140219095212.GT21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 19, 2014 at 03:18:08PM +0530, Viresh Kumar wrote:
> On 19 February 2014 15:13, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Feb 19, 2014 at 11:43:19AM +0530, Viresh Kumar wrote:
> >> Adding ST people as well who have access to boards and are working on SPEAr.
> >>
> >> On 18 February 2014 23:27, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > 1) You're controlling the card power GPIO via the insertion/removal
> >> >    interrupt handler?  What's wrong with using a vmmc regulator for
> >> >    that, which will be controlled via the MMC subsystem as required?
> >>
> >> Haven't explored that earlier.. Maybe its possible but no idea.
> >> The requirements were like this:
> >> - We may or maynot need a GPIO for controlling power
> >> - If we need it, we may need to disable/enable power with card removal/
> >> insertion Or we may need to keep it enabled for ever..
> >
> > So how is this any different from any other system which controls power to
> > the MMC/SD socket?
> 
> I am not claiming it to be different. I am just saying these were the
> requirements
> and I am not sure if they were satisfied with vmmc regulator. It might
> be exactly
> same in all other platforms.

Are you aware that power control to the card is part of the MMC/SD/SDIO
spec - and part of the protocol talking to the card?  Hence why the
mmc layer has support for its control built-in.

If you don't want to use a regulator, then the right way to do this is to
use the set_ios callback and check the power field - anything which is not
MMC_POWER_OFF should result in power to the card being turned on.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
