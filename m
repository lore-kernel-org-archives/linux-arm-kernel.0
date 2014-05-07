From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 7 May 2014 09:35:20 +0530
Subject: [PATCH v2 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM
 bindings
In-Reply-To: <CAK9yfHz6PVT2C-TZkFHqtdj4rT-R8w+aU=jTTnLMF5k4JOXGxg@mail.gmail.com>
References: <1399363824-23543-1-git-send-email-sachin.kamat@linaro.org>
 <53691187.80101@gmail.com>
 <CAK9yfHz6PVT2C-TZkFHqtdj4rT-R8w+aU=jTTnLMF5k4JOXGxg@mail.gmail.com>
Message-ID: <CAK9yfHwXC1rc71-GiP3JxF2hpQGkA-GVv-1=MT9+GsA+Vq3o4w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On 6 May 2014 23:39, Sachin Kamat <sachin.kamat@linaro.org> wrote:
> Hi Tomasz,
>
> On 6 May 2014 22:14, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>> Hi Sachin,
>>
>> Thanks for addressing the comments. I need to verify few things on Universal
>> C210 board first, before I could give my Reviewed-by tag or further
>> comments.
>>
>> I also have some general comments that I missed before, due to limited time
>> for review. Please see inline.
>
> Thanks for your review.
>
>>
>>
>> On 06.05.2014 10:10, Sachin Kamat wrote:
>>>
>>> Instead of hardcoding the SYSRAM details for each SoC,
>>> pass this information through device tree (DT) and make
>>> the code SoC agnostic. Generic SRAM bindings are used
>>> for achieving this.
>>>
>>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>> Acked-by: Heiko Stuebner <heiko@sntech.de>
>>> ---
[snip]

>>>
>>>   static int exynos_set_cpu_boot_addr(int cpu, unsigned long boot_addr)
>>>   {
>>> -       void __iomem *boot_reg = S5P_VA_SYSRAM_NS + 0x1c + 4*cpu;
>>> +       void __iomem *boot_reg;
>>> +
>>> +       if (!sram_ns_base_addr)
>>> +               return 0;
>>
>>
>> Shouldn't this return an error instead? I'm not sure which one would be
>> appropriate, though, probably one of -ENODEV, -ENXIO or -EFAULT.
>
> IIRC, returning error here causes the system to hang and even primary
> cpu does not boot.
> Since any error or absence of sram nodes should atleast boot the
> primary CPU, I thought
> this is better.

Small correction. The above explanation was for the absence of the check.
Sorry about the confusion. Will add -ENODEV here.

-- 
With warm regards,
Sachin
