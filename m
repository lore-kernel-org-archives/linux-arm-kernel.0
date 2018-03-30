From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 30 Mar 2018 17:15:47 +0800
Subject: [PATCH 2/2] net: mvneta: improve suspend/resume
In-Reply-To: <20180329135432.7da1299b@windsurf>
References: <20180329181220.61d63c92@xhacker.debian>
 <20180329181536.46e065d2@xhacker.debian>
 <20180329135432.7da1299b@windsurf>
Message-ID: <20180330171547.5f96bbff@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 29 Mar 2018 13:54:32 +0200 Thomas Petazzoni wrote:

> Hello Jisheng,

Hi Thomas,

> 
> On Thu, 29 Mar 2018 18:15:36 +0800, Jisheng Zhang wrote:
> > Current suspend/resume implementation reuses the mvneta_open() and
> > mvneta_close(), but it could be optimized to take only necessary
> > actions during suspend/resume.
> > 
> > One obvious problem of current implementation is: after hundreds of
> > system suspend/resume cycles, the resume of mvneta could fail due to
> > fragmented dma coherent memory. After this patch, the non-necessary
> > memory alloc/free is optimized out.  
> 
> Indeed, this needs to be fixed, you're totally right.
> 
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/net/ethernet/marvell/mvneta.c | 76 ++++++++++++++++++++++++++++++-----
> >  1 file changed, 66 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> > index 4ec69bbd1eb4..1870f1dd7093 100644
> > --- a/drivers/net/ethernet/marvell/mvneta.c
> > +++ b/drivers/net/ethernet/marvell/mvneta.c
> > @@ -4575,14 +4575,46 @@ static int mvneta_remove(struct platform_device *pdev)
> >  #ifdef CONFIG_PM_SLEEP
> >  static int mvneta_suspend(struct device *device)
> >  {
> > +	int queue;
> >  	struct net_device *dev = dev_get_drvdata(device);
> >  	struct mvneta_port *pp = netdev_priv(dev);
> >  
> > -	rtnl_lock();
> > -	if (netif_running(dev))
> > -		mvneta_stop(dev);
> > -	rtnl_unlock();
> > +	if (!netif_running(dev))
> > +		return 0;  
> 
> This is changing the behavior I believe. The current code is:
> 
>         rtnl_lock();
>         if (netif_running(dev))
>                 mvneta_stop(dev);
>         rtnl_unlock();
>         netif_device_detach(dev);
>         clk_disable_unprepare(pp->clk_bus);
>         clk_disable_unprepare(pp->clk);
>         return 0;
> 
> So, when netif_running(dev) is false, we're indeed not calling
> mvneta_stop(), but we're still doing netif_device_detach(), and
> disabling the clocks. With your change, we're no longer doing these
> steps.

Indeed, will try to keep the behavior in v2

> 
> > +
> >  	netif_device_detach(dev);
> > +
> > +	mvneta_stop_dev(pp);
> > +
> > +	if (!pp->neta_armada3700) {
> > +		spin_lock(&pp->lock);
> > +		pp->is_stopped = true;
> > +		spin_unlock(&pp->lock);  
> 
> Real question: is it OK to set pp->is_stopped *after* calling
> mvneta_stop_dev(), while it was set before calling mvneta_stop_dev() in
> the current code ?

oops, you are right. Fixed in v2

> 
> > +
> > +		cpuhp_state_remove_instance_nocalls(online_hpstate,
> > +						    &pp->node_online);
> > +		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
> > +						    &pp->node_dead);  
> 
> Do we need to remove/add those CPU notifiers when suspending/resuming ?

Take mvneta_cpu_online() as an example, if we don't remove it during
suspend, when system is resume back, it will touch mac when secondary
cpu is ON, but at this point the mvneta isn't resumed, this is not safe.

> 
> > +	}
> > +
> > +	for (queue = 0; queue < rxq_number; queue++) {
> > +		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
> > +
> > +		mvneta_rxq_drop_pkts(pp, rxq);
> > +	}  
> 
> Wouldn't it make sense to have
> mvneta_rxq_sw_deinit/mvneta_rxq_hw_deinit(), like you did for the
> initialization ?

For rxq deinit, we'd like to drop rx pkts, this is both HW and SW operation.
So we reuse mvneta_rxq_drop_pkts() here.

> 
> > +
> > +	for (queue = 0; queue < txq_number; queue++) {
> > +		struct mvneta_tx_queue *txq = &pp->txqs[queue];
> > +
> > +		/* Set minimum bandwidth for disabled TXQs */
> > +		mvreg_write(pp, MVETH_TXQ_TOKEN_CFG_REG(txq->id), 0);
> > +		mvreg_write(pp, MVETH_TXQ_TOKEN_COUNT_REG(txq->id), 0);
> > +
> > +		/* Set Tx descriptors queue starting address and size */
> > +		mvreg_write(pp, MVNETA_TXQ_BASE_ADDR_REG(txq->id), 0);
> > +		mvreg_write(pp, MVNETA_TXQ_SIZE_REG(txq->id), 0);
> > +	}  
> 
> Same comment here: a mvneta_txq_sw_deinit()/mvneta_txq_hw_deinit()
> would be good, and would avoid duplicating this logic.

yep, will do in v2.

Thanks a lot for the kind review.
