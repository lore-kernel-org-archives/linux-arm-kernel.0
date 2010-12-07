From: fernando.lugo@ti.com (Guzman Lugo, Fernando)
Date: Mon, 6 Dec 2010 20:53:59 -0600
Subject: [PATCH] ARM: Add Kconfig entry for SG chain support
In-Reply-To: <20101207104451X.fujita.tomonori@lab.ntt.co.jp>
References: <1291686036-32562-1-git-send-email-fernando.lugo@ti.com>
	<20101207104451X.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <AANLkTi=-ktF0F5uxYy9CCU1-R4_2o32eYQJrr1uHuUxs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 6, 2010 at 7:45 PM, FUJITA Tomonori
<fujita.tomonori@lab.ntt.co.jp> wrote:
> On Mon, ?6 Dec 2010 19:40:36 -0600
> Fernando Guzman Lugo <fernando.lugo@ti.com> wrote:
>
>> Add a entry to make possible SG chaining under ARM
>> architecture.
>>
>> Tidspbridge driver needs SG chaining, however SG chain has not
>> been tested under all platforms. Adding this option OMAP
>> platform can enable it and if other platforms have issues they
>> would not enable it.
>>
>> This patch is base on this discussion:
>>
>> http://marc.info/?l=linux-arm-kernel&m=129166415415541&w=2
>>
>> Signed-off-by: Fernando Guzman Lugo <fernando.lugo@ti.com>
>> ---
>> ?arch/arm/Kconfig ? ? ? ? ? ? ? ? ? | ? ?6 ++++++
>> ?arch/arm/include/asm/scatterlist.h | ? ?4 ++++
>> ?2 files changed, 10 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
>> index dd944bd..f5cfd42 100644
>> --- a/arch/arm/Kconfig
>> +++ b/arch/arm/Kconfig
>> @@ -1017,6 +1017,12 @@ config CPU_HAS_PMU
>> ? ? ? default y
>> ? ? ? bool
>>
>> +config ARM_SG_CHAIN
>> + ? ? bool "Enable SG chain support"
>> + ? ? default n
>> + ? ? help
>> + ? ? ? Enable support for SG chaining for ARM
>> +
>
> I thought that you simply add something like the following to
> arch/arm/include/asm/scatterlist.h?
>
> #ifdef CONFIG_ARCH_OMAP
> #define ARCH_HAS_SG_CHAIN
> #endif

That is exactly to one of my proposals, but I did not received any
comment. I heart from Russell it would be good to have a Kconfig
entry, that's why I am proposing ti patch now.

>
> Because you can't enable sg chaining on some arm architectures. Some
> arm SCSI drivers can't handle sg chaining but they are not available
> on omap, right? Why do you make this configurable on all arm archs
> like the above?

AFAIK omap does not have SCSI drivers. I think it could help other
platforms to test if they have some issues with SG chain, once there
is not issues in any platform it can be enable for all ARM.

Thanks,
Fernando.

>
>
>> ?if !MMU
>> ?source "arch/arm/Kconfig-nommu"
>> ?endif
>> diff --git a/arch/arm/include/asm/scatterlist.h b/arch/arm/include/asm/scatterlist.h
>> index 2f87870..eab7c4f 100644
>> --- a/arch/arm/include/asm/scatterlist.h
>> +++ b/arch/arm/include/asm/scatterlist.h
>> @@ -5,4 +5,8 @@
>> ?#include <asm/types.h>
>> ?#include <asm-generic/scatterlist.h>
>>
>> +#ifdef CONFIG_ARM_SG_CHAIN
>> +#define ARCH_HAS_SG_CHAIN
>> +#endif
>> +
>> ?#endif /* _ASMARM_SCATTERLIST_H */
>
