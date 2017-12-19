From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Tue, 19 Dec 2017 09:08:14 +0100
Subject: [PATCH v4 04/12] thermal: armada: Clarify control registers
 accesses
In-Reply-To: <20171219055154.f23leaob3zndmmqo@sapphire.tkos.co.il>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-5-miquel.raynal@free-electrons.com>
 <20171218203542.msnswjqeyuudyusz@tarshish>
 <20171219013233.319365c4@xps13>
 <20171219055154.f23leaob3zndmmqo@sapphire.tkos.co.il>
Message-ID: <20171219090814.3a53ec3d@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 19 Dec 2017 07:51:54 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Miqu?l,
> 
> On Tue, Dec 19, 2017 at 01:32:33AM +0100, Miquel RAYNAL wrote:
> > On Mon, 18 Dec 2017 22:35:42 +0200
> > Baruch Siach <baruch@tkos.co.il> wrote:  
> > > On Mon, Dec 18, 2017 at 03:36:35PM +0100, Miquel Raynal wrote:  
> > > > Bindings were incomplete for a long time by only exposing one of
> > > > the two available control registers. To ease the migration to
> > > > the full bindings (already in use for the Armada 375 SoC),
> > > > rename the pointers for clarification. This way, it will only
> > > > be needed to add another pointer to access the other control
> > > > register when the time comes.
> > > > 
> > > > This avoids dangerous situations where the offset 0 of the
> > > > control area can be either one register or the other depending
> > > > on the bindings used. After this change, device trees of other
> > > > SoCs could be migrated to the "full" bindings if they may
> > > > benefit from features from the unaccessible register, without
> > > > any change in the driver.
> > > > 
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > > > Reviewed-by: Gregory CLEMENT
> > > > <gregory.clement@free-electrons.com> ---    
> > > 
> > > [...]
> > >   
> > > > +	/*
> > > > +	 * Legacy DT bindings only described "control1"
> > > > register (also referred
> > > > +	 * as "control MSB" on old documentation). New bindings
> > > > cover
> > > > +	 * "control0/control LSB" and "control1/control MSB"
> > > > registers within
> > > > +	 * the same resource, which is then of size 8 instead
> > > > of 4.
> > > > +	 */
> > > > +	if (resource_size(res) == LEGACY_CONTROL_MEM_LEN) {
> > > > +		/* ->control0 unavailable in this
> > > > configuration */
> > > > +		priv->control1 = control +
> > > > LEGACY_CONTROL1_OFFSET;
> > > > +	} else {
> > > > +		priv->control0 = control + CONTROL0_OFFSET;
> > > > +		priv->control1 = control + CONTROL1_OFFSET;
> > > > +	}    
> > > 
> > > The needs_control0 field that you mentioned in the cover page is
> > > missing here.  
> > 
> > Yes, at this point nobody actually *needs* control0 so the
> > limitation is added with the patch that introduce ap806 support as
> > it is the first compatible that needs both control0 and control1 to
> > work correctly. Does this bother you?  
> 
> No. It is just that we agreed to have a verification here that the
> size of the control registers resource matches the binding. I thought
> that the needs_control0 field that you mention in the cover page is
> meant to implement that.

That is absolutely right, but at this point in the series, the supported
compatible strings are "marvell,armada[370|375|38x|xp]-thermal". All of
them can use both bindings so I don't see the point to have a
needs_control0 field in this patch. It is introduced in the next patch
that adds support for ap806 by only supporting the new bindings
though.

> necessary. It would just make sure that no one introduces a DT with
> the wrong resource size.

Not sure I understand what exactly you wanna check, can you
give me an example?

Thank you,
Miqu?l

> 
> baruch
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
