From: broonie@kernel.org (Mark Brown)
Date: Thu, 1 Mar 2018 21:24:02 +0000
Subject: [PATCH v3 07/25] ASoC: qcom: qdsp6: Add support to Q6ADM
In-Reply-To: <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
Message-ID: <20180301212402.GT12864@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 04:58:19PM +0000, srinivas.kandagatla at linaro.org wrote:

> +static struct copp *adm_find_copp(struct q6adm *adm, int port_idx,
> +				  int copp_idx)
> +{
> +	struct copp *c;
> +
> +	spin_lock(&adm->copps_list_lock);
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx)) {
> +			spin_unlock(&adm->copps_list_lock);
> +			return c;
> +		}
> +	}
> +
> +	spin_unlock(&adm->copps_list_lock);

We've again got this use of spinlocks here but no IRQ safety - what
exactly is going on with the locking?  In general all of the locking in
this stuff is raising very serious alarm bells with me, I don't
understand what is being protected against what and there's some very
obvious bugs.  We could probably use some documentation about what the
locking is supposed to be doing.

> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {

> +		copp->id = open->copp_id;
> +		wake_up(&copp->wait);
> +	}
> +	break;
> +	default:

This indentation is confusing.

> +static struct copp *adm_find_matching_copp(struct q6adm *adm,
> +					   int port_id, int topology,
> +					   int mode, int rate, int channel_mode,
> +					   int bit_width, int app_type)
> +{
> +	struct copp *c;
> +
> +	spin_lock(&adm->copps_list_lock);
> +
> +	list_for_each_entry(c, &adm->copps_list, node) {
> +		if ((port_id == c->afe_port) && (topology == c->topology) &&
> +		    (mode == c->mode) && (rate == c->rate) &&
> +		    (bit_width == c->bit_width) && (app_type == c->app_type)) {
> +			spin_unlock(&adm->copps_list_lock);
> +			return c;
> +		}
> +	}
> +	spin_unlock(&adm->copps_list_lock);
> +
> +	c = adm_alloc_copp(adm, port_id);

So really this is a find or allocate operation...

> +	if (IS_ERR_OR_NULL(c))
> +		return ERR_CAST(c);
> +
> +	mutex_lock(&c->lock);
> +	c->refcnt = 0;

Why do we need to lock the thing we just allocated but didn't yet
initialize, and surely if something can find it before we finished
initializing we have a race condition?

> +	copp = adm_find_matching_copp(adm, port_id, topology, perf_mode,
> +				      rate, channel_mode, bit_width, app_type);
> +
> +	/* Create a COPP if port id are not enabled */
> +	if (copp->refcnt == 0) {
> +		ret = q6adm_device_open(adm, copp, port_id, path, topology,
> +				  channel_mode, bit_width, rate);
> +		if (ret < 0)
> +			return ret;
> +	}
> +	mutex_lock(&copp->lock);
> +	copp->refcnt++;
> +	mutex_unlock(&copp->lock);

There's an obvious race here between checking the reference count and
incrementing it - something might drop a reference before we increment
it which would be bad.  I'm also not clear when we'd want multiple
things using a single COPP.

> +	mutex_lock(&copp->lock);
> +	copp->refcnt--;
> +	mutex_unlock(&copp->lock);
> +	if (!copp->refcnt) {

This locking is also broken.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/a1a34bf1/attachment.sig>
