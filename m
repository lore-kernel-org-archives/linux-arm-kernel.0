From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 28 Aug 2015 19:24:47 +0900
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <CACRpkdbJppuA6ZyciNAGfSgrf4M2THVHggzuZYSqORjy2JBp_A@mail.gmail.com>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
 <CACRpkdbJppuA6ZyciNAGfSgrf4M2THVHggzuZYSqORjy2JBp_A@mail.gmail.com>
Message-ID: <CAK7LNATWsa8AhyFGzsR0HAODmQD8yBPidTE0Lx2ACh4_PeQW9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


2015-08-26 22:39 GMT+09:00 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, Aug 24, 2015 at 4:18 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>> This commit adds support for UniPhier outer cache controller.
>> All the UniPhier SoCs are equipped with the L2 cache, while the L3
>> cache is currently only integrated on PH1-Pro5 SoC.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>
> Wow it is really a custom L2$ controller. Wow. Just wow. That's
> really brave, given all the problems we've seen in l2x0.

Looks like my company is crazy...
ARM Ltd. people said we are the only vendor that still uses
a custom outer cache.



>> +UniPhier SoCs are integrated with a level 2 cache controller that resides
>> +outside of the ARM cores, some of them also have a level 3 cache controller.
>> +
>> +Required properties:
>> +- compatible: should be one of the followings:
>> +       "socionext,uniphier-l2-cache"   (L2 cache)
>> +       "socionext,uniphier-l3-cache"   (L3 cache)
>
> Refer to and use the 3.7.3 ePAPR v1.1 specification too:
> https://www.power.org/wp-content/uploads/2012/06/Power_ePAPR_APPROVED_v1.1.pdf


I've checked it out.
Thanks, but I had some doubts.



> cache-unified and cache-level are *not* optional and should be required.


"cache-unified" is mentioned in "3.7.3 Internal (L1) Cache Properties"
(Table 3-8),
but it is not in "3.8 Multi-level and Shared Caches" (Table 3-9)

Are the rules in Table 3-8 also applied for L2?


> So:
>
>> +The L2 cache must exist to use the L3 cache; adding only an L3 cache device
>> +node to the device tree causes the initialization failure of the whole outer
>> +cache system.
>> +
>> +Example:
>> +       l2-cache at 500c0000 {
>> +               compatible = "socionext,uniphier-l2-cache";
>> +               reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
>> +                     <0x506c0000 0x400>;
>
> cache-unified;
> cache-level = <2>;
>
>> +       /* Not all of UniPhier SoCs have L3 cache */
>> +       l3-cache at 500c8000 {
>> +               compatible = "socionext,uniphier-l3-cache";
>> +               reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
>> +                     <0x506c8000 0x400>;
>
> cache-unified;
> cache-level = <3>;
>
> (I'm just assuming this cache is unified, anything else would be baffling.)

In fact, unified/harvard is configurable thru a register of this cache
controller.
It is usually used as a unified cached, though.



> Further the ePAPR spec optionally supports specifying things like the
> cache size, number of sets, block size and line size, unless this can
> be hard coded.
>
> Yours,
> Linus Walleij
>


Given that cache-level specifies the level and next-level-cache
specifies the topology,
I think "socionext,uniphier-l*-cache" gives redundant information.

The L2 and L3 cache controller look the same; they have the same register maps.

The differences between them are register-base, cache-size,
cache-sets, line-size,
which are specified by properties.

So,I am planning to use the same compatible for L2 and L3, like this:


       l2-cache at 500c0000 {
               compatible = "socionext,uniphier-cache";
               reg = <0x500c0000 0x2000>, <0x503c0100 0x8>,
                     <0x506c0000 0x400>;
               cache-unified;
               cache-level = <2>;
               next-level-cache = <&L2>;
               cache-size = <0x200000>;
               cache-sets = <256>;
               cache-line-size = <128>;
            };

       /* Not all of UniPhier SoCs have L3 cache */
       l3-cache at 500c8000 {
               compatible = "socionext,uniphier-cache";
               reg = <0x500c8000 0x2000>, <0x503c8100 0x8>,
                     <0x506c8000 0x400>;
               cache-unified;
               cache-level = <3>;
               cache-size = <0x400000>;
               cache-sets = <256>;
               cache-line-size = <256>;
       };



The Table 3-9 in ePAPR v1.1 says
the compatible should be "cache", but I do not think it makes sense here.




-- 
Best Regards
Masahiro Yamada
