From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Jun 2012 16:35:46 -0600
Subject: [PATCH 3/3] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <20120624110306.GA16455@sirena.org.uk>
References: <1340406842-27135-1-git-send-email-swarren@wwwdotorg.org>
 <1340406842-27135-3-git-send-email-swarren@wwwdotorg.org>
 <1963397.cqAXgGafFs@ax5200p> <20120624110306.GA16455@sirena.org.uk>
Message-ID: <4FEA3942.9040906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24/2012 05:03 AM, Mark Brown wrote:
> On Sat, Jun 23, 2012 at 06:35:01PM +0200, Marc Dietrich wrote:
> 
>>> The regulator configurations were all taken from the AC100 kernel used by
>>> the Ubuntu port, specifically:
> 
> These generally all look pretty broken...
> 
>>> +				regulator at 0 {
>>> +					reg = <0>;
>>> +					regulator-compatible = "sm0";
>>> +					regulator-name = "+1.2vs_sm0";
>>> +					regulator-min-microvolt = < 725000>;
>>> +					regulator-max-microvolt = <1300000>;
> 
> Most of these ranges look suspiciously like the maximum possible
> variation the regulator has, not what the board actually requires (which
> is a depressingly common error, I've no idea why people seem to think
> they're supposed to cut'n'paste the physical limits of the regualtor out
> of the driver).  If something decides to take advantage of the variation
> this could be problematic.

So I think this sm0 (and the sm1) entry might actually be correct; sm0
feeds vdd_core and sm1 feeds vdd_cpu. These rails have DVFS and hence
the voltage can vary. I guess I should change the regulator-name in
these cases to something more useful than the very first signal name on
the schematics too.

That said, we don't actually have DVFS in the mainline kernel yet, and
correlating the regulator limits in our downstream kernels against the
DVFS tables we use is ... challenging; I'm not sure they're consistent
anyway:-(

However, it probably doesn't make sense to vary sm2, since all that is
used for is to feed the TPS6586x's input pins for the the LDO regulators.

Likewise, all the LDO regulators are used for various peripherals in
general, and in the main it probably makes no sense for those rails to vary.

So, what I think I'll do for any regulators where the downstream board
files specify a voltage range, is boot the kernel and find out what
voltage is selected by default, and program both min-/max-microvolt to
that specific value. That way, there will be no behaviour change. We can
expand the ranges on the regulators later if/when we add DVFS etc. Does
that sound like a reasonable approach?
