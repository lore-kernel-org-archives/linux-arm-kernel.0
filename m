From: pankaj.dubey@samsung.com (pankaj.dubey)
Date: Fri, 07 Apr 2017 19:22:50 +0530
Subject: [PATCH v9 08/12] ARM: EXYNOS: move exynos_boot_vector_{addr, flag}
 ops to exynos_s2r_data
In-Reply-To: <CAJKOXPeFhmcscCX-so5qSx9pdX8oEmC+-283HO+J3vJNvWr_Hg@mail.gmail.com>
References: <CGME20170330131436epcas1p4a4f8bf7b64b4a5ff9ee692adc4e7d001@epcas1p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-9-git-send-email-pankaj.dubey@samsung.com>
 <CAJKOXPeFhmcscCX-so5qSx9pdX8oEmC+-283HO+J3vJNvWr_Hg@mail.gmail.com>
Message-ID: <ef086da4-5994-3f44-5225-69ca469882e0@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 07 April 2017 04:02 PM, Krzysztof Kozlowski wrote:
> On Thu, Mar 30, 2017 at 3:17 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
>> Various Exynos SoC needs different boot addresses and flags. Currently we
>> are handling this difference by adding lots of soc_is_exynosMMM checks in
>> the code, in an attempt to remove the dependency of such helper functions
>> specific to each SoC, let's separate helper functions for these helper
>> functions by moving them into SoC specific hooks in struct exynos_s2r_data.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>  arch/arm/mach-exynos/pm.c | 60 +++++++++++++++++++++++++++++++++++++++--------
>>  1 file changed, 50 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
>> index fa24098..c3fa537 100644
>> --- a/arch/arm/mach-exynos/pm.c
>> +++ b/arch/arm/mach-exynos/pm.c
>> @@ -32,26 +32,56 @@
>>  #include "common.h"
>>
>>  struct exynos_s2r_data {
>> +       void __iomem* (*boot_vector_addr)(void);
>> +       void __iomem* (*boot_vector_flag)(void);
>>         void (*enter_aftr)(void);
>>  };
> 
> OK, now I see more uses of this structure so the naming could be
> "exynos_pm_data"?

OK. I will update accordingly.

> 
>>
>>  static const struct exynos_s2r_data *s2r_data;
>>
>> -static inline void __iomem *exynos_boot_vector_addr(void)
>> +static void __iomem *exynos_boot_vector_addr(void)
>> +{
>> +       if (s2r_data && s2r_data->boot_vector_addr)
>> +               return s2r_data->boot_vector_addr();
>> +
>> +       return NULL;
>> +}
>> +
>> +static inline void __iomem *exynos4210_rev11_boot_vector_addr(void)
> 
> Inlines here are mixed up and you are changing them without
> explanation in commit msg. Previously the exynos_boot_vector_addr()
> was inlined, now not. Okay, I can accept that but please mention this
> in commit msg.

OK, let me recheck these inline functions once again.

> But below you are adding new inline functions which are stored as
> pointers in ops. This looks both inconsistent with above and incorrect
> from logical point of view. How would you like to inline them if they
> are referenced through pointer? (okay, compilers are smart and crazy
> so maybe they can do it but anyway I am curious how this would look
> like).

Well I am also wondering what was in my mind when I made them inline and
why I do not get any compilation warning or error?

Just looking for answer, is it OK for inline functions to be used as
function pointers? I can see it is allowed and compilers won't complain
as 'inline' specifier is just hint for compiler and they may or may not
make them inline. Here also as you pointed out probably compilers will
take care and not make them inline.

I further checked with 'nm' command on pm.o file I can see even these
inline marked functions are present in symbol listing so looks they have
not been really inlined by compiler.

I will update this in next patchset.

> 
>> +{
>> +       return pmu_base_addr + S5P_INFORM7;
>> +}
>> +
>> +static inline void __iomem *exynos4210_rev10_boot_vector_addr(void)
>> +{
>> +       return sysram_base_addr + 0x24;
>> +}
>> +
>> +static inline void __iomem *exynos_common_boot_vector_addr(void)
>>  {
>> -       if (samsung_rev() == EXYNOS4210_REV_1_1)
>> -               return pmu_base_addr + S5P_INFORM7;
>> -       else if (samsung_rev() == EXYNOS4210_REV_1_0)
>> -               return sysram_base_addr + 0x24;
>>         return pmu_base_addr + S5P_INFORM0;
>>  }
>>
>> -static inline void __iomem *exynos_boot_vector_flag(void)
>> +static void __iomem *exynos_boot_vector_flag(void)
> 
> ditto for the flag.
> 

This also I will take care in next patchset.

Thanks,
Pankaj Dubey
> Best regards,
> Krzysztof
> 
> 
> 
