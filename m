From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Feb 2013 16:18:06 -0700
Subject: [RFC PATCH 6/9] hwmon: (lm90) Register to the thermal framework
In-Reply-To: <1361187031-3679-7-git-send-email-wni@nvidia.com>
References: <1361187031-3679-1-git-send-email-wni@nvidia.com>
 <1361187031-3679-7-git-send-email-wni@nvidia.com>
Message-ID: <5124082E.604@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2013 04:30 AM, Wei Ni wrote:
> Register the remote sensor to the thermal framework.
> It can support to show the temperature and read/write threshold.

>  arch/arm/boot/dts/tegra30-cardhu.dtsi |    1 +
>  drivers/hwmon/lm90.c                  |  182 ++++++++++++++++++++++++++++++++-

There shouldn't be any need to edit both those files in the same patch.
This patch is making multiple separate logical changes, which should be
separate patches.

> diff --git a/arch/arm/boot/dts/tegra30-cardhu.dtsi b/arch/arm/boot/dts/tegra30-cardhu.dtsi

> +			#sensor-cells = <1>;

Again, in order to allow that, you need some documentation in
Documentation/devicetree/bindings/. Related to that, you need to Cc the
devicetree maintainers on at least the patches that add that documentation.

> diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c

> @@ -1576,12 +1728,38 @@ static int lm90_probe(struct i2c_client *client,
...
> +	np_args.np = dev->of_node;
> +	np_args.index = 0;

As I mentioned before, that'd be better replaced by an explicit of_xlate
function.
