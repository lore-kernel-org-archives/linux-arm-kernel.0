From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 2 Mar 2018 17:08:41 +0000
Subject: [alsa-devel] regression v4.16 on Nokia N900: sound does not work
In-Reply-To: <0f090cc7-2b72-a038-26ee-d43077cb9663@ti.com>
References: <20180224214617.GA22619@amd>
 <71aa88ec-d4df-b49c-7d73-27197f468491@leemhuis.info>
 <20180226131318.GA14045@amd>
 <CAEnQRZBbMTeaxb+=AaarX6PSGasfVjtAUdpbPvJavZyTRMpdgQ@mail.gmail.com>
 <20180226231336.GA18565@amd>
 <CACRpkdarR_7HqGMPwfa8YpG9wnFs5mJrNwuctycn=MrdwaRxyw@mail.gmail.com>
 <20180302091025.GC30267@amd>
 <CACRpkda=deFSmk2iyrtde3Z-aj6rW9_jNfE3Ep4X=ejprGxRUw@mail.gmail.com>
 <20180302111040.GA6344@amd>
 <0f090cc7-2b72-a038-26ee-d43077cb9663@ti.com>
Message-ID: <20180302170841.GP28231@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 08:22:52AM -0600, Andrew F. Davis wrote:
> > diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> > index 84e5a9d..f0fab26 100644
> > --- a/drivers/gpio/gpiolib-of.c
> > +++ b/drivers/gpio/gpiolib-of.c
> > @@ -241,29 +241,17 @@ struct gpio_desc *of_find_gpio(struct device *dev, const char *con_id,
> >  
> >  		desc = of_get_named_gpiod_flags(dev->of_node, prop_name, idx,
> >  						&of_flags);
> > -		/*
> > -		 * -EPROBE_DEFER in our case means that we found a
> > -		 * valid GPIO property, but no controller has been
> > -		 * registered so far.
> > -		 *
> > -		 * This means we don't need to look any further for
> > -		 * alternate name conventions, and we should really
> > -		 * preserve the return code for our user to be able to
> > -		 * retry probing later.
> > -		 */
> > -		if (IS_ERR(desc) && PTR_ERR(desc) == -EPROBE_DEFER)
> > -			return desc;
> >  
> > -		if (!IS_ERR(desc) || (PTR_ERR(desc) != -ENOENT))
> > +		if (!IS_ERR(desc) || PTR_ERR(desc) != -ENOENT)
> 
> 
> I rather like the () so one doesn't always have to look up C operator
> precedence to verify..

Too many make it impossible to see which close paren ties up with
which open paren.  I've spent way too long in the past reformatting
code, where people think that () are a good thing, to work out what
the comparison is actually doing before then rewriting the damn
thing with less () and in a much clearer way.  I'm now convinced
that unnecessary () are a very bad thing as they severely harm
readability as test complexity increases.

> 
> 
> >  			break;
> >  	}
> >  
> >  	/* Special handling for SPI GPIOs if used */
> > -	if (IS_ERR(desc))
> > +	if (IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)

These can be simplified to:

	if (desc == ERR_PTR(-ENOENT))

since error pointers are unique - ERR_PTR(-ENOENT) is what was
returned as an error-pointer, and if IS_ERR(ERR_PTR(-ENOMENT)) etc
were false, we'd have big problems as it'd mean we couldn't detect
error pointers!

As an added bonus, they don't involve any operator precedence
questions either.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
