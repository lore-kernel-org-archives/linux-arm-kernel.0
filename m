From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 18 Nov 2012 18:09:28 -0500
Subject: kirkwood i2s lockup, was: Re: [PATCH] Dove: Fix irq_to_pmu()
In-Reply-To: <20121118223125.GZ3290@n2100.arm.linux.org.uk>
References: <20121118162944.GV3290@n2100.arm.linux.org.uk>
 <20121118163932.GW3290@n2100.arm.linux.org.uk>
 <50A9304C.9010006@mvista.com>
 <20121118203815.GY3290@n2100.arm.linux.org.uk>
 <20121118210229.GV22106@titan.lakedaemon.net>
 <20121118223125.GZ3290@n2100.arm.linux.org.uk>
Message-ID: <20121118230928.GY22106@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 18, 2012 at 10:31:25PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 18, 2012 at 04:02:29PM -0500, Jason Cooper wrote:
> > On Sun, Nov 18, 2012 at 08:38:15PM +0000, Russell King - ARM Linux wrote:
> > > On Sun, Nov 18, 2012 at 11:00:28PM +0400, Sergei Shtylyov wrote:
> > > > Hello.
> > > >
> > > > On 18-11-2012 20:39, Russell King - ARM Linux wrote:
> > > >
> > > >> PMU interrupts start at IRQ_DOVE_PMU_START, not IRQ_DOVE_PMU_START + 1.
> > > >> Fix the condition.  (It may have been less likely to occur had the code
> > > >> been written "if (irq >= IRQ_DOVE_PMU_START" which imho is the easier
> > > >> to understand notation, and matches the normal way of thinking about
> > > >> these things.)
> > > >
> > > >> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > > >> --
> > > >
> > > >    Should be "---", or somebody (you?) will have to hand edit the patch 
> > > > when applying...
> > > 
> > > Sorry, can never remember that...
> > 
> > No problem, I'll handle it when I pull it in.
> 
> And there's yet another bug... this time in the kirkwood audio driver:
> 
> static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
> {
>         struct kirkwood_dma_priv *prdata = dev_id;
>         struct kirkwood_dma_data *priv = prdata->data;
>         unsigned long mask, status, cause;   
>         
>         mask = readl(priv->io + KIRKWOOD_INT_MASK);
>         status = readl(priv->io + KIRKWOOD_INT_CAUSE) & mask;
> 
>         cause = readl(priv->io + KIRKWOOD_ERR_CAUSE);
>         if (unlikely(cause)) {
>                 printk(KERN_WARNING "%s: got err interrupt 0x%lx\n",
>                                 __func__, cause);
>                 writel(cause, priv->io + KIRKWOOD_ERR_CAUSE);
>                 return IRQ_HANDLED;
>         }
> 
> What happens here if an underrun (0x20) interrupt happens?  Well, the
> kernel log looks something like this:
> 
> kirkwood_dma_irq: got err interrupt 0x20
> kirkwood_dma_irq: got err interrupt 0x20
> kirkwood_dma_irq: got err interrupt 0x20
> kirkwood_dma_irq: got err interrupt 0x20
> kirkwood_dma_irq: got err interrupt 0x20
> kirkwood_dma_irq: got err interrupt 0x20
> ...
> 
> and the system spins doing nothing but that message.  It's not because the
> interrupt isn't being cleared (it's a sensible write-1-to-clear register).
> 
> If you have (frigged) orion_wdt to work, then you'll get a reset after 25s,
> otherwise you'll have what appears to be a totally dead system with (due to
> the log buffer rewrite) no kernel message output, no interrupts, no nothing.
> 
> It's taken a full day to track this bug down...
> 
> As for what causes the underrun, that's a different (and as yet unanswered)
> question... but without the patch below which turns off the error reporting
> after the first (until it's re-opened) DVD quality MPEG2 decoding fails in
> less than one minute with ubuntu precise 12.10 userspace with the machine
> locking solid... doesn't matter if it's software or hardware decode.
> 
> diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
> index 690260b..26a1d36 100644
> --- a/sound/soc/kirkwood/kirkwood-dma.c
> +++ b/sound/soc/kirkwood/kirkwood-dma.c
> @@ -73,10 +73,12 @@ static irqreturn_t kirkwood_dma_irq(int irq, void *dev_id)
>  	status = readl(priv->io + KIRKWOOD_INT_CAUSE) & mask;
>  
>  	cause = readl(priv->io + KIRKWOOD_ERR_CAUSE);
> +	cause &= readl(priv->io + KIRKWOOD_ERR_MASK);
>  	if (unlikely(cause)) {
>  		printk(KERN_WARNING "%s: got err interrupt 0x%lx\n",
>  				__func__, cause);
>  		writel(cause, priv->io + KIRKWOOD_ERR_CAUSE);
> +		writel(0, priv->io + KIRKWOOD_ERR_MASK);
>  		return IRQ_HANDLED;
>  	}
>  
> 
> Now I'm getting to the point of wondering how well tested any of this
> dove/kirkwood/orion code actually is... it all looks rather insanely
> fragile to me tonight.

I won't deny that at all, I think the CuBox is the first platform to
actually use the Marvell audio/multimedia code.  Anywho, git blame
points at:

commit f9b95980f87f021f8c69646738929189838ad035
Author: apatard at mandriva.com <apatard@mandriva.com>
Date:   Mon May 31 13:49:14 2010 +0200

    ASoC: kirkwood: Add i2s support

    This patch enables support for the i2s controller available on
    kirkwood platforms

    Signed-off-by: Arnaud Patard <apatard@mandriva.com>
    Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

which is the original commit adding the driver.  I've added them to the
reply to see if they have any insight.

thx,

Jason.
