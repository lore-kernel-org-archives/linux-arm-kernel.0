From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sun, 10 Jan 2010 20:55:39 +0100
Subject: [PATCH 01/12] omap: McBSP: Fix possible port lockout
In-Reply-To: <4B4767DE.4070801@ru.mvista.com>
References: <20100107001728.21352.38471.stgit@baageli.muru.com>
	<20100107001844.21352.899.stgit@baageli.muru.com>
	<4B4767DE.4070801@ru.mvista.com>
Message-ID: <201001102055.41300.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Friday 08 January 2010 18:14:06 Sergei Shtylyov napisa?(a):
> Tony Lindgren wrote:
> > From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >
> > In its current form, the omap_mcbsp_request() function can return after
> > irq_request() failure without any cleanups, effectively locking out the
> > port forever with clocks left running. Fix it.
> >
> > Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> > Acked-by: Jarkko Nikula <jhnikula@gmail.com>
> > Acked-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
>
> [...]
>
> > diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
> > index 2cc1cc3..f757672 100644
> > --- a/arch/arm/plat-omap/mcbsp.c
> > +++ b/arch/arm/plat-omap/mcbsp.c
> > @@ -436,7 +436,7 @@ int omap_mcbsp_request(unsigned int id)
> >  			dev_err(mcbsp->dev, "Unable to request TX IRQ %d "
> >  					"for McBSP%d\n", mcbsp->tx_irq,
> >  					mcbsp->id);
> > -			return err;
> > +			goto error;
> >  		}
> >
> >  		init_completion(&mcbsp->rx_irq_completion);
> > @@ -446,12 +446,26 @@ int omap_mcbsp_request(unsigned int id)
> >  			dev_err(mcbsp->dev, "Unable to request RX IRQ %d "
> >  					"for McBSP%d\n", mcbsp->rx_irq,
> >  					mcbsp->id);
> > -			free_irq(mcbsp->tx_irq, (void *)mcbsp);
> > -			return err;
> > +			goto tx_irq;
> >  		}
> >  	}
> >
> >  	return 0;
> > +tx_irq:
>
>     As if this wasn't a label for error cleanup, i.e. labels could be named
> more consistently, both including 'err' or 'error'...
>
> > +	free_irq(mcbsp->tx_irq, (void *)mcbsp);
> > +error:
> > +	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->free)
> > +			mcbsp->pdata->ops->free(id);
>
>     This line is overindented.
>

Sergei,
Thanks for pointing these out.

Tony,
Since you have already sent a pull request covering this patch, I propose I 
will address both issues soon when I revisit the source while further 
modifying this function for McBSP register cache support, OK?

Thanks,
Janusz
