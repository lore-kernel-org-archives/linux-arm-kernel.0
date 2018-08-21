From: marek.behun@nic.cz (Marek =?ISO-8859-1?Q?Beh=FAn?=)
Date: Tue, 21 Aug 2018 12:07:53 +0200
Subject: [PATCH v1 6/7] net: mvneta: Don't use GRO on Armada 3720
In-Reply-To: <20180809200832.7de1fa9e@xhacker.debian>
References: <20180808152706.21727-1-marek.behun@nic.cz>
 <20180808152706.21727-7-marek.behun@nic.cz>
 <20180809124022.790f1784@xhacker.debian>
 <20180809192755.24e57782@xhacker.debian>
 <20180809200832.7de1fa9e@xhacker.debian>
Message-ID: <20180821120753.1d81d0ce@dellmb.labs.office.nic.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Aug 2018 20:08:32 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> On Thu, 9 Aug 2018 19:27:55 +0800 Jisheng Zhang wrote:
> 
> > Hi,
> > 
> > On Thu, 9 Aug 2018 12:40:41 +0800 Jisheng Zhang wrote:
> >   
> > > + more people
> > > 
> > > On Wed,  8 Aug 2018 17:27:05 +0200 Marek Beh?n wrote:
> > >     
> > > > For some reason on Armada 3720 boards (EspressoBin and Turris
> > > > Mox) the networking driver behaves weirdly when using
> > > > napi_gro_receive.
> > > > 
> > > > For example downloading a big file from a local network (low
> > > > ping) is fast, but when downloading from a remote server
> > > > (higher ping), the download speed is at first high but drops
> > > > rapidly to almost nothing or absolutely nothing.      
> > > 
> > > We also met this issue on some berlin platforms. I tried to fix
> > > the bug, but no clue so far.
> > >     
> > > > 
> > > > This is fixed when using netif_receive_skb instead of
> > > > napi_gro_receive.      
> > > 
> > > This is a workaround. The good news is this workaround also fixes
> > > the issue we saw on berlin.
> > >     
> > > > 
> > > > Signed-off-by: Marek Behun <marek.behun@nic.cz>
> > > > Cc: Russell King - ARM Linux <linux@armlinux.org.uk>
> > > > Cc: netdev at vger.kernel.org
> > > > 
> > > > diff --git a/drivers/net/ethernet/marvell/mvneta.c
> > > > b/drivers/net/ethernet/marvell/mvneta.c index
> > > > 0ad2f3f7da85..27f3017d94c5 100644 ---
> > > > a/drivers/net/ethernet/marvell/mvneta.c +++
> > > > b/drivers/net/ethernet/marvell/mvneta.c @@ -1959,7 +1959,10 @@
> > > > static int mvneta_rx_swbm(struct mvneta_port *pp, int rx_todo, 
> > > >  			skb->protocol = eth_type_trans(skb,
> > > > dev); mvneta_rx_csum(pp, rx_status, skb);
> > > > -			napi_gro_receive(&port->napi, skb);
> > > > +			if (pp->neta_armada3700)
> > > > +				netif_receive_skb(skb);
> > > > +			else
> > > > +				napi_gro_receive(&port->napi,
> > > > skb);    
> > 
> > I think I found the root cause, if neta_armada3700 is true, the
> > port got from this_cpu_ptr(pp->ports) is invalid, this is bug...
> > I'll cook a patch for this  
> 
> correct it as:
> 
> the port's(port is got from this_cpu_ptr(pp->ports) napi is invalid.
> 
> Patch is sent out. Could you please try?
> 
> Per my test, it solves the issue we saw on berlin.
> 
> > 
> > Thanks
> >   
> > > >  
> > > >  			rcvd_pkts++;
> > > >  			rcvd_bytes += rx_bytes;
> > > > @@ -2001,7 +2004,10 @@ static int mvneta_rx_swbm(struct
> > > > mvneta_port *pp, int rx_todo, 
> > > >  		mvneta_rx_csum(pp, rx_status, skb);
> > > >  
> > > > -		napi_gro_receive(&port->napi, skb);
> > > > +		if (pp->neta_armada3700)
> > > > +			netif_receive_skb(skb);
> > > > +		else
> > > > +			napi_gro_receive(&port->napi, skb);
> > > >  	}
> > > >  
> > > >  	if (rcvd_pkts) {      
> > >     
> >   
> 

Jisheng, the issue is solved with your patch. Thanks :)
