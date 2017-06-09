From: ore@pengutronix.de (Oleksij Rempel)
Date: Fri, 9 Jun 2017 12:11:15 +0200
Subject: [PATCH v4 2/3] nvmem: add snvs_lpgpr driver
In-Reply-To: <6babaffa-d782-309b-67e4-14dacb72383d@linaro.org>
References: <20170608165134.14971-1-o.rempel@pengutronix.de>
 <20170608165134.14971-3-o.rempel@pengutronix.de>
 <6babaffa-d782-309b-67e4-14dacb72383d@linaro.org>
Message-ID: <20170609101115.umiaec2qdspkfag3@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 10:35:15AM +0100, Srinivas Kandagatla wrote:
> 
> Few more nit picks!!
> 
> On 08/06/17 17:51, Oleksij Rempel wrote:
> > This is a driver for Low Power General Purpose Register (LPGPR)
> > available on i.MX6 SoCs in Secure Non-Volatile Storage (SNVS)
> > of this chip.
> > 
> > It is a 32-bit read/write register located in the low power domain.
> > Since LPGPR is located in the battery-backed power domain, LPGPR can
> > be used by any application for retaining data during an SoC power-down

.....

> > --- a/drivers/nvmem/Kconfig
> > +++ b/drivers/nvmem/Kconfig
> > @@ -144,4 +144,14 @@ config MESON_EFUSE
> >   	  This driver can also be built as a module. If so, the module
> >   	  will be called nvmem_meson_efuse.
> > +config NVMEM_SNVS_LPGPR
> > +	tristate "Support for Low Power General Purpose Register"
> > +	depends on SOC_IMX6 || COMPILE_TEST
> 
> shouldn't you either "select MFD_SYSCON" or "depends on MFD_SYSCON"
> here.

according to Documentation/kbuild/kconfig-language.txt
"In general use select only for non-visible symbols
 (no prompts anywhere) and for symbols with no dependencies."

this is why I removed select.

And SOC_IMX6 is already doing "select MFD_SYSCON", so I assume it should
be enough to depend on it.

Or do I miss some thing?

> > +	help
> > +	  This is a driver for Low Power General Purpose Register (LPGPR) available on
> > +	  i.MX6 SoCs in Secure Non-Volatile Storage (SNVS) of this chip.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called nvmem-snvs-lpgpr.
> > +
> >   endif

....

> > diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> > index 173140658693..4c589184acee 100644
> > --- a/drivers/nvmem/Makefile
> > +++ b/drivers/nvmem/Makefile
> > +
> > +struct snvs_lpgpr_priv {
> > +	struct device_d		*dev;
> > +	struct regmap		*regmap;
> > +	int			offset;
> 
> why do you need offset here, you already have access to cfg which has the
> offset member.

yes, you right. I'll update it.

> 
> > +	struct nvmem_config	cfg;
> > +};
> > +
> > +struct snvs_lpgpr_cfg {
> > +	int offset;
> > +};
> > +
> > +static const struct snvs_lpgpr_cfg snvs_lpgpr_cfg_imx6q = {
> > +	.offset = 0x68,
> > +};
> > +

....

> > +
> > +	return 0;
> > +}
> > +
> > +static int snvs_lpgpr_read(void *context, unsigned int offset, void *_val,
> > +			   size_t bytes)
> > +{
> > +
> > +static struct platform_driver snvs_lpgpr_driver = {
> > +	.probe	= snvs_lpgpr_probe,
> > +	.remove	= snvs_lpgpr_remove,
> > +	.driver = {
> > +		.name	= "snvs_lpgpr",
> > +		.of_match_table = snvs_lpgpr_dt_ids,
> > +	},
> > +};
> > +module_platform_driver(snvs_lpgpr_driver);
> > +
> > +MODULE_AUTHOR("Oleksij Rempel <o.rempel@pengutronix.de>");
> > +MODULE_DESCRIPTION("Low Power General Purpose Register in i.MX6 Secure Non-Volatile Storage");
> > +MODULE_LICENSE("GPL v2");
> > 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
