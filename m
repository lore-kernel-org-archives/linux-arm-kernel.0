From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 19 Aug 2011 15:17:57 +0800
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <20110819064356.GC12527@S2100-06.ap.freescale.net>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<20110819064356.GC12527@S2100-06.ap.freescale.net>
Message-ID: <20110819071756.GE12527@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 19, 2011 at 02:43:57PM +0800, Shawn Guo wrote:
> On Tue, Aug 16, 2011 at 03:34:54PM -0500, Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > This adds basic support for the Calxeda Highbank platform.
> > 
> > Signed-off-by: Rob Herring <rob.herring@calxeda.com>
[...]
> > +static void __init highbank_map_io(void)
> > +{
> > +	unsigned long base;
> > +
> > +	/* Get SCU base */
> > +	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> > +
> > +	highbank_io_desc[0].pfn = __phys_to_pfn(base);
> > +	iotable_init(highbank_io_desc, ARRAY_SIZE(highbank_io_desc));
> > +}
> > +
> It's a great demo that we can get this base address from CA9 itself.
> However I'm wondering if we have to do so, since this address should
> be known for given SoC.  Can we put this known base into device tree
> and map it when needed?  In that case, we can save another static
> mapping.
> 
Hmm, if CA9 can figure this address out by itself, why do not we create
a init hook in arch/arm/kernel/smp_scu.c to have scu code to get and
map the address?  Then the parameter "scu_base" in those scu helper
functions can be saved.

-- 
Regards,
Shawn
