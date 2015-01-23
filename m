From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 23 Jan 2015 12:22:44 +0000
Subject: [PATCH] arm64: dts: Add initial device tree support for Tegra132
In-Reply-To: <54C23B08.6070503@nvidia.com>
References: <alpine.DEB.2.02.1501161139180.9776@utopia.booyaka.com>
 <20150121161313.GI5044@leverpostej>
 <alpine.DEB.2.02.1501231038130.5450@utopia.booyaka.com>
 <54C23B08.6070503@nvidia.com>
Message-ID: <20150123122244.GJ23493@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 12:14:00PM +0000, Arto Merilainen wrote:
> Hi all,
> 
> On 01/23/2015 01:31 PM, Paul Walmsley wrote:
> > + Arto, Terje for comments on the host1x section
> > + Stephen Warren for comments on the serial DT data
> >
> > Hi Mark,
> >
> > thanks for the review.
> >
> > On Wed, 21 Jan 2015, Mark Rutland wrote:
> >
> >> As mentioned in my reply to the DT list patch [1], there are a couple of
> >> bits I'd like to see cleaned up first, but in the meantime I have some
> >> comments from my first pass of the dtsi below. Some of these may equally
> >> apply to existing dts(i) files.
> >>
> >> I see a few undocumented compatible strings (at least when comparing
> >> against mainline). If there are other series or trees I should be
> >> looking at, any pointers would be appreciated. If not, documentation
> >> updates would be nice (checkpatch should complain otherwise).
> >
> > (discussed in the tegra132-pcie comments below)
> >
> >>
> >> On Fri, Jan 16, 2015 at 11:45:29AM +0000, Paul Walmsley wrote:
> >>> +       host1x at 0,50000000 {
> >>> +               compatible = "nvidia,tegra132-host1x", "nvidia,tegra124-host1x", "simple-bus";
> >>
> >> Regarding simple-bus, are the sub-nodes usable if this didn't probe as
> >> "nvidia,tegra124-host1x" or "nvidia,tegra132-host1x"?
> >> Do the subnodes require anything from this node?
> >>
> >> It looks like we expect/require the host1x node to be probed and
> >> initialised before we probe the children. Which would imply the
> >> simple-bus annotation is wrong.
> >
> > Haven't tried booting with just simple-bus here.  I believe these devices
> > are accessible without the involvement of host1x.  In other words, host1x
> > is not a bus; I believe it might be most accurately described as a type of
> > DMA controller.  So in theory it should be possible for the CPU complex to
> > read and write to these devices directly without the involvement of
> > host1x, although I believe NVIDIA discourages this.
> >
> > Under the theory that DT data should be hardware-specific, not
> > software-specific, in an ideal world I think we would list these devices
> > outside the embrace of the host1x node.  However the existing Tegra124 DT
> > file listed them together, and I am unsure whether that is required for
> > the host1x code to function correctly.
> >
> > Arto may be able to comment further.
> 
> Placing the devices behind host1x is an accurate description of 
> hardware: Despite the direct register access path (writel/readl 
> targeting a host1x client device) is transparent to the CPU, the host1x 
> hardware is internally handling the requests and passing them forward to 
> the host1x client in interest.
> 
> Above implies also a strict parent-child dependency on hardware level: 
> If the CPU tries to access a register in a host1x client before the 
> host1x clock has been enabled, host1x will not be able to forward the 
> requests and the access will fail. This also defines the importance of 
> probe order (i.e. host1x must be initialized before client devices).

In that case, it sounds like the "simple-bus" string is bogus unless the
host1x is at minimum pre-initialised by some firmware and/or bootloader
into a state where the child devices could theoretically be used on
their own.

So I think "simple-bus" should be dropped here.

> In addition, the host1x indirect register programming path ("channel 
> path") is operational only for the host1x client devices and our current 
> host1x driver relies on parent-child relationship in device tree.

So I guess this is more Linux-specific, but still adds to the fuel for
removing "simple-bus" here.

Thanks,
Mark.
