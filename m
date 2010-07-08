From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 9 Jul 2010 00:58:59 +0200
Subject: [PATCH 3/5] colibri-pxa300: add uart support
In-Reply-To: <201007082242.25524.pieterg@gmx.com>
References: <201007081904.08769.pieterg@gmx.com>
	<201007082201.23064.marek.vasut@gmail.com>
	<201007082242.25524.pieterg@gmx.com>
Message-ID: <201007090058.59878.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne ?t 8. ?ervence 2010 22:42:25 pieterg napsal(a):
> On Thursday 08 July 2010 22:01:22 Marek Vasut wrote:
> > Dne ?t 8. ?ervence 2010 19:04:08 pieterg napsal(a):
> > > Signed-off-by: pieter <p.grimmerink@inepro.com>
> > > ---
> > > 
> > >  arch/arm/mach-pxa/colibri-pxa300.c |   28 ++++++++++++++++++++++++++++
> > >  1 files changed, 28 insertions(+), 0 deletions(-)
> > > 
> > > diff --git a/arch/arm/mach-pxa/colibri-pxa300.c
> > > b/arch/arm/mach-pxa/colibri-pxa300.c
> > > index e7762ae..381857d 100644
> > > --- a/arch/arm/mach-pxa/colibri-pxa300.c
> > > +++ b/arch/arm/mach-pxa/colibri-pxa300.c
> > > @@ -170,6 +170,33 @@ static inline void __init colibri_pxa310_init_ac97
> > > (void)
> > > 
> > >  static inline void colibri_pxa310_init_ac97(void) {}
> > >  #endif
> > > 
> > > +static mfp_cfg_t colibri_pxa300_uart_pin_config[] __initdata = {
> > > +	/* FFUART */
> > > +	GPIO99_UART1_RXD,
> > > +	GPIO100_UART1_TXD,
> > > +	GPIO101_UART1_CTS,
> > > +	GPIO102_UART1_DCD,
> > > +	GPIO103_UART1_DTR,
> > > +	GPIO104_UART1_RI,
> > > +	GPIO105_UART1_DSR,
> > > +	GPIO106_UART1_RTS,
> > > +
> > > +	/* BTUART */
> > > +	GPIO111_UART2_CTS,
> > > +	GPIO112_UART2_RXD,
> > > +	GPIO113_UART2_TXD,
> > > +	GPIO114_UART2_RTS,
> > > +
> > > +	/* STUART */
> > > +	GPIO8_UART3_TXD,
> > > +	GPIO110_UART3_RXD,
> > > +};
> > > +
> > > +static void __init colibri_pxa300_init_uart(void)
> > > +{
> > > +	pxa3xx_mfp_config(ARRAY_AND_SIZE(colibri_pxa300_uart_pin_config));
> > > +}
> > > +
> > > 
> > >  void __init colibri_pxa300_init(void)
> > >  {
> > >  
> > >  	pxa_set_ffuart_info(NULL);
> > > 
> > > @@ -184,6 +211,7 @@ void __init colibri_pxa300_init(void)
> > > 
> > >  	colibri_pxa310_init_ac97();
> > > 	
> > > 	colibri_pxa3xx_init_mmc(ARRAY_AND_SIZE(colibri_pxa300_mmc_pin_config),
> > > 
> > > mfp_to_gpio(MFP_PIN_GPIO13));
> > > +	colibri_pxa300_init_uart();
> > > 
> > >  }
> > >  
> > >  MACHINE_START(COLIBRI300, "Toradex Colibri PXA300")
> > 
> > Can't you put this into the board MFP config array ?
> 
> As far as I see, the colibri's don't have a global MFP array anymore.
> Everything is split into function groups.
> (which I think is nice btw, compared to -say- zylonite, where the MFP's do
> not obey CONFIG)
> 
> > Or the other way --
> > register UARTs into that new function you introduced ?
> 
> You mean somehow make it easier for users to select which uarts they want,
> and which they don't?
> Indeed this construction makes it impossible to use those gpio's for
> anything else, but this is exactly how the uart gpio's are configured in
> colibri-pxa320.c as well. So if there's a nicer way, we'd have to the same
> there as well.
> 
> (a nice way in general might perhaps be to enable/disable all 3 uarts from
> the config. Though people might object to an increase in the number of
> necessary config variables)
> 
> Or do you just mean moving the pxa_set_xxuart_info calls into
> colibri_pxa300_init_uart, so we keep all uart stuff together?

This is what I mean, sorry, lack of sleep.
> 
> Rgds, Pieter
