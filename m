From: cyndis@kapsi.fi (Mikko Perttunen)
Date: Thu, 19 Oct 2017 13:21:02 +0300
Subject: compile error in 4.14-rc5 with nvidia tegra enabled
In-Reply-To: <d006a085-d81f-4632-35c9-4e9d607a6504@nvidia.com>
References: <20171019084210.lql5kffhluvxvquu@lemon.iwr.uni-heidelberg.de>
 <d006a085-d81f-4632-35c9-4e9d607a6504@nvidia.com>
Message-ID: <c3afe94a-a2eb-05c3-9838-ff1a4871736d@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann raised this issue previously[1], but I assumed it would 
only happen on some obscure configuration, as clearly arm 
tegra_defconfig and multi_v7_defconfig and arm64 defconfig are building.

It would be interesting to know how this is being triggered here.

Of course the code is here is not very desirable - the root issue is 
that we want to allocate writecombine physical memory but there is no 
API to do that, so we rely on the DMA API "accidentally" doing the right 
thing.

Mikko

[1]: https://patchwork.kernel.org/patch/9688609/

On 19.10.2017 13:11, Jon Hunter wrote:
> Adding linux-tegra and Mikko ...
>
> On 19/10/17 09:42, Hermann Lauer wrote:
>> Hello,
>> compiling 4.14-rc{4,5} with a debian testing arm config yields the attached
>> error. Disabling the Nvidia tegra architecture (unneeded on
>> Banana{Pro,Pi,Ultra}) helps.
>>
>> Thanks,
>>  greetings
>>    Hermann
>>
>>   CC [M]  drivers/gpu/host1x/cdma.o
>> drivers/gpu/host1x/cdma.c: In function ?host1x_pushbuffer_init?:
>> drivers/gpu/host1x/cdma.c:94:48: error: passing argument 3 of ?dma_alloc_wc? from incompatible pointer type [-We
>> rror=incompatible-pointer-types]
>>    pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
>>                                                 ^
>> In file included from drivers/gpu/host1x/cdma.c:22:0:
>> ./include/linux/dma-mapping.h:780:21: note: expected ?dma_addr_t * {aka long long unsigned int *}? but argument
>> is of type ?phys_addr_t * {aka unsigned int *}?
>>  static inline void *dma_alloc_wc(struct device *dev, size_t size,
>>                      ^~~~~~~~~~~~
>> drivers/gpu/host1x/cdma.c:113:48: error: passing argument 3 of ?dma_alloc_wc? from incompatible pointer type [-W
>> error=incompatible-pointer-types]
>>    pb->mapped = dma_alloc_wc(host1x->dev, size, &pb->phys,
>>                                                 ^
>> In file included from drivers/gpu/host1x/cdma.c:22:0:
>> ./include/linux/dma-mapping.h:780:21: note: expected ?dma_addr_t * {aka long long unsigned int *}? but argument
>> is of type ?phys_addr_t * {aka unsigned int *}?
>>  static inline void *dma_alloc_wc(struct device *dev, size_t size,
>>                      ^~~~~~~~~~~~
>>   CC [M]  drivers/hid/hid-ntrig.o
>> cc1: some warnings being treated as errors
>
> Thanks for the report. I don't see this. What config and toolchain are
> you using?
>
> Mikko, have you seen this?
>
> Cheers
> Jon
>
