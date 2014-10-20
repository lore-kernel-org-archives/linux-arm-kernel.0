From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 20 Oct 2014 14:04:11 -0500
Subject: [PATCHv2 1/2] ARM: dts: socfpga: Fix SD card detect
In-Reply-To: <20141020184139.GA23062@leverpostej>
References: <1413819079-17120-1-git-send-email-dinguyen@opensource.altera.com>
 <1413819079-17120-2-git-send-email-dinguyen@opensource.altera.com>
 <20141020184139.GA23062@leverpostej>
Message-ID: <54455CAB.6090804@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/20/2014 01:41 PM, Mark Rutland wrote:
> On Mon, Oct 20, 2014 at 04:31:18PM +0100, dinguyen at opensource.altera.com wrote:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> Without this patch, the booting the SOCFPGA platform would hang at the
>> SDMMC driver loading. There were 2 patches that caused this to happen:
>>
>> - Patch 9795a846e10 "mmc: dw_mmc: remove dw_mci_of_cd_gpio/wp_gpio()" removed
>>   looking for "cd-gpios", since mmc_of_parse was getting called.
>> - Patch 3cf890fc42b "mmc: dw_mmc: Pass back errors from mmc_of_parse()" would
>>   hang the system at the SDMMC driver loading.
> 
> Regardless of which patches caused the issue, the existing DTB should
> continue to function. This is a kernel bug, not a DTB bug.

I apologize. I made the mistake when I looked at mmc_of_parse(). I made
the mistake when I saw this line of code:

mmc_gpiod_request_cd(host, "cd", 0, true, 0, &gpio_invert);

I thought it was looking for a "cd" property, but it's not.

> 
> How did you track down those two patches as being the cause(s)?

If I revert patch 3cf890fc42b "mmc: dw_mmc: Pass back errors from
mmc_of_parse()", then the system boots and gets past the SDMMC driver
loading, without doing anything else.

Basically, if I remove this change from the 3cf890fc42b patch, then the
system boots and does not hang at the sd driver:

+       ret = mmc_of_parse(mmc);
+       if (ret)
+               goto err_host_allocated;


Patch 9795a846e10 "mmc: dw_mmc: remove dw_mci_of_cd_gpio/wp_gpio()" is
probably not the cause of the problem.


> 
> I've heard a report of a similar issue on a sunxi platform (cubietruck),
> but I have not had the time to investigate.
> 
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
>> -	cd-gpios = <&gpio1 18 0>;
>> +	cd = <&gpio1 18 0>;
> 
> This change should not be necessary.
> 

Agreed...

Thanks,
Dinh
