From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 4 Nov 2015 13:34:54 +0100 (CET)
Subject: [patch] bus: sunxi-rsb: unlock on error in sunxi_rsb_read()
In-Reply-To: <5639F7EB.2090308@bfs.de>
References: <20151103220244.GA19280@mwanda> <5639F7EB.2090308@bfs.de>
Message-ID: <alpine.DEB.2.10.1511041334180.2559@hadrien>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Wed, 4 Nov 2015, walter harms wrote:

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
>
> mutex_unlock(&rsb->lock);
> return ret;

I think the goto is nicer.  Failure => goto.

julia
