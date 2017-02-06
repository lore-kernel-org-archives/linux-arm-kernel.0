From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 6 Feb 2017 10:32:41 +0100
Subject: [PATCH] mmc: meson-gx: add support for HS400 mode
In-Reply-To: <m2fuk4uyco.fsf@baylibre.com>
References: <f7f325ec-6099-7f51-5bb4-24ac24073ee7@gmail.com>
 <m2fuk4uyco.fsf@baylibre.com>
Message-ID: <0939c5e6-98bb-7a7c-4b4c-645f7b8b141b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2017 07:55 PM, Kevin Hilman wrote:
> Heiner Kallweit <hkallweit1@gmail.com> writes:
> 
>> Add support for HS400 mode.
>>
>> Successfully tested on a Odroid C2 (S905 GXBB).
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Excellent!  Thanks for the patch.
> 
> Reviewed-by: Kevin Hilman <khilman@baylibre.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> 
> Some folks on IRC had reported that eMMC wasn't working on some boards
> (like Amlogic P200) and with this patch, it's working again for me on P200.
> 
> @Andreas: does this patch fix your R-box Pro?
> 
> Kevin

Hi Heiner,

Actually activating HS400 and DDR modes should need DT attributes to actually enable them
in the MMC core code, and it seems the hardware needs some timings adjustment to use these
modes. If you consider they are enabled by U-boot, good but it won't always be the case !

Ulf, what is exactly needed to support these modes ?
In other drivers and Amlogic own driver, they have support for the some calibration
commands handling.

Neil

> 
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>> index 030425be..be45d57d 100644
>> --- a/drivers/mmc/host/meson-gx-mmc.c
>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>> @@ -83,6 +83,7 @@
>>  #define   CFG_RC_CC_MASK 0xf
>>  #define   CFG_STOP_CLOCK BIT(22)
>>  #define   CFG_CLK_ALWAYS_ON BIT(18)
>> +#define   CFG_CHK_DS BIT(20)
>>  #define   CFG_AUTO_CLK BIT(23)
>>  
>>  #define SD_EMMC_STATUS 0x48
>> @@ -412,6 +413,16 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>  	val &= ~(CFG_RC_CC_MASK << CFG_RC_CC_SHIFT);
>>  	val |= ilog2(SD_EMMC_CFG_CMD_GAP) << CFG_RC_CC_SHIFT;
>>  
>> +	val &= ~CFG_DDR;
>> +	if (ios->timing == MMC_TIMING_UHS_DDR50 ||
>> +	    ios->timing == MMC_TIMING_MMC_DDR52 ||
>> +	    ios->timing == MMC_TIMING_MMC_HS400)
>> +		val |= CFG_DDR;
>> +
>> +	val &= ~CFG_CHK_DS;
>> +	if (ios->timing == MMC_TIMING_MMC_HS400)
>> +		val |= CFG_CHK_DS;
>> +
>>  	writel(val, host->regs + SD_EMMC_CFG);
>>  
>>  	if (val != orig)
