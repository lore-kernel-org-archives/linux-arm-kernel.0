From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 28 Sep 2015 16:29:57 +0800
Subject: [PATCH 2/2] arm64: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <1783631.jH4WY2RqXu@wuerfel>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
 <1443418478-8240-3-git-send-email-thunder.leizhen@huawei.com>
 <1783631.jH4WY2RqXu@wuerfel>
Message-ID: <5608FA85.8070009@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/28 15:35, Arnd Bergmann wrote:
> On Monday 28 September 2015 13:34:38 Zhen Lei wrote:
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 07d1811..25cec57 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -85,7 +85,7 @@ config ARM64
>>         select PERF_USE_VMALLOC
>>         select POWER_RESET
>>         select POWER_SUPPLY
>> -       select RTC_LIB
>> +       select RTC_LIB if !EFI
>>         select SPARSE_IRQ
>>         select SYSCTL_EXCEPTION_TRACE
>>         select HAVE_CONTEXT_TRACKING
> 
> Sorry, we can't do that: enabling EFI has to be done in a way that it only
> adds features but not disables them.

I run "make ARCH=arm64 menuconfig" and found that RTC_CLASS is selected by default. Actually, RTC_LIB only
controls whether to display some configs when run "make menuconfig". I list all informations below:

---------make ARCH=arm64 menuconfig-----
  [*] Real Time Clock  --->

---------drivers/rtc/Kconfig-------
menuconfig RTC_CLASS
        bool "Real Time Clock"
        default n
        depends on !S390 && !UML
        select RTC_LIB

-----------------------------------
find . -name "*Kconfig*" | xargs grep RTC_LIB
./drivers/rtc/Kconfig:config RTC_LIB
./drivers/rtc/Kconfig:	select RTC_LIB
./drivers/char/Kconfig:if RTC_LIB=n
./drivers/char/Kconfig:endif # RTC_LIB
./arch/x86/Kconfig:	select RTC_LIB
./arch/arm/Kconfig:	select RTC_LIB
./arch/arm64/Kconfig:	select RTC_LIB if !EFI
./arch/sh/Kconfig:	select RTC_LIB
./arch/mips/Kconfig:	select RTC_LIB if !MACH_LOONGSON64

--------------drivers/char/Kconfig--------------
if RTC_LIB=n

config RTC
        tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"

.......

endif # RTC_LIB


> 
> Your patch breaks RTC on all non-EFI platforms as soon as CONFIG_EFI
> is selected by the user.

No, on non-EFI platforms, they can still use RTC as before. As I mentioned above,
RTC_LIB only controls whether to display some configs when run "make menuconfig".
On ARM64, (in this patch) I only allowed EFI_RTC can be showed when RTC_LIB was not selected.

--------------drivers/char/Kconfig--------------
if RTC_LIB=n

config RTC
tristate "Enhanced Real Time Clock Support (legacy PC RTC driver)"

.......

config EFI_RTC
        bool "EFI Real Time Clock Services"
        depends on IA64 || ARM64

.......

endif # RTC_LIB

> 
> 	Arnd
> 
> .
> 
