From: bhutchings@solarflare.com (Ben Hutchings)
Date: Mon, 18 Apr 2011 21:57:25 +0100
Subject: [PATCH V14 4/4] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
In-Reply-To: <1728ffb5735c2a04876a69ad55427c4e7b5a1bd7.1303107532.git.richard.cochran@omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<1728ffb5735c2a04876a69ad55427c4e7b5a1bd7.1303107532.git.richard.cochran@omicron.at>
Message-ID: <1303160245.2857.60.camel@bwh-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-04-18 at 08:30 +0200, Richard Cochran wrote:
> This patch adds support for the PTP clock found on the DP83640.
> The basic clock operations and one external time stamp have
> been implemented.
[...]
> --- /dev/null
> +++ b/drivers/net/phy/dp83640.c
[...]
> +static int match(struct sk_buff *skb, unsigned int type, struct rxts *rxts)
> +{
> +	u16 *seqid;

Should be __be16 *, and similarly for the casts.

> +	u8 *msgtype, *data = skb_mac_header(skb);
> +
> +	/* check sequenceID, messageType, 12 bit hash of offset 20-29 */
> +	/* We assume that the IPv4 header has no options. */

Does the hardware definitely not timestamp received packets with IP
options?

> +	switch (type) {
> +	case PTP_CLASS_V1_IPV4:
> +		msgtype = data + 42 + 32;
> +		seqid = (u16 *)(data + 42 + 30);
> +		break;
> +	case PTP_CLASS_V1_IPV6:
> +		msgtype = data + 62 + 32;
> +		seqid = (u16 *)(data + 62 + 30);
> +		break;
> +	case PTP_CLASS_V2_IPV4:
> +		msgtype = data + 42 + 0;
> +		seqid = (u16 *)(data + 42 + 30);
> +		break;
> +	case PTP_CLASS_V2_IPV6:
> +		msgtype = data + 62 + 0;
> +		seqid = (u16 *)(data + 62 + 30);
> +		break;
> +	case PTP_CLASS_V2_L2:
> +		msgtype = data + 14 + 0;
> +		seqid = (u16 *)(data + 14 + 30);
> +		break;
> +	case PTP_CLASS_V2_VLAN:
> +		msgtype = data + 18 + 0;
> +		seqid = (u16 *)(data + 18 + 30);
> +		break;
[...]

Would be better without the magic numbers.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
