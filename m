From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Sep 2011 15:38:16 +0200
Subject: [PATCH] at91/usb: always provide all the clocks
In-Reply-To: <4E6775EB.6060401@atmel.com>
References: <1314667768-14129-1-git-send-email-plagnioj@jcrosoft.com>
	<4E6775EB.6060401@atmel.com>
Message-ID: <20110907133816.GB14919@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15:47 Wed 07 Sep     , Nicolas Ferre wrote:
> Le 30/08/2011 03:29, Jean-Christophe PLAGNIOL-VILLARD :
> > drop the cpu_is in the driver
> > at91sam9261 and at91sam9g10 expect 3 clocks
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > ---
> >  arch/arm/mach-at91/at91cap9.c    |    2 ++
> >  arch/arm/mach-at91/at91rm9200.c  |    2 ++
> >  arch/arm/mach-at91/at91sam9260.c |    2 ++
> >  arch/arm/mach-at91/at91sam9261.c |   29 +++++++++++++++--------------
> >  arch/arm/mach-at91/at91sam9263.c |    2 ++
> >  arch/arm/mach-at91/at91sam9g45.c |    2 ++
> 
> I know that I have signed the patch *but* there is an issue here...
> 
> 
> >  drivers/usb/host/ohci-at91.c     |   15 +++++----------
> >  7 files changed, 30 insertions(+), 24 deletions(-)
> > 
> > diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
> > index bfc6844..ecdd54d 100644
> > --- a/arch/arm/mach-at91/at91cap9.c
> > +++ b/arch/arm/mach-at91/at91cap9.c
> > @@ -219,6 +219,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
> >  	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
> > +	/* fake hclk clock */
> > +	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
> >  };
> >  
> >  static struct clk_lookup usart_clocks_lookups[] = {
> > diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
> > index f73302d..713d3bd 100644
> > --- a/arch/arm/mach-at91/at91rm9200.c
> > +++ b/arch/arm/mach-at91/at91rm9200.c
> > @@ -193,6 +193,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
> > +	/* fake hclk clock */
> > +	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
> >  };
> >  
> >  static struct clk_lookup usart_clocks_lookups[] = {
> > diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
> > index cb397be..a9be758 100644
> > --- a/arch/arm/mach-at91/at91sam9260.c
> > +++ b/arch/arm/mach-at91/at91sam9260.c
> > @@ -199,6 +199,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
> >  	CLKDEV_CON_DEV_ID("t4_clk", "atmel_tcb.1", &tc4_clk),
> >  	CLKDEV_CON_DEV_ID("t5_clk", "atmel_tcb.1", &tc5_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc_clk),
> > +	/* fake hclk clock */
> > +	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
> >  };
> >  
> >  static struct clk_lookup usart_clocks_lookups[] = {
> > diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
> > index 6c8e3b5..658a518 100644
> > --- a/arch/arm/mach-at91/at91sam9261.c
> > +++ b/arch/arm/mach-at91/at91sam9261.c
> > @@ -129,6 +129,20 @@ static struct clk lcdc_clk = {
> >  	.type		= CLK_TYPE_PERIPHERAL,
> >  };
> >  
> > +/* HClocks */
> > +static struct clk hck0 = {
> > +	.name		= "hck0",
> > +	.pmc_mask	= AT91_PMC_HCK0,
> > +	.type		= CLK_TYPE_SYSTEM,
> > +	.id		= 0,
> > +};
> > +static struct clk hck1 = {
> > +	.name		= "hck1",
> > +	.pmc_mask	= AT91_PMC_HCK1,
> > +	.type		= CLK_TYPE_SYSTEM,
> > +	.id		= 1,
> > +};
> > +
> >  static struct clk *periph_clocks[] __initdata = {
> >  	&pioA_clk,
> >  	&pioB_clk,
> > @@ -161,6 +175,7 @@ static struct clk_lookup periph_clocks_lookups[] = {
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.0", &ssc0_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.1", &ssc1_clk),
> >  	CLKDEV_CON_DEV_ID("pclk", "ssc.2", &ssc2_clk),
> > +	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &hck0),
> >  };
> >  
> >  static struct clk_lookup usart_clocks_lookups[] = {
> > @@ -199,20 +214,6 @@ static struct clk pck3 = {
> >  	.id		= 3,
> >  };
> >  
> > -/* HClocks */
> > -static struct clk hck0 = {
> > -	.name		= "hck0",
> > -	.pmc_mask	= AT91_PMC_HCK0,
> > -	.type		= CLK_TYPE_SYSTEM,
> > -	.id		= 0,
> > -};
> > -static struct clk hck1 = {
> > -	.name		= "hck1",
> > -	.pmc_mask	= AT91_PMC_HCK1,
> > -	.type		= CLK_TYPE_SYSTEM,
> > -	.id		= 1,
> > -};
> > -
> >  static void __init at91sam9261_register_clocks(void)
> >  {
> >  	int i;
> > diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
> > index 044f3c9..f83fbb0 100644
> > --- a/arch/arm/mach-at91/at91sam9263.c
> > +++ b/arch/arm/mach-at91/at91sam9263.c
> > @@ -189,6 +189,8 @@ static struct clk_lookup periph_clocks_lookups[] = {
> >  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.0", &spi0_clk),
> >  	CLKDEV_CON_DEV_ID("spi_clk", "atmel_spi.1", &spi1_clk),
> >  	CLKDEV_CON_DEV_ID("t0_clk", "atmel_tcb.0", &tcb_clk),
> > +	/* fake hclk clock */
> > +	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &ohci_clk),
> 
> We cannot do this: it does not even compiles.
> The ohci_clk clock is not existing on this device. Moreover, the "hclk"
> con_id is already existing for the *gadget* device...
> 
> We have to correct this before I can send it upstream.
we can as the conid + devid are prioritary than just the conid

so
	CLKDEV_CON_DEV_ID("hclk", "at91_ohci", &uhphs_clk),

Best Regards,
J.
