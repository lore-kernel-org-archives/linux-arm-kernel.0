From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 21 Feb 2011 11:53:27 -0700 (MST)
Subject: [PATCH 3/3] OMAP2+: voltage: reorganize, split code from data
In-Reply-To: <AANLkTikdx41hE5d5xG8rpB95DUvVu0=VHi6Zj=ePtREb@mail.gmail.com>
References: <20110221020231.7598.14024.stgit@twilight.localdomain>
	<20110221020856.7598.34506.stgit@twilight.localdomain>
	<AANLkTikdx41hE5d5xG8rpB95DUvVu0=VHi6Zj=ePtREb@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102211034450.22636@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

On Mon, 21 Feb 2011, Gulati, Shweta wrote:

> On Mon, Feb 21, 2011 at 7:38 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2/opp3xxx_data.c
> > index 0486fce..3c7f0c0 100644
> > --- a/arch/arm/mach-omap2/opp3xxx_data.c
> > +++ b/arch/arm/mach-omap2/opp3xxx_data.c

...

> > +/* VDD2 */
> > +struct omap_volt_data omap36xx_vddcore_volt_data[] = {
> > + ? ? ? VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP50_UV, OMAP3630_CONTROL_FUSE_OPP50_VDD2, 0xf4, 0x0c),
> > + ? ? ? VOLT_DATA_DEFINE(OMAP3630_VDD_CORE_OPP100_UV, OMAP3630_CONTROL_FUSE_OPP100_VDD2, 0xf9, 0x16),
> > + ? ? ? VOLT_DATA_DEFINE(0, 0, 0, 0),
> > +};
> > +
> The definition of "VOLT_DATA_DEFINE" is there in voltage.h
> I think its better to move these Volt_data to voltagedomains files
> rather than in
> OPP layer files

opp*_data.c is currently where process/wafer/die-variable parameters go.  
The struct omap_volt_data also consists mostly[1] of 
process/wafer/die-variable parameters.  So it made sense to group it 
there.

In comparison, voltagedomains*_data.c files consist of 
process/wafer/die-invariant data, such as register layouts, voltage domain 
partitioning, etc.  This is data that we don't expect to ever change over 
the lifetime of a production design.

You are correct in that there seems to be little point leaving the 
VOLT_DATA_DEFINE macro in voltage.h, so I have moved this to 
omap_opp_data.h.


- Paul

1. The SCM register offsets in the struct omap_volt_data don't technically 
belong in the process/wafer/die-variable parameters.  It probably would 
make sense to replace these with SCM OPP IDs, and then to create an 
interface in the SCM code to fetch the SR data from the SCM, given an OPP 
ID.
