From: davem@davemloft.net (David Miller)
Date: Fri, 16 Nov 2018 19:42:19 -0800 (PST)
Subject: [PATCH v2 2/2] dpaa_eth: add ethtool coalesce control
In-Reply-To: <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
References: <1542126591-5114-1-git-send-email-madalin.bucur@nxp.com>
 <1542126591-5114-3-git-send-email-madalin.bucur@nxp.com>
Message-ID: <20181116.194219.2027125174407236599.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Tue, 13 Nov 2018 18:29:51 +0200

> +	for_each_cpu(cpu, cpus) {
> +		portal = qman_get_affine_portal(cpu);
> +		res = qman_portal_set_iperiod(portal, period);
> +		if (res)
> +			return res;
> +		res = qman_dqrr_set_ithresh(portal, thresh);
> +		if (res)
> +			return res;

Nope, you can't do it like this.

If any intermediate change fails, you have to unwind all of the
changes made up until that point.

Which means you'll have to store the previous setting somewhere
and reinstall those saved values in the error path.
