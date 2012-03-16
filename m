From: Maximilian.Schwerin@tigris.de (Maximilian Schwerin)
Date: Fri, 16 Mar 2012 10:26:49 +0100
Subject: AW: [PATCH] OMAP3: OPP: Test for IVA subsystem before attempting to
 add IVA OPP
In-Reply-To: <8762e6et1u.fsf@ti.com>
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56D6A8@dolphin.TIGRIS.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Von: Kevin Hilman [mailto:khilman at ti.com] 
> 
> "Menon, Nishanth" <nm@ti.com> writes:
> 
> > On Wed, Mar 14, 2012 at 16:15, Kevin Hilman <khilman@ti.com> wrote:
> >> Maximilian Schwerin <mvs@tigris.de> writes:
> >>
> >>> From: Steve Sakoman <steve@sakoman.com>
> >>>
> >>> Don't try to add IVA OPPs for OMAP3 versions not containing an IVA
> >>> subsystem, as this would make omap_init_opp_table fail.
> >>>
> >>> Signed-off-by: Steve Sakoman <steve@sakoman.com>
> >>> Signed-off-by: Maximilian Schwerin <mvs@tigris.de>
> >>
> >> Minor: patch subjects for arch/arm/* core code need to 
> have the ARM:
> >> prefix also.
> >>
> >> Also, please run scripts/checkpatch.pl on your patch and fix the
> >> warnings.
> >>
> >>> ---
> >>> ?arch/arm/mach-omap2/opp.c | ? ?4 ++++
> >>> ?1 files changed, 4 insertions(+), 0 deletions(-)
> >>>
> >>> diff --git a/arch/arm/mach-omap2/opp.c b/arch/arm/mach-omap2/opp.c
> >>> index 9262a6b..414f2ec 100644
> >>> --- a/arch/arm/mach-omap2/opp.c
> >>> +++ b/arch/arm/mach-omap2/opp.c
> >>> @@ -62,6 +62,10 @@ int __init omap_init_opp_table(struct 
> omap_opp_def *opp_def,
> >>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? __func__, i);
> >>> ? ? ? ? ? ? ? ? ? ? ? return -EINVAL;
> >>> ? ? ? ? ? ? ? }
> >>> +
> >>> + ? ? ? ? ? ? if ((strcmp(opp_def->hwmod_name,"iva") == 
> 0) && !omap3_has_iva())
> >>> + ? ? ? ? ? ? ? ? ? ? continue;
> >>> +
> >>> ? ? ? ? ? ? ? oh = omap_hwmod_lookup(opp_def->hwmod_name);
> >>> ? ? ? ? ? ? ? if (!oh || !oh->od) {
> >>> ? ? ? ? ? ? ? ? ? ? ? pr_warn("%s: no hwmod or odev for %s, [%d] "
> >>
> >> Wouldn't the one-liner below do the same thing?
> >>
> >> Actually, your patch makes it less noisy at boot time, avoiding the
> >> pr_warn(), so is probably better.
> >
> > The only issue i have with current patch is that it 
> focusses to solve
> > a specific device IVA.
> > we could have similar variances if we had SGX/AESS device etc
> > registered in the common
> > table. a generic solution might be preferable - could we reduce the
> > severity of pr_warn to pr_debug and do a continue instead?
> 
> I agree, that would be a better generic solution.
> 
> Kevin
>

This is a pragmatic and simple solution for a well understood problem with no side effects. Why not fix the problem now and do the generic solution later on? 

I'm not a fulltime kernel dev. I have about two weeks to get my new board out to my customer... Every time I set up a new board, I have to fix problems using known patches that are sometimes years old. Every patch I have to find costs me hours of time I really don't have. 

Just my two cents (euro cents of course :-), Maximilian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 197 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/16737b2b/attachment.sig>
