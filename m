From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 31 Mar 2011 09:09:54 +0100
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm>
References: <AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<alpine.LFD.2.00.1103301531420.28032@xanadu.home>
	<AANLkTim6zg-U6HtAQbqnENqoK7x8erXSqOuTFVC0YE5r@mail.gmail.com>
	<alpine.LFD.2.00.1103301814250.28032@xanadu.home>
	<alpine.DEB.2.00.1103301728000.15330@asgard.lang.hm>
	<alpine.LFD.2.00.1103302255280.28032@xanadu.home>
	<alpine.DEB.2.00.1103302130500.29543@asgard.lang.hm>
Message-ID: <20110331080954.GA14323@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 30, 2011 at 10:05:41PM -0700, david at lang.hm wrote:
> with ARM you do have a couple different architectures (arm5 vs arm7 for  
> example), but what you are hearing people say is that
>
> arm7+IPblock1+IPblock2
> arm7+IPblock1+IPblock3>
> arm7+IPblock2+IPblock3>
>
> are not three different architectures, they are one architecture with  
> different devices attached.

Wrong.  Let's take an example.  If you have an OMAP SoC with ARMv7 + GIC +
OMAP timer, and another SoC (eg, MSM) with GIC + their own timer, then
the common code will be used to support ARMv7 on both SoCs.

The common GIC support code will be used to talk to the GIC interrupt
controller.

The OMAP timer code will be used to handle the OMAP timer, and the MSM
timer code will be used to handle the MSM timer.

We're not crazy.  We don't have N sets of code implementing support for
the GIC interrupt controller.  Same happens for the VIC code - we have
common code supporting VIC implementations across the different SoCs
which have a VIC.

But the GIC is a totally different beast to the VIC.  The GIC is SMP
capable and has two software interfaces - the CPU local part and the
CPU global part.  The VIC doesn't have any of that as it is UP only.
They function entirely differently.  How can you have some common code
to support both of those?

> what's more, you seem to be saying that
>
> arm7+IPblock1
>
> and
>
> arm7+IPblock1
>
> are different architectures if the wiring between the arm core and  
> IPblock1 are different (they are different 'boards' or different chip  
> models, possibly from different manufacturers)

Over the years which I was overseeing platform support I tried to ensure
as much sharing of code across different platforms.  I no longer oversee
platform specific stuff, and so its entirely possible that several SoCs
have the same IP block but their own code to drive it.

That's where Thomas is right - we need a team of people to provide
review of that to catch it and get it consolidated.  Such a team would
need funding.  Where does that funding come from?  I've no idea.
This review issue is something which I've been on about for the last
ten years, and it hasn't really got much better during that time.

We also need the various SoC designers and ARM architecture people to
realise that what the hardware situation is rediculous; I have commented
about this lack of standardisation to ARM in past years.  ARM have had
a standard set of peripherals for ten years, but the SoC people haven't
really taken them up - and when they do, they seem to always introduce
their own tweaks, sometimes with no way to detect those tweaks.

So far, I've avoided merging code to change the way the driver support
works for those peripherals to allow the platform level code to describe
those differences because I don't like it.  It sounds like I should
continue to avoid merging it and, hopefully, it'll just go away.
