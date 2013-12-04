From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 4 Dec 2013 10:31:36 +0100
Subject: [PATCH v3 2/3] regulator: tps6586x: add and use correct voltage
 table
In-Reply-To: <c70dc80179c8cfaa18c2665c342ce1bcd827d923.1386100296.git.stefan@agner.ch>
References: <cover.1386100296.git.stefan@agner.ch>
 <c70dc80179c8cfaa18c2665c342ce1bcd827d923.1386100296.git.stefan@agner.ch>
Message-ID: <20131204093136.GN19943@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 08:57:28PM +0100, Stefan Agner wrote:
[...]
> Changes since v2:
>   - Removed reg_ from reg_version
>   - Moved walk through version dependent tables to find_regulator_info,
>     removed the inline definition. This reduces .o size and encapsulates
>     the logic of finding the right regulator into one function. It comes
>     with a slight code duplication, the table search now appears twice.

Well, the table was searched twice in the original patch, too, so this
variant isn't any worse, really.

> ---
>  arch/arm/boot/dts/tegra20-colibri-512.dtsi |  4 +-
>  drivers/regulator/tps6586x-regulator.c     | 91 +++++++++++++++++++++++-------
>  2 files changed, 74 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20-colibri-512.dtsi b/arch/arm/boot/dts/tegra20-colibri-512.dtsi
[...]
> -static inline struct tps6586x_regulator *find_regulator_info(int id)
> +static struct tps6586x_regulator *find_regulator_info(int id, int version)
>  {
>  	struct tps6586x_regulator *ri;
> +	struct tps6586x_regulator *table = NULL;
> +	int num;
>  	int i;
>  
> +	switch (version) {
> +	case TPS658623:
> +		table = tps658623_regulator;
> +		num = ARRAY_SIZE(tps658623_regulator);
> +		break;
> +	case TPS658643:
> +		table = tps658643_regulator;
> +		num = ARRAY_SIZE(tps658643_regulator);
> +		break;
> +	}
> +

I think you still need to check for table to be valid here. Depending on
the version it might still be NULL.

> +	/* Search version specific table first */
> +	for (i = 0; i < num; i++) {
> +		ri = &table[i];
> +		if (ri->desc.id == id)
> +			return ri;
> +	}

So this would need to be wrapped in an "if (table) { }" block.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131204/cbaa8a9d/attachment.sig>
