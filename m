From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Thu, 02 Sep 2010 11:17:26 -0700
Subject: [PATCH v3] davinci: Initial support for MityDSP-L138/MityARM-1808
In-Reply-To: <4C7FE773.5070005@mvista.com> (Sergei Shtylyov's message of "Thu,
	02 Sep 2010 22:05:39 +0400")
References: <1283450287-9881-1-git-send-email-michael.williamson@criticallink.com>
	<4C7FE773.5070005@mvista.com>
Message-ID: <87tym857t5.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sergei Shtylyov <sshtylyov@mvista.com> writes:

> Hello.
>
> Michael Williamson wrote:
>
>> This patch adds initial support for the MityDSP-L138 and MityDSP-1808 system
>> on Module (SOM) under the machine name "mityomapl138".  These SOMs are based
>> on the da850 davinci CPU architecture.  Information on these SOMs may be
>> found at http://www.mitydsp.com.
>
>> Basic support for the console UART, NAND, and EMAC (MII interface) is
>> included in this patch.
>
>> Signed-off-by: Michael Williamson <michael.williamson@criticallink.com>
>
> [...]
>
>> diff --git a/arch/arm/mach-davinci/board-mityomapl138.c b/arch/arm/mach-davinci/board-mityomapl138.c
>> new file mode 100644
>> index 0000000..78c972b
>> --- /dev/null
>> +++ b/arch/arm/mach-davinci/board-mityomapl138.c
>> @@ -0,0 +1,220 @@
> [...]
>> +static const short mityomap_mii_pins[] = {
>> +	DA850_MII_TXEN, DA850_MII_TXCLK, DA850_MII_COL, DA850_MII_TXD_3,
>> +	DA850_MII_TXD_2, DA850_MII_TXD_1, DA850_MII_TXD_0, DA850_MII_RXER,
>> +	DA850_MII_CRS, DA850_MII_RXCLK, DA850_MII_RXDV, DA850_MII_RXD_3,
>> +	DA850_MII_RXD_2, DA850_MII_RXD_1, DA850_MII_RXD_0, DA850_MDIO_CLK,
>> +	DA850_MDIO_D,
>> +	-1
>> +};
>> +
>> +static const short mityomap_rmii_pins[] = {
>> +	DA850_RMII_TXD_0, DA850_RMII_TXD_1, DA850_RMII_TXEN,
>> +	DA850_RMII_CRS_DV, DA850_RMII_RXD_0, DA850_RMII_RXD_1,
>> +	DA850_RMII_RXER, DA850_RMII_MHZ_50_CLK, DA850_MDIO_CLK,
>> +	DA850_MDIO_D,
>> +	-1
>> +};
>> +
>> +static void __init mityomapl138_config_emac(void)
>> +{
>> +	void __iomem *cfg_chip3_base;
>> +	int ret;
>> +	u32 val;
>> +	struct davinci_soc_info *soc_info = &davinci_soc_info;
>
>    Should be an empty line here...

I'll add this before pushing.

>> +	soc_info->emac_pdata->rmii_en = 0; /* hardcoded for now */
>> +
>> +	cfg_chip3_base = DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG);
>> +	val = __raw_readl(cfg_chip3_base);
>> +
>> +	if (soc_info->emac_pdata->rmii_en) {
>
>    If it's hard coded to 0, why handle the other case?

He's planning to add support for the other options in subsequent
patches, so I'm OK with leaving this as is.


>> +		val |= BIT(8);
>> +		ret = davinci_cfg_reg_list(mityomap_rmii_pins);
>> +		pr_info("RMII PHY configured\n");
>> +	} else {
>> +		val &= ~BIT(8);
>> +		ret = davinci_cfg_reg_list(mityomap_mii_pins);
>> +		pr_info("MII PHY configured\n");
>> +	}
>
> WBR, Sergei

Kevin
