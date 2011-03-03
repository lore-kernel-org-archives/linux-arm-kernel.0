From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 3 Mar 2011 21:59:04 +0530
Subject: [PATCH 08/17] omap4: pm: Add GIC save/restore support
In-Reply-To: <8739n55f75.fsf@ti.com>
References: <1298112158-28469-1-git-send-email-santosh.shilimkar@ti.com><1298112158-28469-9-git-send-email-santosh.shilimkar@ti.com>
	<8739n55f75.fsf@ti.com>
Message-ID: <000b275e5d210abd5dec6c09c5508734@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Kevin Hilman [mailto:khilman at ti.com]
> Sent: Thursday, March 03, 2011 4:00 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 08/17] omap4: pm: Add GIC save/restore support
[...]

> > @@ -67,6 +82,17 @@ struct omap4_cpu_pm_info {
> >
> >  static DEFINE_PER_CPU(struct omap4_cpu_pm_info, omap4_pm_info);
> >
> > +/* Helper functions */
> > +static inline void sar_writel(u32 val, u32 offset, u8 idx)
> > +{
> > +	__raw_writel(val, sar_ram_base + offset + 4 * idx);
> > +}
>
> aha, this is what I was thinking of in the earlier SAR patch.
>
> Something like this should be part of the SAR code, not here.
>
If you remember during the internal review, this helpers
are added to improve the readability and they are inline
functions. Same is the case with wakeupgen save code.

If you move this code to SAR file and GIC helper
to gic file, the save routine will become highly
un-optimal.

In General Save is like below.
	Read_Harfware_register()
	Write_it_sar_location()

This happens for every GIC and wakeupgen
registers and hence moving this across files
and calling them from there is going add un-necessary
stack overhead.

I already got rid-off the global address pointers. I will
get those now using omap4_get_*_base() and store it for
local use in the file.


> > +static inline u32 gic_readl(u32 offset, u8 idx)
> > +{
> > +	return __raw_readl(gic_dist_base_addr + offset + 4 * idx);
> > +}
>
> Similarily, it would be nice tos see this as part of GIC code so
> this code doesn't have to access a global base address pointer.
>
Same comment applies here too.

Regards
Santosh
