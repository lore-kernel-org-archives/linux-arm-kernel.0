From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 10 Jul 2014 19:00:30 +0530
Subject: [PATCH V9 2/7] phy: Add drivers for PCIe and SATA phy on SPEAr13xx
In-Reply-To: <53BE926A.2070005@ti.com>
References: <cover.1404976058.git.viresh.kumar@linaro.org>
 <d1ef8db8704d09ba4f276c954dc22b555998f957.1404976058.git.viresh.kumar@linaro.org>
 <53BE926A.2070005@ti.com>
Message-ID: <CAKohpokNijH37NAmuh5cYEZxYFJE-COKwVNP3RNHSEoS03YYAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 July 2014 18:47, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On Thursday 10 July 2014 12:56 PM, Viresh Kumar wrote:
>> From: Pratyush Anand <pratyush.anand@st.com>
>>
>> ARM based ST Microelectronics's SPEAr1310/40 platforms uses ST's phy (known as
>> 'miphy') for PCIe and SATA. This patch adds drivers for these miphys.
>>
>> This also adds proper bindings for miphys.
>>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Pratyush Anand <pratyush.anand@st.com>
>> Tested-by: Mohit Kumar <mohit.kumar@st.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> [viresh: fixed logs/cclist/checkpatch warnings, broken into smaller patches]
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  .../devicetree/bindings/phy/st-spear1310-miphy.txt |  12 +
>>  .../devicetree/bindings/phy/st-spear1340-miphy.txt |  11 +
>>  drivers/phy/Kconfig                                |  12 +
>>  drivers/phy/Makefile                               |   2 +
>>  drivers/phy/phy-spear1310-miphy.c                  | 274 +++++++++++++++++++
>>  drivers/phy/phy-spear1340-miphy.c                  | 302 +++++++++++++++++++++
>
> Please send separate patche for each driver.

These were both around SPEAr and were on the same lines.
So sending these in a single patch shouldn't be a big issue I believe.

In case another version is required, I may do it.

>> diff --git a/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>> new file mode 100644
>> index 0000000..b9b281a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/st-spear1310-miphy.txt
>
> We generally create a single document for a SoC vendor. So just use st-phy.txt.

Probably yes.

> <snip>

Please keep line containing file names while removing stuff, makes it easy
to locate code.

>> +
>> +static int spear1340_miphy_sata_init(struct spear1340_miphy_priv *priv)
>> +{
>> +     regmap_update_bits(priv->misc, SPEAR1340_PCIE_SATA_CFG,
>> +                        SPEAR1340_PCIE_SATA_CFG_MASK,
>> +                        SPEAR1340_SATA_CFG_VAL);
>> +     regmap_update_bits(priv->misc, SPEAR1340_PCIE_MIPHY_CFG,
>> +                        SPEAR1340_PCIE_MIPHY_CFG_MASK,
>> +                        SPEAR1340_PCIE_SATA_MIPHY_CFG_SATA_25M_CRYSTAL_CLK);
>> +     /* Switch on sata power domain */
>> +     regmap_update_bits(priv->misc, SPEAR1340_PCM_CFG,
>> +                        SPEAR1340_PCM_CFG_SATA_POWER_EN,
>> +                        SPEAR1340_PCM_CFG_SATA_POWER_EN);
>> +     msleep(20);
>> +     /* Disable PCIE SATA Controller reset */
>> +     regmap_update_bits(priv->misc, SPEAR1340_PERIP1_SW_RST,
>> +                        SPEAR1340_PERIP1_SW_RSATA, 0);
>> +     msleep(20);
>
> Please add a comment for all delays added.

@Pratyush/Mohit: please let me know what to add here.

>> +#ifdef CONFIG_PM_SLEEP
>> +static int spear1340_miphy_suspend(struct device *dev)
>> +{
>> +     struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
>> +     int ret = 0;
>> +
>> +     if (priv->mode == SATA)
>> +             ret = spear1340_miphy_sata_exit(priv);
>
> Shouldn't this be spear1340_miphy_init()?
>> +
>> +     return ret;
>> +}
>> +
>> +static int spear1340_miphy_resume(struct device *dev)
>> +{
>> +     struct spear1340_miphy_priv *priv = dev_get_drvdata(dev);
>> +     int ret = 0;
>> +
>> +     if (priv->mode == SATA)
>> +             ret = spear1340_miphy_sata_init(priv);
>
> And here spear1340_miphy_exit()? Why only for sata phys?

@Mohit/Pratyush ??

Thanks Kishon for another round of review :)
