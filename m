From: will.deacon@arm.com (Will Deacon)
Date: Thu, 6 Mar 2014 16:18:58 +0000
Subject: [PATCH v2] ARM64: Kernel managed pages are only flushed
In-Reply-To: <5317832E.9020809@codeaurora.org>
References: <1394018716-17075-1-git-send-email-Bharat.Bhushan@freescale.com>
 <20140305161255.GG29309@mudshark.cambridge.arm.com>
 <06b7685849ef4682878556ea1ea8f9d6@BN1PR03MB266.namprd03.prod.outlook.com>
 <5317832E.9020809@codeaurora.org>
Message-ID: <20140306161857.GK5202@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laura,

On Wed, Mar 05, 2014 at 08:03:58PM +0000, Laura Abbott wrote:
> On 3/5/2014 8:27 AM, Bharat.Bhushan at freescale.com wrote:
> >> On Wed, Mar 05, 2014 at 11:25:16AM +0000, Bharat Bhushan wrote:
> >>> Kernel can only access pages which maps to managed memory.
> >>> So flush only valid kernel pages.
> >>>
> >> How do you get into this function without a valid, userspace, executable pte?
> >>
> >> I suspect you've got changes elsewhere and are calling this function in a
> >> context where it's not supposed to be called.
> >
> > Below I will describe the context in which this function is called:
> >
> > When we direct assign a bus device (we have a different freescale specific bus
>  > device but we can take PCI device for discussion as this logic 
> applies equally
>  > for PCI device I think) to user space using VFIO. Then userspace needs to
>  > mmap(PCI_BARx_offset: this PCI bar offset in not a kernel visible 
> memory).
> > Then VFIO-kernel mmap() ioctl code calls remap_pfn_range()  for mapping the
>  >requested address. While remap_pfn_range() internally calls this function.
> >
> 
> As someone who likes calling functions in context where they aren't 
> supposed to be called, I took a look a this because I was curious.

Somebody should hide your keyboard. Stephen?

> I can confirm the same problem trying to mmap arbitrary io address space 
> with remap_pfn_range. We should only be hitting this if the pte is 
> marked as exec per set_pte_at. With my test case, even mmaping with only 
> PROT_READ and PROT_WRITE was setting PROT_EXEC as well which was 
> triggering the bug. This seems to be because READ_IMPLIES_EXEC 
> personality was set which was derived from
> 
> #define elf_read_implies_exec(ex,stk)   (stk != EXSTACK_DISABLE_X)
> 
> and none of the binaries I'm generating seem to be setting the stack 
> execute bit either way (all are EXECSTACK_DEFAULT).
> 
> It's not obvious what the best solution is here.

It would be nice if something like phys_mem_access_prot was used by the
callers, since this is used by the /dev/mem driver to make sure that the
pgprot is sane for the underlying pfn. In the absence of that, I guess we
could add the pfn_valid check (we have it already on arch/arm/) but if that
means we end up with executable devices, we're still entering a world of
looks-like-my-instruction-fetcher-just-acked-an-irq style pain.

Will
