From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Mon, 6 Feb 2017 19:28:46 +0100
Subject: [PATCH] mmc: meson-gx: add support for HS400 mode
In-Reply-To: <0939c5e6-98bb-7a7c-4b4c-645f7b8b141b@baylibre.com>
References: <f7f325ec-6099-7f51-5bb4-24ac24073ee7@gmail.com>
 <m2fuk4uyco.fsf@baylibre.com>
 <0939c5e6-98bb-7a7c-4b4c-645f7b8b141b@baylibre.com>
Message-ID: <70768042-2b19-f8de-2f18-366b31475d14@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.02.2017 um 10:32 schrieb Neil Armstrong:
> On 01/27/2017 07:55 PM, Kevin Hilman wrote:
>> Heiner Kallweit <hkallweit1@gmail.com> writes:
>>
>>> Add support for HS400 mode.
>>>
>>> Successfully tested on a Odroid C2 (S905 GXBB).
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>
>> Excellent!  Thanks for the patch.
>>
>> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>>
>> Some folks on IRC had reported that eMMC wasn't working on some boards
>> (like Amlogic P200) and with this patch, it's working again for me on P200.
>>
>> @Andreas: does this patch fix your R-box Pro?
>>
>> Kevin
> 
> Hi Heiner,
> 
> Actually activating HS400 and DDR modes should need DT attributes to actually enable them
> in the MMC core code, and it seems the hardware needs some timings adjustment to use these
> modes. If you consider they are enabled by U-boot, good but it won't always be the case !
> 
Sure, to enable HS400 the related DT property needs to be set. I did this for my tests.
HS400 worked out of the box with 200MHz and a Hardkernel 8GB eMMC card.
However with a Hardkernel 128GB card I have issues with 200MHz even in SDR mode.
So yes, it seems at least tuning support needs to be added to the driver.

By the way: With the current mainline driver I have terrible performance, reads in
the range 10-15 MB/s. Even the uboot driver is faster, at least it states that it
reads the kernel image with 40 MB/s.

> Ulf, what is exactly needed to support these modes ?
> In other drivers and Amlogic own driver, they have support for the some calibration
> commands handling.
> 
Chip-internal calibration support sounds nice, however I have only the Amlogic driver
as basis and the pure register description in the Hardkernel-provided S905GXBB spec.
The spec misses more detailed information on how the calibration support works and
how the registers are supposed to be used.

> Neil
> 
>>
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 11 +++++++++++
>>>  1 file changed, 11 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 030425be..be45d57d 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -83,6 +83,7 @@
>>>  #define   CFG_RC_CC_MASK 0xf
>>>  #define   CFG_STOP_CLOCK BIT(22)
>>>  #define   CFG_CLK_ALWAYS_ON BIT(18)
>>> +#define   CFG_CHK_DS BIT(20)
>>>  #define   CFG_AUTO_CLK BIT(23)
>>>  
>>>  #define SD_EMMC_STATUS 0x48
>>> @@ -412,6 +413,16 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  	val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
>>>  	val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
>>>  
>>> +	val &= ~CFG_DDR;
>>> +	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
>>> +	    ios->timing == MMC_TIMING_MMC_DDR52 ||
>>> +	    ios->timing == MMC_TIMING_MMC_HS400)
>>> +		val |= CFG_DDR;
>>> +
>>> +	val &= ~CFG_CHK_DS;
>>> +	if (ios->timing == MMC_TIMING_MMC_HS400)
>>> +		val |= CFG_CHK_DS;
>>> +
>>>  	writel(val, host->regs + SD_EMMC_CFG);
>>>  
>>>  	if (val != orig)
> 
> 
