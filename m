From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 22 Aug 2011 17:11:54 -0700
Subject: error: implicit declaration of function 'machine_is_ventana'
In-Reply-To: <20110823000135.GD3895@n2100.arm.linux.org.uk>
References: <74CDBE0F657A3D45AFBB94109FB122FF04B24A376A@HQMAIL01.nvidia.com>
	<20110822234008.GC3895@n2100.arm.linux.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF04B24A377F@HQMAIL01.nvidia.com>
	<20110823000135.GD3895@n2100.arm.linux.org.uk>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B24A3789@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King wrote at Monday, August 22, 2011 6:02 PM:
> On Mon, Aug 22, 2011 at 04:49:06PM -0700, Stephen Warren wrote:
> > Russell King wrote at Monday, August 22, 2011 5:40 PM:
> > > On Mon, Aug 22, 2011 at 04:11:50PM -0700, Stephen Warren wrote:
> > > > Russell,
> > > >
> > > > Commit 46dcfc806a9f6834e6007449eac175f781058c49 "ARM: Update mach-types"
> > > > removed the entry for Ventana (2927). In turn, this broke compilation of
> > > > sound/soc/tegra/tegra_wm8903.c, since that calls machine_is_ventana().
> > > > It looks like the machine is still registered at
> > > > http://www.arm.linux.org.uk/developer/machines/. Can you explain what the
> > > > removal policy is for arch/arm/tools/mach-types?
...
> Ah, sorry, I thought you were talking about a platform which was merged
> into mainline.  This platform is not present in mainline, so accordingly
> it isn't marked as such in the machine database.
> 
> Any entry not marked as being present in mainline will be removed after
> 12 months after it was last touched - which apparantly was 18th June
> 2010.

Ah, that I can understand.

> So, the questions are:
> 1. why do we have driver code merged for a platform which shows no sign
>    of being merged.

Well, I or someone probably would have pushed Ventana support into
mainline within the last few months, since it's pretty similar to Harmony
and Seaboard which are both already supported. However, I've been holding
due to the no-new-board-files thing, until Device-Tree gets fully baked,
and we can then support the board just by adding a simple .dts file.

> 2. why do we have drivers depending on their platform anyway.

The ASoC subsystem defines a "machine driver", which defines facets of
the audio system such as which pins on the audio codec are connected to
the headphone jack. This varies between boards, so the "machine driver"
picks the appropriate routing table at run-time based on the board that
the code is running on. Arguably, one could represent all this data in
board files using platform data, but IIUC, the ASoC maintainers prefer
to keep it all centralized in the sound directory tree.

I understand from Grant Likely that John Bonesio will be posting a patch
in the very near future to retrieve all this data from Device Tree, so
this won't be an issue moving forward, given that Tegra will probably
switch to Device Tree pretty aggressively.

Still, I suppose we could rip out explicit support for Ventana in the
sound driver in the interim if you want, rather than adding back the
Ventana machine definition.

-- 
nvpublic
