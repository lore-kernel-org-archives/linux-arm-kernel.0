From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Nov 2017 23:22:07 +0000
Subject: [RFC] Improving udelay/ndelay on platforms where that is possible
In-Reply-To: <CAD=FV=U1FYVS34BYrSTV+0mP6ERhD=MBJGt8ni1bS2-r__Ta4A@mail.gmail.com>
References: <1fa81694-7bd2-564b-e5b9-ae53b9ea6620@sigmadesigns.com>
 <20171116153625.GJ31757@n2100.armlinux.org.uk>
 <9a4cfa9d-3940-b7f2-5a4d-59e89af85bb7@sigmadesigns.com>
 <nycvar.YSQ.7.76.1711161106240.20817@knanqh.ubzr>
 <48c38055-20f7-e565-aa56-74f360e6e3d9@sigmadesigns.com>
 <20171116163254.GK31757@n2100.armlinux.org.uk>
 <fc4ce9e1-8c9d-e6bf-30d3-ead2c5518683@sigmadesigns.com>
 <20171116170527.GL31757@n2100.armlinux.org.uk>
 <9f678f27-38a0-1dbe-50b9-2d9109c639a9@free.fr>
 <CAD=FV=U1FYVS34BYrSTV+0mP6ERhD=MBJGt8ni1bS2-r__Ta4A@mail.gmail.com>
Message-ID: <20171116232206.GM31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 02:15:02PM -0800, Doug Anderson wrote:
> Hi,
> 
> On Thu, Nov 16, 2017 at 1:05 PM, Marc Gonzalez
> <marc_gonzalez@sigmadesigns.com> wrote:
> > On 16/11/2017 18:05, Russell King - ARM Linux wrote:
> >
> >> On Thu, Nov 16, 2017 at 05:42:36PM +0100, Marc Gonzalez wrote:
> >>
> >>> Requesting 100 ?s and spinning only 25 ?s is still a problem,
> >>> don't you agree?
> >>
> >> Which is why, as I've said *many* times already, that drivers are written
> >> with leaway on the delays.
> >
> > A delay 75% too short is possible. Roger that.
> >
> >> I get the impression that we're just going around in circles, and what
> >> you're trying to do is to get me to agree with your point of view.
> >> That's not going to happen, because I know the history over about the
> >> last /24/ years of kernel development (which is how long I've been
> >> involved with the kernel.)  That's almost a quarter of a century!
> >>
> >> I know how things were done years ago (which is relevant because we
> >> still have support in the kernel for these systems), and I also know the
> >> history of facilities like cpufreq - I was the one who took the work
> >> that Erik Mouw and others involved with the LART project, and turned it
> >> into something a little more generic.  The idea of dynamically scaling
> >> the CPU frequency on ARM SoCs was something that the SoC manufacturer
> >> had not even considered - it was innovative.
> >>
> >> I know that udelay() can return short delays when used in a kernel with
> >> cpufreq enabled, and I also know that's almost an impossible problem to
> >> solve without going to a timer-based delay.
> >>
> >> So, when you think that sending an email about a udelay() that can be
> >> 10x shorter might be somehow new information, and might convince people
> >> that there's a problem, I'm afraid that it isn't really new information.
> >> The SA1110 cpufreq driver is dated 2001, and carries my copyright, and
> >> has the ability to make udelay()s 4x shorter or 4x longer depending on
> >> the direction of change.
> >>
> >> We've discussed solutions in the past (probably 10 years ago) about
> >> this, and what can be done, and the conclusion to that was, as Nicolas
> >> has said, to switch to using a timer-based delay mechanism where
> >> possible.  Where this is not possible, the platform is stuck with the
> >> loops based delays, and their inherent variability and inaccuracy.
> >>
> >> These platforms have been tested with such a setup over many years.
> >> They work even with udelay() having this behaviour, because it's a
> >> known issue and drivers cater for it in ways that I've already covered
> >> in my many previous emails to you.
> >>
> >> These issues are known.  They've been known for the last 15 odd years.
> >
> > So you've known for umpteen years that fixing loop-based delays is
> > intractable, yet you wrote:
> >
> >> udelay() needs to offer a consistent interface so that drivers know
> >> what to expect no matter what the implementation is.  Making one
> >> implementation conform to your ideas while leaving the other
> >> implementations with other expectations is a recipe for bugs.
> >>
> >> If you really want to do this, fix the loops_per_jiffy implementation
> >> as well so that the consistency is maintained.
> >
> > In other words, "I'll consider your patch as soon as Hell freezes over".
> >
> > Roger that. I'll drop the subject then.
> 
> Presumably, though, you could introduce a new API like:
> 
>   udelay_atleast()
> 
> That was guaranteed to delay at least the given number of
> microseconds.  Unlike the current udelay(), the new udelay_atleast()
> wouldn't really try that hard to get a delay that's approximately the
> one requested, it would just guarantee not to ever delay _less_ than
> the amount requested.

I look forward to reviewing your implementation.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
