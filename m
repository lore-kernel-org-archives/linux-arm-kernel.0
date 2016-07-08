From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Jul 2016 18:06:42 +0100
Subject: [PATCH v4 1/8] arm64: mm: change IOMMU notifier action to attach
 DMA ops
In-Reply-To: <20160708145521.GD6493@arm.com>
References: <cover.1467388950.git.robin.murphy@arm.com>
 <06d430a86f5d7f461308a9278bf25f40fb50d93c.1467388950.git.robin.murphy@arm.com>
 <20160708145521.GD6493@arm.com>
Message-ID: <20160708170642.GD22099@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 08, 2016 at 03:55:21PM +0100, Will Deacon wrote:
> On Fri, Jul 01, 2016 at 05:50:10PM +0100, Robin Murphy wrote:
> > From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > 
> > Current bus notifier in ARM64 (__iommu_attach_notifier)
> > attempts to attach dma_ops to a device on BUS_NOTIFY_ADD_DEVICE
> > action notification.
> > 
> > This will cause issues on ACPI based systems, where PCI devices
> > can be added before the IOMMUs the devices are attached to
> > had a chance to be probed, causing failures on attempts to
> > attach dma_ops in that the domain for the respective IOMMU
> > may not be set-up yet by the time the bus notifier is run.
> > 
> > Devices dma_ops do not require to be set-up till the matching
> > device drivers are probed. This means that instead of running
> > the notifier attaching dma_ops to devices (__iommu_attach_notifier)
> > on BUS_NOTIFY_ADD_DEVICE action, it can be run just before the
> > device driver is bound to the device in question (on action
> > BUS_NOTIFY_BIND_DRIVER) so that it is certain that its IOMMU
> > group and domain are set-up accordingly at the time the
> > notifier is triggered.
> > 
> > This patch changes the notifier action upon which dma_ops
> > are attached to devices and defer it to driver binding time,
> > so that IOMMU devices have a chance to be probed and to register
> > their bus notifiers before the dma_ops attach sequence for a
> > device is actually carried out.
> > 
> > As a result we also no longer need worry about racing with
> > iommu_bus_notifier(), or about retrying the queue in case devices
> > were added too early on DT-based systems, so clean up the notifier
> > itself plus the additional workaround from 722ec35f7fae ("arm64:
> > dma-mapping: fix handling of devices registered before arch_initcall")
> > 
> > Cc: Will Deacon <will.deacon@arm.com>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > [rm: get rid of other now-redundant bits]
> > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > ---
> > 
> > v4: No change.
> > 
> >  arch/arm64/mm/dma-mapping.c | 22 +++++-----------------
> >  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> Whilst this series is unlikely to make it for 4.8, this patch is
> independent and it would be good to see it queued in the arm64 tree for
> 4.8, if possible. It shouldn't change anything on its own, but it's a
> prerequisite for this series and anything on the IORT side from Lorenzo,
> so it makes sense to me to keep the delta down if we can.

I queued it for 4.8. Thanks.

-- 
Catalin
