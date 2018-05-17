From: broonie@kernel.org (Mark Brown)
Date: Thu, 17 May 2018 15:55:44 +0900
Subject: [PATCH v8 09/24] ASoC: qdsp6: q6afe: Add q6afe driver
In-Reply-To: <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
References: <20180509125635.5653-1-srinivas.kandagatla@linaro.org>
 <20180509125635.5653-10-srinivas.kandagatla@linaro.org>
Message-ID: <20180517065544.GO20254@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 01:56:20PM +0100, Srinivas Kandagatla wrote:

> +static struct q6afe_port *afe_find_port(struct q6afe *afe, int token)
> +{
> +	struct q6afe_port *p = NULL;
> +	struct q6afe_port *ret = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&afe->port_list_lock, flags);
> +	list_for_each_entry(p, &afe->port_list, node)
> +		if (p->token == token) {
> +			ret = p;
> +			break;
> +		}
> +
> +	spin_unlock_irqrestore(&afe->port_list_lock, flags);
> +	return ret;

This lock only protects the list, it does nothing to ensure that the
port we look up is still valid by the time we return to the caller.
That means we won't crash during list traversal but does nothing to
ensure we won't crash immediately afterwards if the port is deallocated
just after we look it up.  What stops that happening?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/2294767d/attachment-0001.sig>
