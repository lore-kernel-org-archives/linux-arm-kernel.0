From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sun, 20 Oct 2013 10:03:33 +0200
Subject: [PATCH v3 2/2] ASoC: kirkwood: fix loss of external clock at
 probe time
In-Reply-To: <20131019102809.180dc4ff@armhf>
References: <20131018203555.4d974251@armhf>
 <20131018191259.GF10079@pengutronix.de>
 <20131019102809.180dc4ff@armhf>
Message-ID: <20131020080333.GG10079@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 19, 2013 at 10:28:09AM +0200, Jean-Francois Moine wrote:
> On Fri, 18 Oct 2013 21:12:59 +0200
> Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:
> 
> > > +	if (IS_ERR(priv->extclk)) {
> > > +		if (PTR_ERR(priv->extclk) == -EPROBE_DEFER)
> > > +			return -EPROBE_DEFER;  
> > Maybe the better logic here is:
> > 		if (!PTR_ERR(priv->extclk) == -ENOENT)
> > 			return PTR_ERR(priv->extclk);
> > 
> > ?
> 
> No. This patch is associated with an other one which returns
> -EPROBE_DEFER when the external clock is declared in the DT and when
> the clock driver is not yet initialized. Then, the kirkwood modules
> must be probed later.
Yes, that's understood. My suggestion behaves as your's for the return
values -EPROBE_DEFER and -ENOENT, so the deferred probe should work,
too. The question is only what you want to do for other errors (don't
know if they can happen at this stage). I'd say, on a dt parsing error
bail out, too.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
