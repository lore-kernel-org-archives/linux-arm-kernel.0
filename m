From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 25 Apr 2013 14:02:45 +0100
Subject: [PATCH] mfd: vexpress: Handle pending config transactions
In-Reply-To: <1366821084-12815-1-git-send-email-pawel.moll@arm.com>
References: <1366821084-12815-1-git-send-email-pawel.moll@arm.com>
Message-ID: <1366894965.3528.19.camel@computer5.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-04-24 at 17:31 +0100, Pawel Moll wrote:
> The config transactions "scheduler" was hopelessly broken,
> repeating completed transaction instead of picking up
> next pending one.
> 
> Fixed now. Also improved debug messages.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/mfd/vexpress-config.c |   31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/mfd/vexpress-config.c b/drivers/mfd/vexpress-config.c
> index 3c1723aa..4991db3 100644
> --- a/drivers/mfd/vexpress-config.c
> +++ b/drivers/mfd/vexpress-config.c
> @@ -184,13 +184,14 @@ static int vexpress_config_schedule(struct vexpress_config_trans *trans)
>  
>  	spin_lock_irqsave(&bridge->transactions_lock, flags);
>  
> -	vexpress_config_dump_trans("Executing", trans);
> -
> -	if (list_empty(&bridge->transactions))
> +	if (list_empty(&bridge->transactions)) {
> +		vexpress_config_dump_trans("Executing", trans);
>  		status = bridge->info->func_exec(trans->func->func,
>  				trans->offset, trans->write, trans->data);
> -	else
> +	} else {
> +		vexpress_config_dump_trans("Queuing", trans);
>  		status = VEXPRESS_CONFIG_STATUS_WAIT;
> +	}
>  
>  	switch (status) {
>  	case VEXPRESS_CONFIG_STATUS_DONE:
> @@ -217,20 +218,28 @@ void vexpress_config_complete(struct vexpress_config_bridge *bridge,
>  
>  	trans = list_first_entry(&bridge->transactions,
>  			struct vexpress_config_trans, list);
> +	trans->status = status;
>  	vexpress_config_dump_trans("Completed", trans);
>  
> -	trans->status = status;
>  	list_del(&trans->list);
>  
> -	if (!list_empty(&bridge->transactions)) {
> -		vexpress_config_dump_trans("Pending", trans);
> +	complete(&trans->completion);
> +
> +	while (!list_empty(&bridge->transactions)) {
> +		trans = list_first_entry(&bridge->transactions,
> +				struct vexpress_config_trans, list);
>  
> -		bridge->info->func_exec(trans->func->func, trans->offset,
> -				trans->write, trans->data);
> +		vexpress_config_dump_trans("Executing pending", trans);
> +		status = bridge->info->func_exec(trans->func->func,
> +				trans->offset, trans->write, trans->data);
> +
> +		if (status == VEXPRESS_CONFIG_STATUS_DONE)
> +			vexpress_config_dump_trans("Finished pending", trans);
> +		else
> +			break;

For each transaction we execute in this loop, don't we also need to do
the actions vexpress_config_complete does? E.g.

	trans->status = status;
	list_del(&trans->list);
	complete(&trans->completion);

except in the case status==VEXPRESS_CONFIG_STATUS_WAIT.

Or, does the call to func_exec cause vexpress_config_complete() to be
called later? (It hadn't better be called synchronously or we get a
deadlock).

Actually, if it is called later, there is still a problem because if the
call to func_exec returns VEXPRESS_CONFIG_STATUS_DONE then the
transaction is left on the list and the while loop will try and execute
it again.

>  	}
> -	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
>  
> -	complete(&trans->completion);
> +	spin_unlock_irqrestore(&bridge->transactions_lock, flags);
>  }
>  EXPORT_SYMBOL(vexpress_config_complete);
>  

-- 
Tixy
