From: brouer@redhat.com (Jesper Dangaard Brouer)
Date: Mon, 14 Mar 2016 10:57:14 +0100
Subject: [PATCH v6 net-next 08/10] net: mvneta: bm: add support for
 hardware buffer management
In-Reply-To: <1457944745-7634-9-git-send-email-gregory.clement@free-electrons.com>
References: <1457944745-7634-1-git-send-email-gregory.clement@free-electrons.com>
 <1457944745-7634-9-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20160314105714.1e97b4c1@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Mon, 14 Mar 2016 09:39:03 +0100 Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index b0ae69f84493..2847c0c291de 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
[...]
> -static void *mvneta_frag_alloc(const struct mvneta_port *pp)
> +void *mvneta_frag_alloc(unsigned int frag_size)
>  {
> -	if (likely(pp->frag_size <= PAGE_SIZE))
> -		return netdev_alloc_frag(pp->frag_size);
> +	if (likely(frag_size <= PAGE_SIZE))
> +		return netdev_alloc_frag(frag_size);

(I know you are modifying existing code here.)

Be aware that there is a significant performance advantage of using
napi_alloc_frag() over netdev_alloc_frag().  You obviously can only use
the NAPI call, if you indeed are running in NAPI/BH context.

>  	else
> -		return kmalloc(pp->frag_size, GFP_ATOMIC);
> +		return kmalloc(frag_size, GFP_ATOMIC);
>  }
> +EXPORT_SYMBOL_GPL(mvneta_frag_alloc);
  


-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  Author of http://www.iptv-analyzer.org
  LinkedIn: http://www.linkedin.com/in/brouer
