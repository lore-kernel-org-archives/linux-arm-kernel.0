From: poonam.aggrwal@nxp.com (Poonam Aggrwal)
Date: Mon, 8 Jan 2018 04:31:13 +0000
Subject: [PATCH][v2] arm64: Allocate elfcorehdr & crashkernel mem before
 any reservation
In-Reply-To: <5A4F5C45.3090006@arm.com>
References: <1515080048-9154-1-git-send-email-poonam.aggrwal@nxp.com>
 <5A4F5C45.3090006@arm.com>
Message-ID: <DB5PR0401MB1733C9CB0DCDF94FCF3E4E1286130@DB5PR0401MB1733.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks James for  the feedback.
Please find replies inline.

Regards
Poonam

> -----Original Message-----
> From: James Morse [mailto:james.morse at arm.com]
> Sent: Friday, January 05, 2018 4:37 PM
> To: Poonam Aggrwal <poonam.aggrwal@nxp.com>; linux-arm-
> kernel at lists.infradead.org
> Cc: takahiro.akashi at linaro.org; will.deacon at arm.com; G.h. Gao
> <guanhua.gao@nxp.com>; Abhimanyu Saini <abhimanyu.saini@nxp.com>
> Subject: Re: [PATCH][v2] arm64: Allocate elfcorehdr & crashkernel mem before
> any reservation
> 
> Hi Poonam,
> 
> On 04/01/18 15:34, Poonam Aggrwal wrote:
> > Address for both crashkernel memory and elfcorehdr can be assigned
> > statically. For crashkernel memory it is via crashkernel=SIZE at ADDRESS
> > and elfcorehdr_addr via by kexec-utils in dump kernel device tree.
> 
> There are some crashkernel=SIZE at ADDRESS values that the user can supply that
> we must reject. The obvious one is if it overlaps with the kernel text. (this patch
> won't spot this). We need to read the hardware's reserved regions from the DT
> before we allocate the crashkernel region, for example if the bootloader
> reserved a chunk of memory for a frame-buffer, I shouldn't be able to use that
> as crashkernel memory.
> 
> (you shouldn't need to specify an address, doing so prevents the kernel from
> picking memory it can use)
> 
> 
> > So memory should be reserved for both the above areas before any other
> > memory reservations are done. Otherwise overlaps may happen and memory
> > allocations will fail leading to failure in booting the dump capture
> > kernel.
> 
> > Signed-off-by: Guanhua <guanhua.gao@nxp.com>
> 
> The first signed-off-by should be the patch author.
> If you want to credit your colleagues you can use 'CC', or they can give
> reviewed-by/acked-by to the patch.
> 
> 
> > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> > Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> 
> And the last signed-of-by should be from the person posting to the mailing list.
> 
Sure will correct this.
> 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> > 00e7b90..24ce15d 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -453,6 +453,14 @@ void __init arm64_memblock_init(void)
> >  	 * Register the kernel text, kernel data, initrd, and initial
> >  	 * pagetables with memblock.
> >  	 */
> 
> Please don't insert this code between 'memblock_reserve(__pa_symbol(_text),
> _end
> - _text);' and the comment that describes it.
Thanks for catching this, will fix it.
> 
> 
> > +
> > +	/* make these the first reservations to avoid chances of
> > +	 * overlap
> > +	 */
> 
> Nit: comment style
Right, will fix it.
> 
> 
> > +	reserve_elfcorehdr();
> 
> (Moving reserve_elfcorehdr() makes sense, but..)
> 
> 
> > +	reserve_crashkernel();
> 
> reserve_crashkernel() does the allocation for the crashkernels reserved memory.
> I expect this to always fail in the kdump kernel because there isn't enough
> memory. (fdt_enforce_memory_region() at the top of this function calls
> memblock_cap_memory_range()).
> 
> Moving this allocation above the early_init_fdt_scan_reserved_mem() below
> means we may allocate memory for the crashdump that is in use by
> firmware/hardware and described as reserved in the DT.
Yeah, this is a good point. So ideally the address of the crash kernel should be diligently provided by the user based on the system.
> 
> 
> >  	memblock_reserve(__pa_symbol(_text), _end - _text);  #ifdef
> > CONFIG_BLK_DEV_INITRD
> >  	if (initrd_start) {
> > @@ -472,10 +480,6 @@ void __init arm64_memblock_init(void)
> >  	else
> >  		arm64_dma_phys_limit = PHYS_MASK + 1;
> >
> > -	reserve_crashkernel();
> > -
> > -	reserve_elfcorehdr();
> > -
> >  	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
> >
> >  	dma_contiguous_reserve(arm64_dma_phys_limit);
> >
> 
> 
> Thanks,
> 
> James
