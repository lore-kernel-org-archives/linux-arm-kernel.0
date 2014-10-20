From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 20 Oct 2014 11:31:59 -0500
Subject: [PATCHv2 1/2] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <CAD=FV=X=DOVLeW6YQzFcXBrVte9vCizMvDy9DJQFLYUnzEAeHQ@mail.gmail.com>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>	<1413819079-17120-2-git-send-email-dinguyen@opensource.altera.com>
 <CAD=FV=X=DOVLeW6YQzFcXBrVte9vCizMvDy9DJQFLYUnzEAeHQ@mail.gmail.com>
Message-ID: <544538FF.7090200@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 10:46 AM, Doug Anderson wrote:
> Dinh,
> 
> On Mon, Oct 20, 2014 at 8:31 AM,  <dinguyen@opensource.altera.com> wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> Without this patch, the booting the SOCFPGA platform would hang at the
>> SDMMC driver loading. There were 2 patches that caused this to happen:
>>
>> - Patch 9795a846e10 "mmc: dw_mmc: remove dw_mci_of_cd_gpio/wp_gpio()" removed
>>   looking for "cd-gpios", since mmc_of_parse was getting called.
>> - Patch 3cf890fc42b "mmc: dw_mmc: Pass back errors from mmc_of_parse()" would
>>   hang the system at the SDMMC driver loading.
>>
>> This patch will fix booting with SDMMC enabled on SOCFPGA dev kit.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm/boot/dts/socfpga_cyclone5_socdk.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> index d7296a5..739c3b7 100644
>> --- a/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> +++ b/arch/arm/boot/dts/socfpga_cyclone5_socdk.dts
>> @@ -69,7 +69,7 @@
>>  };
>>
>>  &mmc0 {
>> -       cd-gpios = <&gpio1 18 0>;
>> +       cd = <&gpio1 18 0>;
> 
> This doesn't look right to me.  What was the error that was passed back?
> 
> I think your change has the same net effect as just deleting the
> "cd-gpios" line.  ...or is there some code somewhere that is parsing
> the "cd" property.
> 

It just hangs here:

dw_mmc ff704000.dwmmc0: Using PIO mode.
dw_mmc ff704000.dwmmc0: Version ID is 240a
dw_mmc ff704000.dwmmc0: DW MMC controller at irq 171, 32 bit host data
width, 1024 deep fifo
platform ff704000.dwmmc0: Driver dw_mmc requests probe deferral


Without this patch :
mmc_of_parse ret=-517 (EPROBE_DEFER)

With this patch or deleting the "cd-gpios" line then
mmc_of_parse ret=0


So does the driver go into polling for a card removal when neither cd or
cd-gpios are specified? Because I can see that card removal and
insertion working without any cd/cd-gpios entry in the DTS?

Thanks,
Dinh
