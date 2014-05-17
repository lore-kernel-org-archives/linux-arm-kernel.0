From: emilgoode@gmail.com (Emil Goode)
Date: Sun, 18 May 2014 00:51:53 +0200
Subject: [PATCH v3] ARM: imx: fix error handling in ipu device registration
In-Reply-To: <20140517220836.GI15585@mwanda>
References: <1400352033-18262-1-git-send-email-emilgoode@gmail.com>
 <20140517191821.GD16662@pengutronix.de>
 <20140517220836.GI15585@mwanda>
Message-ID: <20140517225153.GB20413@lianli>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Dan,

On Sun, May 18, 2014 at 01:08:36AM +0300, Dan Carpenter wrote:
> On Sat, May 17, 2014 at 09:18:21PM +0200, Uwe Kleine-K?nig wrote:
> > diff --git a/arch/arm/mach-imx/devices/platform-ipu-core.c b/arch/arm/mach-imx/devices/platform-ipu-core.c
> > index fc4dd7cedc11..6bd7c3f37ac0 100644
> > --- a/arch/arm/mach-imx/devices/platform-ipu-core.c
> > +++ b/arch/arm/mach-imx/devices/platform-ipu-core.c
> > @@ -77,7 +77,7 @@ struct platform_device *__init imx_alloc_mx3_camera(
> >  
> >  	pdev = platform_device_alloc("mx3-camera", 0);
> >  	if (!pdev)
> > -		goto err;
> > +		return ERR_PTR(-ENOMEM);
> >  
> >  	pdev->dev.dma_mask = kmalloc(sizeof(*pdev->dev.dma_mask), GFP_KERNEL);
> >  	if (!pdev->dev.dma_mask)
> 
> Emil, do this one, please and not the second suggestion.

Yes, I would pick this one to.

> 
> Direct returns are more readable.  Otherwise, you wonder what the goto
> is for and where it will take you and be annoyed to discover it is a
> waste of time, no-op goto.  Also you will wonder if platform_device_put()
> accepts NULL pointers.  Thirdly there is a small ugliness that the error
> code is not preserved.  What is the point of setting the error code to
> -ENOMEM only to discard it?
> 
> Let's look at that error handling again.
> 
> err:  <-- the name is not descriptive.  the location is bad.
> 		kfree(pdev->dev.dma_mask);  <- null dereference.
> 		platform_device_put(pdev);  <- ok
> 		return ERR_PTR(-ENODEV);    <- should be "return ERR_PTR(ret);"
> 
> 3 out of 4 of the lines are bad.

I agree that it's not very pretty.

Now that Uwe solved the issue regarding converting the function to
platform_device_register_full(), I will look into sending a second patch
that would remove these lines.

Thank you!

Best regards,

Emil Goode
