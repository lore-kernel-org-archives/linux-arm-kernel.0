From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 4 May 2012 19:47:38 +0000
Subject: [PATCH 01/02] mach-shmobile: Emma Mobile EV2 SoC base support
In-Reply-To: <201205041307.46080.arnd@arndb.de>
References: <20120503144645.6390.62303.sendpatchset@w520>
 <20120503144654.6390.56399.sendpatchset@w520>
 <201205041307.46080.arnd@arndb.de>
Message-ID: <201205041947.38375.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 May 2012, Arnd Bergmann wrote:
> 
> On Thursday 03 May 2012, Magnus Damm wrote:
> 
> > +
> > +/* EMEV2 SMU registers */
> > +#define USIAU0_RSTCTRL 0xe0110094
> > +#define USIBU1_RSTCTRL 0xe01100ac
> > +#define USIBU2_RSTCTRL 0xe01100b0
> > +#define USIBU3_RSTCTRL 0xe01100b4
> > +#define STI_RSTCTRL 0xe0110124
> > +#define USIAU0GCLKCTRL 0xe01104a0
> > +#define USIBU1GCLKCTRL 0xe01104b8
> > +#define USIBU2GCLKCTRL 0xe01104bc
> > +#define USIBU3GCLKCTRL 0xe01104c0
> > +#define STIGCLKCTRL 0xe0110528
> > +#define USIAU0SCLKDIV 0xe011061c
> > +#define USIB2SCLKDIV 0xe011065c
> > +#define USIB3SCLKDIV 0xe0110660
> > +#define STI_CLKSEL 0xe0110688
> 
> Please cast to __iomem* here, e.g. using the IOMEM() macro, as these are
> virtual addresses.

I should revise that: there is no excuse to hardcode these virtual address
here at all. Just use call ioremap() on the physical address for the
clock registers (0xe0110000) and use the resulting pointer with an
offset that you define locally in this file.

It is safe to call ioremap when you get to emev2_clock_init()
and you will still get a large page mapping with the recent
code reworks for map_desc.

Regarding the iotable that is currently defined as

+static struct map_desc emev2_io_desc[] __initdata = {
+       /* 128K entity map for 0xe0020000 (GIC) */
+       {
+               .virtual        = 0xe0020000,
+               .pfn            = __phys_to_pfn(0xe0020000),
+               .length         = SZ_128K,
+               .type           = MT_UNCACHED
+       },
+       /* 128K entity map for 0xe0100000 (SMU) */
+       {
+               .virtual        = 0xe0100000,
+               .pfn            = __phys_to_pfn(0xe0100000),
+               .length         = SZ_128K,
+               .type           = MT_DEVICE
+       },
+};

I would recommend just mapping the entire 16MB page around this, or at least
2 MB, so you can benefit from the larger mappings. If you don't do that,
better remove the entire iotable registration and rely on ioremap, the
result will be the same and you can be prevent any hacks from creeping in
that rely on the virtual address being the same as the physical address.

	Arnd
