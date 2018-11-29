From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2018 10:14:29 +0000
Subject: [PATCH v2] ARM: dma-mapping: fix potential uninitialized return
In-Reply-To: <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
References: <20181128173929.3050-1-nathanj439@gmail.com>
 <20181128185910.5778-1-nathanj439@gmail.com>
 <401b58b2-fb17-dc83-f898-c10cafdc5413@arm.com>
Message-ID: <20181129101428.GQ30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2018 at 09:50:59AM +0000, Vladimir Murzin wrote:
> On 11/28/18 6:59 PM, Nathan Jones wrote:
> > If neither of the if() statements fire then the return value is
> > uninitialized. In the worst case it returns 0 which means the caller
> > will think the function succeeded.
> 
> "ret" is updated indirectly via:
> 
>         if (dma_mmap_from_dev_coherent(dev, vma, cpu_addr, size, &ret))
>                 return ret;

I'm afraid you are wrong - "ret" really is used uninitialised.

dma_mmap_from_dev_coherent() calls __dma_mmap_from_coherent(), and
there is a top-function-level if statement:

static int __dma_mmap_from_coherent(struct dma_coherent_mem *mem,
                struct vm_area_struct *vma, void *vaddr, size_t size, int *ret)
{
        if (mem && vaddr >= mem->virt_base && vaddr + size <=
                   (mem->virt_base + (mem->size << PAGE_SHIFT))) {
		... path that sets *ret ...
		return 1;
        }
        return 0;
}

If that if statement is true, then yes, ret will be initialised, and
dma_mmap_from_dev_coherent() will return 1.  We will take that
"return ret" statement in __arm_dma_mmap() and everything is fine.

If that if statement is false, then the function returns zero without
setting "ret" to anything, and we continue processing __arm_dma_mmap().
The next statements are:

        if (off < nr_pages && nr_vma_pages <= (nr_pages - off)) {
                ret = remap_pfn_range(vma, vma->vm_start,
                                      pfn + off,
                                      vma->vm_end - vma->vm_start,
                                      vma->vm_page_prot);
        }

        return ret;

So, if _this_ if statement is also false, then we get to "return ret"
but ret has not been initialised by anything.

Therefore, 'ret' does need initialisation, since as of your commit,
there is a path through the code where it is used uninitialised.

Hence, Nathan's patch is correct.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
