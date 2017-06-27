From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 27 Jun 2017 18:14:45 +0100
Subject: [PATCH] ARM: memblock limit must be pmd-aligned
In-Reply-To: <b55726c8-0e36-fa50-78cb-6e488ef9bf31@gmail.com>
References: <20170626172315.26369-1-opendmb@gmail.com>
 <48116220-b89b-7413-ea62-c78dfb0594a2@redhat.com>
 <129544df-5461-a877-84c9-9889bd5e9dc0@gmail.com>
 <20170627105912.GE30002@leverpostej>
 <b55726c8-0e36-fa50-78cb-6e488ef9bf31@gmail.com>
Message-ID: <20170627171445.GG30002@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 27, 2017 at 09:57:17AM -0700, Doug Berger wrote:
> On 06/27/2017 03:59 AM, Mark Rutland wrote:
> > On Mon, Jun 26, 2017 at 05:50:03PM -0700, Doug Berger wrote:
> >> On 06/26/2017 04:43 PM, Laura Abbott wrote:
> >>> On 06/26/2017 10:23 AM, Doug Berger wrote:
> >>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> >>>> index 31af3cb59a60..2ae4f9c9d757 100644
> >>>> --- a/arch/arm/mm/mmu.c
> >>>> +++ b/arch/arm/mm/mmu.c
> >>>> @@ -1226,7 +1226,7 @@ void __init adjust_lowmem_bounds(void)
> >>>>  	if (memblock_limit)
> >>>>  		memblock_limit = round_down(memblock_limit, PMD_SIZE);
> >>>>  	if (!memblock_limit)
> >>>> -		memblock_limit = arm_lowmem_limit;
> >>>> +		memblock_limit = round_down(arm_lowmem_limit, PMD_SIZE);
> >>>>  
> > 
> > Given we're always going to do the rounding, how about we move that out
> > of the existing conditional, i.e. get rid of the first if, and have:
> > 
> > 	if (!memblock_limit)
> > 		memblock_limit = arm_lowmem_limit;
> > 
> > 	/*
> > 	 * Round the memblock limit down to a pmd size.  This
> > 	 * helps to ensure that we will allocate memory from the
> > 	 * last full pmd, which should be mapped.
> > 	 */
> > 	memblock_limit = round_down(memblock_limit, PMD_SIZE);
> > 
> > Thanks,
> > Mark.
> That makes perfect sense to me.  I will submit a v2 with this code
> change.  Should I add your Signed-off-by since it is your change?

Since you're writing the patch, there's no need.

Feel free to add my Suggested-by if you want, but I'm not too worried
either way.

Thanks,
Mark.
