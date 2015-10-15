From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 15 Oct 2015 10:09:27 +0100
Subject: l2c: Kernel panic in l2c310_enable() in non-secure mode
In-Reply-To: <561F6A52.70706@sigmadesigns.com>
References: <561E6407.6000002@sigmadesigns.com>
 <561E6B1F.1070701@sigmadesigns.com>
 <CAL_Jsq+GMui-ztROeJ8zg06E+SuJ9+JSnpotHA0OcD3ZhCj4Uw@mail.gmail.com>
 <561F6A52.70706@sigmadesigns.com>
Message-ID: <20151015090927.GZ32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 10:56:50AM +0200, Marc Gonzalez wrote:
> On 14/10/2015 19:06, Rob Herring wrote:
> 
> > Yes, FLOZ has to be enabled after enabling the L2 and disabled before
> > disabling the L2.
> 
> Is FLOZ merely a performance optimization?
> 
> Have you (or someone else) measured the impact of having it enabled vs
> disabled?

FLZ is a performance optimisation.  It allows the Cortex-A9 to indicate
to a L2 cache that an entire cache line should be zeroed, rather than
having the Cortex A9 write each word with zero.  As this uses non-AXI
compliant signalling, it needs to be enabled in two locations.

The enable bit in the L2 cache enables reception of this signalling.
This will only have an effect when both the L2 FLZ enable bit _and_
the L2 cache are both enabled, so the signalling can only be interpreted
by an appropriately configured and enabled L2 cache controller.

After that, the Cortex A9 FLZ enable bit can be set to allow the CA9 to
generate the non-standard signalling.  This enables the CA9 to generate
the non-standard signalling, and stops it generating the individual word
writes.

Enabling the CA9 first results in the non-standard signalling being used
but nothing on the bus can interpret it, which causes data corruption.

So, performance wise it's beneficial for zero initialising memory.

If you can't write to the Cortex A9 auxiliary control register, then you
can't use this feature, and discussing the performance impact of having
the feature disabled is irrelevant.

> >> I suppose a work-around might be to set NSACR[18]?
> > 
> > You may find you need that anyway for control of the SMP bit if you
> > shut off cores.
> 
> NSACR[18] == NSACR.NS_SMP
> 
> Usage constraints
> The ACTLR is: [...] RW in Non-secure state if NSACR.NS_SMP = 1.
> In this case all bits are Write Ignore except for the SMP bit.
> 
> Thus, even if my firmware sets NSACR.NS_SMP, Linux won't be able to
> set bits 1,2,3 in ACTLR.

However, at _least_ the ACTLR write won't fault.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
