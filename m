From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 20 Jul 2017 19:06:47 +0530
Subject: [PATCH 00/16] omap_hsmmc: Add ADMA support and UHS/HS200/DDR
 support
In-Reply-To: <fc9c1576-7419-b174-ea42-97ccf4666cee@ti.com>
References: <20170616124544.15046-1-kishon@ti.com>
 <CAPDyKFo+ORA=OpdikiUZWj3gpx+ssuqbC5MtqiFJneyJhu84dA@mail.gmail.com>
 <fc9c1576-7419-b174-ea42-97ccf4666cee@ti.com>
Message-ID: <27776609-2425-9423-3eaa-dc128c4b07f0@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Tuesday 11 July 2017 07:27 PM, Kishon Vijay Abraham I wrote:
> Hi Ulf,
> 
> On Tuesday 11 July 2017 06:40 PM, Ulf Hansson wrote:
>> On 16 June 2017 at 14:45, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> This is the final part of the series originally sent as
>>> part of [2].
>>>
>>> This series adds UHS, HS200, DDR mode and ADMA support to
>>> omap_hsmmc driver used to improve the throughput of MMC/SD in dra7
>>> SoCs.
>>>
>>> Changes from [2]:
>>> *) No more updating omap2plus_defconfig or multi_v7_defconfig is
>>>    required, so those patches are removed.
>>> *) Addressed Rob Herring's comment on implementing a function
>>>    instead of having a macro while getting pinctrl state.
>>>
>>> This series is created on top of [3], [4], [5] AND [6]
>>> (i.e after
>>>   ARM: dts: omap3-overo: Remove "vqmmc-supply" property from MMC dt node
>>>   omap_hsmmc: use mmc_regulator_get_supply() to get regulators
>>>   omap*: Fixes/Cleanups for MMC devicetree node
>>>   ARM: dts: Add iodelay data for MMC)
>>>
>>> The functionality implemented in this series was sent before ([1]) but
>>> was never followed up since supporting high speed modes in dra7 required
>>> IODelay values to be configured. With IODelay driver being merged into
>>> kernel, sending it as a fresh series with support for configuring IODelay
>>> values.
>>
>> Is it safe to queue this via mmc tree for 4.14 or is there a
>> dependency I must consider? The above didn't quite tell me that, could
>> you please elaborate.
> 
> There is a dependency with https://www.spinics.net/lists/arm-kernel/msg586215.html.
> 
> I'll resend the series after all the platform data specific stuff is merged.
>>
>>>
>>> Suggestions of migrating to sdhci driver (from omap_hsmmc driver) is not
>>> addressed since
>>> *) tuning ratio of MMC in dra7 is different from sdhci
>>> *) IOdelay is required for dra7
>>> *) GPIO based card detect is not supported in sdhci
>>
>> Lots of sdhci drivers calls mmc_of_parse(), and uses the mmc slot gpio
>> APIs, so I don't this this is correct statement.
>>
>>> *) Some of the registers don't always have correct values as in sdhci
>>>    (like PSTATE).
>>> Supporting all of these in sdhci will result in adding lot of quirks in
>>> sdhci driver.
>>
>> Is it really that much different? It would be nice if some really took
>> on the challenge of converting omap_hsmmc into an sdhci variant.
> 
> Okay. I'll give that a shot and see how far I can get.

I created a sdhci variant and was able to get it working with high speed mode
in dra7.

I have a query on sdhci_set_power_noreg() in sdhci.c. sdhci_set_power_noreg
sets SDHCI_POWER_CONTROL based on *vdd* value. However SDHCI_POWER_CONTROL is
for setting bus voltage and need not be based on *vdd*. IMHO
SDHCI_POWER_CONTROL should be set based on "ios->signal_voltage".

Let me know if my understanding is wrong.

Thanks
Kishon
