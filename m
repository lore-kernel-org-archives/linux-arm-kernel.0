From: joe@perches.com (Joe Perches)
Date: Fri, 04 Mar 2016 09:35:47 -0800
Subject: [PATCH net-next V2 13/16] net: fec: print more debug info in
 fec_timeout
In-Reply-To: <56D9B238.2040400@boundarydevices.com>
References: <1456360619-24390-1-git-send-email-troy.kisky@boundarydevices.com>
 <1456360619-24390-14-git-send-email-troy.kisky@boundarydevices.com>
 <VI1PR0401MB18552AB3E4128E412273B439FFBE0@VI1PR0401MB1855.eurprd04.prod.outlook.com>
 <56D9B238.2040400@boundarydevices.com>
Message-ID: <1457112947.4044.133.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-03-04 at 09:05 -0700, Troy Kisky wrote:
> On 3/4/2016 3:06 AM, Fugang Duan wrote:
> > From: Troy Kisky <troy.kisky@boundarydevices.com> Sent: Thursday, February 25, 2016 8:37 AM
[]
> > > Print the current interrupt flags and mask and the interrupt state during the last
> > > interrupt in fec_timeout.
[]
> > > diff --git a/drivers/net/ethernet/freescale/fec_main.c
[]
> > > @@ -1107,6 +1107,9 @@ fec_timeout(struct net_device *ndev)
> > > ?	int i;
> > > ?	uint events = 0;
> > > 
> > > +	pr_err("%s: last=%x %x, mask %x\n", __func__, fep->last_ievents,
> > > +	???????readl(fep->hwp + FEC_IEVENT), readl(fep->hwp + FEC_IMASK));
> > > +
> > pr_err() -> netdev_err()
> Sounds good

This seems like debugging information rather than
an error a user can do anything with and if there's
a timeout, how likely is it that the hardware is
hosed and this would? repetitively and unnecessarily
fill up logs?

So maybe netdev_dbg and net_ratelimit() too.

	if (net_ratelimit()
		netdev_<level>(etc...)
