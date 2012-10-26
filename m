From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 26 Oct 2012 11:04:20 -0600
Subject: [PATCH 1/2] ARM: tegra: dt: add L2 cache controller
In-Reply-To: <1351247649-15859-1-git-send-email-josephl@nvidia.com>
References: <1351247649-15859-1-git-send-email-josephl@nvidia.com>
Message-ID: <508AC294.7080506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/26/2012 04:34 AM, Joseph Lo wrote:
> Add L2 cache controller binding into DT for Tegra.

> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi

> +	L2: cache-controller at 50043000 {
> +		compatible = "arm,pl310-cache";
> +		reg = <0x50043000 0x1000>;
> +		arm,data-latency = <5 5 2>;
> +		arm,tag-latency = <4 4 2>;
> +		cache-unified;
> +		cache-level = <2>;
> +	};

Do you need to specify arm,filter-ranges here? It's certainly parsed by
pl310_of_setup() and used if present, although I don't think we're
programming the register in the existing code, so I guess we don't need it.

The L2 label above isn't necessary unless something references those
nodes. Usually, that something is the cpu nodes' next-level-cache
property. I don't suppose you could amend this series to also fill in
Tegra's /cpus nodes in these files too?

Finally, is this series going to be a dependency for any of the cpuidle
or other work you're submitting? I assume it's completely independent
and hence I can throw it in any old branch in any order I feel like?

Thanks.
