From: pawel.moll@arm.com (Pawel Moll)
Date: Thu, 25 Apr 2013 15:40:49 +0100
Subject: [PATCH] mfd: vexpress: Handle pending config transactions
In-Reply-To: <1366894965.3528.19.camel@computer5.home>
References: <1366821084-12815-1-git-send-email-pawel.moll@arm.com>
 <1366894965.3528.19.camel@computer5.home>
Message-ID: <1366900849.10438.12.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-04-25 at 14:02 +0100, Jon Medhurst (Tixy) wrote:
> > +	while (!list_empty(&bridge->transactions)) {
> > +		trans = list_first_entry(&bridge->transactions,
> > +				struct vexpress_config_trans, list);
> >  
> > -		bridge->info->func_exec(trans->func->func, trans->offset,
> > -				trans->write, trans->data);
> > +		vexpress_config_dump_trans("Executing pending", trans);
> > +		status = bridge->info->func_exec(trans->func->func,
> > +				trans->offset, trans->write, trans->data);
> > +
> > +		if (status == VEXPRESS_CONFIG_STATUS_DONE)
> > +			vexpress_config_dump_trans("Finished pending", trans);
> > +		else
> > +			break;
> 
> For each transaction we execute in this loop, don't we also need to do
> the actions vexpress_config_complete does? E.g.
> 
> 	trans->status = status;
> 	list_del(&trans->list);
> 	complete(&trans->completion);
> 
> except in the case status==VEXPRESS_CONFIG_STATUS_WAIT.

You're completely right. I shouldn't have write this code as the last
thing in the afternoon...

Will send v2.

Pawe?
