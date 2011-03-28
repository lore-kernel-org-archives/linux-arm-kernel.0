From: B29396@freescale.com (Dong Aisheng-B29396)
Date: Mon, 28 Mar 2011 04:48:13 +0000
Subject: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash issue
In-Reply-To: <19851.19831.866814.522361@pilspetsen.it.uu.se>
References: <1300965400-28304-1-git-send-email-b29396@freescale.com>
	<19851.19831.866814.522361@pilspetsen.it.uu.se>
Message-ID: <65EE16ACC360FA4D99C96DC085B3F77214AB6F@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Mikael Pettersson [mailto:mikpe at it.uu.se]
> Sent: Thursday, March 24, 2011 9:56 PM
> To: Dong Aisheng-B29396
> Cc: linux-arm-kernel at lists.infradead.org; linux at arm.linux.org.uk
> Subject: Re: [PATCH 1/1] ARM: dmabounce: fix dmabounce may cause crash
> issue
> 
> Aisheng.Dong writes:
>  >  static inline dma_addr_t map_single(struct device *dev, void *ptr,
> size_t size,
>  >  		enum dma_data_direction dir)
>  >  {
>  > -	struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
>  > +	struct dmabounce_device_info *device_info;
>  >  	dma_addr_t dma_addr;
>  >  	int needs_bounce = 0;
>  >
>  > +	if (dev)
>  > +		device_info = dev->archdata.dmabounce;
>  > +
>  >  	if (device_info)
>  >  		DO_STATS ( device_info->map_op_count++ );
> 
> If dev == NULL then device_info is uninitialized in this if-test.
> (gcc should have warned about that.  Did it?)
I did not see gcc warning with -Wall, maybe caused by inline and -O2 option.
(Without inclined it, I could see the warning)
Anyway, I think you're right and we should pre-init device_info.
Thanks for the info.

> Just pre-init device_info to NULL, then you can also remove the following
> change:
> 
>  > -	if (device_info && (needs_bounce || dma_needs_bounce(dev, dma_addr,
> size))) {
>  > +	if (dev && device_info && (needs_bounce || dma_needs_bounce(dev,
> dma_addr, size))) {
