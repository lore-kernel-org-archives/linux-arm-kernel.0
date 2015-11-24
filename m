From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Nov 2015 14:00:47 +0000
Subject: [RFC/PATCH 0/3] ARM: Use udiv/sdiv for __aeabi_{u}idiv library
 functions
In-Reply-To: <yw1xk2p7r371.fsf@unicorn.mansr.com>
References: <1448068997-26631-1-git-send-email-sboyd@codeaurora.org>
 <20151124001306.GI19156@codeaurora.org>
 <20151124085349.GQ19156@codeaurora.org>
 <4485320.CGMJdfZLya@wuerfel>
 <20151124104225.GA8644@n2100.arm.linux.org.uk>
 <yw1xsi3vr42t.fsf@unicorn.mansr.com>
 <20151124122308.GB8644@n2100.arm.linux.org.uk>
 <yw1xk2p7r371.fsf@unicorn.mansr.com>
Message-ID: <20151124140047.GC8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 24, 2015 at 12:29:06PM +0000, M?ns Rullg?rd wrote:
> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> 
> > On Tue, Nov 24, 2015 at 12:10:02PM +0000, M?ns Rullg?rd wrote:
> >> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
> >> 
> >> > On Tue, Nov 24, 2015 at 11:38:53AM +0100, Arnd Bergmann wrote:
> >> >> I suggested using -mcpu=cortex-a15 because there are old gcc versions
> >> >> that don't know about -march=armv7ve or -march=armv7-a+idiv yet, but
> >> >> that do understand -mcpu=cortex-a15.
> >> >
> >> > That's not all.  The bigger problem is that there are toolchains out
> >> > there which accept these options, but do _not_ support IDIV in either
> >> > ARM or Thumb mode.  I'm afraid that makes it impossible to add this
> >> > feature to the mainline kernel in this form: we need to run a test
> >> > build to check that -march=armv7ve or what-not really does work
> >> > through both GCC and GAS.
> >> 
> >> If the compiler accepts the option but doesn't actually emit any div
> >> instructions, is there any real harm?
> >
> > That's not what I've found.  I've found that asking the assembler
> > to accept idiv instructions appears to be ignored, which is something
> > completely different.
> >
> > Further to this, what it comes down to is the stupid idea that the
> > compiler should embed .arch / .cpu in the assembly output, which has
> > the effect of overriding the command line arguments given to it via
> > -Wa.  So, giving -Wa,-mcpu=cortex-a15 is a total no-op, because the
> > first thing in the assembly output is:
> >
> > 	.arch armv7-a
> >
> > which kills off any attempt to set the assembly level ISA from the
> > command line.
> 
> Oh, you mean the compiler knows about the instructions but the assembler
> doesn't or isn't passed the right options.  It's infuriating when that
> happens.

No, that isn't what I meant.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
