From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 29 Oct 2011 12:44:18 +0100
Subject: [PATCH v2 2/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <20111029110320.GD20132@ponder.secretlab.ca>
References: <cover.1319658296.git.marvin24@gmx.de>
	<e528a8eb783ace4729e0c76ca72d500d5281c9af.1319658296.git.marvin24@gmx.de>
	<74CDBE0F657A3D45AFBB94109FB122FF173E1B48D7@HQMAIL01.nvidia.com>
	<3520326.MNh26pzpGT@fb07-iapwap2>
	<74CDBE0F657A3D45AFBB94109FB122FF173EDAB4C7@HQMAIL01.nvidia.com>
	<20111029084330.GW19187@n2100.arm.linux.org.uk>
	<20111029110320.GD20132@ponder.secretlab.ca>
Message-ID: <20111029114418.GZ19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2011 at 01:03:20PM +0200, Grant Likely wrote:
> On Sat, Oct 29, 2011 at 09:43:30AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Oct 28, 2011 at 09:49:49AM -0700, Stephen Warren wrote:
> > > When boards boot from DT, there is no fixup function to override the
> > > bootloader's ATAGs. I also see a bunch of code to set up the memory
> > > information from DT e.g. setup_machine_fdt()'s call to:
> > > 
> > > 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > > 
> > > ... but I assume that happens before the ATAGs are processed, and the
> > > buggy ATAGs end up overriding the information in the DT file.
> > 
> > As far as the uncompressed kernel is concerned, there is either ATAG
> > or DT information, never both.  If the boot loader provides ATAGs and
> > the zImage has a DT appended to it, the zImage decompressor merges the
> > ATAGs into the appended DT and passes the DT to the kernel.
> > 
> > So anyone who currently 'fixes' their broken boot loader via the fixup
> > function by directly manipulating the ATAGS is going to hit the DT
> > image instead.
> 
> Ugh.  Not pretty.  A platform could still have board specific fixup
> code that matches on the compatible string that deals with broken
> firmware ATAGs, but I don't think that is what we want to do.

No.  The point I was making is that by the time you get to the fixup
function with a DT or even into the uncompressed kernel, even if the
boot loader provided ATAGs, your ATAGs have long since been obliterated
and are no longer available.
