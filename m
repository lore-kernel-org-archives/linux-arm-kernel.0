From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Wed, 13 Dec 2017 19:46:42 +0900
Subject: [PATCH] arch/arm64: elfcorehdr should be the first allocation
In-Reply-To: <20171211140714.GD2141@arm.com>
References: <1512970412-5472-1-git-send-email-prabhakar.kushwaha@nxp.com>
 <20171211140714.GD2141@arm.com>
Message-ID: <20171213104640.GD28046@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 02:07:14PM +0000, Will Deacon wrote:
> On Mon, Dec 11, 2017 at 11:03:32AM +0530, Prabhakar Kushwaha wrote:
> > From: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> > 
> > elfcorehdr_addr is assigned by kexec-utils and device tree of
> > dump kernel is fixed in chosen node with parameter "linux,elfcorehdr".
> > So, memory should be first reserved for elfcorehdr,
> > otherwise overlaps may happen with other memory allocations
> > which were done before the allocation of elcorehdr in the crash kernel
> 
> What happens in that case? Do you have a crash log we can include in
> the commit message?

In private discussions with Poonam, he said:
|   The overlap here I observed was for the reserved-mem areas in the dtb.
|   And they were specific to NXP device.

Since I have not got any details since then, I'm not sure
whether your patch is the way to go.
(I suspect that we might better fix the issue on kexec-tools side.)

Thanks,
-Takahiro AKASHI

> > Signed-off-by: Guanhua <guanhua.gao@nxp.com>
> > Signed-off-by: Poonam Aggrwal <poonam.aggrwal@nxp.com>
> > Signed-off-by: Abhimanyu Saini <abhimanyu.saini@nxp.com>
> > ---
> 
> Really? How on Earth did you get three people co-developing this patch?
> 
> >  arch/arm64/mm/init.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> > index 5960bef0170d..551048cfcfff 100644
> > --- a/arch/arm64/mm/init.c
> > +++ b/arch/arm64/mm/init.c
> > @@ -453,6 +453,10 @@ void __init arm64_memblock_init(void)
> >  	 * Register the kernel text, kernel data, initrd, and initial
> >  	 * pagetables with memblock.
> >  	 */
> > +
> > +	/* make this the first reservation so that there are no chances of
> > +	 * overlap */
> > +	reserve_elfcorehdr();
> >  	memblock_reserve(__pa_symbol(_text), _end - _text);
> >  #ifdef CONFIG_BLK_DEV_INITRD
> >  	if (initrd_start) {
> > @@ -474,8 +478,6 @@ void __init arm64_memblock_init(void)
> >  
> >  	reserve_crashkernel();
> >  
> > -	reserve_elfcorehdr();
> 
> Why isn't this also a problem for reserve_crashkernel() or any other
> static reservations?
> 
> Will
