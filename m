From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 16 Jan 2014 11:26:17 -0800
Subject: [PATCH v5 2/4] devicetree: bindings: Document Krait CPU/L1 EDAC
In-Reply-To: <20140116183326.GG25540@e102568-lin.cambridge.arm.com>
References: <1389735034-21430-1-git-send-email-sboyd@codeaurora.org>
 <1389735034-21430-3-git-send-email-sboyd@codeaurora.org>
 <20140115102701.GA27314@e102568-lin.cambridge.arm.com>
 <20140115165623.GJ14405@codeaurora.org>
 <20140116013840.GA674@codeaurora.org>
 <20140116113332.GC25540@e102568-lin.cambridge.arm.com>
 <20140116180505.GA30925@codeaurora.org>
 <20140116183326.GG25540@e102568-lin.cambridge.arm.com>
Message-ID: <20140116192617.GA13785@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16, Lorenzo Pieralisi wrote:
> On Thu, Jan 16, 2014 at 06:05:05PM +0000, Stephen Boyd wrote:
> > On 01/16, Lorenzo Pieralisi wrote:
> > > Do we really want to do that ? I am not sure. A cpus node is supposed to
> > > be a container node, we should not define this binding just because we
> > > know the kernel creates a platform device for it then.
> > 
> > This is just copying more of the ePAPR spec into this document.
> > It just so happens that having a compatible field here allows a
> > platform device to be created. I don't see why that's a problem.
> 
> I do not see why you cannot define a node like pmu or arch-timer and stick
> a compatible property in there. cpus node does not represent a device, and
> must not be created as a platform device, that's my opinion.
> 

I had what you're suggesting before in the original revision of
this patch. Please take a look at the original patch series[1]. I
suppose it could be tweaked slightly to still have a cache node
for the L2 interrupt and the next-level-cache pointer from the
CPUs.

> What would you do for big.LITTLE systems ? We are going to create two
> cpus node because we need two platform devices ? I really think there
> must be a better way to implement this, but I will let DT maintainers
> make a decision.

There is no such thing as big.LITTLE for Krait, so this is not a
concern.

> 
> > > interrupts is a cpu node property and I think it should be kept as such.
> > > 
> > > I know it will be duplicated and I know you can't rely on a platform
> > > device for probing (since if I am not mistaken, removing a compatible
> > > string from cpus prevents its platform device creation), but that's an issue
> > > related to how the kernel works, you should not define DT bindings to solve
> > > that IMHO.
> > 
> > The interrupts property is also common for all cpus so it seems
> > fine to collapse the value down into a PPI specifier indicating
> > that all CPUs get the interrupt, similar to how we compress the
> > information about the compatible string.
> 
> I think it is nicer to create a device node (as I said, like a pmu or an
> arch-timer) and define interrupts there along with a proper compatible
> property. This would serve the same purpose without adding properties in
> the cpus node.
> 
> cpu-edac {
> 	compatible = "qcom,cpu-edac";
> 	interrupts = <...>;
> };

Yes, please see the original thread.

[1] https://lkml.org/lkml/2013/10/29/134

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
