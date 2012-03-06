From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Mar 2012 14:49:43 -0500 (EST)
Subject: [PATCH 6/6] ARM: mm: truncate memory banks to fit in 4GB space for
 classic MMU
In-Reply-To: <20120306175853.GB17518@mudshark.cambridge.arm.com>
References: <1331052846-19144-1-git-send-email-will.deacon@arm.com>
 <1331052846-19144-7-git-send-email-will.deacon@arm.com>
 <4F565230.6030800@ru.mvista.com>
 <20120306175853.GB17518@mudshark.cambridge.arm.com>
Message-ID: <alpine.LFD.2.02.1203061448540.31242@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Mar 2012, Will Deacon wrote:

> On Tue, Mar 06, 2012 at 06:06:40PM +0000, Sergei Shtylyov wrote:
> > Hello.
> 
> Hi Sergei,
> 
> > On 03/06/2012 07:54 PM, Will Deacon wrote:
> > 
> > > If a bank of memory spanning the 4GB boundary is added on a !CONFIG_LPAE
> > > kernel then we will hang early during boot since the memory bank will
> > > have wrapped around to zero.
> > 
> > > This patch truncates memory banks for !LPAE configurations when the end
> > > address is not representable in 32 bits.
> > 
> > > Signed-off-by: Will Deacon<will.deacon@arm.com>
> > > ---
> > >   arch/arm/kernel/setup.c |   11 ++++++++++-
> > >   1 files changed, 10 insertions(+), 1 deletions(-)
> > 
> > > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > > index a255c39..aeaa048 100644
> > > --- a/arch/arm/kernel/setup.c
> > > +++ b/arch/arm/kernel/setup.c
> > > @@ -521,7 +521,16 @@ int __init arm_add_memory(phys_addr_t start, unsigned long size)
> > >   	 */
> > >   	size -= start&  ~PAGE_MASK;
> > >   	bank->start = PAGE_ALIGN(start);
> > > -	bank->size  = size&  PAGE_MASK;
> > > +
> > > +#ifndef CONFIG_LPAE
> > > +	if (bank->start + size<  bank->start) {
> > > +		printk(KERN_CRIT "Truncating memory at 0x%08llx to fit in "
> > > +			"32-bit physical address space\n", (long long)start);
> > > +		size = ULONG_MAX - bank->start;
> > 
> >     I think you forgot to add one here.
> 
> No, I deliberately omit the last page because otherwise we end up with the
> end address of the bank being calculated as 0, which leads to boot failure.

What this mentioned in the code, or at least in the patch log?


Nicolas
