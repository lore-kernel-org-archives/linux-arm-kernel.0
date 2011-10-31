From: grant.likely@secretlab.ca (Grant Likely)
Date: Sun, 30 Oct 2011 21:13:53 -0600
Subject: [PATCH v2 2/3] arm/dt: tegra: add dts file for paz00
In-Reply-To: <4025601.AfFCiixCcK@ax5200p>
References: <cover.1319658296.git.marvin24@gmx.de>
	<3520326.MNh26pzpGT@fb07-iapwap2>
	<74CDBE0F657A3D45AFBB94109FB122FF173EDAB4C7@HQMAIL01.nvidia.com>
	<4025601.AfFCiixCcK@ax5200p>
Message-ID: <20111031031353.GB1174@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2011 at 09:39:37PM +0100, Marc Dietrich wrote:
> On Friday 28 October 2011 09:49:49 Stephen Warren wrote:
> > I also see a bunch of code to set up the memory
> > information from DT e.g. setup_machine_fdt()'s call to:
> > 
> > 	of_scan_flat_dt(early_init_dt_scan_memory, NULL);
> > 
> > ... but I assume that happens before the ATAGs are processed, and the
> > buggy ATAGs end up overriding the information in the DT file. And further,
> > I assume that specifying "mem=" on the command-line overrides that, thus
> > solving the problem.
> > 
> > It'd be awesome if you could validate this; the simplest way is probably
> > to:
> > 
> > a) Remove mem= from the command-line
> 
> I tested several variations. Without DT, the fixup can compensate a missing 
> mem entry in the kernel command line, but with a mem= from the kernel command 
> line, a fixup is not needed.
> 
> With DT, the command line specified from nvflash is ignored and the one from 
> DT comes into the game. If it is also missing there, system detects 512 MB 
> (which is physical right, but we cannot reserve memory for the gpu). The fixup 
> is indeed ignored in this case.

The /memreserve/ fields are supposed to allow you to do this.

> 
> > b) Modify arch/arm/kernel/setup.c:parse_tag_mem32() to do nothing;
> >    comment out the call to arm_add_memory()
> 
> I leave this out because the bootloader does not send memory info in the 
> ATAGS.
> 
> > c) Test booting, and check what RAM size the kernel thinks you have.
> 
> see above. RAM detection works, but it's not what we want ...
> 
> > If that works, then ATAGs are the problem. We probably need to modify the
> > core ARM code not to use memory ATAGs when there is a DT?
> > 
> > I'm mainly pushing on this because adding "mem=" to the command-line in
> > the DT file isn't a great solution; when people start using bootloaders
> > that rewrite the DT to include the user-specified command-line, then every
> > user is going to have to start specifying "mem=" in their command-lines.
> 
> Well, I see two options for our case:
> 
> 	a) use the mem=448M at 0 in the DT so the gpu can get its memory
> 	b) upstream the chromeos changes to reserve gpu memory "on the fly" from 
> the autodetected 512M (as it should be IMHO).

b) is the ideal.  a) is absolutely wrong.  /memreserve/ should fix the
gpu memory problem when not passing a mem= parameter.  If /memreserve/
isn't working, then I'd like to know why.

g.
