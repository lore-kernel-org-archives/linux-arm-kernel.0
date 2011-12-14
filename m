From: t-kristo@ti.com (Tero Kristo)
Date: Wed, 14 Dec 2011 12:17:08 +0200
Subject: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD
 wakeup status
In-Reply-To: <20111213224851.GX32251@atomide.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
 <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
 <20111213222804.GV32251@atomide.com>
 <alpine.DEB.2.00.1112131530100.12046@utopia.booyaka.com>
 <20111213224851.GX32251@atomide.com>
Message-ID: <1323857828.14920.9.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2011-12-13 at 14:48 -0800, Tony Lindgren wrote:
> * Paul Walmsley <paul@pwsan.com> [111213 14:06]:
> > On Tue, 13 Dec 2011, Tony Lindgren wrote:
> > 
> > > * Paul Walmsley <paul@pwsan.com> [111213 13:44]:
> > > > 
> > > > On Mon, 12 Dec 2011, Tero Kristo wrote:
> > > > 
> > > > So the patch description says:
> > > > 
> > > > > From: R, Govindraj <govindraj.raja@ti.com>
> > > > > 
> > > > > Add API to determine IO-PAD wakeup event status for a given
> > > > > hwmod dynamic_mux pad.
> > > > 
> > > > But the code does:
> > > > 
> > > > > +	for (i = 0; i < hmux->nr_pads; i++) {
> > > > > +		struct omap_device_pad *pad = &hmux->pads[i];
> > > > 
> > > > which is going to check all of the pads, not just the dynamic ones.
> > > > 
> > > > So it seems to me that we need to decide whether this code should be 
> > > > testing all the pads, or just the dynamically remuxed ones.  The same 
> > > > thing should be decided for the code in patch 1.
> > > > 
> > > > Na?vely it seems to me that we want to test all of the pads in both 
> > > > patches 1 and 2, not just the dynamically remuxable ones.  Comments?
> > > 
> > > You're right, it should be only the dynamic ones.
> > 
> > Hmm, looks to me like it should check all of them?  Can't a pad be marked 
> > with OMAP_DEVICE_PAD_WAKEUP, but not be marked with OMAP_DEVICE_PAD_REMUX?  
> > In that case it would not end up on the dynamic list, right?
> 
> Hmm yes that's even more true :) Maybe the right approach would be to
> copy the OMAP_DEVICE_PAD_WAKEUP pins also to the dynamic list to
> avoid going through all of them.

Yea, all pads that have WAKEUP capability should be checked. Not sure if
this comment is valid anymore seeing patch 2 is kind of irrelevant with
patch 8, but the code that scans wakeups should check them all.

-Tero
