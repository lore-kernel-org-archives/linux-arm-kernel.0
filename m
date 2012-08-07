From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Tue, 7 Aug 2012 14:31:23 -0400
Subject: [PATCH v2 16/23] xen: clear IRQ_NOAUTOEN and IRQ_NOREQUEST
In-Reply-To: <1344263246-28036-16-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1208061428060.4645@kaball.uk.xensource.com>
 <1344263246-28036-16-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20120807183123.GS15053@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 06, 2012 at 03:27:19PM +0100, Stefano Stabellini wrote:
> Reset the IRQ_NOAUTOEN and IRQ_NOREQUEST flags that are enabled by
> default on ARM. If IRQ_NOAUTOEN is set, __setup_irq doesn't call
> irq_startup, that is responsible for calling irq_unmask at startup time.
> As a result event channels remain masked.

Acked by me.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  drivers/xen/events.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/xen/events.c b/drivers/xen/events.c
> index 5ecb596..8ffb7b7 100644
> --- a/drivers/xen/events.c
> +++ b/drivers/xen/events.c
> @@ -836,6 +836,7 @@ int bind_evtchn_to_irq(unsigned int evtchn)
>  		struct irq_info *info = info_for_irq(irq);
>  		WARN_ON(info == NULL || info->type != IRQT_EVTCHN);
>  	}
> +	irq_clear_status_flags(irq, IRQ_NOREQUEST|IRQ_NOAUTOEN);
>  
>  out:
>  	mutex_unlock(&irq_mapping_update_lock);
> -- 
> 1.7.2.5
