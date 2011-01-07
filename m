From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 7 Jan 2011 14:13:54 +0530
Subject: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix for
	undefined reference to 'omap2_prm_read_mod_reg'
In-Reply-To: <alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
References: <1294225024-21857-1-git-send-email-santosh.shilimkar@ti.com>
	<1294225024-21857-2-git-send-email-santosh.shilimkar@ti.com>
	<alpine.DEB.2.00.1101061056340.22048@utopia.booyaka.com>
Message-ID: <9bbee95dfb5aa1a6b6b004e4e6b741e9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Paul Walmsley [mailto:paul at pwsan.com]
> Sent: Thursday, January 06, 2011 11:28 PM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v2 2/5] omap2plus: prm: Trvial build break fix
> for undefined reference to 'omap2_prm_read_mod_reg'
>
> Hi Santosh
>
> On Wed, 5 Jan 2011, Santosh Shilimkar wrote:
>
> > omap2plus_defocnfig build breaks when customised with only
> ARCH_OMAP4
> > selected. This is because common files make references to the
> functions
> > which are defined only for omap2xxx and omap3xxx.
>
> ...
>
> >
> > This patch adds stubs for these functions so that build continues
> to work.
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/prm2xxx_3xxx.h |   63
> +++++++++++++++++++++++++++++++++++-
> >  1 files changed, 62 insertions(+), 1 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-
> omap2/prm2xxx_3xxx.h
> > index 53d44f6..843f329 100644
> > --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> > +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> > @@ -228,7 +228,67 @@
> >
> >
> >  #ifndef __ASSEMBLER__
> > -
> > +/*
> > + * Stub omap2xxx/omap3xxx functions so that common files
> > + * continue to build when custom builds are used
> > + */
> > +#if defined(CONFIG_ARCH_OMAP4) && !(defined(CONFIG_ARCH_OMAP2) ||
> 	\
> > +					defined(CONFIG_ARCH_OMAP3))
> > +static inline u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
> > +{
> > +	WARN_ONCE(1, "prm: omap2xxx/omap3xxx specific function and "
> > +		"not suppose to be used on omap4\n");
> > +	return 0;
> > +}
>
> I think it would be best to use WARN() on these, rather than
> WARN_ONCE().
> That's because these could be called from different parts of the
> code
> base, and the stack backtrace will help someone figure out all the
> code
> that needs to be fixed.
>
Ok.

> Once you do that, this patch is
>
> Acked-by: Paul Walmsley <paul@pwsan.com>
>
Thanks
