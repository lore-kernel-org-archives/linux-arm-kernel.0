From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Oct 2013 11:31:18 +0100
Subject: [PATCH] genirq: error reporting for non-percpu interrupt in
 request_percpu_irq()
In-Reply-To: <1382090789-18177-1-git-send-email-vkale@apm.com>
References: <1382090789-18177-1-git-send-email-vkale@apm.com>
Message-ID: <20131018103117.GA3296@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 11:06:29AM +0100, Vinayak Kale wrote:
> Return a separate error code when a non-percpu interrupt is passed to
> request_percpu_irq().
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Vinayak Kale <vkale@apm.com>
> ---
>  kernel/irq/manage.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 514bcfd..c2713ae 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1671,10 +1671,12 @@ int request_percpu_irq(unsigned int irq, irq_handler_t handler,
>  		return -EINVAL;
>  
>  	desc = irq_to_desc(irq);
> -	if (!desc || !irq_settings_can_request(desc) ||
> -	    !irq_settings_is_per_cpu_devid(desc))
> +	if (!desc || !irq_settings_can_request(desc))
>  		return -EINVAL;
>  
> +	if (!irq_settings_is_per_cpu_devid(desc))
> +		return -EPERM;

<bikeshedding> I reckon -ENODEV is clearer here. </bikeshedding>

Also, there's a counterpart to this code in request_threaded_irq, where I
think we should do something similar.

Will
