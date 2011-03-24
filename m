From: mikpe@it.uu.se (Mikael Pettersson)
Date: Thu, 24 Mar 2011 14:56:07 +0100
Subject: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash issue
In-Reply-To: <1300965400-28304-1-git-send-email-b29396@freescale.com>
References: <1300965400-28304-1-git-send-email-b29396@freescale.com>
Message-ID: <19851.19831.866814.522361@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aisheng.Dong writes:
 >  static inline dma_addr_t map_single(struct device *dev, void *ptr, size_t size,
 >  		enum dma_data_direction dir)
 >  {
 > -	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
 > +	struct dmabounce_device_info *device_info;
 >  	dma_addr_t dma_addr;
 >  	int needs_bounce = 0;
 >  
 > +	if (dev)
 > +		device_info = dev->archdata.dmabounce;
 > +
 >  	if (device_info)
 >  		DO_STATS ( device_info->map_op_count++ );

If dev == NULL then device_info is uninitialized in this if-test.
(gcc should have warned about that.  Did it?)

Just pre-init device_info to NULL, then you can also remove the
following change:

 > -	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
 > +	if (dev && device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr, size))) {
