From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 31 Jan 2013 17:45:40 +0000
Subject: [PATCH 4/4] pinctrl/abx500: destroy mutex if returning early due
 to error
In-Reply-To: <510AA9BA.8080704@wwwdotorg.org>
References: <1359574822-15729-1-git-send-email-linus.walleij@stericsson.com>
 <51097E35.6080100@wwwdotorg.org> <20130131080151.GA5301@gmail.com>
 <510AA9BA.8080704@wwwdotorg.org>
Message-ID: <20130131174540.GL2042@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, Stephen Warren wrote:

> On 01/31/2013 01:01 AM, Lee Jones wrote:
> > On Wed, 30 Jan 2013, Stephen Warren wrote:
> > 
> >> On 01/30/2013 12:40 PM, Linus Walleij wrote:
> >>> From: Lee Jones <lee.jones@linaro.org>
> >>>
> >>> Current failure path neglects to mutex_destroy() before returning
> >>> an error due to an invalid parameter or an error received from
> >>> gpiochip_add(). This patch aims to remedy that behaviour.
> >>
> >>> diff --git a/drivers/pinctrl/pinctrl-abx500.c b/drivers/pinctrl/pinctrl-abx500.c
> >>
> >>> @@ -1155,11 +1155,13 @@ static int abx500_gpio_probe(struct platform_device *pdev)
> >>>  	default:
> >>>  		dev_err(&pdev->dev, "Unsupported pinctrl sub driver (%d)\n",
> >>>  				(int) platid->driver_data);
> >>> +		mutex_destroy(&pct->lock);
> >>>  		return -EINVAL;
> >>
> >> Especially given there's already a label out_free which performs this
> >> mutex_destroy(), those last two lines would be better as:
> >>
> >> ret = -EINVAL;
> >> goto out_free;
> > 
> > Yes, that's one way of doing it. I figured it was 6 of one and half a
> > dozen of the other to be honest.
> > 
> > Either I:
> > 
> >  +           mutex_destroy(&pct->lock);
> > 
> > Or:
> > 
> >  +           ret = -EINVAL; 
> >  +           goto out_free;
> >  -           return -EINVAL;
> > 
> > I figured the smallest diff would be best. To be honest, I'm not
> > bothered either way. If it offends you, I can do it the other way, no
> > problem. Just let me know quick, so I can get the fixed up patch to
> > Linus.
> > 
> > NB: There is no 'out_free:' at this point, it has already been
> > removed.
> 
> Where has it been removed? Both the latest linux-next and LinusW's
> pinctrl tree on git.kernel.org still contain it...

It's an ordering thing. I submitted a 13 patch patch-set to Linus
which completely reworks the driver. One of the first things I did was
to remove all IRQ handling from the driver and pass responsibility over
to the AB8500 core driver. However, there were some issues with some
of the patches, so Linus decided it would be better to get the simple
stuff out of the way whilst I fixup the more complex IRQ stuff. This
was one of the simple patches which was located at the 'end' of the
patch-set. I don't think you've seen the other stuff yet.

> The style in that code is clearly "goto foo" for error-handling, and
> makes for smaller simpler code, so I don't see why the label would be
> removed.
> 
> Still, this review is just a suggestion; this driver isn't anything I
> have any ownership of, so I guess feel free to go either way.

I too am easy and would be happy to go either way. The implementation
now only has one goto for post gpiochip_add() stuff. As I say, the
others have now been removed as they pertained to IRQ stuff.

Sorry for any confusion.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
