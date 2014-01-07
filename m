From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 7 Jan 2014 16:10:04 +0200
Subject: [PATCH v2 4/6] ARM: tegra: rework fuse.c
In-Reply-To: <52CB1722.70306@wwwdotorg.org>
References: <1387891931-9854-1-git-send-email-pdeschrijver@nvidia.com>
 <1387891931-9854-5-git-send-email-pdeschrijver@nvidia.com>
 <52CB1722.70306@wwwdotorg.org>
Message-ID: <20140107141004.GF26588@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 09:50:42PM +0100, Stephen Warren wrote:
> On 12/24/2013 06:32 AM, Peter De Schrijver wrote:
> > Reduce fuse.c to the minimum functionality required for the early bootstages.
> >
> > Also export tegra_read_straps() for use by the fuse driver.
> 
> Since the fuse driver is tristate, it could be a module. Doesn't it
> literally need to be EXPORT_SYMBOL'd, not simply not static?
> 

Good point.

> I'm rather worried that this series isn't bisectable, since this patch
> removes a bunch of code that's replaced by code in the fuse driver which
> can't be built/linked at this point in the series. I'm also worried
> about initialization ordering, since a lot of the fuse code could be a
> module...
> 

Maybe it should indeed never be a module...

> > diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
> 
> > -/* Tegra20 only */
> >  #define FUSE_UID_LOW		0x108
> >  #define FUSE_UID_HIGH		0x10c
> 
> Why remove that comment but leave the two defines it applies to?
> 
> >  #define TEGRA20_FUSE_SPARE_BIT		0x200
> 
> That define, and tegra_spare_fuse() which uses it, are no longer used
> after patch 5/6, but aren't removed in patch 5/6. Perhaps it'd be better
> to squash or re-order the two patches, so this dead code can be removed?
> 
> > -int tegra_sku_id;
> > -int tegra_cpu_process_id;
> > -int tegra_core_process_id;
> >  int tegra_chip_id;
> > -int tegra_cpu_speedo_id;		/* only exist in Tegra30 and later */
> > -int tegra_soc_speedo_id;
> >  enum tegra_revision tegra_revision;
> 
> It's a bit odd to remove most of this, but leave a few parts hanging
> around. Wouldn't it be better to the drivers/misc/fuse code to export
> this, so that /all/ the fuse logic was there, rather than part of it
> being left over in arch/arm/? We'll need to fix that up anyway when we
> start using these globals on ARMv8, so may as well get it right now.
> Also, I rather think that the new drivers/misc/fuse code shouldn't be a
> module or driver, so that we can guarantee it's always there to provide
> the globals and that they are initialized early enough...

tegra_revision is used in tegra_dt_init() to initialize soc_dev_attr->revision
Hence this needs to be available before the fuse driver is initialized.

Cheers,

Peter.
