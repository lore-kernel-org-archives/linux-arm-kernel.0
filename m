From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Sep 2014 20:34:53 +0100
Subject: [PATCH v10 03/19] arm: fiq: Replace default FIQ handler
In-Reply-To: <5406EBAA.9040206@linaro.org>
References: <1408369264-14242-1-git-send-email-daniel.thompson@linaro.org>
 <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1408466769-20004-4-git-send-email-daniel.thompson@linaro.org>
 <20140819173742.GG30401@n2100.arm.linux.org.uk> <53F39377.1070308@linaro.org>
 <20140828150112.GD30401@n2100.arm.linux.org.uk> <5405AEBC.9020904@linaro.org>
 <20140902164204.GT30401@n2100.arm.linux.org.uk> <5406EBAA.9040206@linaro.org>
Message-ID: <20140903193453.GA30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 03, 2014 at 11:21:30AM +0100, Daniel Thompson wrote:
> On 02/09/14 17:42, Russell King - ARM Linux wrote:
> > Yes, it does, because unlike the x86 community, we have a wide range
> > of platforms, and platform code does not go through the same path or
> > get the same review as core ARM code.
> > 
> > As I already pointed out, with a notifier, it's very easy to sneak
> > something into the FIQ path by submitting a patch for platform code
> > which calls the registration function.  That's going to be pretty
> > difficult to spot amongst the 3000+ messages on the linux-arm-kernel
> > list each month in order to give it the review that it would need.
> > That's especially true as I now ignore almost all most platform
> > code patches as we have Arnd and Olof to look at that.
> > 
> > So, unless you can come up with a proposal which ensures that there
> > is sufficient review triggered when someone decides to call the
> > notifier registration function...
> 
> Reflecting upon this and upon Thomas' comments about only using FIQ for
> watchdog, backtrace and performance monitoring...
> 
> The short version is, "I was wrong and should have done what you said in
> the first place".
> 
> The long version adds, "because the coupling concerns were spurious; the
> only proposed users of the default FIQ handler outside of core ARM code,
> are ARM-centric irqchip drivers."

I would say that the ARM specific changes to entry-armv.S and setup.c
are correct.  All that you're doing there is to replace the existing
default no-op FIQ handler with some additional code which gets us into
SVC mode and back out, but itself is also a no-op.  In other words, no
real change.

That's a good first patch, and one which I would actually like to have
in my tree sooner rather than later, so that I can split that out from
my prototype code.

I can also split out from it the ARM generic changes for implementing
the FIQ dumping too, which gives us a second patch.  With a bit of
additional work, much of that should actually be generic code, not
ARM or x86 specific code.  That's going to annoy x86 people a little
because some of that is being reworked...

That will leave the problem of how to deal with the IRQ controller
specifics, and how to properly wire it together with the IRQ controller
in the loop - that is where Thomas' concerns are focused.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
