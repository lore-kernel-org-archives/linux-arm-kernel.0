From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Tue, 6 Sep 2011 16:08:52 +0300 (EEST)
Subject: OMAP2+: hwmod: remove OMAP_CHIP*
In-Reply-To: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
References: <alpine.DEB.2.00.1109042042250.9056@utopia.booyaka.com>
Message-ID: <alpine.DEB.2.00.1109051606330.19606@esdhcp041196.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 5 Sep 2011, Paul Walmsley wrote:
> At Tony's request, remove the OMAP_CHIP* flags from the hwmod data, and
> replace it instead with chip family, variant, and ES level-specific lists
> of hwmods to register.
>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>

[...]

> int __init omap3xxx_hwmod_init(void)
> {
> -	return omap_hwmod_register(omap3xxx_hwmods);
> +	int r;
> +	struct omap_hwmod **h = NULL;
> +
> +	/* Register hwmods common to all OMAP3 */
> +	r = omap_hwmod_register(omap3xxx_hwmods);
> +	if (!r)
> +		return r;

Should the timer12 be also removed from the common omap3xxx_hwmods
list, as it is not available on (some?) HS devices. See
e.g. <http://marc.info/?l=linux-omap&m=129433066521102&w=2>

Currently RM-680 boot is broken because of this.

A.
