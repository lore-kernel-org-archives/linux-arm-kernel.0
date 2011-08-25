From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 25 Aug 2011 12:03:39 +0800
Subject: [PATCH 2/6] ARM: add Highbank core platform support
In-Reply-To: <4E55B748.1000306@gmail.com>
References: <1313526898-19920-1-git-send-email-robherring2@gmail.com>
	<1313526898-19920-3-git-send-email-robherring2@gmail.com>
	<201108181734.25397.arnd@arndb.de> <4E5000A1.8060609@gmail.com>
	<4E55B748.1000306@gmail.com>
Message-ID: <20110825040338.GB16853@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 09:45:28PM -0500, Rob Herring wrote:
> Arnd,
> 
> On 08/20/2011 01:44 PM, Rob Herring wrote:
> > Arnd,
> > 
> > On 08/18/2011 10:34 AM, Arnd Bergmann wrote:
> >> On Tuesday 16 August 2011, Rob Herring wrote:
> >>
> >>> +void __iomem *a9_base_addr = ((void __iomem *)(HB_MPIC_VIRT_BASE));
> >>> +void __iomem *sregs_base;
> >>> +
> >>> +static struct map_desc highbank_io_desc[] __initdata = {
> >>> +	{
> >>> +		.virtual	= HB_MPIC_VIRT_BASE,
> >>> +		.pfn		= 0, /* run-time */
> >>> +		.length		= SZ_4K,
> >>> +		.type		= MT_DEVICE,
> >>> +	},
> >>> +#ifdef CONFIG_DEBUG_LL
> >>> +	{
> >>> +		.virtual	= HB_DEBUG_LL_VIRT_BASE,
> >>> +		.pfn		= __phys_to_pfn(HB_DEBUG_LL_PHYS_BASE),
> >>> +		.length		= SZ_4K,
> >>> +		.type		= MT_DEVICE,
> >>> +	},
> >>> +#endif
> >>> +};
> >>> +
> >>> +static void __init highbank_map_io(void)
> >>> +{
> >>> +	unsigned long base;
> >>> +
> >>> +	/* Get SCU base */
> >>> +	asm("mrc p15, 4, %0, c15, c0, 0" : "=r" (base));
> >>> +
> >>> +	highbank_io_desc[0].pfn = __phys_to_pfn(base);
> >>> +	iotable_init(highbank_io_desc, ARRAY_SIZE(highbank_io_desc));
> >>> +}
> >>
> >> I really liked the way that Barry moved the io_desc out to the
> >> drivers using them, e.g arch/arm/mach-prima2/lluart.c.
> >>
> >> Can you do the same thing with your lluart and with the a9_base_addr?
> >> I guess it can live locally in platsmp.c.
> > 
> > Okay.
> 
> Looking at this some more, it doesn't work too well. platsmp.c depends
> on CONFIG_SMP, but the SCU mapping is always needed even for !SMP
> because the SCU has a power mode register for each core used by the
> power controller. So putting it in platsmp.c would add ifdefs.
> 
It sounds you have a well designed power controller which will shut
down different CA-9 power domains per SCU power mode settings, e.g.
it will shut off different set of CA-9 power domains for Dormant and
Shutdown modes.  Is that the case?

i.MX6Q is different from that case, so I can actually follow Arnd's
suggestion to keep scu_base locally in platsmp.c.

-- 
Regards,
Shawn
