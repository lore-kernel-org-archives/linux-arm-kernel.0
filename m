From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 31 Jan 2013 08:01:51 +0000
Subject: [PATCH 4/4] pinctrl/abx500: destroy mutex if returning early due
 to error
In-Reply-To: <51097E35.6080100@wwwdotorg.org>
References: <1359574822-15729-1-git-send-email-linus.walleij@stericsson.com>
 <51097E35.6080100@wwwdotorg.org>
Message-ID: <20130131080151.GA5301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Jan 2013, Stephen Warren wrote:

> On 01/30/2013 12:40 PM, Linus Walleij wrote:
> > From: Lee Jones <lee.jones@linaro.org>
> > 
> > Current failure path neglects to mutex_destroy() before returning
> > an error due to an invalid parameter or an error received from
> > gpiochip_add(). This patch aims to remedy that behaviour.
> 
> > diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
> 
> > @@ -1155,11 +1155,13 @@ static int abx500_gpio_probe(struct platform_device *pdev)
> >  	default:
> >  		dev_err(&pdev->dev, "Unsupported pinctrl sub driver (%d)\n",
> >  				(int) platid->driver_data);
> > +		mutex_destroy(&pct->lock);
> >  		return -EINVAL;
> 
> Especially given there's already a label out_free which performs this
> mutex_destroy(), those last two lines would be better as:
> 
> ret = -EINVAL;
> goto out_free;

Yes, that's one way of doing it. I figured it was 6 of one and half a
dozen of the other to be honest.

Either I:

 +           mutex_destroy(&pct->lock);

Or:

 +           ret = -EINVAL; 
 +           goto out_free;
 -           return -EINVAL;

I figured the smallest diff would be best. To be honest, I'm not
bothered either way. If it offends you, I can do it the other way, no
problem. Just let me know quick, so I can get the fixed up patch to
Linus.

NB: There is no 'out_free:' at this point, it has already been
removed.

I'll leave it up to you.

> >  	}
> >  
> >  	if (!pct->soc) {
> >  		dev_err(&pdev->dev, "Invalid SOC data\n");
> > +		mutex_destroy(&pct->lock);
> >  		return -EINVAL;
> 
> Same there.
> 
> >  	}
> >  
> > @@ -1176,6 +1178,7 @@ static int abx500_gpio_probe(struct platform_device *pdev)
> >  	ret = gpiochip_add(&pct->chip);
> >  	if (ret) {
> >  		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
> > +		mutex_destroy(&pct->lock);
> >  		goto out_rem_irq;
> 
> And here, just change the goto target to out_free rather than adding the
> mutex_destroy() call.


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
