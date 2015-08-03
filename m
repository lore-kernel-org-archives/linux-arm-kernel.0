From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 3 Aug 2015 17:42:57 +0530
Subject: [PATCH 00/17] omap_hsmmc: regulator usage cleanup and fixes
In-Reply-To: <CALtMJEDP1-Q9W=x-0hq3tZQ1QZ2LVwVj47=ADYDjT7BsfanffA@mail.gmail.com>
References: <1438168187-1614-1-git-send-email-kishon@ti.com>
 <CALtMJEDP1-Q9W=x-0hq3tZQ1QZ2LVwVj47=ADYDjT7BsfanffA@mail.gmail.com>
Message-ID: <55BF5AC9.9000007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Monday 03 August 2015 12:58 PM, Andreas Fenkart wrote:
> Hi Kishon,
> 
> Thanks for taking a look at the regulator code. Do you have a public
> git repository so I can pull your patches instead of cherry picking
> 1-by-1?

I'll post v2 shortly. With that I'll have the patches in a git tree.

Thanks
Kishon

> 
> /Andi
> 
> 2015-07-29 13:09 GMT+02:00 Kishon Vijay Abraham I <kishon@ti.com>:
>> This patch series does the following
>> *) Uses devm_regulator_get_optional() for vmmc and then removes the
>>    CONFIG_REGULATOR check altogether.
>> *) return on -EPROBE_DEFER
>> *) enable/disable vmmc_aux regulator based on prior state
>>
>> This series is in preparation for implementing the voltage switch
>> sequence so that UHS cards can be supported.
>>
>> Did basic read/write test in J6, J6 Eco, Beagle-x15, AM437x EVM,
>> Beaglebone black, OMAP5 uEVM and OMAP4 PANDA.
>>
>> Kishon Vijay Abraham I (16):
>>   mmc: host: omap_hsmmc: use devm_regulator_get_optional() for vmmc
>>   mmc: host: omap_hsmmc: return error from omap_hsmmc_reg_get on
>>     -EPROBE_DEFER
>>   mmc: host: omap_hsmmc: cleanup omap_hsmmc_reg_get()
>>   mmc: host: omap_hsmmc: use the ocrmask provided by the vmmc regulator
>>   mmc: host: omap_hsmmc: use mmc_host's vmmc and vqmmc
>>   mmc: host: omap_hsmmc: remove unnecessary pbias set_voltage
>>   mmc: host: omap_hsmmc: return error if any of the regulator APIs fail
>>   mmc: host: omap_hsmmc: add separate functions for enable/disable
>>     supply
>>   mmc: host: omap_hsmmc: add separate function to set pbias
>>   mmc: host: omap_hsmmc: avoid pbias regulator enable on power off
>>   mmc: host: omap_hsmmc: don't use ->set_power to set initial regulator
>>     state
>>   ARM: dts: am57xx-beagle-x15: Fix regulator populated in MMC1 dt node
>>   mmc: host: omap_hsmmc: enable/disable vmmc_aux regulator based on
>>     prior state
>>   mmc: host: omap_hsmmc: use regulator_is_enabled to find pbias status
>>   mmc: host: omap_hsmmc: use ios->vdd for setting vmmc voltage
>>   mmc: host: omap_hsmmc: remove CONFIG_REGULATOR check
>>
>> Roger Quadros (1):
>>   mmc: host: omap_hsmmc: use "mmc_of_parse_voltage" to get ocr_avail
>>
>>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    2 +
>>  arch/arm/boot/dts/am57xx-beagle-x15.dts            |    1 -
>>  drivers/mmc/host/omap_hsmmc.c                      |  333 +++++++++++++-------
>>  3 files changed, 216 insertions(+), 120 deletions(-)
>>
>> --
>> 1.7.9.5
>>
