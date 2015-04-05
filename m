From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 5 Apr 2015 23:44:55 +0100
Subject: [PATCH v4 07/11] ARM: allow MULTIPLATFORM with !MMU
In-Reply-To: <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
References: <1428090292-21693-1-git-send-email-stefan@agner.ch>
 <1428090292-21693-8-git-send-email-stefan@agner.ch>
 <20150403200931.GD13898@n2100.arm.linux.org.uk>
 <1f84d767d3bb8a8c470a26064cba454e@agner.ch>
 <20150405161014.GG13898@n2100.arm.linux.org.uk>
 <24394c50bcd8000c21aca0360fd20b6f@agner.ch>
Message-ID: <20150405224455.GB12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 06, 2015 at 12:19:43AM +0200, Stefan Agner wrote:
> On 2015-04-05 18:10, Russell King - ARM Linux wrote:
> > config ARM_SINGLE_ARMV7M
> > 	bool "ARM architecture v7M compliant (Cortex-M0/M3/M4) SoC"
> > 	depends on !MMU
> > 	select ARM_NVIC
> > 	... etc ...
> 
> I guess that would be ARCH_SINGLE_ARMV7M?

No, I meant ARM_SINGLE_xxx

> > which then allows a /multiplatform/ v7M kernel to be built, allowing the
> > selection of EFM32, SOC_VF610, and any other v7M compliant SoC.
> 
> In my view, that wouldn't end up being much different than what that
> patchset is doing:

It's different.  It's different because we are _not_ enabling multiplatform.
Multiplatform brings with it all the MMU-full stuff that we don't want on
!MMU.

You're thinking far too specifically about V7M here.  We have other !MMU
CPUs, such as ARM946 and ARM940 which are older generation mmuless CPUs.

The problem with the ARCH_MULTI_V7M approach is that they're V4T and V5
CPUs, and we _really_ don't want to enable ARCH_MULTI_V4T and
ARCH_MULTI_V5.  If we did that, we'll allow _every_ V4T and V5
multiplatform to be selected, whether they're compatible with nommu
or not - and whether they're compatible with each other or not.

So, that kind of solution _doesn't_ scale to what we _once_ already
allowed.

> As far as I can tell, this is already the case with that patchset.

What I'm trying to do here is to fix the cockup that the multiplatform
conversion has created with previous generation noMMU and restore it
back to where it should be without excluding the newer stuff from it.

What you're interested in is just the newer stuff.  You're approaching
the problem from a different angle and thinking that your solution is
the best.  I'm saying it has deficiencies.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
