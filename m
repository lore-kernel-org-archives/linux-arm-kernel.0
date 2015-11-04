From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 4 Nov 2015 15:46:46 +0300
Subject: [patch] bus: sunxi-rsb: unlock on error in sunxi_rsb_read()
In-Reply-To: <5639F7EB.2090308@bfs.de>
References: <20151103220244.GA19280@mwanda>
 <5639F7EB.2090308@bfs.de>
Message-ID: <20151104124645.GN18797@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 01:19:55PM +0100, walter harms wrote:
> 
> 
> Am 03.11.2015 23:02, schrieb Dan Carpenter:
> > Don't forget to unlock before returning an error code.
> > 
> > Fixes: d787dcdb9c8f ('bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus')
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
> > index 846bc29c..0cfcb39 100644
> > --- a/drivers/bus/sunxi-rsb.c
> > +++ b/drivers/bus/sunxi-rsb.c
> > @@ -342,13 +342,13 @@ static int sunxi_rsb_read(struct sunxi_rsb *rsb, u8 rtaddr, u8 addr,
> >  
> >  	ret = _sunxi_rsb_run_xfer(rsb);
> >  	if (ret)
> > -		goto out;
> > +		goto unlock;
> >  
> >  	*buf = readl(rsb->regs + RSB_DATA);
> >  
> > +unlock:
> >  	mutex_unlock(&rsb->lock);
> >  
> > -out:
> >  	return ret;
> >  }
> >  
> 
> microoptimisation:
> You can remove the goto.
> 
> if (!ret)
> 	*buf = readl(rsb->regs + RSB_DATA);

Success handling is an anti-pattern.

People normally don't do success handling because it leads to a lot of
nesting and spaghetti code.

	ret = one();
	if (!ret) {
		ret = two();
		if (!ret) {
			ret = three();
			if (!ret)
				return four();
		}
	}

But then they get to the last condition or the last two in a function
and they switch to success handling.

	ret = one();
	if (ret)
		handle_error;

	ret = two();
	if (ret)
		handle_error;

	ret = three();
	if (ret)
		handle_error;

	ret = four();
	if (!ret)
		handle_success;

	return ret;

Code like this drives me nuts.  It's often bug prone.  Keep it
consistent.  Always do error handling instead of success handling.
Don't worry about the extra line.  Worry more about keeping it simple.

regards,
dan carpenter
