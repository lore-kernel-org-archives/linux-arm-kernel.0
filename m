From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 31 Oct 2011 08:51:43 -0700
Subject: [PATCH v2 2/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <20111029084330.GW19187@n2100.arm.linux.org.uk>
References: <cover.1319658296.git.marvin24@gmx.de>
	<e528a8eb783ace4729e0c76ca72d500d5281c9af.1319658296.git.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B48D7@HQMAIL01.nvidia.com>
	<3520326.MNh26pzpGT@fb07-iapwap2>
	<74CDBE0F657A3D45AFBB94109FB122FF173EDAB4C7@HQMAIL01.nvidia.com>
	<20111029084330.GW19187@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF173EDAB770@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Saturday, October 29, 2011 2:44 AM:
> On Fri, Oct 28, 2011 at 09:49:49AM -0700, Stephen Warren wrote:
> > When boards boot from DT, there is no fixup function to override the
> > bootloader's ATAGs. I also see a bunch of code to set up the memory
> > information from DT e.g. setup_machine_fdt()'s call to:
> >
> > 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> >
> > ... but I assume that happens before the ATAGs are processed, and the
> > buggy ATAGs end up overriding the information in the DT file.
> 
> As far as the uncompressed kernel is concerned, there is either ATAG
> or DT information, never both.  If the boot loader provides ATAGs and
> the zImage has a DT appended to it, the zImage decompressor merges the
> ATAGs into the appended DT and passes the DT to the kernel.
> 
> So anyone who currently 'fixes' their broken boot loader via the fixup
> function by directly manipulating the ATAGS is going to hit the DT
> image instead.

I believe the PAZ00 fixup function runs on the kernel's internal data-
structures, not the ATAGs directly, so the issue you point out isn't
a problem here:

static void __init tegra_paz00_fixup(struct tag *tags, char **cmdline,
        struct meminfo *mi)
{
        mi->nr_banks = 1;
        mi->bank[0].start = PHYS_OFFSET;
        mi->bank[0].size = 448 * SZ_1M;
}

-- 
nvpublic
