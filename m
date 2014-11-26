From: js07.lee@gmail.com (Jungseung Lee)
Date: Wed, 26 Nov 2014 19:05:13 +0900
Subject: [PATCH v2] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <6108655.KIqtjFdn4U@wuerfel>
References: <1416981921-19643-1-git-send-email-js07.lee@gmail.com>
 <6108655.KIqtjFdn4U@wuerfel>
Message-ID: <CAPP0e=PGo7UGso1eHhLW3ZCt7qb3dobsax7hpxECqAZFgiSBxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

2014-11-26 17:48 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 26 November 2014 15:05:21 Jungseung Lee wrote:
>> +#if __LINUX_ARM_ARCH__ >= 6 && !defined(CONFIG_ARM_LPAE)
>> +static inline bool cpu_has_classic_pxn(void)
>> +{
>> +       static unsigned int vmsa = ~0UL;
>> +
>> +       if (cpu_architecture() != CPU_ARCH_ARMv7)
>> +               return false;
>> +       if (vmsa == 4)
>> +               return true;
>> +
>> +       vmsa = (read_cpuid_ext(CPUID_EXT_MMFR0) & 0xf) >> 0;
>> +       return vmsa == 4;
>> +}
>> +#else
>> +static inline bool cpu_has_classic_pxn(void)
>> +{
>> +       return false;
>> +}
>> +#endif
>> +
>>
>
> As mentioned before, please turn the #ifdef into an "if (IS_ENABLED(...))" check.
>
Actually I select the style since I thought the style is more intuitive .
I'll turn the #ifdef into "if(...)" check.

> The 'if (vmsa == 4)' check above looks like it came from an earlier version
> and is always false, so just drop that.
vmsa is static variable and it is intended to avoid read_cpuid_ext
call at every cpu_has_classic_pxn() calling.
Is it confused code or read_cpuid_ext() overhead is tiny to ignore?
Kindly let me know your suggestion..

>
>         Arnd

Thanks!
