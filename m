From: steve.capper@linaro.org (Steve Capper)
Date: Thu, 3 Jul 2014 14:47:01 +0100
Subject: [PATCH V6 2/2] arm: mm: Modify pte_write and pmd_write logic for
 LPAE
In-Reply-To: <20140703121808.GV32514@n2100.arm.linux.org.uk>
References: <1404389173-4246-1-git-send-email-steve.capper@linaro.org>
 <1404389173-4246-3-git-send-email-steve.capper@linaro.org>
 <20140703121808.GV32514@n2100.arm.linux.org.uk>
Message-ID: <20140703134700.GA6720@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 01:18:08PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jul 03, 2014 at 01:06:13PM +0100, Steve Capper wrote:
> > diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> > index c508f41..00a1cf9 100644
> > --- a/arch/arm/mm/dump.c
> > +++ b/arch/arm/mm/dump.c
> > @@ -126,8 +126,8 @@ static const struct prot_bits section_bits[] = {
> >  		.val	= PMD_SECT_USER,
> >  		.set	= "USR",
> >  	}, {
> > -		.mask	= PMD_SECT_RDONLY,
> > -		.val	= PMD_SECT_RDONLY,
> > +		.mask	= PMD_SECT_AP2,
> > +		.val	= PMD_SECT_AP2,
> 
> I think we're almost there, except for this hunk, which I think can
> just be deleted.
> 
> We want to report what the PTEs/PMDs are requested to be, not what they
> physically are at the point where we dump them out.  In other words, we
> don't want to know that they're physically read-only because the dirty
> bit isn't set - what we want to know is that they have permission to be
> written to if the dirty bit were to be set.
> 
> The reasoning is that we want the dump to reflect what is possible -
> for example, we want to know whether a page can be executed _and_ written
> to.
> 
> Consider the case where the dirty bit is implemented in hardware.

Thanks Russell, that makes more sense. I'll change the mask and val to:
L_PMD_SECT_RDONLY, to catch the software bit.

Cheers,
-- 
Steve
