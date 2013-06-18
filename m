From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 18 Jun 2013 10:04:28 +0530
Subject: [PATCH v10 1/2] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E95C2@DLEE08.ent.ti.com>
References: <1371463571-2578-1-git-send-email-nsekhar@ti.com>
 <1371463571-2578-2-git-send-email-nsekhar@ti.com>
 <20130617170326.GA28497@quad.lixom.net>
 <083BC63EECB6FD41B8E81CF7FD87CC0F2E4E95C2@DLEE08.ent.ti.com>
Message-ID: <51BFE354.6070207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/17/2013 11:25 PM, Fernandes, Joel A wrote:
> Hi Olof,
> 
>> -----Original Message-----
>> From: Olof Johansson [mailto:olof at lixom.net]
>> Sent: Monday, June 17, 2013 12:03 PM
>> To: Nori, Sekhar
>> Cc: Russell King; Vinod Koul; Chris Ball; Liam Girdwood; Mark Brown; Kevin
>> Hilman; Matt Porter; Fernandes, Joel A; linux-arm-kernel at lists.infradead.org;
>> davinci-linux-open-source at linux.davincidsp.com; linux-mmc at vger.kernel.org;
>> alsa-devel at alsa-project.org; Arnd Bergmann
>> Subject: Re: [PATCH v10 1/2] ARM: davinci: move private EDMA API to
>> arm/common
>>
>> On Mon, Jun 17, 2013 at 03:36:10PM +0530, Sekhar Nori wrote:
>>> From: Matt Porter <mporter@ti.com>
>>>
>>> Move mach-davinci/dma.c to common/edma.c so it can be used by OMAP
>>> (specifically AM33xx) as well.
>>>
>>> Signed-off-by: Matt Porter <mporter@ti.com>
>>> Acked-by: Chris Ball <cjb@laptop.org> # davinci_mmc.c
>>> [nsekhar at ti.com: dropped davinci sffsdr changes]
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>
>> Acked-by: Olof Johansson <olof@lixom.net>
>>
>> Tiny nit below, no need to respin just for that.
>>
>> I suppose we should take this through arm-soc.
>>
>>> ---
>>>  arch/arm/Kconfig                                   |    1 +
>>>  arch/arm/common/Kconfig                            |    3 +
>>>  arch/arm/common/Makefile                           |    1 +
>>>  arch/arm/{mach-davinci/dma.c => common/edma.c}     |    2 +-
>>>  arch/arm/mach-davinci/Makefile                     |    2 +-
>>>  arch/arm/mach-davinci/board-tnetv107x-evm.c        |    2 +-
>>>  arch/arm/mach-davinci/davinci.h                    |    2 +-
>>>  arch/arm/mach-davinci/devices-tnetv107x.c          |    2 +-
>>>  arch/arm/mach-davinci/devices.c                    |    6 +-
>>>  arch/arm/mach-davinci/dm355.c                      |    2 +-
>>>  arch/arm/mach-davinci/dm365.c                      |    2 +-
>>>  arch/arm/mach-davinci/dm644x.c                     |    2 +-
>>>  arch/arm/mach-davinci/dm646x.c                     |    2 +-
>>>  arch/arm/mach-davinci/include/mach/da8xx.h         |    2 +-
>>>  drivers/dma/edma.c                                 |    2 +-
>>>  drivers/mmc/host/davinci_mmc.c                     |    1 +
>>>  include/linux/mfd/davinci_voicecodec.h             |    3 +-
>>>  .../mach => include/linux/platform_data}/edma.h    |   89 +-------------------
>>>  include/linux/platform_data/spi-davinci.h          |    2 +-
>>>  sound/soc/davinci/davinci-evm.c                    |    1 +
>>>  sound/soc/davinci/davinci-pcm.c                    |    1 +
>>>  sound/soc/davinci/davinci-pcm.h                    |    2 +-
>>>  22 files changed, 29 insertions(+), 103 deletions(-)  rename
>>> arch/arm/{mach-davinci/dma.c => common/edma.c} (99%)  rename
>>> {arch/arm/mach-davinci/include/mach =>
>>> include/linux/platform_data}/edma.h (59%)
>>>
>>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig index
>>> 49d993c..b1c66a4 100644
>>> --- a/arch/arm/Kconfig
>>> +++ b/arch/arm/Kconfig
>>> @@ -840,6 +840,7 @@ config ARCH_DAVINCI
>>>  	select GENERIC_IRQ_CHIP
>>>  	select HAVE_IDE
>>>  	select NEED_MACH_GPIO_H
>>> +	select TI_PRIV_EDMA
>>
>> What does PRIV here mean? Privileged? Private? I think it can be shortened to
>> TI_EDMA.
>>
>  [Joel] TI_EDMA already exists. It is used to build drivers/dma/edma.
> I have a patch that reuses the TI_EDMA option instead of the PRIV one . I will
> include that In my v11 series for EDMA (v10 was just posted) . If its ok, let us
> merge Sekhar's patch as-is, and then mine will get rid of the PRIV option
> (among other things).

PRIV is short for "private". We will get rid of TI_PRIV_EDMA along with
all users of private DMA API (including audio). TI_EDMA and TI_PRIV_EDMA
denote different things and we cannot reuse one for the other.

Thanks,
Sekhar
