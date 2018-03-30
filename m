From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Fri, 30 Mar 2018 11:49:16 +0200
Subject: [PATCH 2/2] net: mvneta: improve suspend/resume
In-Reply-To: <20180330171547.5f96bbff@xhacker.debian>
References: <20180329181220.61d63c92@xhacker.debian>
 <20180329181536.46e065d2@xhacker.debian>
 <20180329135432.7da1299b@windsurf>
 <20180330171547.5f96bbff@xhacker.debian>
Message-ID: <20180330114916.4e786de2@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 30 Mar 2018 17:15:47 +0800, Jisheng Zhang wrote:

> > > +		cpuhp_state_remove_instance_nocalls(online_hpstate,
> > > +						    &pp->node_online);
> > > +		cpuhp_state_remove_instance_nocalls(CPUHP_NET_MVNETA_DEAD,
> > > +						    &pp->node_dead);    
> > 
> > Do we need to remove/add those CPU notifiers when suspending/resuming ?  
> 
> Take mvneta_cpu_online() as an example, if we don't remove it during
> suspend, when system is resume back, it will touch mac when secondary
> cpu is ON, but at this point the mvneta isn't resumed, this is not safe.

Hm. I'm still a bit confused by this new CPU hotplug API. I understand
the issue you have and indeed unregistering the CPU hotplug callbacks
is a way to solve the problem, but I find it weird that we have to do
this.

Anyway, it's OK to do it, because it's anyway what was done so far. It
is just annoying that there is a duplication of the logic between
mvneta_suspend() and mvneta_stop() on one side, and duplication between
mvneta_resume() and mvnete_start() on the other side.

> > > +	for (queue = 0; queue < rxq_number; queue++) {
> > > +		struct mvneta_rx_queue *rxq = &pp->rxqs[queue];
> > > +
> > > +		mvneta_rxq_drop_pkts(pp, rxq);
> > > +	}    
> > 
> > Wouldn't it make sense to have
> > mvneta_rxq_sw_deinit/mvneta_rxq_hw_deinit(), like you did for the
> > initialization ?  
> 
> For rxq deinit, we'd like to drop rx pkts, this is both HW and SW operation.
> So we reuse mvneta_rxq_drop_pkts() here.

Hum, OK, indeed. It would have been nicer to have something symmetric,
with the hw/sw parts split in a similar way for the init and deinit of
both txqs and rxqs, but I agree that dropping the RX packets before
going into suspend involves both HW and SW operations.

Thanks!

Thomas Petazzoni
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
