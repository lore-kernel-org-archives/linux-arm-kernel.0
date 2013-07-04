From: heiko@sntech.de (Heiko =?utf-8?q?St=C3=BCbner?=)
Date: Thu, 4 Jul 2013 16:34:10 +0200
Subject: [PATCH v2 1/6] misc: sram: fix error path in sram_probe
In-Reply-To: <1372151074.3981.21.camel@pizza.hi.pengutronix.de>
References: <201306251046.04873.heiko@sntech.de>
 <201306251046.38993.heiko@sntech.de>
 <1372151074.3981.21.camel@pizza.hi.pengutronix.de>
Message-ID: <201307041634.11248.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Am Dienstag, 25. Juni 2013, 11:04:34 schrieb Philipp Zabel:
> Hi Heiko,
> 
> Am Dienstag, den 25.06.2013, 10:46 +0200 schrieb Heiko St?bner:
> > The pool is created thru devm_gen_pool_create, so the call to
> > gen_pool_destroy is not necessary.
> > Instead the sram-clock must be turned off again if it exists.
> > 
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > ---
> > 
> >  drivers/misc/sram.c |    3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> > index d87cc91..afe66571 100644
> > --- a/drivers/misc/sram.c
> > +++ b/drivers/misc/sram.c
> > @@ -68,7 +68,8 @@ static int sram_probe(struct platform_device *pdev)
> > 
> >  	ret = gen_pool_add_virt(sram->pool, (unsigned long)virt_base,
> >  	
> >  				res->start, size, -1);
> >  	
> >  	if (ret < 0) {
> > 
> > -		gen_pool_destroy(sram->pool);
> 
> Right, thanks.
> 
> > +		if (sram->clk)
> > +			clk_disable_unprepare(sram->clk);
> > 
> >  		return ret;
> >  	
> >  	}
> 
> In light of the following patch, I'd rather move the
> clk_prepare_enable() call after gen_pool_add_virt() and its error path.

I'm not sure, but isn't moving the clock enablement below the pool allocation 
producing a race condition?

I.e. can the case happen that some other part wants to allocate part of the 
newly generated pool already, while the subsequent gen_pool_add_virt calls 
from the following patch are still running? ... And what will happen in this 
case, when the sram clock is still disabled?


Thanks
Heiko
