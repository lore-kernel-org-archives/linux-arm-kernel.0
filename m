From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 27 Jan 2013 19:20:01 +0100
Subject: [PATCH v3 1/3] cpufreq: kirkwood: Add a cpufreq driver for
 Marvell Kirkwood SoCs
In-Reply-To: <20130127171111.GG23505@n2100.arm.linux.org.uk>
References: <1359281244-31455-1-git-send-email-andrew@lunn.ch>
 <1359281244-31455-2-git-send-email-andrew@lunn.ch>
 <20130127171111.GG23505@n2100.arm.linux.org.uk>
Message-ID: <20130127182001.GN29973@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 05:11:11PM +0000, Russell King - ARM Linux wrote:
> On Sun, Jan 27, 2013 at 11:07:22AM +0100, Andrew Lunn wrote:
> > +static struct priv
> > +{
> > +	struct clk *cpu_clk;
> > +	struct clk *ddr_clk;
> > +	struct clk *powersave_clk;
> > +	struct device *dev;
> > +	void __iomem *base;
> > +} priv;
> 
> I guess you probably think that the compiler will do something special
> with this

Nope, i expect nothing at all from the compiler. I just know i need
only one of these structures so i statically allocated it. I could
allocate it dynamically, probably get the cleanup wrong in the error
path and get shouted at by Russel King. Oh well...

> > +static unsigned int kirkwood_cpufreq_get_cpu_frequency(unsigned int cpu)
> > +{
> > +	if (__clk_is_enabled(priv.powersave_clk))
> 
> This looks to me to be a layering violation.

Possibly is. Not sure. This is a gated clock, so clk_get_rate()
returns the rate of the parent clock independent of if the gated clock
is enabled or not. So that does not help me. The cpufreq driver needs
to cause a transition on this clock, either disabled->enabled, or
enabled->disabled, then do a WFI, and once the system is stable it
wakes up. If there is no transition, it was already enabled and all
that clk_enable() does is increment the count, the WFI never exits and
the system sleeps forever. I'm assuming here that no other driver is
using this clock, which i think is a sensible assumption. But i've no
idea of the initial state of the clock. Did uboot enable it or not?

Thanks
	Andrew
