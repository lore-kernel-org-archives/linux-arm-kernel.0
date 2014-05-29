From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 29 May 2014 09:52:22 -0600
Subject: [PATCH v2] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
References: <1400877395-4235-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <538757B6.4010109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/2014 02:36 PM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> This commit introduces a generic device tree binding for IOMMU devices.
> Only a very minimal subset is described here, but it is enough to cover
> the requirements of both the Exynos System MMU and Tegra SMMU as
> discussed here:
> 
>     https://lkml.org/lkml/2014/4/27/346
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Apologies for the noise, but apparently I mistyped one of the email
> addresses, should be fixed now.
> 
> Changes in v2:
> - add notes about "dma-ranges" property (drop note from commit message)
> - document priorities of "iommus" property vs. "dma-ranges" property
> - drop #iommu-cells in favour of #address-cells and #size-cells

I think this is a mistake. address-cells/size-cells are for transactions
flowing down the bus (from the CPU to date). Describing a connection
from a device to an IOMMU is something completely different, and should
therefore simply use an iommu-cells property to describe any necessary
information. If we start re-using properties for different things in
different contexts, how is anyone going to know what they mean, and how
will conflicts be resolved. For example, what if there's a single HW
module that both acts as a regular register bus with children (where
address-cells/size-cells defines how transactions reach the children
from the parent), and is also an IOMMU (where according to this binding
proposal, address-cells/size-cells represent some aspect of the IOMMU
feature). Using different properties for different things is the only
sane way to keep different concepts separate. Another alternative would
be to represent the single HW module as separate nodes in DT, but I
think that will only make our lives harder, and where I've done that in
the past, I've regretted it.
