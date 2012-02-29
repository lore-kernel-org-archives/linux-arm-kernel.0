From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Wed, 29 Feb 2012 14:27:54 +0000
Subject: [PATCH 1/2] ARM: EXYNOS: Add EHCI AHB burst function
In-Reply-To: <CAJuYYwTW6rBiSJdeFYMui96t6nszjADW4t+14XakRkc=_4DbBA@mail.gmail.com>
References: <1330519283-4722-1-git-send-email-sangwook.lee@linaro.org>	<1330519283-4722-2-git-send-email-sangwook.lee@linaro.org>
 <CAJuYYwTW6rBiSJdeFYMui96t6nszjADW4t+14XakRkc=_4DbBA@mail.gmail.com>
Message-ID: <4F4E35EA.8050605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 29/02/12 13:01, Thomas Abraham wrote:
> Hi Sangwook,
>
> On 29 February 2012 18:11, Sangwook Lee<sangwook.lee@linaro.org>  wrote:
>> Enable burst transfer from AHB for EHCI.
>> This fixes data transfer of USB Ethernet with EHCI.
>> Without this patch, scp hardly works.
>>
>> Signed-off-by: Sangwook Lee<sangwook.lee@linaro.org>
>> ---
>>   arch/arm/mach-exynos/setup-usb-phy.c      |    6 ++++++
>>   arch/arm/plat-samsung/devs.c              |    2 ++
>>   arch/arm/plat-samsung/include/plat/ehci.h |   19 +++++++++++++++++++
>>   3 files changed, 27 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
>> index 41743d2..5a20460 100644
>> --- a/arch/arm/mach-exynos/setup-usb-phy.c
>> +++ b/arch/arm/mach-exynos/setup-usb-phy.c
>> @@ -18,6 +18,7 @@
>>   #include<mach/regs-usb-phy.h>
>>   #include<plat/cpu.h>
>>   #include<plat/usb-phy.h>
>> +#include<plat/ehci.h>
>>
>>   static atomic_t host_usage;
>>
>> @@ -149,3 +150,8 @@ int s5p_usb_phy_exit(struct platform_device *pdev, int type)
>>
>>         return -EINVAL;
>>   }
>> +
>> +void s5p_ehci_burst_enable(struct platform_device *pdev, void __iomem *base)
>> +{
>> +       writel(EHCI_INSNREG00_ENABLE_BURST, base + EHCI_INSNREG00);
>> +}
>
> This functionality can be added in ehci-s5p itself and avoid adding a
> new platform callback in platform data. If this is specific to exynos,
> driver data could be added in ehci-s5p to indicate platforms that need
> this to be enabled.

it makes sense.

>
> Thanks,
> Thomas.
>
> [...]
