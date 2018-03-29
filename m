From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Thu, 29 Mar 2018 16:29:22 +0200
Subject: [PATCH] mtd: nand: raw: atmel: add module param to avoid using dma
In-Reply-To: <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <30d8bd45-4e5d-3703-5f41-07f5fc70f09d@microchip.com>
Message-ID: <20180329162922.5db7acd1@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Mar 2018 16:20:38 +0200
Nicolas Ferre <nicolas.ferre@microchip.com> wrote:

> On 29/03/2018 at 15:10, Peter Rosin wrote:
> > On a sama5d31 with a Full-HD dual LVDS panel (132MHz pixel clock) NAND
> > flash accesses have a tendency to cause display disturbances. Add a
> > module param to disable DMA from the NAND controller, since that fixes
> > the display problem for me.
> > 
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> > ---
> >   drivers/mtd/nand/raw/atmel/nand-controller.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > index b2f00b398490..2ff7a77c7b8e 100644
> > --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
> > +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
> > @@ -129,6 +129,11 @@
> >   #define DEFAULT_TIMEOUT_MS			1000
> >   #define MIN_DMA_LEN				128
> >   
> > +static bool atmel_nand_avoid_dma __read_mostly;
> > +
> > +MODULE_PARM_DESC(avoiddma, "Avoid using DMA");
> > +module_param_named(avoiddma, atmel_nand_avoid_dma, bool, 0400);  
> 
> We had the DT parameter "atmel,nand-has-dma" for this purpose and it was

Actually, that was not my understanding of this property. To me it
sounds like something to flag whether the platform supports DMA or
not, no whether it should be enabled on a per-board basis.

> associated with a module parameter as well (use_dma,).

That's true for the use_dma module param, I didn't add it back when
reworking the driver.

> 
> Is it only managed by old DT binding?

It is. I'm really not in favor of adding the DT prop back, but let's
re-introduce the module param if you think it's needed. BTW, the module
name has changed, so the param name will be different.

-- 
Boris Brezillon, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
