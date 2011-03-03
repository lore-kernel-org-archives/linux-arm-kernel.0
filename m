From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Mar 2011 21:38:12 +0530
Subject: [PATCH 02/17] omap4: pm: Add SAR RAM support
In-Reply-To: <87vd016vaa.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-3-git-send-email-santosh.shilimkar@ti.com>
	<87vd016vaa.fsf@ti.com>
Message-ID: <2a3493e9e5af3821f8b43c4c136c04db@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 3:27 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 02/17] omap4: pm: Add SAR RAM support
>
[..]

> > +
> > +	/* Static mapping, never released */
> > +	sar_ram_base = ioremap(OMAP44XX_SAR_RAM_BASE, SZ_8K);
> > +	BUG_ON(!sar_ram_base);
>
> Again, a BUG is not approprate here.
>
> Instead, other code needs to properly handle when sar_ram_base ==
> NULL
>
Fixed.

> > +	return 0;
> > +}
> > +early_initcall(omap4_sar_ram_init);
> > diff --git a/arch/arm/mach-omap2/omap4-sar-layout.h
> b/arch/arm/mach-omap2/omap4-sar-layout.h
> > new file mode 100644
> > index 0000000..bb66816
> > --- /dev/null
> > +++ b/arch/arm/mach-omap2/omap4-sar-layout.h
> > @@ -0,0 +1,24 @@

[....]
> > +
> > +extern void __iomem *sar_ram_base;
>
> This patch creates this as global, but has no global users.
>
> Also, personally, I don't like these 'base address as global
> pointer'
> that are appearing throughout the OMAP4 code.  This one is
> continuing
> the pattern of some others (gic_dist_base_addr, gic_cpu_base) etc.,
> but
> I'm not crazy about them.  BTW, the gic* ones also suffer from the
> BUG
> problem and do not properly handle error conditions.
>
> It would be much cleaner to keep this base address static (and
> local)
> and just create some sar_read/write helpers that can be used from
> other code.
>
I have fixed all of these in one patch and added helper functions
to get the address. Also removed BUG_ON() from gic_*() functions
as well.

> Hmm, I see the assembly code uses this base address to.  For that, a
> helper function to get the base address could be created.
>

Regards,
Santosh
