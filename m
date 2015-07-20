From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jul 2015 10:46:27 -0700
Subject: [PATCH 07/10] opp: Add OPP sharing information to OPP library
In-Reply-To: <20150718063304.GD11802@linux>
References: <cover.1434369079.git.viresh.kumar@linaro.org>
 <2e1c7fcc1fb62f73c82bd57d196d054ba2607a55.1434369079.git.viresh.kumar@linaro.org>
 <55A986DD.3010104@codeaurora.org> <20150718063304.GD11802@linux>
Message-ID: <55AD33F3.4000302@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2015 11:33 PM, Viresh Kumar wrote:
> From: Viresh Kumar <viresh.kumar@linaro.org>
> Date: Wed, 11 Feb 2015 16:16:28 +0800
> Subject: [PATCH] opp: Add OPP sharing information to OPP library
>
> An opp can be shared by multiple devices, for example its very common
> for CPUs to share the OPPs, i.e. when they share clock/voltage rails.
>
> This patch adds support of shared OPPs to the OPP library.
>
> Instead of a single device, dev_opp will not contain a list of devices
> that use it. It also senses if the device (we are trying to initialize
> OPPs for) shares OPPs with a device added earlier and in that case we
> update the list of devices managed by OPPs instead of duplicating OPPs
> again.
>
> The same infrastructure will be used for the old OPP bindings, with
> later patches.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> +static struct device_opp *_managed_opp(const struct device_node *np)
> +{
> +	struct device_opp *dev_opp;
> +
> +	list_for_each_entry_rcu(dev_opp, &dev_opp_list, node)
> +		if (dev_opp->np == np) {
> +			/*
> +			 * Multiple devices can point to the same OPP table and
> +			 * so will have same node-pointer, np.
> +			 *
> +			 * But the OPPs will be considered as shared only if the
> +			 * OPP table contains a "opp-shared" property.
> +			 */
> +			if (dev_opp->shared_opp)
> +				return dev_opp;
> +			else
> +				return NULL;
> +		

The janitors will probably find this and say that it could be simplified 
to an if () and a return without the else.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
