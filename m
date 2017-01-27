From: huziji@marvell.com (Ziji Hu)
Date: Sat, 28 Jan 2017 00:39:33 +0800
Subject: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
In-Reply-To: <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
Message-ID: <461fd409-81e8-2c3f-3674-ec593e1c7383@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Ulf,

On 2017/1/26 18:50, Ulf Hansson wrote:
> On 11 January 2017 at 18:19, Gregory CLEMENT
> <gregory.clement@free-electrons.com> wrote:
>> From: Hu Ziji <huziji@marvell.com>
>>
>> Add Xenon eMMC/SD/SDIO host controller core functionality.
>> Add Xenon specific intialization process.
>> Add Xenon specific mmc_host_ops APIs.
>> Add Xenon specific register definitions.
>>
>> Add CONFIG_MMC_SDHCI_XENON support in drivers/mmc/host/Kconfig.
>>
>> Marvell Xenon SDHC conforms to SD Physical Layer Specification
>> Version 3.01 and is designed according to the guidelines provided
>> in the SD Host Controller Standard Specification Version 3.00.
>>
>> Signed-off-by: Hu Ziji <huziji@marvell.com>
>> Tested-by: Russell King <rmk+kernel@armlinux.org.uk>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/mmc/host/Kconfig       |   9 +-
>>  drivers/mmc/host/Makefile      |   3 +-
>>  drivers/mmc/host/sdhci-xenon.c | 631 ++++++++++++++++++++++++++++++++++-
>>  drivers/mmc/host/sdhci-xenon.h |  70 ++++-
>>  4 files changed, 713 insertions(+)
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>>  create mode 100644 drivers/mmc/host/sdhci-xenon.h
>>
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index 2eb97014dc3f..8d2d08de14a0 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -819,3 +819,12 @@ config MMC_SDHCI_BRCMSTB
>>           Broadcom STB SoCs.
>>
>>           If unsure, say Y.
>> +
>> +config MMC_SDHCI_XENON
>> +       tristate "Marvell Xenon eMMC/SD/SDIO SDHCI driver"
>> +       depends on MMC_SDHCI && MMC_SDHCI_PLTFM
> 
> Depending on MMC_SDHCI_PLTFM is enough.
> 

    Thanks a lot for your review and detailed suggestions.
    They are really helpful.

    I will simplify the dependence to MMC_SDHCI_PLTFM only.

> [...]
> 
>> +
>> +static int xenon_start_signal_voltage_switch(struct mmc_host *mmc,
>> +                                            struct mmc_ios *ios)
>> +{
>> +       struct sdhci_host *host = mmc_priv(mmc);
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +
>> +       /*
>> +        * Before SD/SDIO set signal voltage, SD bus clock should be
>> +        * disabled. However, sdhci_set_clock will also disable the Internal
>> +        * clock in mmc_set_signal_voltage().
>> +        * If Internal clock is disabled, the 3.3V/1.8V bit can not be updated.
>> +        * Thus here manually enable internal clock.
>> +        *
>> +        * After switch completes, it is unnecessary to disable internal clock,
>> +        * since keeping internal clock active obeys SD spec.
>> +        */
>> +       enable_xenon_internal_clk(host);
>> +
>> +       if (priv->init_card_type == MMC_TYPE_MMC)
> 
> So, you need a specific voltage switch for eMMC.
> 
> For that, I don't think you need to implement ->init_card(), as to set
> priv->init_card_type and then check it here.
> 
> Instead you should be able to find out whether the card is an eMMC,
> only by the parsing of the child node for the "mmc-card" compatible.
> More about this below.
> 

    I would like to discuss about ->init_card() implementation in
    my reply to our next patch ([PATCH v5 07/12] mmc: sdhci-xenon:
    Add support to PHYs of Marvell Xenon SDHC).

>> +               return xenon_emmc_signal_voltage_switch(mmc, ios);
>> +
>> +       return sdhci_start_signal_voltage_switch(mmc, ios);
>> +}
>> +
>> +/*
> 
> [...]
> 
>> + */
>> +static int xenon_child_node_of_parse(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>> +       struct mmc_host *mmc = host->mmc;
>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +       struct device_node *child;
>> +       int nr_child;
>> +
>> +       priv->init_card_type = XENON_CARD_TYPE_UNKNOWN;
>> +
>> +       nr_child = of_get_child_count(np);
>> +       if (!nr_child)
>> +               return 0;
>> +
>> +       for_each_child_of_node(np, child) {
>> +               if (of_device_is_compatible(child, "mmc-card")) {
> 
> To avoid code from being duplicated, I would rather see the DT parsing
> of the child nodes for "mmc-card", to be done by the mmc core.
> 
> As a matter of fact it is already being done, but perhaps we need to
> change that a bit as to fit your case.
> 
> I suggest you have a look and see how to update this in the core,
> instead of doing it here in the host driver.
> 

    I understand your concern.

    It seems that so far "mmc-card" is only used in our Xenon driver.
    Besides, we set Xenon specific parameters and attributions when
    parsing "mmc-card" property.

    May I keep current implementation?
    In my very own opinion, moving it into core layer should be another
    independent patch.
    And it will also cost some more time. To be honest, it is difficult
    for me to bring up a generic core layer implementation to parse
    "mmc-card", since I'm not clear about other vendor's requirement.

>> +                       priv->init_card_type = MMC_TYPE_MMC;
>> +                       mmc->caps |= MMC_CAP_NONREMOVABLE;
>> +
>> +                       /*
>> +                        * Force to clear BUS_TEST to
>> +                        * skip bus_test_pre and bus_test_post
>> +                        */
>> +                       mmc->caps &= ~MMC_CAP_BUS_WIDTH_TEST;
>> +                       mmc->caps2 |= MMC_CAP2_HC_ERASE_SZ |
> 
> This cap is a bit strange. It was added several years ago by Adrian
> Hunter, but I am wondering about the reason to why it's needed.
> 
> Should it be removed and instead enabled per default? If not, should
> we invent a new specific DT binding for it?
> 
> I need Adrian's help here to understand the options.
> 
>> +                                     MMC_CAP2_PACKED_CMD |
> 
> The MMC_CAP2_PACKED_CMD cap has be removed.

    Will remove it in next version.

> 
>> +                                     MMC_CAP2_NO_SD |
>> +                                     MMC_CAP2_NO_SDIO;
> 
> I think we need to update the DT documentation for mmc-card.
> Typically, we should explicitly state what kind of other existing mmc
> DT properties that will be automatically selected, when the mmc-card
> is specified.
> 
> Can you please look into updating this DT doc as well.
> 

  Similar to above, may I keep it now and bring up another patch later
  to update mmc-card DT and parsing?

> [...]
> 
>> +       priv->sdhc_id = 0x0;
>> +       if (!of_property_read_u32(np, "marvell,xenon-sdhc-id", &sdhc_id)) {
>> +               nr_sdhc = sdhci_readl(host, XENON_SYS_CFG_INFO);
>> +               nr_sdhc &= XENON_NR_SUPPORTED_SLOT_MASK;
>> +               if (unlikely(sdhc_id > nr_sdhc)) {
>> +                       dev_err(mmc_dev(mmc), "SDHC Index %d exceeds Number of SDHCs %d\n",
>> +                               sdhc_id, nr_sdhc);
>> +                       return -EINVAL;
>> +               }
>> +       }
>> +
>> +       tuning_count = XENON_DEF_TUNING_COUNT;
>> +       if (!of_property_read_u32(np, "marvell,xenon-tun-count",
>> +                                 &tuning_count)) {
>> +               if (unlikely(tuning_count >= XENON_TMR_RETUN_NO_PRESENT)) {
>> +                       dev_err(mmc_dev(mmc), "Wrong Re-tuning Count. Set default value %d\n",
>> +                               XENON_DEF_TUNING_COUNT);
>> +                       tuning_count = XENON_DEF_TUNING_COUNT;
>> +               }
>> +       }
> 
> I suggest you move the parsing of the xenon specific bindings into a
> separate function.
> 

    I totally agree with you.

>> +       priv->tuning_count = tuning_count;
>> +
>> +       return err;
>> +}
>> +
> 
> [...]
> 
> Kind regards
> Uffe
> 
