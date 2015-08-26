From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 26 Aug 2015 10:38:59 +0900
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <2021253.vgeYqalDfp@wuerfel>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <1440382692-3855-2-git-send-email-yamada.masahiro@socionext.com>
 <2021253.vgeYqalDfp@wuerfel>
Message-ID: <CAK7LNAQ_oymnQNEcP+FDqyxNKtMyiCwgxSRMmg5HAKQW9C6eRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


2015-08-25 4:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Monday 24 August 2015 11:18:10 Masahiro Yamada wrote:
>> diff --git a/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt b/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
>> new file mode 100644
>> index 0000000..6428289
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/uniphier/cache-uniphier.txt
>> @@ -0,0 +1,30 @@
>> +UniPhier outer cache controller
>> +
>> +UniPhier SoCs are integrated with a level 2 cache controller that resides
>> +outside of the ARM cores, some of them also have a level 3 cache controller.
>> +
>> +Required properties:
>> +- compatible: should be one of the followings:
>> +       "socionext,uniphier-l2-cache"   (L2 cache)
>> +       "socionext,uniphier-l3-cache"   (L3 cache)
>> +- reg: offsets and lengths of the register sets for the device.  It should
>> +  contain 3 regions: control registers, revision registers, operation
>> +  registers, in this order.
>> +
>> +The L2 cache must exist to use the L3 cache; adding only an L3 cache device
>> +node to the device tree causes the initialization failure of the whole outer
>> +cache system.
>>
>
> How much does this outer cache have in common with the l2x0/pl310 cache
> controller model?

Nothing.

This outer cache is not a variant of l2x0/pl310.
It was designed only for our SoCs from scratch.


> Would it make sense to at least share the
> common entry point at l2x0_of_init() so you don't need to call it from
> the platform file?

I do not think so.


l2x0_of_init() checks L2X0_AUX_CTRL register,
but the cache-uniphier does not have such register,
so the boot code crashes.



BTW, what makes l2x0_of_init() so special?

Only L2x0/L310 and variants can be initialized
directly from init_IRQ().

Moreover, outer-cache init seems to be unrelated to
IRQ init.


-- 
Best Regards
Masahiro Yamada
