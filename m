From: peter@korsgaard.com (Peter Korsgaard)
Date: Tue, 30 Sep 2014 18:55:05 +0200
Subject: [PATCH 2/6] hwrng: atmel: use
 clk_prepapre_enable/_disable_unprepare
In-Reply-To: <1412093987-30241-3-git-send-email-boris.brezillon@free-electrons.com>
 (Boris Brezillon's message of "Tue, 30 Sep 2014 18:19:43 +0200")
References: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
 <1412093987-30241-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <87k34loxp2.fsf@dell.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Boris" == Boris Brezillon <boris.brezillon@free-electrons.com> writes:

 > Use clk_prepapre_enable/_disable_unprepare instead of clk_enable/disable
 > to work properly with the CCF.

s/prepapre/prepare/

Other than that, looks fine to me.

Acked-by: Peter Korsgaard <peter@korsgaard.com>

 > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
 > ---
 >  drivers/char/hw_random/atmel-rng.c | 8 ++++----
 >  1 file changed, 4 insertions(+), 4 deletions(-)

 > diff --git a/drivers/char/hw_random/atmel-rng.c b/drivers/char/hw_random/atmel-rng.c
 > index 851bc7e..644ec48 100644
 > --- a/drivers/char/hw_random/atmel-rng.c
 > +++ b/drivers/char/hw_random/atmel-rng.c
 > @@ -67,7 +67,7 @@ static int atmel_trng_probe(struct platform_device *pdev)
 >  	if (IS_ERR(trng->clk))
 >  		return PTR_ERR(trng->clk);
 
 > -	ret = clk_enable(trng->clk);
 > +	ret = clk_prepare_enable(trng->clk);
 >  	if (ret)
 >  		return ret;
 
 > @@ -95,7 +95,7 @@ static int atmel_trng_remove(struct platform_device *pdev)
 >  	hwrng_unregister(&trng->rng);
 
 >  	writel(TRNG_KEY, trng->base + TRNG_CR);
 > -	clk_disable(trng->clk);
 > +	clk_disable_unprepare(trng->clk);
 
 >  	return 0;
 >  }
 > @@ -105,7 +105,7 @@ static int atmel_trng_suspend(struct device *dev)
 >  {
 >  	struct atmel_trng *trng = dev_get_drvdata(dev);
 
 > -	clk_disable(trng->clk);
 > +	clk_disable_unprepare(trng->clk);
 
 >  	return 0;
 >  }
 > @@ -114,7 +114,7 @@ static int atmel_trng_resume(struct device *dev)
 >  {
 >  	struct atmel_trng *trng = dev_get_drvdata(dev);
 
 > -	return clk_enable(trng->clk);
 > +	return clk_prepare_enable(trng->clk);
 >  }
 
 >  static const struct dev_pm_ops atmel_trng_pm_ops = {
 > -- 
 > 1.9.1



-- 
Bye, Peter Korsgaard
