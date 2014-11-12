From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 12 Nov 2014 18:09:30 +0000
Subject: [PATCH] efi-entry.S: add dsb and isb
In-Reply-To: <54639DEF.1040805@amd.com>
References: <20141111063204.1506.57655.stgit@joelaarch64.amd.com>
 <20141112165842.GL28015@leverpostej> <54639DEF.1040805@amd.com>
Message-ID: <20141112180930.GA4330@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tom,

On Wed, Nov 12, 2014 at 05:50:39PM +0000, Tom Lendacky wrote:
> On 11/12/2014 10:58 AM, Mark Rutland wrote:
> > Hi Joel,
> >
> > I've Cc'd a few people who were involved in authoring this.
> >
> > I have an alternative patch [1] that also adds some missing maintenance.
> > Would you be able to give that a go?
> 
> I applied the referenced patch and have booted about two dozen times
> without seeing a synchronous exception.  Prior to either patch I would
> see a synchronous exception about every three or four (re)boots.

Thank you for testing.

May I add your Tested-by?

Cheers,
Mark.

> Thanks,
> Tom
> 
> >
> > On Tue, Nov 11, 2014 at 06:32:04AM +0000, Joel Schopp wrote:
> >> Add a dsb and isb after the instruction flush before the data cache and
> >> mm offing.  Without this patch I am seeing synchronous exceptions occur
> >> every few boots.
> >>
> >> Signed-off-by: Joel Schopp <joel.schopp@amd.com>
> >> Tested-by: Tom Lendacky <Thomas.Lendacky@amd.com>
> >> ---
> >>   arch/arm64/kernel/efi-entry.S |    6 ++++++
> >>   1 file changed, 6 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
> >> index 619b1dd..7d95eda 100644
> >> --- a/arch/arm64/kernel/efi-entry.S
> >> +++ b/arch/arm64/kernel/efi-entry.S
> >> @@ -76,6 +76,12 @@ ENTRY(efi_stub_entry)
> >>   	bl	__flush_dcache_area
> >>   	ic	ialluis
> >>
> >> +	/* We need to sync again after the instruction cache sync
> >> +	 * and before turning off the dcache and mmu
> >> +	 */
> >> +	dsb	sy
> >> +	isb
> >
> > In my series I reasoned that it wasn't necessary to have an ISB before
> > we disabled the MMU. The current image must already be visible to the
> > I-cache, so the I-cache can't have stale entries for it. We don't
> > disable the MMU until after the image is visible at the PoC, so we
> > shouldn't break the visbility of the current image to the I-cache.
> >
> > There is a bug in that We don't flush the current image in case of
> > relocation, but I don't see how the ISB would help there.
> >
> > Thanks,
> > Mark.
> >
> >> +
> >>   	/* Turn off Dcache and MMU */
> >>   	mrs	x0, CurrentEL
> >>   	cmp	x0, #CurrentEL_EL2
> >>
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >>
> >
> > [1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/301779.html
> >
> 
