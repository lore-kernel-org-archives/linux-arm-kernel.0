From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 27 Jun 2012 00:02:36 +0100
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <4FEA3942.9040906@wwwdotorg.org>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <1340406842-27135-3-git-send-email-swarren@wwwdotorg.org>
 <1963397.cqAXgGafFs@ax5200p> <20120624110306.GA16455@sirena.org.uk>
 <4FEA3942.9040906@wwwdotorg.org>
Message-ID: <20120626230235.GX30406@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2012 at 04:35:46PM -0600, Stephen Warren wrote:

> So I think this sm0 (and the sm1) entry might actually be correct; sm0
> feeds vdd_core and sm1 feeds vdd_cpu. These rails have DVFS and hence
> the voltage can vary. I guess I should change the regulator-name in
> these cases to something more useful than the very first signal name on
> the schematics too.

Even if they feed these supplies are they capable of varying on this
board if they're shared with other things?  This is one of the common
issues with constraints...  But generally if the supply covers more than
one thing the idiomatic thing is to list them all separated by / or
something.

> That said, we don't actually have DVFS in the mainline kernel yet, and
> correlating the regulator limits in our downstream kernels against the
> DVFS tables we use is ... challenging; I'm not sure they're consistent
> anyway:-(

Well, if you're using the regulator API the regulator API limits will
win if they're more constrained.  But this is half the problem with
these silly constraints that just copy the regulator limits, you've no
idea what the board is actually supposed to do.

> However, it probably doesn't make sense to vary sm2, since all that is
> used for is to feed the TPS6586x's input pins for the the LDO regulators.

Actually if we get clever then there's some fun to be had there.  If we
can have all the LDOs specify the headroom they need then we should be
able to arrange to vary the DCDC depending on what the needs of the
currently active LDOs are which would improve power efficiency as the
goal here is to drop the voltage as much as possible using the more
efficient DCDC then regulate on from there with the LDOs.

I keep considering doing this but don't have any real need for it
myself, it's just amusing.  Might fall out of (or be similar to) some
work I'm going to be doing soon for bypass modes though.

> Likewise, all the LDO regulators are used for various peripherals in
> general, and in the main it probably makes no sense for those rails to vary.

This is typically very unusual, the devices on the rails are normally
heavily constrained when active.

> So, what I think I'll do for any regulators where the downstream board
> files specify a voltage range, is boot the kernel and find out what
> voltage is selected by default, and program both min-/max-microvolt to
> that specific value. That way, there will be no behaviour change. We can
> expand the ranges on the regulators later if/when we add DVFS etc. Does
> that sound like a reasonable approach?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120627/a89ae1f2/attachment-0001.sig>
