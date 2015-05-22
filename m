From: stefan@agner.ch (Stefan Agner)
Date: Fri, 22 May 2015 14:02:52 +0200
Subject: [PATCH v3 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <35561091.AtkcGa6qVG@wuerfel>
References: <cover.1432290463.git.maitysanchayan@gmail.com>
 <d27c4ba234cd298914676884a9604ea8472a17d0.1432290463.git.maitysanchayan@gmail.com>
 <35561091.AtkcGa6qVG@wuerfel>
Message-ID: <61585e4449cfc1f36e16a64b9b4a54fe@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-05-22 13:11, Arnd Bergmann wrote:
> On Friday 22 May 2015 16:21:54 Sanchayan Maity wrote:
>> +#define OCOTP_CFG0_OFFSET      0x00000410
>> +#define OCOTP_CFG1_OFFSET      0x00000420
>> +#define MSCM_CPxCOUNT_OFFSET   0x0000002C
>> +#define MSCM_CPxCFG1_OFFSET    0x00000014
>> +#define ROM_REVISION_OFFSET    0x00000080
>> +
>> +static const struct of_device_id vf610_soc_bus_match[] = {
>> +	{ .compatible = "fsl,vf610-mscm-cpucfg", },
>> +	{ /* sentinel */ }
>> +};
>> +
>> +static int __init vf610_soc_init(void)
>> +{
>> +	struct regmap *ocotp_regmap, *mscm_regmap, *rom_regmap;
>> +	struct soc_device_attribute *soc_dev_attr;
>> +	struct soc_device *soc_dev;
>> +	struct device_node *np;
>> +	char soc_type[] = "xx0";
>> +	u32 cpxcount, cpxcfg1;
>> +	u32 soc_id1, soc_id2, rom_rev;
>> +	u64 soc_id;
>> +	int ret;
>> +
>> +	np = of_find_matching_node(NULL, vf610_soc_bus_match);
>> +	if (!np)
>> +		return -ENODEV;
>> +
> 
> Why not use module_platform_driver() and make this a probe function instead?
> 
>> +	ocotp_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocotp");
>> +	if (IS_ERR(ocotp_regmap)) {
>> +		pr_err("regmap lookup for octop failed\n");
>> +		return PTR_ERR(ocotp_regmap);
>> +	}
>> +
>> +	mscm_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-mscm-cpucfg");
>> +	if (IS_ERR(mscm_regmap)) {
>> +		pr_err("regmap lookup for mscm failed");
>> +		return PTR_ERR(mscm_regmap);
>> +	}
>> +
>> +	rom_regmap = syscon_regmap_lookup_by_compatible("fsl,vf610-ocrom");
>> +	if (IS_ERR(rom_regmap)) {
>> +		pr_err("regmap lookup for ocrom failed");
>> +		return PTR_ERR(rom_regmap);
>> +	}
> 
> Can you use syscon_regmap_lookup_by_phandle instead, and put the
> phandles in the fsl,vf610-mscm-cpucfg node?

Hm, with that we would wire up hardware modules which does nothing has
to do with each other. We just happen to need a driver which collects
information accross the SoC. I'm not sure we should put the modules
required into the device tree.

I don't think its nice to have the compatible strings in the source
code, however it feels more appropriate than in the device tree, IMHO...

> Also, I'd argue that the mscm should not be a syscon device at all,
> but instead I'd use platform_get_resource()/devm_ioremap_resource()
> to get an __iomem pointer.

We need to have mscm-cpucfg to be syscon because we need to get the CPU
personality in the MSCM interrupt router driver (irq-vf610-mscm-ir.c). 

--
Stefan
