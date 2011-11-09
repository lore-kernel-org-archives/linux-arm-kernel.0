From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 9 Nov 2011 14:55:37 +0000
Subject: [PATCHv4 07/13] ARM: s3c64xx: convert to MULTI_IRQ_HANDLER
In-Reply-To: <4EBA9339.5010407@gmail.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
 <1320369010-23428-8-git-send-email-jamie@jamieiles.com>
 <CAJuYYwRPoFDUhtcVLT_rj4c9whJWVXyQ7tcaK3O_G3X9SYf-cw@mail.gmail.com>
 <20111109115406.GB4253@totoro> <4EBA9339.5010407@gmail.com>
Message-ID: <20111109145537.GF4253@totoro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 09, 2011 at 08:50:33AM -0600, Rob Herring wrote:
> On 11/09/2011 05:54 AM, Jamie Iles wrote:
> > On Wed, Nov 09, 2011 at 04:55:06PM +0530, Thomas Abraham wrote:
> >> Hi Jamie,
> >>
> >> On 4 November 2011 06:40, Jamie Iles <jamie@jamieiles.com> wrote:
> >>> Now that there is a generic IRQ handler for multiple VIC devices use it
> >>> for s3c64xx to help building multi platform kernels.
> >>>
> >>> Cc: Ben Dooks <ben-linux@fluff.org>
> >>> Signed-off-by: Jamie Iles <jamie@jamieiles.com>
> >>> ---
> >>>  arch/arm/Kconfig                                 |    1 +
> >>>  arch/arm/mach-s3c64xx/include/mach/entry-macro.S |    7 ++++---
> >>>  arch/arm/mach-s3c64xx/mach-anw6410.c             |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-crag6410.c            |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-hmt.c                 |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-mini6410.c            |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-ncp.c                 |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-real6410.c            |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-smartq5.c             |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-smartq7.c             |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-smdk6400.c            |    2 ++
> >>>  arch/arm/mach-s3c64xx/mach-smdk6410.c            |    2 ++
> >>>  12 files changed, 25 insertions(+), 3 deletions(-)
> >>>
> >>
> >> I have tested this patch series on smdk6410 board (s3c64xx) using the
> >> following repositorty and branch
> >>
> >> https://github.com/jamieiles/linux-2.6-ji.git  branch: vic-dt
> >>
> >> There is a crash while booting. Am I using the right tree and branch?
> >> The following is the boot log. Is there any other config option to be
> >> enabled?
> > 
> > Hmm, could you please try with the patch below applied?
> > 
> > Rob, I'm not sure if this is the best fix.  The alternatives I can think 
> > of would be to always export irq_domain_simple_ops even if 
> > !CONFIG_OF_IRQ but not set .dt_translate or provide a generic 
> > irq_domain_null_ops.
> > 
> > Jamie
> 
> There is a simple fix:
> 
> @@ -74,7 +76,7 @@ struct irq_domain {
>  static inline unsigned int irq_domain_to_irq(struct irq_domain *d,
>                                              unsigned long hwirq)
>  {
> -       if (d->ops->to_irq)
> +       if (d->ops && d->ops->to_irq)
>                 return d->ops->to_irq(d, hwirq);
>         if (WARN_ON(hwirq < d->hwirq_base))
>                 return 0;
> 
> I'll prepare a patch and send to tglx.

I did wonder about that, but that means we do it differently for 
ops->dt_translate (though that really should be there if it's required).

It works for me though!

Jamie
