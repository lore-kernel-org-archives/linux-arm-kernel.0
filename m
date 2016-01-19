From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 19 Jan 2016 17:25:28 +0900
Subject: [Question] cacheline sharing problem on DMA for custom outer-cache
In-Reply-To: <20160118123226.GF19062@n2100.arm.linux.org.uk>
References: <CAK7LNASC2kkgQvxetrRA=guvKTAnxGm3xeMbtV0hXgubR0tEwQ@mail.gmail.com>
 <134552368.ft0oU8iHdY@wuerfel>
 <CAK7LNAQBJbjx4koGjkKHo1Xe9NKC-dCj_0TP6AiT=3eaPTYdoQ@mail.gmail.com>
 <20160118123226.GF19062@n2100.arm.linux.org.uk>
Message-ID: <CAK7LNATAgV5OQf3ZQrH-jsqTJ5P-iFA1RJ+4bOr5-myBYs1few@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,


2016-01-18 21:32 GMT+09:00 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Mon, Jan 18, 2016 at 09:05:15PM +0900, Masahiro Yamada wrote:
>> L1_CACHE_BYTES is not a configuration.  It is a hardware property.
>>
>> Actually, Tegra is the only hardware that has L1 cache with 64byte line-size.
>
> We have a load of paltforms which select ARM_L1_CACHE_SHIFT_6, plus
> Cortex-A8 and Cortex-A15 both have 64-byte L1 line size.
>
> It's all in the git history, please research.
>
> $ git log -p -- arch/arm/Kconfig arch/arm/mm/Kconfig
>
> and search for "ARM_L1_CACHE_SHIFT_6".

Ah, I missed that.
Thanks for clarifying this.



>> The other SoCs in multi_v7_defconfig run software configured for
>> 64byte line-size on CPUs with 32byte line-size.  Weird.
>
> Nothing weird here.  A kernel configured for a 64 byte cache line size
> can be run on a system with a 32 byte cache line size, but not vice
> versa.
>
>> And, deciding the DMA aligment only with L1 line-size does not seem nice.
>> I admit the outer-cache on my SoC is odd, though.
>
> Currently, the L1 defines the biggest restriction on DMA cache line
> alignment that we have.  However, you should be wary of changing
> only the DMA cache alignment - I think you'll find a lot of things
> assume that aligning to L1_CACHE_BYTES will be DMA safe.
>
>> If we could parse "line-size" DT-property in the early stage
>> and change the DMA alignment run-time, it would avoid degrading
>> performance on other SoCs.
>
> You can't realign data structures in the kernel image at runtime.
>
> L1_CACHE_BYTES is used as a constant in several places for this
> purpose.

OK, I understand that it is difficult to change the definition of this macro.



If I submitted something like follows, would it be accepted?


 config ARM_L1_CACHE_SHIFT
         int
+        default 7 if CACHE_UNIPHIER
         default 6 if ARM_L1_CACHE_SHIFT_6
         default 5




-- 
Best Regards
Masahiro Yamada
