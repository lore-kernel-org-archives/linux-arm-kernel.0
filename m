From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Thu, 06 Aug 2015 16:33:42 +0900
Subject: [RFC PATCH v4 0/9]
In-Reply-To: <55C30D52.6040802@rock-chips.com>
References: <1438843469-23807-1-git-send-email-shawn.lin@rock-chips.com>
 <55C307D2.7020501@samsung.com> <55C30D52.6040802@rock-chips.com>
Message-ID: <55C30DD6.8020802@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2015 04:31 PM, Shawn Lin wrote:
> ? 2015/8/6 15:08, Jaehoon Chung ??:
>> Hi, Shawn.
>>
>> I remembered that Krzysztof has mentioned "Fix the title of cover letter."
>> Your cover letter's title is nothing.. "[RFC PATCH v4 0/9] " ??
>> [RFC PATCH v4 0/9] your title...
>  Sorry, I forgot it, and will fix in next version...

No problem :) 
At next time,  add the title at your cover-letter, plz.

Best Regards,
Jaehoon Chung

> 
>> Best Regards,
>> Jaehoon Chung
>>
>> On 08/06/2015 03:44 PM, Shawn Lin wrote:
>>> Add external dma support for Synopsys MSHC
>>>
>>> Synopsys DesignWare mobile storage host controller supports three
>>> types of transfer mode: pio, internal dma and external dma. However,
>>> dw_mmc can only supports pio and internal dma now. Thus some platforms
>>> using dw-mshc integrated with generic dma can't work in dma mode. So we
>>> submit this patch to achieve it.
>>>
>>> And the config option, CONFIG_MMC_DW_IDMAC, was added by Will Newton
>>> (commit:f95f3850) for the first version of dw_mmc and never be touched since
>>> then. At that time dt-bindings hadn't been introduced into dw_mmc yet means
>>> we should select CONFIG_MMC_DW_IDMAC to enable internal dma mode at compile
>>> time. Nowadays, device-tree helps us to support a variety of boards with one
>>> kernel. That's why we need to remove it and decide the transfer mode by reading
>>> dw_mmc's HCON reg at runtime.
>>>
>>> This RFC patch needs lots of ACKs. I know it's hard, but it does need someone
>>> to make the running.
>>>
>>> Patch does the following things:
>>> - remove CONFIG_MMC_DW_IDMAC config option
>>> - add bindings for edmac used by synopsys-dw-mshc
>>>    at runtime
>>> - add edmac support for synopsys-dw-mshc
>>>
>>> Patch is based on next of git://git.linaro.org/people/ulf.hansson/mmc
>>>
>>>
>>> Changes in v4:
>>> - remove "host->trans_mode" and use "host->use_dma" to indicate
>>>    transfer mode.
>>> - remove all bt-bindings' changes since we don't need new properities.
>>> - check transfer mode at runtime by reading HCON reg
>>> - spilt defconfig changes for each sub-architecture
>>> - fix the title of cover letter
>>> - reuse some code for reducing code size
>>>
>>> Changes in v3:
>>> - choose transfer mode at runtime
>>> - remove all CONFIG_MMC_DW_IDMAC config option
>>> - add supports-idmac property for some platforms
>>>
>>> Changes in v2:
>>> - Fix typo of dev_info msg
>>> - remove unused dmach from declaration of dw_mci_dma_slave
>>>
>>> Shawn Lin (9):
>>>    mmc: dw_mmc: Add external dma interface support
>>>    Documentation: synopsys-dw-mshc: add bindings for idmac and edmac
>>>    mips: pistachio_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arc: axs10x_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: exynos_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: hisi_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: lpc18xx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: multi_v7_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>    arm: zx_defconfig: remove CONFIG_MMC_DW_IDMAC
>>>
>>>   .../devicetree/bindings/mmc/synopsys-dw-mshc.txt   |  25 ++
>>>   arch/arc/configs/axs101_defconfig                  |   1 -
>>>   arch/arc/configs/axs103_defconfig                  |   1 -
>>>   arch/arc/configs/axs103_smp_defconfig              |   1 -
>>>   arch/arm/configs/exynos_defconfig                  |   1 -
>>>   arch/arm/configs/hisi_defconfig                    |   1 -
>>>   arch/arm/configs/lpc18xx_defconfig                 |   1 -
>>>   arch/arm/configs/multi_v7_defconfig                |   1 -
>>>   arch/arm/configs/zx_defconfig                      |   1 -
>>>   arch/mips/configs/pistachio_defconfig              |   1 -
>>>   drivers/mmc/host/Kconfig                           |  11 +-
>>>   drivers/mmc/host/dw_mmc-pltfm.c                    |   2 +
>>>   drivers/mmc/host/dw_mmc.c                          | 258 +++++++++++++++++----
>>>   include/linux/mmc/dw_mmc.h                         |  27 ++-
>>>   14 files changed, 257 insertions(+), 75 deletions(-)
>>>
>>
>>
>>
> 
> 
