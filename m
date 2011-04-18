From: bhutchings@solarflare.com (Ben Hutchings)
Date: Mon, 18 Apr 2011 21:53:06 +0100
Subject: [PATCH V14 3/4] ptp: Added a clock driver for the IXP46x.
In-Reply-To: <dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
Message-ID: <1303159986.2857.56.camel@bwh-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-18 at 08:29 +0200, Richard Cochran wrote:
> This patch adds a driver for the hardware time stamping unit found on the
> IXP465. The basic clock operations and an external trigger are implemented.
[...]
> --- a/drivers/net/arm/ixp4xx_eth.c
> +++ b/drivers/net/arm/ixp4xx_eth.c
[...]
> @@ -246,6 +255,169 @@ static int ports_open;
>  static struct port *npe_port_tab[MAX_NPES];
>  static struct dma_pool *dma_pool;
>  
> +static struct sock_filter ptp_filter[] = {
> +	PTP_FILTER
> +};
> +
> +static int ixp_ptp_match(struct sk_buff *skb, u16 uid_hi, u32 uid_lo, u16 seq)
> +{
> +	unsigned int type;
> +	u16 *hi, *id;
> +	u8 *lo, *data = skb->data;
> +
> +	type = sk_run_filter(skb, ptp_filter);
> +
> +	if (PTP_CLASS_V1_IPV4 == type) {
> +
> +		id = (u16 *)(data + 42 + 30);
> +		hi = (u16 *)(data + 42 + 22);
> +		lo = data + 42 + 24;
[...]

PTP_FILTER does not verify that the packet length is sufficient to hold
a complete PTP header, nor does it require that the IPv4 header length
is 5 (i.e. 20 bytes).  So you have to check those here rather than using
magic numbers.

I think you also need to use be16_to_cpup() to read 'id' and 'hi', since
the host byte order may vary.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
