From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 24 Feb 2014 20:49:49 +0000
Subject: [PATCH 2/2] arm/xen: Don't use xen DMA ops when the device is
 protected by an IOMMU
In-Reply-To: <20140224151636.GA13489@kroah.com>
References: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
 <1392914159.32657.18.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1402241214570.4471@kaball.uk.xensource.com>
 <20140224151636.GA13489@kroah.com>
Message-ID: <alpine.DEB.2.02.1402242036490.31489@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Feb 2014, gregkh at linuxfoundation.org wrote:
> On Mon, Feb 24, 2014 at 12:19:11PM +0000, Stefano Stabellini wrote:
> > CC'ing Greg.
> > 
> > On Thu, 20 Feb 2014, Ian Campbell wrote:
> > > On Thu, 2014-02-20 at 16:21 +0000, Julien Grall wrote:
> > > > Only Xen is able to know if a device can safely avoid to use xen-swiotlb.
> > > > This patch introduce a new property "protected-devices" for the hypervisor
> > > > node which list device which the IOMMU are been correctly programmed by Xen.
> > > > 
> > > > During Linux boot, Xen specific code will create an hash table which
> > > > contains all these devices. The hash table will be used in need_xen_dma_ops
> > > > to check if the Xen DMA ops needs to be used for the current device.
> > > 
> > > Is it out of the question to find a field within struct device itself to
> > > store this e.g. in struct device_dma_parameters perhaps and avoid the
> > > need for a hashtable lookup.
> > > 
> > > device->iommu_group might be another option, if we can create our own
> > > group?
> > 
> > I agree that a field in struct device would be ideal.
> > Greg, get_maintainer.pl points at you as main maintainer of device.h, do
> > you have an opinion on this?
> 
> I need a whole lot more context here please.  With a patch would be even
> better so that I know exactly what you are referring to...

The Xen hypervisor tells Linux which devices are protected by an SMMU,
preprogrammed by Xen, so that Linux can avoid the swiotlb and bounce
buffers for DMA requests involving them.
The information is present on device tree and parsed at boot time by
Linux.

Julien is proposing to store the list of "safe" devices on an hash table
in the Xen specific code (in arch/arm/xen/enlighten.c, see
http://marc.info/?l=linux-kernel&m=139291370526082&w=2).
Whenever Linux is about to do DMA, we would check in the hashtable to
figure out whether we need to go through the swiotlb or we can simply
use the native dma_ops.

Ian and I were thinking that it would be much easier and faster to have
a "xen_safe_device" parameter in struct device and just check for that.
It doesn't actually need to be in struct device, it could simply be a
flag in struct device_dma_parameters as Ian was suggesting.

Julien, could you please come up with a simple patch to demonstrate the
concept?
