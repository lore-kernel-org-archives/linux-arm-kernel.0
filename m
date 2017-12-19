From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Tue, 19 Dec 2017 01:32:33 +0100
Subject: [PATCH v4 04/12] thermal: armada: Clarify control registers
 accesses
In-Reply-To: <20171218203542.msnswjqeyuudyusz@tarshish>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-5-miquel.raynal@free-electrons.com>
 <20171218203542.msnswjqeyuudyusz@tarshish>
Message-ID: <20171219013233.319365c4@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Baruch,

On Mon, 18 Dec 2017 22:35:42 +0200
Baruch Siach <baruch@tkos.co.il> wrote:

> Hi Miqu?l,
> 
> On Mon, Dec 18, 2017 at 03:36:35PM +0100, Miquel Raynal wrote:
> > Bindings were incomplete for a long time by only exposing one of
> > the two available control registers. To ease the migration to the
> > full bindings (already in use for the Armada 375 SoC), rename the
> > pointers for clarification. This way, it will only be needed to add
> > another pointer to access the other control register when the time
> > comes.
> > 
> > This avoids dangerous situations where the offset 0 of the control
> > area can be either one register or the other depending on the
> > bindings used. After this change, device trees of other SoCs could
> > be migrated to the "full" bindings if they may benefit from
> > features from the unaccessible register, without any change in the
> > driver.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> > Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---  
> 
> [...]
> 
> > +	/*
> > +	 * Legacy DT bindings only described "control1" register
> > (also referred
> > +	 * as "control MSB" on old documentation). New bindings
> > cover
> > +	 * "control0/control LSB" and "control1/control MSB"
> > registers within
> > +	 * the same resource, which is then of size 8 instead of 4.
> > +	 */
> > +	if (resource_size(res) == LEGACY_CONTROL_MEM_LEN) {
> > +		/* ->control0 unavailable in this configuration */
> > +		priv->control1 = control + LEGACY_CONTROL1_OFFSET;
> > +	} else {
> > +		priv->control0 = control + CONTROL0_OFFSET;
> > +		priv->control1 = control + CONTROL1_OFFSET;
> > +	}  
> 
> The needs_control0 field that you mentioned in the cover page is
> missing here.

Yes, at this point nobody actually *needs* control0 so the limitation
is added with the patch that introduce ap806 support as it is the first
compatible that needs both control0 and control1 to work correctly.
Does this bother you?

Thanks,
Miqu?l

> 
> baruch
> 



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
