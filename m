From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Tue, 21 Feb 2017 17:32:58 +0200
Subject: [PATCH -next v2] pinctrl: samsung: Fix return value check in
 samsung_pinctrl_get_soc_data()
In-Reply-To: <c4dd122b-0312-fcca-08e2-4d4586949a88@samsung.com>
References: <20170125140321.23911-1-weiyj.lk@gmail.com>
 <20170205155849.4362-1-weiyj.lk@gmail.com>
 <CGME20170213145008epcas3p119bdd6f76468a00fb8d796308ad37698@epcas3p1.samsung.com>
 <CACRpkda0BYLNpPFwpNaEMdeyx61KDUQz_6Y=FQj340pViFjVVQ@mail.gmail.com>
 <c4dd122b-0312-fcca-08e2-4d4586949a88@samsung.com>
Message-ID: <CAJKOXPf=890hCFPRZLd1C0sQq9B3bEvvmRkm07ngknAnOYAW4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 3:49 PM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Hi All,
>
> On 2017-02-13 15:49, Linus Walleij wrote:
>>
>> On Sun, Feb 5, 2017 at 4:58 PM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
>>
>>> From: Wei Yongjun <weiyongjun1@huawei.com>
>>>
>>> In case of error, the function devm_ioremap() returns NULL pointer not
>>> ERR_PTR(). Fix by using devm_ioremap_resource instead of devm_ioremap.
>>>
>>> Fixes: 8b1bd11c1f8f ("pinctrl: samsung: Add the support the multiple
>>> IORESOURCE_MEM for one pin-bank")
>>> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>>> ---
>>> v1 -> v2: use devm_ioremap_resource instead of devm_ioremap
>>
>> Patch applied with Krzysztof's ACK.
>
>
> Sadly this patch breaks support for IMEM pinctrl block on Exynos5433/TM2
> and it took us some time to find the source of the problem.
>
> devm_ioremap_resource() is not functionally a full equivalent of
> devm_ioremap(). The problem here is that registers for IMEM and ALIVE
> pin controllers are shared and both devices have <0x11090000 0x1000>
> range in their reg property. devm_ioremap_resource() maps given
> resource exclusively for the device, while devm_ioremap() allows
> non-exclusive mappings.
>
> This patch has to be reverted asap.

Damn, the additional request_mem_region() raised my concerns but I
didn't compare it with actual DTS layout... Which brings us to two
important lessons:
1. Do not accept untested code.
2. Do not fix two things at the same time.

I vote for the revert as well + original version of patch (these two
could be squashed) + a need of Tested-by. Otherwise an untested fix
might not be a fix at all.

Best regards,
Krzysztof
