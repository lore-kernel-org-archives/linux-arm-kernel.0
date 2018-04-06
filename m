From: Vadim.Lomovtsev@caviumnetworks.com (Vadim Lomovtsev)
Date: Fri, 6 Apr 2018 08:14:25 -0700
Subject: [PATCH v2] net: thunderx: rework mac addresses list to u64 array
In-Reply-To: <20180406.110603.978796669734920248.davem@davemloft.net>
References: <20180405145756.12633-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406111425.14636-1-Vadim.Lomovtsev@caviumnetworks.com>
 <20180406.110603.978796669734920248.davem@davemloft.net>
Message-ID: <20180406151425.GA15317@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2018 at 11:06:03AM -0400, David Miller wrote:
> From: Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>
> Date: Fri,  6 Apr 2018 04:14:25 -0700
> 
> > diff --git a/drivers/net/ethernet/cavium/thunder/nic.h b/drivers/net/ethernet/cavium/thunder/nic.h
> > index 5fc46c5a4f36..448d1fafc827 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nic.h
> > +++ b/drivers/net/ethernet/cavium/thunder/nic.h
> > @@ -265,14 +265,9 @@ struct nicvf_drv_stats {
> >  
> >  struct cavium_ptp;
> >  
> > -struct xcast_addr {
> > -	struct list_head list;
> > -	u64              addr;
> > -};
> > -
> >  struct xcast_addr_list {
> > -	struct list_head list;
> >  	int              count;
> > +	u64              mc[];
> >  };
> >  
> >  struct nicvf_work {
> > diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > index 1e9a31fef729..a26d8bc92e01 100644
> > --- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > +++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
> > @@ -1929,7 +1929,7 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >  						  work.work);
> >  	struct nicvf *nic = container_of(vf_work, struct nicvf, rx_mode_work);
> >  	union nic_mbx mbx = {};
> > -	struct xcast_addr *xaddr, *next;
> > +	u8 idx = 0;
>         ^^^^^^^^^^^
> 
> >  
> >  	if (!vf_work)
> >  		return;
> > @@ -1956,16 +1956,10 @@ static void nicvf_set_rx_mode_task(struct work_struct *work_arg)
> >  	/* check if we have any specific MACs to be added to PF DMAC filter */
> >  	if (vf_work->mc) {
> >  		/* now go through kernel list of MACs and add them one by one */
> > -		list_for_each_entry_safe(xaddr, next,
> > -					 &vf_work->mc->list, list) {
> > +		for (idx = 0; idx < vf_work->mc->count; idx++) {
> 
> vf_work->mx->count is an 'int' therefore 'idx' should be declared 'int' as well,
> not a 'u8'.

My bad, sorry.
Will post v4 shortly then.


WBR,
Vadim
