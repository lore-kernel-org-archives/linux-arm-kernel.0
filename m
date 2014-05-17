From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sun, 18 May 2014 01:53:39 +0300
Subject: [PATCH v3] ARM: imx: fix error handling in ipu device registration
In-Reply-To: <20140517223555.GR3693@n2100.arm.linux.org.uk>
References: <1400352033-18262-1-git-send-email-emilgoode@gmail.com>
 <20140517191821.GD16662@pengutronix.de>
 <20140517220836.GI15585@mwanda>
 <20140517223555.GR3693@n2100.arm.linux.org.uk>
Message-ID: <20140517225339.GJ16255@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 17, 2014 at 11:35:55PM +0100, Russell King - ARM Linux wrote:
> On Sun, May 18, 2014 at 01:08:36AM +0300, Dan Carpenter wrote:
> > Let's look at that error handling again.
> > 
> > err:  <-- the name is not descriptive.  the location is bad.
> > 		kfree(pdev->dev.dma_mask);  <- null dereference.
> > 		platform_device_put(pdev);  <- ok
> > 		return ERR_PTR(-ENODEV);    <- should be "return ERR_PTR(ret);"
> > 
> > 3 out of 4 of the lines are bad.
> 
> 2 out of 4.  kfree(NULL) is perfectly legal.

pdev was NULL though...

The bug is *caused* by trying to use the same "err" label to do all
error handling.  This is a very common anti-patern, but if you follow
canonical kernel style then your error handling is less buggy.

regards,
dan carpenter
