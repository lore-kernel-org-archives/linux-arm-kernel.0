From: thommyj@gmail.com (Thommy Jakobsson)
Date: Tue, 10 Sep 2013 11:54:03 +0200 (CEST)
Subject: kmalloc memory slower than malloc
In-Reply-To: <1378458778.4208.30.camel@weser.hi.pengutronix.de>
References: <alpine.DEB.2.02.1309060811400.1299@kelly.ryd.net>
 <1378458778.4208.30.camel@weser.hi.pengutronix.de>
Message-ID: <alpine.DEB.2.02.1309101124450.1305@kelly.ryd.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Fri, 6 Sep 2013, Lucas Stach wrote:

> This is the relevant part where you are mapping things uncached into
> userspace, so no wonder it is slower than cached malloc memory. If you
> want to use cached userspace mappings you need bracketed MMAP access,
> where you tell the kernel by using an ioctl or something that userspace
> is accessing the mapping so it can flush/invalidate caches at the right
> points in time.
Removing the pgprot_noncached() seems to make things more what I expected. 
Both buffers takes about the same time to traverse in userspace. Thanks.

I changed the code in my testprogram and driver to do the same thing in 
kernelspace as well. And now I don't understand the result. The result 
stepping through and adding all bytes in a page sized buffer is about 4-5 
times faster to do in the kernel. This is the times for looping through 
the buffer 10000 times on a imx6:
dma_alloc_coherent in kernel   4.256s (s=0)
kmalloc in kernel              0.126s (s=86700000)
dma_alloc_coherent userspace   0.566s (s=0)
kmalloc in userspace          0.566s (s=86700000)
malloc in userspace          0.566s (s=0)

The 's' inside the paranthes is the resulting sum. See below for 
actual code. I've read the L2 cache controller (PL310) in the imx6 has 
speculative read. So I assume that it will be a performance increase to 
have the memory physically continous (like kmalloc). But that should be 
the same after I have map:ed it to userspace aswell, right? There is no 
other load on the target during the test run.

I don't really understand the different pgprot-flags (some are obvious 
like L_PTE_MT_UNCACHED of ocurse), so maybe I still have some errors in my 
mmap. Can someone point me in the right direction or have any ideas why 
it is so much faster in the kernel?

Thanks,
Thommy

code from testdriver:
--------------------
static long device_ioctl(struct file *file,
			 unsigned int cmd, unsigned long arg){

        dma_addr_t pa = 0;	
	int i,j;
	unsigned long s=0;

	printk("entering ioctl cmd %d\r\n",cmd);
	switch(cmd)
	{
	case DMAMEM:
		va_dmabuf = dma_alloc_coherent(0,BUFSIZE,&pa,GFP_KERNEL|GFP_DMA);
		//memset(va_dmabuf,0,BUFSIZE);
		//va_dmabuf[15] = 23;
		pa_dmabuf = pa;	
		printk("kernel va_dmabuf: 0x%p, pa_dmabuf 0x%08X\r\n",va_dmabuf,pa_dmabuf);
		break;
	case DMAMEM_TEST:
		for(j=0;j<LOOPCNT;j++){
			for(i=0;i<BUFSIZE;i++){
				s += va_dmabuf[i];
			}
		}
		break;
	case KMEM:
		va_kmbuf = kmalloc(BUFSIZE,GFP_KERNEL);
		//pa = virt_to_phys(va_kmbuf);
		//pa = __pa(va_kmbuf);
		pa = dma_map_single(0,va_kmbuf,BUFSIZE,DMA_FROM_DEVICE);
		pa_kmbuf = pa;
		dma_sync_single_for_cpu(0,pa_kmbuf,BUFSIZE,DMA_FROM_DEVICE);
		//memset(va_kmbuf,0,BUFSIZE);
		//va_kmbuf[10] = 11;
		printk("kernel va_kmbuf: 0x%p, pa_kmbuf 0x%08X\r\n",va_kmbuf,pa_kmbuf);
		break;
	case KMEM_TEST:
		for(j=0;j<LOOPCNT;j++){
			for(i=0;i<BUFSIZE;i++){
				s += va_kmbuf[i];
			}
		}
		break;
	case DMAMEM_REL:
		dma_free_coherent(0,BUFSIZE,va_dmabuf,pa_dmabuf);
		va_dmabuf = 0;
		break;
	case KMEM_REL:
		kfree(va_kmbuf);
		va_kmbuf = 0;
		break;
	default:
		break;
	} 
 
	if(cmd == DMAMEM_TEST || cmd == KMEM_TEST){
		if(copy_to_user((void*)arg, &s, sizeof(s)))
			return -EFAULT;
	}else{
		pa_currentbuf = pa;
 		if(copy_to_user((void*)arg, &pa, sizeof(pa)))
			return -EFAULT;
	}
	return 0;
}

static int device_mmap(struct file *filp, struct vm_area_struct *vma)
 {
	unsigned long size;
	int res = 0;
	size = vma->vm_end - vma->vm_start;
	//vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
//	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
//	vma->vm_page_prot = __pgprot_modify(vma->vm_page_prot,L_PTE_MT_MASK,L_PTE_MT_WRITEBACK);
//	vma->vm_page_prot = __pgprot_modify(vma->vm_page_prot,L_PTE_MT_MASK,L_PTE_MT_DEV_CACHED);
//	vma->vm_page_prot = __pgprot_modify(vma->vm_page_prot,L_PTE_MT_MASK,L_PTE_MT_WRITETHROUGH);

	if (remap_pfn_range(vma, vma->vm_start,
			    pa_currentbuf>>PAGE_SHIFT , size, vma->vm_page_prot)) {
		res = -ENOBUFS;
		goto device_mmap_exit;
	}

	vma->vm_flags &= ~VM_IO;	/* using shared anonymous pages */

device_mmap_exit:
	return res;

 }


code from testapplication:
-------------------------
	/*
	 * test speed of dma_alloc_coherent buffer in kernel
	 */
	gettimeofday(&t1,NULL);
	ioctl(fd,DMAMEM_TEST,&s);
        gettimeofday(&t2,NULL);
        printf("dma_alloc_coherent in kernel   %.3fs (s=%lu)\n",
		((t2.tv_sec-t1.tv_sec)*1000000+(t2.tv_usec-t1.tv_usec))/1000000.0,s);

        /*
         * test speed of kmalloc buffer in kernel
         */
        gettimeofday(&t1,NULL);
	ioctl(fd,KMEM_TEST,&s);
        gettimeofday(&t2,NULL);
        printf("kmalloc in kernel              %.3fs (s=%lu)\n",
		((t2.tv_sec-t1.tv_sec)*1000000+(t2.tv_usec-t1.tv_usec))/1000000.0,s);
 

	/*
	 * test speed of dma_alloc_coherent buffer
	 */
	s=0;
	gettimeofday(&t1,NULL);
        for(j=0;j<LOOPCNT;j++){
		for(i=0;i<BUFSIZE;i++){
                	s += va_dmabuf[i];
		}
	}	
        gettimeofday(&t2,NULL);
        printf("dma_alloc_coherent userspace   %.3fs (s=%lu)\n",
		((t2.tv_sec-t1.tv_sec)*1000000+(t2.tv_usec-t1.tv_usec))/1000000.0,s);
 

        /*
         * test speed of kmalloc buffer
         */
	s=0;
        gettimeofday(&t1,NULL);
        for(j=0;j<LOOPCNT;j++){
                for(i=0;i<BUFSIZE;i++){
                        s += va_kmbuf[i];
        	}
	}
        gettimeofday(&t2,NULL);
        printf("kmalloc in userspace          %.3fs (s=%lu)\n",
		((t2.tv_sec-t1.tv_sec)*1000000+(t2.tv_usec-t1.tv_usec))/1000000.0,s);


	/*
	 * test speed of malloc
	 */
	s=0;
	va_mbuf = malloc(BUFSIZE);

        gettimeofday(&t1,NULL);
        for(j=0;j<LOOPCNT;j++){
                for(i=0;i<BUFSIZE;i++){
                        s += va_mbuf[i];
		}
        }
        gettimeofday(&t2,NULL);
        printf("malloc in userspace          %.3fs (s=%lu)\n",
		((t2.tv_sec-t1.tv_sec)*1000000+(t2.tv_usec-t1.tv_usec))/1000000.0,s);
