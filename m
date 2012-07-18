From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 18 Jul 2012 19:23:26 +0300
Subject: [PATCHv6 3/7] ARM: OMAP4: hwmod: flag hwmods/modules not
 supporting module level context status
In-Reply-To: <CAOMWX4e9bpJivetsx-FD_U7BbjrWh0Xto-7MTUe5YK8Mjpi9Sg@mail.gmail.com>
References: <1339428387-4800-1-git-send-email-t-kristo@ti.com>
 <1339428387-4800-4-git-send-email-t-kristo@ti.com>
 <CAOMWX4e9bpJivetsx-FD_U7BbjrWh0Xto-7MTUe5YK8Mjpi9Sg@mail.gmail.com>
Message-ID: <1342628606.4672.112.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-07-17 at 03:11 -0500, Menon, Nishanth wrote:
> On Mon, Jun 11, 2012 at 10:26 AM, Tero Kristo <t-kristo@ti.com> wrote:
> > On OMAP4 most modules/hwmods support module level context status. On
> > OMAP3 and earlier, we relied on the power domain level context status.
> > Identify all modules that don't support 'context_offs' by marking the
> > offset as USHRT_MAX. Rest have a valid 'context_offs' populated in
> > .prcm structure already.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 +
> >  1 files changed, 1 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > index 86fc513..828e7b8 100644
> > --- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > +++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
> > @@ -208,6 +208,7 @@ static struct omap_hwmod omap44xx_l4_abe_hwmod = {
> >         .prcm = {
> >                 .omap4 = {
> >                         .clkctrl_offs = OMAP4_CM1_ABE_L4ABE_CLKCTRL_OFFSET,
> > +                       .context_offs = USHRT_MAX,
> 
> OMAP4430_RM_ABE_AESS_CONTEXT? why not use LOSTMEM_AESSMEM ? ABE will
> need to know when it lost context to be able to reload it's firmware,
> no?

It looks like current hwmod data doesn't support specific bits to be
used for the context declaration, it is only specifying the register
offset. Also, the same register is used by aess hwmod, so this will
cause a conflict if I take the same register into use.

This could be fixed by adding a field for the context bits, but I guess
this should be commented upon by someone (Benoit / Paul) before I craft
some sort of patch for that.

Meanwhile, I will keep the USHRT_MAX here until better solution is
available.

-Tero
