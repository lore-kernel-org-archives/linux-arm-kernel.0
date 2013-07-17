From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 17 Jul 2013 16:52:42 -0600
Subject: [PATCH] ASoC: tegra: depend on ARCH_TEGRA, not ARCH_TEGRA_*
In-Reply-To: <20130717223309.GZ22506@sirena.org.uk>
References: <1374013667-21435-1-git-send-email-swarren@wwwdotorg.org>
 <20130717083003.GA22506@sirena.org.uk> <51E6CDEA.7060003@wwwdotorg.org>
 <20130717175701.GY22506@sirena.org.uk> <51E6E107.8020300@wwwdotorg.org>
 <20130717223309.GZ22506@sirena.org.uk>
Message-ID: <51E7203A.2020007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 04:33 PM, Mark Brown wrote:
> On Wed, Jul 17, 2013 at 12:23:03PM -0600, Stephen Warren wrote:
>> On 07/17/2013 11:57 AM, Mark Brown wrote:
> 
>>> So how do they disable the core support for the older SoCs with
>>> the new model?
> 
>> They don't; the core support is so small it's not worth having
>> the ifdefs in it; just a few K. As such, it seems simpler to just
>> always compile in the core support, and remove the need for all
>> the ifdef nests in mach-tegra/. The bulk of the differences are
>> different drivers for different chips.
> 
> So my take on that is that it seems like it's simpler to just have
> the core selection since that's just one option for the user to
> choose and save all the space for whatever device they're not
> interested in rather than having to go through individual drivers
> disabling the boring SoCs. It seems more straightfoward from a UI
> point of view but perhaps I'm not thinking about it from the right
> angle?

Ah, so you mean keep the options in mach-tegra/Kconfig so that there's
a single place to configure per-SoC support, but just ignore those
options in code (like the Tegra CPU reset vector) where it's not worth
it. That sounds reasonable.

The one remaining issue is that we have plenty of HW module whose
driver works across multiple HW generations. For example,
tegra20_i2s.c supports only Tegra20, yet tegra30_i2s.c supports both
Tegra30 and Tegra114, and likely will support other generations too.
The key to enable tegra30_i2s.c should really be ARCH_TEGRA_3x_SOC ||
ARCH_TEGRA_114_SOC, which gets a bit unwieldy once you have, say, 4
different SoCs in that list and a similar list starts to apply to a
lot of different HW-modules/drivers. Even creating an
ARCH_TEGRA_30_OR_LATER_SOC will get problematic, since defining "or
later" will likely become progressively more complex over time, as we
start putting our more SoCs. What are your thoughts on the best way to
solve that?
