From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 22 Mar 2012 14:20:09 +0000
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <CAOh2x=k6ZfamB8DnPgVPjxZ7E1gTuHOQYg6s1Nd1ybA+TSquWA@mail.gmail.com>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <201203211236.37891.arnd@arndb.de>
 <CAOh2x=k6ZfamB8DnPgVPjxZ7E1gTuHOQYg6s1Nd1ybA+TSquWA@mail.gmail.com>
Message-ID: <201203221420.10127.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 22 March 2012, viresh kumar wrote:
> On Mar 21, 2012 6:09 PM, "Arnd Bergmann" <arnd@arndb.de> wrote:
> > Regarding the spear3xx patches, I'm looking forward to your patches.
> > I think spear is simple and clean enough that it can serve as an example
> > for others doing DT conversion.
> 
> I was doing DT stuff for 3xx and have a doubt
> regarding DT. How are boards identified at runtime now? Earlier we had
> machine_is_*() to do that.

The direct replacement is of_machine_is_compatible(), but there are a lot
of cases where it's better to have a local property in the device node
that a driver is using.

For instance, in case of your clock driver, I would suggest you use
the "compatible" property of the clock device node, and do

/* null terminated array, turn the lookups into null termination as well */
struct of_device_id spear_clock_match = {
	{ "st,spear300-clock", &spear300_clk_lookups },
	{ "st,spear310-clock", &spear310_clk_lookups },
	{ "st,spear320-clock", &spear320_clk_lookups },
	{ },
};

void __init spear3xx_of_clk_init(void)
{
	struct device_node *np;
	struct of_device_id *match;
	struct clk_lookup *lookup;

	for_each_matching_node(np, &spear_clock_match)
		match = of_match_node(&spear_clock_match, np);

	for (lookup = match->data; lookup->clk; lookup++)
		clk_register(lookup);

	for (lookup = spear_clk_lookups; lookup->clk; lookup++)
		clk_register(lookup);
}

> Also why are both DT_MACHINE_START and MACHINE_START present on some SoC's?

This is for the transition phase where you want to be able to boot both
using ATAG and using DT.

	Arnd
