From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 Dec 2015 08:00:14 -0800
Subject: [PATCH 2/2] ARM: OMAP2+: Change core_initcall levels to
 postcore_initcall
In-Reply-To: <1448900789-4034-3-git-send-email-tony@atomide.com>
References: <1448900789-4034-1-git-send-email-tony@atomide.com>
 <1448900789-4034-3-git-send-email-tony@atomide.com>
Message-ID: <20151203160014.GL23396@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [151130 08:29]:
> We want to be able to probe a few selected device drivers before hwmod
> code populates the clocks in omap_hwmod_setup_all(). This allows us to
> convert most of the clock drivers into regular device drivers.
> 
> We only need a few minimal clock drivers early for the system timers to
> select between the 32KiHz clock and the high frequency oscillator.
> 
> With these changes, initializing the clock drivers can be just done at
> core_initcall time with something like:
> 
> np = of_find_node_by_name(NULL, "plls");
> if (np)
> 	of_platform_populate(np, NULL, NULL, NULL);
> 
> And then these clocks will be available for the interconnect code to use.
> 
> Having most of the clock drivers being regular device drivers allows
> us to use the nice things like devm_* functions and dev_err and dev_dbg.
> As an extra bonus, this also allows us to develop the clock drivers for
> new SoCs as loadable modules initially for cases where we can boot up
> the system based on the bootloader configured clocks.
> 
> To do this, let's change the core_initcalls to postcore_initcall under
> mach-omap2.

FYI I'm applying this one into omap-for-v4.5/soc today, the first patch
in this series needs more work as discussed.

Regards,

Tony
