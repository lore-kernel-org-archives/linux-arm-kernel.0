From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 06 Sep 2013 11:12:58 +0200
Subject: kmalloc memory slower than malloc
In-Reply-To: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
Message-ID: <1378458778.4208.30.camel@weser.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thommy,

Am Freitag, den 06.09.2013, 09:48 +0200 schrieb Thommy Jakobsson:
> Hi,
> 
> doing a project where I use DMA and a DMA-capable buffer in a driver. This 
> buffer is then mmap:ed to userspace, the driver notice userspace 
> that the device has filled the buffer. Pretty standard setup I think.
> 
> The initial problem was that I noticed that the buffer I got through 
> dma_alloc_coherent was very slow to step through in my userspace program. 
> I figured it was due to the memory allocated should be coherent (my hw 
> doesn't have cache coherence for DMA), so I probably got memory with cache 
> turned off. So I switched to a kmalloc and dma_map_single, plan was to  
> get more speed if I did cache invalidations.
> 
> After switching to kmalloc in the driver I still got loosy performance 
> though. I run below testdriver and program on a 
> marvell kirkwood 88F6281 (ARM9Em ARMv5TE) and a imx6 (Cortex A9 MP, Armv7) 
> with similar result. The test program is looping through a 4k buffer 
> 10000 times, just adding all bytes and measuring how long time it takes. 
> On the kirkwood I get the following printout:
> 
> pa_dmabuf = 0x195d8000
> va_dmabuf = 0x401e4000
> pa_kmbuf = 0x19418000
> va_kmbuf = 0x4031c000
> dma_alloc_coherent 3037365us
> kmalloc            3039321us
> malloc              823403us
> 
> As you can see the kmalloc is ~3-4times slower to step through than a 
> normal malloc. The addresses in the beginning are just printouts of where 
> the buffers end up, both physical and virtual (in userspace) addresses.
> 
> I would have expected the kmalloc buffer to have roughly the same speed as 
> a malloc one. Any ideas what am I doing wrong? or are the assumptions 
> wrong?
> 
> 
> BR,
> Thommy
> 
> relevant driver part:
> ------------------------------------------------------------------
> static long device_ioctl(struct file *file,
> 			 unsigned int cmd, unsigned long arg){
> 
>         dma_addr_t pa = 0;	
> 
> 	printk("entering ioctl cmd %d\r\n",cmd);
> 	switch(cmd)
> 	{
> 	case DMAMEM:
> 		va_dmabuf = dma_alloc_coherent(0,BUFSIZE,&pa,GFP_KERNEL|GFP_DMA);
> 		pa_dmabuf = pa;
> 		break;
> 	case KMEM:
> 		va_kmbuf = kmalloc(BUFSIZE,GFP_KERNEL);
> 		//pa = dma_map_single(0,va_kmbuf,BUFSIZE,DMA_FROM_DEVICE);
> 		pa = __pa(va_kmbuf);
> 		pa_kmbuf = pa;
> 		break;
> 	case DMAMEM_REL:
> 		dma_free_coherent(0,BUFSIZE,va_dmabuf,pa_dmabuf);
> 		break;
> 	case KMEM_REL:
> 		kfree(va_kmbuf);
> 		break;
> 	default:
> 		break;
> 	} 
>  
> 	printk("allocated pa = 0x%08X\r\n",pa);
> 
>  	if(copy_to_user((void*)arg, &pa, sizeof(pa)))
> 		return -EFAULT;
> 	return 0;
> }
> 
> static int device_mmap(struct file *filp, struct vm_area_struct *vma)
>  {
> 	unsigned long size;
> 	int res = 0;
> 	size = vma->vm_end - vma->vm_start;
> 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
This is the relevant part where you are mapping things uncached into
userspace, so no wonder it is slower than cached malloc memory. If you
want to use cached userspace mappings you need bracketed MMAP access,
where you tell the kernel by using an ioctl or something that userspace
is accessing the mapping so it can flush/invalidate caches at the right
points in time.

Before doing so read up on how conflicting page mappings can lead to
undefined behavior on ARMv7 systems and consider the consequences
carefully. If you aren't sure you understood the problem fully and know
how to mitigate the problems, back out and live with an uncached or
writecombined mapping.

> 	if (remap_pfn_range(vma, vma->vm_start,
> 			    vma->vm_pgoff, size, vma->vm_page_prot)) {
> 		res = -ENOBUFS;
> 		goto device_mmap_exit;
> 	}
> 
> 	vma->vm_flags &= ~VM_IO;	/* using shared anonymous pages */
> 
> device_mmap_exit:
> 	return res;
> 
>  }
[...]

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
