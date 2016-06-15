From: broonie@kernel.org (Mark Brown)
Date: Wed, 15 Jun 2016 14:49:38 +0100
Subject: [PATCH v5 4/8] arm64: parse cpu capacity-dmips-mhz from DT
In-Reply-To: <1465985877-18271-5-git-send-email-juri.lelli@arm.com>
References: <1465985877-18271-1-git-send-email-juri.lelli@arm.com>
 <1465985877-18271-5-git-send-email-juri.lelli@arm.com>
Message-ID: <20160615134938.GA2282@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 15, 2016 at 11:17:53AM +0100, Juri Lelli wrote:

> +		if (!raw_capacity) {
> +			raw_capacity = kzalloc(sizeof(*raw_capacity) *
> +					num_possible_cpus(), GFP_KERNEL);

kcalloc()?

> +			if (!raw_capacity) {
> +				pr_err("cpu_capacity: failed to allocate memory"
> +				       " for raw capacities\n");

It's normally better to avoid splitting errors message so people can
grep if they see the error.

> +	} else {
> +		pr_err("cpu_capacity: missing %s raw capacity "
> +		       "(fallback to 1024 for all CPUs)\n",
> +				cpu_node->full_name);

That's going to complain fairly loudly for all existing DTs isn't it and
it's kind of redundant if all the cores have the same capacity (which is
a very common case)?  How about printing an error only if we already
found one, or printing a single warning at the end if we didn't get
anything?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160615/7556dbd7/attachment-0001.sig>
