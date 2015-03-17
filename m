From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Mar 2015 10:26:23 +0000
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <20150317102623.GS8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 17, 2015 at 03:48:38AM +0000, Chris Brandt wrote:
> I've been running XIP_KERNEL with linux-3.14 on a Renesas RZ/A1 (ARCH_R7S72100) for a while now (with some bug fixes of course) so I thought I'd see if my fixes should be pushed back upstream.
> 
> However, I see that all the Renesas parts are being moved to ARCH_MULTIPLATFORM, which by means of arch/arm/Kconfig disallows XIP_KERNEL.
> 
> Looking back through the mailing list archives I see that there was some discussion on this, but never really a conclusion.
> 
> So my question is basically: What is the correct configuration to use XIP_KERNEL with a Renesas SoC? Is the idea that I need to go carve up my own config and do everything outside the normal tree from here on out?

I think we need to re-think our Kconfig approach towards multiplatform.

As seems to be far too common, we charge headlong towards some wonderful
modern structure and decide that the old structure is plainly bad and
somehow disgusting.  While I can see that reasoning, in part in this
instance that was due to XIP not seeming to have many users (and its
only users were old platforms which were never really going to convert to
multiplatform) so it did seem sane to disallow XIP.

One thing which the whole multiplatform/DT project has taught me though
is that the above approach is virtually always wrong.  We've run into it
over ATAGs and we've run into it over Kconfig symbols.  The "eww, legacy,
that's disgusting" crap really needs to stop and a more balanced view is
necessary.  What we _should_ be doing (imho) is celebrating legacy stuff.
It's what got us to where we are today.  More importantly though, when it
was written, it was written with the same intentions that we write modern
code.  What we view today as wonderful code will be tomorrow's legacy code,
and we'll probably be going "eww, legacy" at it again!

We've run into the need a few times now to allow a SoC family converted to
multiplatform to also be chosen using the previous non-multiplatform
behaviour.

What I believe is that rather than ripping out the old platform choices,
we should have augmented them with the multiplatform support instead.
We could then make the big choice statement either include a multiplatform
option, or we could disable it when multiplatform was enabled.  More
importantly, we would still have the ability to turn multiplatform off
and target just one SoC family along with allowing things like XIP.

Yes, it would've been slightly longer winded to achieve, but it's do-able.

1. Convert all choice config symbols to (ARCH|MACH)_SP_foo.
2. Convert all multiplatform config symbols to (ARCH|MACH)_MP_foo.
3. Add (ARCH|MACH)_foo which would be selected by the corresponding above
   two symbols.

We then have a way to either select a SoC family as part of the multi
platform project, or as a stand-alone platform for things like old noMMU
and XIP.

The problem with this approach is we end up breaking everyone's config
file - because "make oldconfig" has no way to work out that it a
reference to ARCH_foo should select ARCH_[MS]P_foo instead - so we'd end
up with no platforms selected.  That can be worked around with a
progressive approach to converting this stuff in a way that ensures we
gain the new symbols in people's defconfigs before we switch things
around.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
