From: julien.grall@linaro.org (Julien Grall)
Date: Fri, 14 Mar 2014 16:50:23 +0000
Subject: [PATCH 2/2] arm/xen: Don't use xen DMA ops when the device is
 protected by an IOMMU
In-Reply-To: <alpine.DEB.2.02.1402242036490.31489@kaball.uk.xensource.com>
References: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
 <1392914159.32657.18.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1402241214570.4471@kaball.uk.xensource.com>
 <20140224151636.GA13489@kroah.com>
 <alpine.DEB.2.02.1402242036490.31489@kaball.uk.xensource.com>
Message-ID: <5323334F.90700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/24/2014 08:49 PM, Stefano Stabellini wrote:
> On Mon, 24 Feb 2014, gregkh at linuxfoundation.org wrote: 
> Julien is proposing to store the list of "safe" devices on an hash table
> in the Xen specific code (in arch/arm/xen/enlighten.c, see
> http://marc.info/?l=linux-kernel&m=139291370526082&w=2).
> Whenever Linux is about to do DMA, we would check in the hashtable to
> figure out whether we need to go through the swiotlb or we can simply
> use the native dma_ops.
> 
> Ian and I were thinking that it would be much easier and faster to have
> a "xen_safe_device" parameter in struct device and just check for that.
> It doesn't actually need to be in struct device, it could simply be a
> flag in struct device_dma_parameters as Ian was suggesting.
> 
> Julien, could you please come up with a simple patch to demonstrate the
> concept?

Hello Stefano and Greg,

Sorry for the late answer. I wrote a simple patch which depend on patch #1.
Let me know if it's the right direction.

Regards,

commit ca55e82bc191678b284792d2f0d200fa1ce08e16
Author: Julien Grall <julien.grall@linaro.org>
Date:   Fri Mar 14 16:27:01 2014 +0000

    ARM: platform_device: dev_archdata: Add xen specific boolean
    
    Until now, every DMA-capable devices are using specific Xen DMA ops when Linux
    is running as DOM0. These DMA ops call swiotlb-xen to bounce buffer.
    
    With the support of IOMMU drivers in Xen, every device protected by IOMMU
    must not use swiotlb DMA ops.
    
    This patch introduces a boolean in dev_archdata to indicate if the device
    can safely use its own DMA ops or swiotlb ops.
    
    Signed-off-by: Julien Grall <julien.grall@linaro.org>

diff --git a/arch/arm/include/asm/device.h b/arch/arm/include/asm/device.h
index dc662fc..345a96e 100644
--- a/arch/arm/include/asm/device.h
+++ b/arch/arm/include/asm/device.h
@@ -17,6 +17,9 @@ struct dev_archdata {
 #ifdef CONFIG_ARM_DMA_USE_IOMMU
        struct dma_iommu_mapping        *mapping;
 #endif
+#ifdef CONFIG_XEN
+       bool    is_protected;
+#endif
 };
 
 struct omap_device;
diff --git a/arch/arm/include/asm/xen/dma-mapping.h b/arch/arm/include/asm/xen/dma-mapping.h
index 002fc57..d6cc012 100644
--- a/arch/arm/include/asm/xen/dma-mapping.h
+++ b/arch/arm/include/asm/xen/dma-mapping.h
@@ -5,9 +5,21 @@
 
 extern struct dma_map_ops *xen_dma_ops;
 
+#ifdef CONFIG_XEN
+static inline bool xen_is_protected_device(const struct device *dev)
+{
+       return dev->archdata.is_protected;
+}
+#else
+static inline bool xen_is_protected_device(const struct device *dev)
+{
+       return 0;
+}
+#endif
+
 static inline bool need_xen_dma_ops(struct device *dev)
 {
-       return xen_initial_domain();
+       return xen_initial_domain() && !xen_is_protected_device(dev);
 }
 
 #endif /* _ASM_ARM_XEN_DMA_MAPPING_H */

-- 
Julien Grall
