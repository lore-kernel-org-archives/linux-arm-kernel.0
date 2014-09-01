From: treding@nvidia.com (Thierry Reding)
Date: Mon, 1 Sep 2014 09:07:49 +0200
Subject: [PATCH 10/29] drivers: add DRIVER_HAS_OWN_IOMMU_MANAGER flag
In-Reply-To: <54040298.9020002@samsung.com>
References: <1407235677-26324-1-git-send-email-m.szyprowski@samsung.com>
 <1407235677-26324-11-git-send-email-m.szyprowski@samsung.com>
 <54040298.9020002@samsung.com>
Message-ID: <20140901070748.GA24226@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 01, 2014 at 07:22:32AM +0200, Marek Szyprowski wrote:
> Hi Greg,
> 
> On 2014-08-05 12:47, Marek Szyprowski wrote:
> > This patch adds a new flags for device drivers. This flag instructs
> > kernel that the device driver does it own management of IOMMU assisted
> > IO address space translations, so no default dma-mapping structures
> > should be initialized.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > ---
> >   include/linux/device.h | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/include/linux/device.h b/include/linux/device.h
> > index 5f4ff02..2e62371 100644
> > --- a/include/linux/device.h
> > +++ b/include/linux/device.h
> > @@ -253,6 +253,8 @@ struct device_driver {
> >   
> >   /* disables bind/unbind via sysfs */
> >   #define DRIVER_SUPPRESS_BIND_ATTRS	(1 << 0)
> > +/* driver uses own methods to manage IO address space */
> > +#define DRIVER_HAS_OWN_IOMMU_MANAGER	(1 << 1)
> >   
> >   extern int __must_check driver_register(struct device_driver *drv);
> >   extern void driver_unregister(struct device_driver *drv);
> 
> Could you comment if the approach of using flags in the struct driver
> could be accepted? I've converted suppress_bind_attrs entry to flags to
> avoid extending the structure, please see patch "[PATCH 05/29] drivers:
> convert suppress_bind_attrs parameter into flags".

Is this really necessary? What I did as part of an RFC series for Tegra
IOMMU support is keep this knowledge within the IOMMU driver rather than
export it to the driver core.

The idea being that the IOMMU driver wouldn't create an ARM DMA/IOMMU
mapping by default but rather allow individual drivers to be marked as
"kernel-internal" and use the DMA/IOMMU glue in that case. Drivers such
as DRM would use the IOMMU API directly.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140901/7b534439/attachment-0001.sig>
