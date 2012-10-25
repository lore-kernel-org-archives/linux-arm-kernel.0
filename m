From: balbi@ti.com (Felipe Balbi)
Date: Thu, 25 Oct 2012 13:48:40 +0300
Subject: [PATCH 3/8] i2c: omap: fix error checking
In-Reply-To: <5089156E.7020701@amarulasolutions.com>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
 <1350899218-13624-4-git-send-email-balbi@ti.com>
 <5087FE07.6090504@amarulasolutions.com>
 <20121025101010.GC21217@arwen.pp.htv.fi>
 <5089156E.7020701@amarulasolutions.com>
Message-ID: <20121025104839.GF21217@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 25, 2012 at 12:33:18PM +0200, Michael Trimarchi wrote:
> >>> @@ -587,9 +587,9 @@ static int omap_i2c_xfer_msg(struct i2c_adapter *adap,
> >>>  		goto err_i2c_init;
> >>>  	}
> >>>  
> >>> -	/* We have an error */
> >>> -	if (dev->cmd_err & (OMAP_I2C_STAT_AL | OMAP_I2C_STAT_ROVR |
> >>> -			    OMAP_I2C_STAT_XUDF)) {
> >>> +	if ((dev->cmd_err & OMAP_I2C_STAT_AL)
> >>> +			|| (dev->cmd_err & OMAP_I2C_STAT_ROVR)
> >>> +			|| (dev->cmd_err & OMAP_I2C_STAT_XUDF)) {
> >>
> >> Sorry, what is the difference? I didn't understand the optimisation
> >> and why now is more clear. Can you just add a comment?
> > 
> > semantically they're not the same, right ? We want to check if each of
> > those bits are set, not if all of them are set together.
> > 
> > my 2 cents.
> 
> You are doing the same thing, but of course is better with just one

I never claimed the contrary. I said *semantically* they're not the
same.

> *if* as before . A general rule is: when you have logic expression you

We still have a single *if* and I'm sure compiler will optimize that
expression as much as it likes.

> can use undefined states to simplify the logic. 

don't-care is not the same as undefined states.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121025/cbb6ab32/attachment.sig>
