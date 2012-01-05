From: amit.kachhap@linaro.org (Amit Kachhap)
Date: Thu, 5 Jan 2012 11:56:44 +0530
Subject: [PATCH V5 5/5] ARM: exynos: Enable l2 configuration through
 device tree
In-Reply-To: <CAOesGMjb5no9o0kwiVm87XM8Q5QsMWdXhAypCmJMi7npy1fnSA@mail.gmail.com>
References: <1325737525-12869-1-git-send-email-amit.kachhap@linaro.org>
 <1325737525-12869-6-git-send-email-amit.kachhap@linaro.org>
 <CAOesGMjb5no9o0kwiVm87XM8Q5QsMWdXhAypCmJMi7npy1fnSA@mail.gmail.com>
Message-ID: <CAK44p206AS_F_2JJx2CXfzQmFZVPYhAUTSA9GgofTovg7v294A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 January 2012 10:06, Olof Johansson <olof@lixom.net> wrote:
> On Wed, Jan 4, 2012 at 8:25 PM, Amit Daniel Kachhap
> <amit.kachhap@linaro.org> wrote:
>> This patch enables calling generic l2 setup functions if device tree is used.
>>
>> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>> ---
>> ?arch/arm/mach-exynos/common.c | ? 14 ++++++++++++--
>> ?1 files changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
>> index f8bb808..e91b92d 100644
>> --- a/arch/arm/mach-exynos/common.c
>> +++ b/arch/arm/mach-exynos/common.c
>> @@ -47,6 +47,8 @@
>> ?#include <plat/regs-serial.h>
>>
>> ?#include "common.h"
>> +#define L2_AUX_VAL 0x7C470001
>> +#define L2_AUX_MASK 0xC200ffff
>>
>> ?static const char name_exynos4210[] = "EXYNOS4210";
>> ?static const char name_exynos4212[] = "EXYNOS4212";
>> @@ -453,6 +455,15 @@ core_initcall(exynos4_core_init);
>> ?#ifdef CONFIG_CACHE_L2X0
>> ?static int __init exynos4_l2x0_cache_init(void)
>> ?{
>> +#ifdef CONFIG_OF
>> + ? ? ? int ret;
>> + ? ? ? ret = l2x0_of_init(L2_AUX_VAL, L2_AUX_MASK);
>> + ? ? ? if (!ret) {
>> + ? ? ? ? ? ? ? l2x0_regs_phys = virt_to_phys(&l2x0_saved_regs);
>> + ? ? ? ? ? ? ? clean_dcache_area(&l2x0_regs_phys, sizeof(unsigned long));
>> + ? ? ? ? ? ? ? return 0;
>> + ? ? ? }
>> +#endif
>
> No need for ifdef here, if CONFIG_OF is off, then there's a static
> inline version of l2x_of_init() that will return -ENODEV.

Will accept your suggestion. Thanks

>
>
> -Olof
