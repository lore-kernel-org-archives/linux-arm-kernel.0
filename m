From: khilman@ti.com (Kevin Hilman)
Date: Mon, 19 Mar 2012 14:27:03 -0700
Subject: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to
 add IVA OPP
In-Reply-To: <20120316142034.GA22234@senorita.am.dhcp.ti.com> (Nishanth
 Menon's message of "Fri, 16 Mar 2012 09:20:35 -0500")
References: <8762e6et1u.fsf@ti.com>
 <5448984682E7954C9BFF27F747A9C6CA56D6A8@dolphin.TIGRIS.local>
 <20120316142034.GA22234@senorita.am.dhcp.ti.com>
Message-ID: <87sjh45ljs.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nishanth Menon <nm@ti.com> writes:

> On 10:26-20120316, Maximilian Schwerin wrote:
> [...]
>> > >>> +
>> > >>> + ? ? ? ? ? ? if ((strcmp(opp_def->hwmod_name,"iva") == 
>> > 0) && !omap3_has_iva())
>> > >>> + ? ? ? ? ? ? ? ? ? ? continue;
>> > >>> +
>> > >>> ? ? ? ? ? ? ? oh = omap_hwmod_lookup(opp_def->hwmod_name);
>> > >>> ? ? ? ? ? ? ? if (!oh || !oh->od) {
>> > >>> ? ? ? ? ? ? ? ? ? ? ? pr_warn("%s: no hwmod or odev for %s, [%d] "
>> > >>
>> > >> Wouldn't the one-liner below do the same thing?
>> > >>
>> > >> Actually, your patch makes it less noisy at boot time, avoiding the
>> > >> pr_warn(), so is probably better.
>> > >
>> > > The only issue i have with current patch is that it 
>> > focusses to solve
>> > > a specific device IVA.
>> > > we could have similar variances if we had SGX/AESS device etc
>> > > registered in the common
>> > > table. a generic solution might be preferable - could we reduce the
>> > > severity of pr_warn to pr_debug and do a continue instead?
>> > 
>> > I agree, that would be a better generic solution.
>> > 
>> > Kevin
>> >
>> 
>> This is a pragmatic and simple solution for a well understood problem with no side effects. Why not fix the problem now and do the generic solution later on? 
>> 
>> I'm not a fulltime kernel dev. I have about two weeks to get my new board out to my customer... Every time I set up a new board, I have to fix problems using known patches that are sometimes years old. Every patch I have to find costs me hours of time I really don't have. 
>> 
>> Just my two cents (euro cents of course :-), Maximilian
> ok, so lets fix it generically - here is the patch for it. Let us know
> if this works for you
>
>
> From 5275d09c9f1a16c8f0814745e1c313c6cca049f6 Mon Sep 17 00:00:00 2001
> From: Nishanth Menon <nm@ti.com>
> Date: Fri, 16 Mar 2012 09:13:24 -0500
> Subject: [PATCH] OMAP2+: OPP: allow OPP enumeration to continue if device is not present
>
> On platforms such as OMAP3, certain variants may not have IVA, SGX
> or some specific component. We currently have a check to aid fixing
> wrong population of OPP entries for issues such as typos. This however
> causes a conflict with valid requirement where the SoC variant does
> not actually have the module present.
>
> So, reduce the severity of the print to a debug statement and skip
> registering that specific OPP, but continue down the list.
>
> Reported-by: Steve Sakoman <steve@sakoman.com>
> Reported-by: Maximilian Schwerin <mvs@tigris.de>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/opp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> index 9262a6b..de6d464 100644
> --- a/arch/arm/mach-omap2/opp.c
> +++ b/arch/arm/mach-omap2/opp.c
> @@ -64,10 +64,10 @@ int __init omap_init_opp_table(struct omap_opp_def *opp_def,
>  		}
>  		oh = omap_hwmod_lookup(opp_def->hwmod_name);
>  		if (!oh || !oh->od) {
> -			pr_warn("%s: no hwmod or odev for %s, [%d] "
> +			pr_debug("%s: no hwmod or odev for %s, [%d] "
>  				"cannot add OPPs.\n", __func__,
>  				opp_def->hwmod_name, i);
> -			return -EINVAL;
> +			continue;
>  		}
>  		dev = &oh->od->pdev->dev;
>  

Yes, thanks for doing this more genericly.

Nishanth, can you collect the acks/tested-bys and repost and official
patch.

I'll queue this up.

Thanks,

Kevin
