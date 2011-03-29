From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 29 Mar 2011 23:40:18 +0100
Subject: [PATCH v2 2/2] regulator: Propagate uA_load requirements up
	supply chain
In-Reply-To: <1301356432-7586-2-git-send-email-collinsd@codeaurora.org>
References: <1301356355-7546-1-git-send-email-collinsd@codeaurora.org>
	<1301356432-7586-2-git-send-email-collinsd@codeaurora.org>
Message-ID: <20110329224017.GB15535@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 04:53:52PM -0700, David Collins wrote:

Some more specific comments on the code:

> +	if (rdev->desc->ops->get_current_required) {
> +		err = rdev->desc->ops->get_current_required(rdev, input_uV,
> +							output_uV, current_uA);
> +		if (err < 0)
> +			return;
> +		rdev->uA_load = err;
> +	}

I think we need something to handle misssing data here if there is a
supply connected, otherwise we'll end up failing silently.  Off the top
of my head we could either just complain loudly if there's no operation
and there should be one or make a pessimistic assumption about
efficiency by default.

> +	/* get supply current required for load */
> +	int (*get_current_required) (struct regulator_dev *, int input_uV,
> +				     int output_uV, int load_uA);
> +

I like the interface for the driver but possibly call it something like
get_supply_current() or something to make it a little clearer which
current is being requested?  Also needs to have kerneldoc added for the
new function - ideally the documentation would say this is for sustained
rather than peak load.
