From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 18 Dec 2017 14:33:19 +0900
Subject: [PATCH] arch/arm64: elfcorehdr should be the first allocation
In-Reply-To: <DB5PR0401MB173388B553457AA08431C361860B0@DB5PR0401MB1733.eurprd04.prod.outlook.com>
References: <1512970412-5472-1-git-send-email-prabhakar.kushwaha@nxp.com>
 <20171211140714.GD2141@arm.com> <20171213104640.GD28046@linaro.org>
 <DB5PR0401MB173388B553457AA08431C361860B0@DB5PR0401MB1733.eurprd04.prod.outlook.com>
Message-ID: <20171218053318.2lnoouuiewkwwnmf@fireball>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 15, 2017 at 02:20:15PM +0000, Poonam Aggrwal wrote:
> Thanks Takahiro and Will,
> 
> Please find responses below.
> 
> Regards
> Poonam
> > -----Original Message-----
> > From: AKASHI Takahiro [mailto:takahiro.akashi at linaro.org]
> > Sent: Wednesday, December 13, 2017 4:17 PM
> > To: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> > Cc: Will Deacon <will.deacon@arm.com>; Prabhakar Kushwaha
> > <prabhakar.kushwaha@nxp.com>; linux-arm-kernel at lists.infradead.org;
> > Poonam Aggrwal <poonam.aggrwal@nxp.com>; G.h. Gao
> > <guanhua.gao@nxp.com>; james.morse at arm.com
> > Subject: Re: [PATCH] arch/arm64: elfcorehdr should be the first allocation
> > 
> > On Mon, Dec 11, 2017 at 02:07:14PM +0000, Will Deacon wrote:
> > > On Mon, Dec 11, 2017 at 11:03:32AM +0530, Prabhakar Kushwaha wrote:
> > > > From: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> > > >
> > > > elfcorehdr_addr is assigned by kexec-utils and device tree of dump
> > > > kernel is fixed in chosen node with parameter "linux,elfcorehdr".
> > > > So, memory should be first reserved for elfcorehdr, otherwise
> > > > overlaps may happen with other memory allocations which were done
> > > > before the allocation of elcorehdr in the crash kernel
> > >
> > > What happens in that case? Do you have a crash log we can include in
> > > the commit message?
> > 
> > In private discussions with Poonam, he said:
> > |   The overlap here I observed was for the reserved-mem areas in the dtb.
> > |   And they were specific to NXP device.
> Thanks Takahiro for providing this information.
> Yes the memory overlap happens because when the dump-capture kernel tries to reserve elfcoreheader at the specific address, it finds that the address has already been reserved for some other use by early_init_fdt_scan_reserved_mem().
> Based on the "reserved-memory" node entries in the dts file , the overlap is seen to happen with one of the below alocations:

So the point is that reserve_elfcorehdr() should be placed before
early_init_fdt_scan_reserved_mem() which may allocate memory dynamically,
isn't it. I think it makes sense.

Lisewise, reserve_crashkernel(), which can also allocate memory statically
in case of "crashkernel=SIZE at ADDRESS", should be.
(Even if an overrap might happen, this wouldn't prevent the system from
booting though. We just can't use kdump in this case.)

Thanks,
-Takahiro AKASHI

> [    0.000000] Reserved memory: created DMA memory pool at 0x00000000fb800000, size 4 MiB
> [    0.000000] Reserved memory: initialized node qman-fqd, compatible id shared-dma-pool
> [    0.000000] Reserved memory: created DMA memory pool at 0x00000000f8000000, size 32 MiB
> [    0.000000] Reserved memory: initialized node qman-pfdr, compatible id shared-dma-pool
> > 
> > Since I have not got any details since then, I'm not sure whether your patch is
> > the way to go.
> > (I suspect that we might better fix the issue on kexec-tools side.)
> > 
> I may not have full understanding of kexec-tools, but I am not sure how will kexec tools be able to know what addresses will get  assigned for the reserved-memory regions in the device tree. 
> > Thanks,
> > -Takahiro AKASHI
> > 
> > > > Signed-off-by: Guanhua <guanhua.gao@nxp.com>
> > > > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> > > > Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> > > > ---
> > >
> > > Really? How on Earth did you get three people co-developing this patch?
>  : )Contribution was from all in terms of reproducing, testing on various platforms including the debug experiments. Just wanted to acknowledge the effort.
> > >
> > > >  arch/arm64/mm/init.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> > > > 5960bef0170d..551048cfcfff 100644
> > > > --- a/arch/arm64/mm/init.c
> > > > +++ b/arch/arm64/mm/init.c
> > > > @@ -453,6 +453,10 @@ void __init arm64_memblock_init(void)
> > > >  	 * Register the kernel text, kernel data, initrd, and initial
> > > >  	 * pagetables with memblock.
> > > >  	 */
> > > > +
> > > > +	/* make this the first reservation so that there are no chances of
> > > > +	 * overlap */
> > > > +	reserve_elfcorehdr();
> > > >  	memblock_reserve(__pa_symbol(_text), _end - _text);  #ifdef
> > > > CONFIG_BLK_DEV_INITRD
> > > >  	if (initrd_start) {
> > > > @@ -474,8 +478,6 @@ void __init arm64_memblock_init(void)
> > > >
> > > >  	reserve_crashkernel();
> > > >
> > > > -	reserve_elfcorehdr();
> > >
> > > Why isn't this also a problem for reserve_crashkernel() or any other
> > > static reservations?
> Thanks, for raising this. Yes looking at the code flow this may also cause a problem, definitely when the start address of the crash kernel is specified in the bootargs. We mostly tested with just the size, so it was an allocation without a specific address.
> 
> > >
> > > Will
