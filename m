From: robh@kernel.org (Rob Herring)
Date: Tue, 8 Sep 2015 19:06:27 -0500
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <CACRpkdan0+rywnSR8Rs=aw63QAm3nN99ujqPcZwfpoh4_Dwc-w@mail.gmail.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdbJppuA6ZyciNAGfSgrf4M2THVHggzuZYSqORjy2JBp_A@mail.gmail.com>
 <CAK7LNATWsa8AhyFGzsR0HAODmQD8yBPidTE0Lx2ACh4_PeQW9w@mail.gmail.com>
 <CACRpkdan0+rywnSR8Rs=aw63QAm3nN99ujqPcZwfpoh4_Dwc-w@mail.gmail.com>
Message-ID: <55EF7803.2010004@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2015 08:09 AM, Linus Walleij wrote:
> On Fri, Aug 28, 2015 at 12:24 PM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> 2015-08-26 22:39 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> 
>>> cache-unified and cache-level are *not* optional and should be required.
>>
>> "cache-unified" is mentioned in "3.7.3 Internal (L1) Cache Properties"
>> (Table 3-8),
>> but it is not in "3.8 Multi-level and Shared Caches" (Table 3-9)
>>
>> Are the rules in Table 3-8 also applied for L2?
> 
> Your guess is as good as mine unless someone involved in
> actually writing that spec says something :/

Maybe you'd have to be crazy to have Harvard cache for 2nd+ level. I've
got no clue. Doesn't hurt to have it.

> 
>>> (I'm just assuming this cache is unified, anything else would be baffling.)
>>
>> In fact, unified/harvard is configurable thru a register of this cache
>> controller.
> 
> Jesus Christ.

Hardware designers either hate software folks or ensure our job security.

> 
>> It is usually used as a unified cached, though.
> 
> I would, too.
> 
>> So,I am planning to use the same compatible for L2 and L3, like this:
>>
>>
>>        l2-cache at 500c0000 {
>>                compatible = "socionext,uniphier-cache";
>>                reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
>>                      <0x506c0000 0x400>;
>>                cache-unified;
>>                cache-level = <2>;
>>                next-level-cache = <&L2>;

Next level of the L2 is the L2?

>>                cache-size = <0x200000>;
>>                cache-sets = <256>;
>>                cache-line-size = <128>;
>>             };
>>
>>        /* Not all of UniPhier SoCs have L3 cache */
>>        l3-cache at 500c8000 {
>>                compatible = "socionext,uniphier-cache";
>>                reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
>>                      <0x506c8000 0x400>;
>>                cache-unified;
>>                cache-level = <3>;
>>                cache-size = <0x400000>;
>>                cache-sets = <256>;
>>                cache-line-size = <256>;
>>        };
> 
> This LooksGoodToMe.
> 
>> The Table 3-9 in ePAPR v1.1 says
>> the compatible should be "cache", but I do not think it makes sense here.
> 
> Agree.

It could be useful for finding all cache nodes, but we've generally
failed to use it, so at this point it doesn't matter.

Rob
