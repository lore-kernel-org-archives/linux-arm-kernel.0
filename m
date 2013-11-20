From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 20 Nov 2013 21:58:38 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: Fix populating the hwmod data from device
 tree
In-Reply-To: <20131120192209.GI10317@atomide.com>
References: <20131120025620.GF10317@atomide.com>
 <20131120181255.GG10317@atomide.com> <20131120192209.GI10317@atomide.com>
Message-ID: <alpine.DEB.2.02.1311202148160.30143@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Nov 2013, Tony Lindgren wrote:

> * Tony Lindgren <tony@atomide.com> [131120 10:13]:
> > * Tony Lindgren <tony@atomide.com> [131119 18:57]:
> > > We have some device tree properties where the ti,hwmod has multiple
> > > values:
> > > 
> > > am33xx.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> > > am4372.dtsi:	ti,hwmods = "tpcc", "tptc0", "tptc1", "tptc2";
> 
> I think these should be defined in the .dtsi files as separate devices
> and removed from the related omap_hwmod_*_data.c files.
> 
> > > dra7.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2";
> 
> These too should be defined in the .dtsi file. Looks like we're missing
> the related data in the omap_hwmod_7xx_data.c file anyways?
> 
> > > omap3.dtsi:	ti,hwmods = "mcbsp2", "mcbsp2_sidetone";
> > > omap3.dtsi:	ti,hwmods = "mcbsp3", "mcbsp3_sidetone";
> 
> OK the sidetone data we can probably parse using the ti,hwmods as
> an index.
> 
> > > omap4.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> > > omap5.dtsi:	ti,hwmods = "l3_main_1", "l3_main_2", "l3_main_3";
> 
> Benoit, I guess these mean that those devices should be created
> dynamically, right?
> 
> Yet we've removed the related data in commit 3b9b10 and are not
> passing it in the .dtsi file?
> 
> So these should be created as separate devices in the .dtsi file
> instead AFAIK.
> 
> > Hmm I think this also needs part two to it to populate the right IO space
> > based on the index, this probably now wrongly populates the first IO space
> > for all the hwmod instances in the group.
> 
> Yeah this patch clearly is not the right fix to the problem of
> missing data.

In most of the cases with multiple hwmods per DT device, there's probably 
something wrong with the data.  So we should try to remove those when 
possible.

For example if you look at the SIDETONE blocks, those should definitely be 
separate DT devices - they have separate address spaces, SYSCONFIG 
registers, etc. (section 21.6.2 "SIDETONE register mapping summary", 
OMAP36xx TRM)

Would strongly suspect that's the case also for the EDMA blocks you 
mention.

Am not 100% sure about the L3 cases; would have to dig deeper.


- Paul
