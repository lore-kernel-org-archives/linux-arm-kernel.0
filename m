From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Mon, 30 Jan 2017 09:41:28 +0100
Subject: [PATCH v5 06/12] mmc: sdhci-xenon: Add Marvell Xenon SDHC core
 functionality
In-Reply-To: <461fd409-81e8-2c3f-3674-ec593e1c7383@marvell.com>
References: <cover.8527229dae6c124f24c5e637430c2cdc86f80392.1484154449.git-series.gregory.clement@free-electrons.com>
 <3546f143091c121face8ecbcbf7f6a4c41d2cec7.1484154449.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFrwxix4zY4a1x9u6jh_gPfKTsaLnD8b8crum=pc5CN3AA@mail.gmail.com>
 <461fd409-81e8-2c3f-3674-ec593e1c7383@marvell.com>
Message-ID: <CAPDyKFoERET6Fzc7qEGWJ95t6GZir=XJWfTEoRSEROjPgJ95hg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>>> + */
>>> +static int xenon_child_node_of_parse(struct platform_device *pdev)
>>> +{
>>> +       struct device_node *np = pdev->dev.of_node;
>>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>>> +       struct mmc_host *mmc = host->mmc;
>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +       struct sdhci_xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
>>> +       struct device_node *child;
>>> +       int nr_child;
>>> +
>>> +       priv->init_card_type = XENON_CARD_TYPE_UNKNOWN;
>>> +
>>> +       nr_child = of_get_child_count(np);
>>> +       if (!nr_child)
>>> +               return 0;
>>> +
>>> +       for_each_child_of_node(np, child) {
>>> +               if (of_device_is_compatible(child, "mmc-card")) {
>>
>> To avoid code from being duplicated, I would rather see the DT parsing
>> of the child nodes for "mmc-card", to be done by the mmc core.
>>
>> As a matter of fact it is already being done, but perhaps we need to
>> change that a bit as to fit your case.
>>
>> I suggest you have a look and see how to update this in the core,
>> instead of doing it here in the host driver.
>>
>
>     I understand your concern.
>
>     It seems that so far "mmc-card" is only used in our Xenon driver.

git grep "mmc-card" tells you more about where it's being parsed by
the mmc core.

>     Besides, we set Xenon specific parameters and attributions when
>     parsing "mmc-card" property.

I don't see any Xenon specific properties.

Instead I think it would make sense to update the generic
interpretation of the binding for mmc-card, as you have done here.

>
>     May I keep current implementation?

Rather not. Let's try to make the parsing of the child node for
mmc-card generic.

>     In my very own opinion, moving it into core layer should be another
>     independent patch.

Absolutely an independent patch. Whether it can be done as a part of
mmc_of_parse() or whether we need yet another new mmc_of* API, we can
discuss.

My point is that, I don't this to be specific for Xenon (unless there
are specific reason, which I don't see here).

>     And it will also cost some more time. To be honest, it is difficult
>     for me to bring up a generic core layer implementation to parse
>     "mmc-card", since I'm not clear about other vendor's requirement.

Well, then you need to learn more about how the mmc core works. In
this case, it shouldn't be too hard to implement.

[...]

>
>>
>>> +                                     MMC_CAP2_NO_SD |
>>> +                                     MMC_CAP2_NO_SDIO;
>>
>> I think we need to update the DT documentation for mmc-card.
>> Typically, we should explicitly state what kind of other existing mmc
>> DT properties that will be automatically selected, when the mmc-card
>> is specified.
>>
>> Can you please look into updating this DT doc as well.
>>
>
>   Similar to above, may I keep it now and bring up another patch later
>   to update mmc-card DT and parsing?

Please, no.

[...]

Kind regards
Uffe
