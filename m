From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 03 Dec 2013 10:31:15 +0800
Subject: Build warning in drivers/dma/mmp_tdma.c
In-Reply-To: <CAMj5Bkjkndq1-AJSm0k9Mm8xeaWEGktoFb6nZ3kr7RackFdcaw@mail.gmail.com>
References: <CAPcyv4i1i+3ia5qcYA-LR4TFq1MOCXTHLhW2u5maq6Us9kyATg@mail.gmail.com>	<CAMj5Bkjk6v_2Op1oph8GGw2mf8w40c-L3JhBRPNsRewiFxQHpw@mail.gmail.com>	<529C37F3.1040205@marvell.com>	<CAPcyv4jfk+JBv7WY_njuYtx8hERZHhoCAij=FOfqxAhLJAHnFA@mail.gmail.com>
 <CAMj5Bkjkndq1-AJSm0k9Mm8xeaWEGktoFb6nZ3kr7RackFdcaw@mail.gmail.com>
Message-ID: <529D4273.10602@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 10:13 AM, Zhangfei Gao wrote:
> On Tue, Dec 3, 2013 at 4:05 AM, Dan Williams <dan.j.williams@intel.com> wrote:
>> On Sun, Dec 1, 2013 at 11:34 PM, Qiao Zhou <zhouqiao@marvell.com> wrote:
>
>>>>> commit 1a4ee91dacedde3e82d8ce6eeace7f16884474f9
>>>>> Author: Dan Williams <dan.j.williams@intel.com>
>>>>> Date:   Thu Nov 28 12:27:38 2013 -0800
>>>>>
>>>>>       dma: mmp_dma depends on CPU_MMP2
>>>>>
>>>>>       It calls sram_get_gpool() which is only defined if CONFIG_CPU_MMP2=y
>>>>>
>>>>>       Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>>>
>>>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>>>> index 446687cc2334..dad83634cb65 100644
>>>>> --- a/drivers/dma/Kconfig
>>>>> +++ b/drivers/dma/Kconfig
>>>>> @@ -287,7 +287,7 @@ config DMA_SA11X0
>>>>>
>>>>>    config MMP_TDMA
>>>>>           bool "MMP Two-Channel DMA support"
>>>>> -       depends on ARCH_MMP
>>>>> +       depends on ARCH_MMP && CPU_MMP2
>>>>
>>>>
>>>> Hi, Qiao
>>>>
>>>> Do you have comments?
>>>> Does this work on PXA910?
>>>
>>> MMP_TDMA should not depend on CPU_MMP2. PXA910, and other chip set also use
>>> mmp_tdma.
>>
>> It does depend on CPU_MMP2, as I can generate the following build
>> failure with the attached config.
>>
>> drivers/built-in.o: In function `mmp_tdma_free_descriptor':
>> drivers/dma/mmp_tdma.c:329: undefined reference to `sram_get_gpool'
>> drivers/built-in.o: In function `mmp_tdma_alloc_descriptor':
>> drivers/dma/mmp_tdma.c:379: undefined reference to `sram_get_gpool'
>>
>
> How about modifying arch/arm/mach-mmp/Makefile
> Like:
> -obj-y                          += common.o devices.o time.o
> +obj-y                          += common.o devices.o time.o sram.o
> -obj-$(CONFIG_CPU_MMP2)         += mmp2.o sram.o
> +obj-$(CONFIG_CPU_MMP2)         += mmp2.o
>
> As Qiao mentioned sram is used both on mmp2 and pxa910.
>
> Thanks
>

I prefer to add CONFIG_MMP_SRAM instead, since sram isn't available in 
pxa168.

Regards
Haojian
