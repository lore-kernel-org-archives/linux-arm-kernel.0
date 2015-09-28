From: thunder.leizhen@huawei.com (Leizhen (ThunderTown))
Date: Mon, 28 Sep 2015 16:41:19 +0800
Subject: [PATCH 2/2] arm64: to allow EFI_RTC can be selected on ARM64
In-Reply-To: <CAKv+Gu_uFi03XVf5mX9Qy7eH=m1Q1ufpBNN2ucvSREBD+H-Q4g@mail.gmail.com>
References: <1443418478-8240-1-git-send-email-thunder.leizhen@huawei.com>
 <1443418478-8240-3-git-send-email-thunder.leizhen@huawei.com>
 <CAKv+Gu_uFi03XVf5mX9Qy7eH=m1Q1ufpBNN2ucvSREBD+H-Q4g@mail.gmail.com>
Message-ID: <5608FD2F.1000105@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/9/28 15:40, Ard Biesheuvel wrote:
> On 28 September 2015 at 06:34, Zhen Lei <thunder.leizhen@huawei.com> wrote:
>> Now, ARM64 is also support EFI startup. We hope use EFI runtime services
>> to get/set current time and date.
>>
>> RTC_LIB only controls some configs in drivers/char/Kconfig(included
>> EFI_RTC), and will be automatically selected when RTC_CLASS opened. So
>> this patch have no functional change but give an opportunity to select
>> EFI_RTC when RTC_CLASS closed.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  arch/arm64/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
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
> You can currently enable EFI_RTC just fine on arm64 when EFI is enabled.
> Why exactly do you need this patch on top?

Because when we run "make ARCH=arm64 menuconfig", RTC_LIB is always selected. And we have no opportunity
to deselect it. And EFI_RTC can be displayed only when RTC_LIB=n.

--------drivers/rtc/Kconfig-------
config RTC_LIB
        bool

menuconfig RTC_CLASS
        bool "Real Time Clock"
        default n
        depends on !S390 && !UML
        select RTC_LIB

--------------drivers/char/Kconfig--------------
if RTC_LIB=n

......

config EFI_RTC
        bool "EFI Real Time Clock Services"
        depends on IA64 || ARM64

.......

endif # RTC_LIB

> 
> .
> 
