From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Sep 2014 17:03:39 +0100
Subject: [PATCH v8 1/4] pci:host: APM X-Gene PCIe host controller driver
In-Reply-To: <CACoXjckWYhe=PpWE+xYSC9Q72FyAq__3uUh2gGeGtgpC5SrpzQ@mail.gmail.com>
References: <1410476266-29426-1-git-send-email-tinamdar@apm.com>
 <1410476266-29426-2-git-send-email-tinamdar@apm.com>
 <20140912091816.GU27864@e106497-lin.cambridge.arm.com>
 <CACoXjckWYhe=PpWE+xYSC9Q72FyAq__3uUh2gGeGtgpC5SrpzQ@mail.gmail.com>
Message-ID: <20140917160337.GA15261@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 09:02:11PM +0100, Tanmay Inamdar wrote:
> On Fri, Sep 12, 2014 at 2:18 AM, Liviu Dudau <Liviu.Dudau@arm.com> wrote:
> > On Thu, Sep 11, 2014 at 11:57:43PM +0100, Tanmay Inamdar wrote:
> >> This patch adds the AppliedMicro X-Gene SOC PCIe host controller driver.
> >> X-Gene PCIe controller supports maximum up to 8 lanes and GEN3 speed.
> >> X-Gene SOC supports maximum 5 PCIe ports.
> >>
> >> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
> >
> > It looks good to me now. You can add if you care:
> >
> > Reviewed-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> I will have to send another version of patch as I forgot to add
> 'dma-coherent' in device tree entry.
> 
> Secondly I see that setting 'dma-coherent' in device tree node sets
> coherent_dma_ops for the root bus but for the endpoint another 'dev'
> gets assigned. This causes endpoint to use non-coherent dma apis
> causing failure in dma operations.

For PCIe, setting dma-coherent in the DT nodes wouldn't have any effect
yet. We have of_dma_configure() being called for platform devices but it
won't work for PCIe which are probed at run-time (nor for AMBA which
require an additional patch).

So for arm64 currently we have some hooks in dma-mapping.c to intercept
when a device is added to a bus. What I need to do though is check
recursively whether the parent (bus) had the 'dma-coherent' property
(pointed out by Jon). I think something like this would do (not tested):

diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
index 4164c5ace9f8..638475378f94 100644
--- a/arch/arm64/mm/dma-mapping.c
+++ b/arch/arm64/mm/dma-mapping.c
@@ -316,7 +316,7 @@ static int dma_bus_notifier(struct notifier_block *nb,
 	if (event != BUS_NOTIFY_ADD_DEVICE)
 		return NOTIFY_DONE;
 
-	if (of_property_read_bool(dev->of_node, "dma-coherent"))
+	if (of_dma_is_coherent(dev->of_node))
 		set_dma_ops(dev, &coherent_swiotlb_dma_ops);
 
 	return NOTIFY_OK;

After this, we need to a bus notifier for PCIe as well. Since I don't
think we have an of_node for a PCI device, we would need to check
recursively on the parent device rather than the parent node until we
find an OF node with the 'dma-coherent' property.

-- 
Catalin
