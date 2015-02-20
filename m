From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Feb 2015 12:37:38 -0800
Subject: [PATCH v2 1/2] ARM: perf: Preparatory work for Scorpion PMU
 support
In-Reply-To: <20150220193034.GD1767@arm.com>
References: <1423851849-6069-1-git-send-email-sboyd@codeaurora.org>
 <1423851849-6069-2-git-send-email-sboyd@codeaurora.org>
 <20150220193034.GD1767@arm.com>
Message-ID: <20150220203738.GE24928@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/20, Will Deacon wrote:
> On Fri, Feb 13, 2015 at 06:24:08PM +0000, Stephen Boyd wrote:
> > Do some things to make the Krait PMU support code generic enough
> > to be used by the Scorpion PMU support code.
> > 
> >  * Rename the venum register functions to be venum instead of krait
> >    specific because the same registers exist on Scorpion
> > 
> >  * Add a krait_decode_event() function to decode our Krait specific
> >    event encoding that's the same on Scorpion (modulo an extra region).
> > 
> >  * Drop krait from krait_clear_pmresrn_group() so it can be used
> >    by Scorpion code
> > 
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  arch/arm/kernel/perf_event_v7.c | 87 ++++++++++++++++++++++-------------------
> >  1 file changed, 46 insertions(+), 41 deletions(-)
> 
> [...]
> 
> > +static void krait_decode_event(u32 event, unsigned int *region,
> > +		unsigned int *group, unsigned int *code, bool *venum, bool *cpu)
> > +{
> > +	if (region)
> > +		*region = (event >> 12) & 0xf;
> > +	if (group)
> > +		*group  = (event >> 0)  & 0xf;
> > +	if (code)
> > +		*code   = (event >> 4) & 0xff;
> > +	if (venum)
> > +		*venum  = !!(event & VENUM_EVENT);
> > +	if (cpu)
> > +		*cpu = !!(event & KRAIT_EVENT);
> > +}
> 
> Maybe worth sticking these fields in a struct? Failing that, just using
> macros for each one and using them in-line isn't so bad.
> 

Ok let's see how a macro goes. Is there any advantage either way?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
