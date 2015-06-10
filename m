From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 10 Jun 2015 16:55:46 +0200
Subject: [PATCH] clk: at91: modify PMC peripheral clock to deal with
 newer register layout
In-Reply-To: <55784C2C.8070701@atmel.com>
References: <1433943764-18506-1-git-send-email-nicolas.ferre@atmel.com>
 <20150610155545.171fd92d@bbrezillon> <55784C2C.8070701@atmel.com>
Message-ID: <20150610165546.5d7c8033@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Jun 2015 16:39:40 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Le 10/06/2015 15:55, Boris Brezillon a ?crit :
> > Hi Nicolas,
> > 
> > On Wed, 10 Jun 2015 15:42:44 +0200
> > Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> > 
> >> As some more information is added to the PCR register, we'd better use
> >> a copy of its content and modify just the peripheral-related bits.
> >> Implement a read-modify-write for the enable() and disable() callbacks.
> >>
> >> Header file is also modified to have the PCR_DIV mask.
> >>
> >> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> > 
> > Apart from the below comment you can add my:
> > 
> > Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> >> ---
> >>  drivers/clk/at91/clk-peripheral.c | 19 +++++++++++++------
> >>  include/linux/clk/at91_pmc.h      |  3 ++-
> >>  2 files changed, 15 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
> >> index 597fed423d7d..37e2fea14890 100644
> >> --- a/drivers/clk/at91/clk-peripheral.c
> >> +++ b/drivers/clk/at91/clk-peripheral.c
> >> @@ -161,14 +161,17 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
> >>  {
> >>  	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
> >>  	struct at91_pmc *pmc = periph->pmc;
> >> +	u32 tmp;
> >>  
> >>  	if (periph->id < PERIPHERAL_ID_MIN)
> >>  		return 0;
> >>  
> >> -	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
> >> -				     AT91_PMC_PCR_CMD |
> >> -				     AT91_PMC_PCR_DIV(periph->div) |
> >> -				     AT91_PMC_PCR_EN);
> >> +	pmc_lock(pmc);
> >> +	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
> >> +	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_P_DIV;
> >> +	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_PDIV(periph->div)
> >> +					 | AT91_PMC_PCR_EN);
> >> +	pmc_unlock(pmc);
> >>  	return 0;
> >>  }
> >>  
> >> @@ -176,12 +179,16 @@ static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
> >>  {
> >>  	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
> >>  	struct at91_pmc *pmc = periph->pmc;
> >> +	u32 tmp;
> >>  
> >>  	if (periph->id < PERIPHERAL_ID_MIN)
> >>  		return;
> >>  
> >> -	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
> >> -				     AT91_PMC_PCR_CMD);
> >> +	pmc_lock(pmc);
> >> +	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
> >> +	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_EN;
> >> +	pmc_write(pmc, AT91_PMC_PCR, tmp);
> >> +	pmc_unlock(pmc);
> >>  }
> >>  
> >>  static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
> >> diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
> >> index 7669f7618f39..4685c3d62f94 100644
> >> --- a/include/linux/clk/at91_pmc.h
> >> +++ b/include/linux/clk/at91_pmc.h
> >> @@ -184,7 +184,8 @@ extern void __iomem *at91_pmc_base;
> >>  #define AT91_PMC_PCR		0x10c			/* Peripheral Control Register [some SAM9 and SAMA5] */
> >>  #define		AT91_PMC_PCR_PID	(0x3f  <<  0)		/* Peripheral ID */
> >>  #define		AT91_PMC_PCR_CMD	(0x1  <<  12)		/* Command (read=0, write=1) */
> >> -#define		AT91_PMC_PCR_DIV(n)	((n)  <<  16)		/* Divisor Value */
> >> +#define		AT91_PMC_PCR_P_DIV	(0x3  <<  16)		/* Divisor mask */
> > 
> > How about renaming this macro into AT91_PMC_PCR_PDIV_MSK ?
> > I know the macro names in this file are not consistent, but maybe it's
> > time to choose appropriate names for new AT91_PMC macros.
> 
> Well, this is what I tried to find: consistency ;-)
> It seems that other macros are like I did for this one: the pure name of
> the field for the mask and some kind of other form of the name for a
> value macro or a (usually useless) list of macro-per-value things.
> 
> For this one I added a "P" for peripheral which is not in the real name
> of the register field. This is to differentiate it from the upcoming
> GCK_DIV field...

Yes, but that doesn't help in describing what the macros are really
representing. My point is that, yes moving to _MSK doesn't add any
consistency, but there already is no consistency in the existing names,
so, IMHO, we should at least choose representative names.
I'm not arguing against the addition of a P before the DIV word, but
why is P_DIV chosen to reprensent the mask and PDIV used to define the
macro building the value to be stored in the PCR register ?


-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
