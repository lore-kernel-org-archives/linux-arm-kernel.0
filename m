From: viresh.kumar@st.com (viresh kumar)
Date: Tue, 7 Sep 2010 16:21:24 +0530
Subject: [PATCH 43/74] ST SPEAr : EMI (Extrenal Memory Interface)
	controller driver
In-Reply-To: <20100906224050.GA8153@game.jcrosoft.org>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<468bb871e1ce062fbde39f78600b23a896b57a72.1283161023.git.viresh.kumar@st.com>
	<20100906224050.GA8153@game.jcrosoft.org>
Message-ID: <4C86192C.801@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/7/2010 4:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>> diff --git a/arch/arm/mach-spear3xx/clock.c b/arch/arm/mach-spear3xx/clock.c
>> > index 41a2b5e..4f049fe 100644
>> > --- a/arch/arm/mach-spear3xx/clock.c
>> > +++ b/arch/arm/mach-spear3xx/clock.c
>> > @@ -552,6 +552,15 @@ static struct clk adc_clk = {
>> >       .recalc = &follow_parent,
>> >  };
>> >
>> > +#if defined(CONFIG_MACH_SPEAR310) || defined(CONFIG_MACH_SPEAR320)
> can you create a macro for this?
> or even better detect it
> 

It should be statically allocated, registering this to clkdev framework
should be dynamic, which is done in my local repository (as mentioned in
i2c patch).

Regarding creating macros: As we have three machines in spear3xx (300, 310, 320)
we need to create 4 macros (300 & 310, 310 &320, 300 & 320, 300&310&320),
This will make it even more complex to read. So, i would like to keep it as it is.

>> > +/* emi clock */
>> > +static struct clk emi_clk = {
>> > +     .flags = ALWAYS_ENABLED,
>> > +     .pclk = &ahb_clk,
>> > +     .recalc = &follow_parent,
>> > +};
>> > +#endif


>> +/* emi nor flash device registeration */
>> > +static struct physmap_flash_data emi_norflash_data;
>> > +
>> > +static struct resource emi_nor_resources[] = {
>> > +     {
>> > +             .start  = SPEAR310_EMI_MEM_0_BASE,
>> > +             .end    = SPEAR310_EMI_MEM_0_BASE + SPEAR310_EMI_MEM_SIZE - 1,
>> > +             .flags  = IORESOURCE_MEM,
>> > +     },
>> > +};
> it's board specfic not mach
> 
> NACK

No. This is machine specific. Same for all boards.
