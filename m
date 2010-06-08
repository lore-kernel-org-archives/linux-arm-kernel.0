From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 15:55:29 +0800
Subject: [PATCH] pxa168 and pxa930 build fix - plat-pxa/pmu.c dependent on
	ARCH_PXA for IRQ_PMU
In-Reply-To: <AANLkTilXErDZHWf71e7pwUbt1i66MVrfP_lPisgoBZ0G@mail.gmail.com>
References: <1275932959-474-1-git-send-email-jic23@cam.ac.uk>
	<AANLkTilXErDZHWf71e7pwUbt1i66MVrfP_lPisgoBZ0G@mail.gmail.com>
Message-ID: <AANLkTinm5ZU1tLR8CYwU4K8FPbCdLTdAyrfXq54nYkl_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 8, 2010 at 2:57 PM, Wan ZongShun <mcuos.com@gmail.com> wrote:
> 2010/6/8 Jonathan Cameron <jic23@cam.ac.uk>:
>> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
>> ---
>> ?Found this build issue whilst browsing kautobuild logs.
>> ?There may well be a better fix but until someone with
>> ?a board in ARCH_MMP can test it, lets just not build
>> ?pmu.c. ?Can't find equivalent fix in Eric's tree so I
>> ?think this is still a live problem.
>>
>
> When building pxa168 platform, IRQ_PMU cannot be find and error occurs.
> Eric, before delete it from MMP, should not we check whether the
> performance counter function
> is necessary for MMP or not?
>
> If necessary , we should fix this issue by define IRQ_PMU to
> IRQ_PXA168_PMU, or we can delete it.
>

We have different ways to handle this:

1. register different platform devices with different IRQs for pxa[23]xx, pxa168
2. modify the IRQ at run-time to a correct one
3. move the platform device registration back into arch/arm/mach-pxa/<soc>.c
(or arch/arm/mach-pxa/common.c) and arch/arm/mach-mmp/<soc>.c

We need to figure out if there are some other differences between these
PMUs (or in the future), which will make solution 3) stand out.

>> ?arch/arm/plat-pxa/Makefile | ? ?3 ++-
>> ?1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/plat-pxa/Makefile b/arch/arm/plat-pxa/Makefile
>> index 6187edf..a17cc0c 100644
>> --- a/arch/arm/plat-pxa/Makefile
>> +++ b/arch/arm/plat-pxa/Makefile
>> @@ -2,8 +2,9 @@
>> ?# Makefile for code common across different PXA processor families
>> ?#
>>
>> -obj-y ?:= dma.o pmu.o
>> +obj-y ?:= dma.o
>>
>> +obj-$(CONFIG_ARCH_PXA) ? ? ? ? += pmu.o
>> ?obj-$(CONFIG_GENERIC_GPIO) ? ? += gpio.o
>> ?obj-$(CONFIG_PXA3xx) ? ? ? ? ? += mfp.o
>> ?obj-$(CONFIG_ARCH_MMP) ? ? ? ? += mfp.o
>> --
>> 1.6.4.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
>
>
> --
> *linux-arm-kernel mailing list
> mail addr:linux-arm-kernel at lists.infradead.org
> you can subscribe by:
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> * linux-arm-NUC900 mailing list
> mail addr:NUC900 at googlegroups.com
> main web: https://groups.google.com/group/NUC900
> you can subscribe it by sending me mail:
> mcuos.com at gmail.com
>
