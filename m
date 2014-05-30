From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 30 May 2014 09:30:08 +0200
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <538757B6.4010109@wwwdotorg.org>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
 <538757B6.4010109@wwwdotorg.org>
Message-ID: <20140530073006.GA24748@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 29, 2014 at 09:52:22AM -0600, Stephen Warren wrote:
> On 05/23/2014 02:36 PM, Thierry Reding wrote:
> > From: Thierry Reding <treding@nvidia.com>
> > 
> > This commit introduces a generic device tree binding for IOMMU devices.
> > Only a very minimal subset is described here, but it is enough to cover
> > the requirements of both the Exynos System MMU and Tegra SMMU as
> > discussed here:
> > 
> >     https://lkml.org/lkml/2014/4/27/346
> > 
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> > Apologies for the noise, but apparently I mistyped one of the email
> > addresses, should be fixed now.
> > 
> > Changes in v2:
> > - add notes about "dma-ranges" property (drop note from commit message)
> > - document priorities of "iommus" property vs. "dma-ranges" property
> > - drop #iommu-cells in favour of #address-cells and #size-cells
> 
> I think this is a mistake. address-cells/size-cells are for transactions
> flowing down the bus (from the CPU to date). Describing a connection
> from a device to an IOMMU is something completely different, and should
> therefore simply use an iommu-cells property to describe any necessary
> information. If we start re-using properties for different things in
> different contexts, how is anyone going to know what they mean, and how
> will conflicts be resolved. For example, what if there's a single HW
> module that both acts as a regular register bus with children (where
> address-cells/size-cells defines how transactions reach the children
> from the parent), and is also an IOMMU (where according to this binding
> proposal, address-cells/size-cells represent some aspect of the IOMMU
> feature). Using different properties for different things is the only
> sane way to keep different concepts separate. Another alternative would
> be to represent the single HW module as separate nodes in DT, but I
> think that will only make our lives harder, and where I've done that in
> the past, I've regretted it.

There was some back-and-forth on this topic and the latest concensus
when I wrote the second version was that #address-cells and #size-cells
were to be used.

But there was some bore back-and-forth after that, and it seems like
Arnd no longer thinks that using #address-cells and #size-cells is a
good idea either[0].

Arnd, can you take another look at this binding and see if there's
anything else missing? If not I'll go through the document again and
update all #address-cells/#size-cells references with #iommu-cells as
appropriate and submit v3.

Thanks,
Thierry

[0]: https://lkml.org/lkml/2014/5/20/609
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140530/6cf2a62b/attachment.sig>
