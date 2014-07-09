From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 9 Jul 2014 14:56:14 +0200
Subject: [PATCH 6/9] ARM: tegra: Export tegra_powergate_power_on
In-Reply-To: <20140709124344.GK23218@tbergstrom-lnx.Nvidia.com>
References: <53A3096B.1040409@wwwdotorg.org>
 <20140623101441.GU3407@tbergstrom-lnx.Nvidia.com>
 <20140708130501.GC9516@ulmo>
 <20140708141135.GC23218@tbergstrom-lnx.Nvidia.com>
 <20140709063130.GA3170@ulmo>
 <20140709083311.GE23218@tbergstrom-lnx.Nvidia.com>
 <20140709102551.GA19357@ulmo>
 <20140709110816.GF23218@tbergstrom-lnx.Nvidia.com>
 <20140709120400.GA3819@ulmo>
 <20140709124344.GK23218@tbergstrom-lnx.Nvidia.com>
Message-ID: <20140709125613.GA3262@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 09, 2014 at 03:43:44PM +0300, Peter De Schrijver wrote:
> On Wed, Jul 09, 2014 at 02:04:02PM +0200, Thierry Reding wrote:
> > > For those 2 domains we can find the necessary clocks and resets by parsing
> > > the relevant existing DT nodes for PCIe and gr3d. For clocks, this isn't
> > > even needed as we can always register some extra clkdev's to get them. There
> > > is no equivalent for resets so we have to parse the gr3d and pcie DT nodes,
> > > but that's not too bad I think.
> > 
> > Even if we could really do this, at this point I don't see an advantage.
> > All that it would be doing is move to some subsystem that doesn't quite
> > match what we need just for the sake of moving to that subsystem. Having
> > a Tegra-specific API doesn't sound so bad anymore.
> > 
> 
> The advantage would be that we can use LP0/SC7 as a cpuidle state.

How is that going to work? And why does it need powergates to be
implemented as power domains? If we switch off power gates, then we need
to restore context in the drivers anyway, therefore I assume .suspend()
and .resume() would need to be called, in which case powergate handling
can surely be done at that stage, can't it?

> Also system
> resume from LP0 can be faster as we potentially don't have to resume all
> domains at once.

I don't understand what that's got to do with anything. If we call into
the PMC driver explicitly via tegra_powergate_*() functions from driver
code, then we have full control over suspend/resume in the drivers, and
therefore don't need to resume all at once either.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140709/0899cb01/attachment.sig>
