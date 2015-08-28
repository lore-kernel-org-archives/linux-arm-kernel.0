From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 28 Aug 2015 17:59:54 +0900
Subject: [PATCH 1/3] ARM: uniphier: add outer cache support
In-Reply-To: <4027826.UsiXogeDbt@wuerfel>
References: <1440382692-3855-1-git-send-email-yamada.masahiro@socionext.com>
 <2021253.vgeYqalDfp@wuerfel>
 <CAK7LNAQ_oymnQNEcP+FDqyxNKtMyiCwgxSRMmg5HAKQW9C6eRg@mail.gmail.com>
 <4027826.UsiXogeDbt@wuerfel>
Message-ID: <CAK7LNATq3XQc=frE09g_DC_cq4fr79FcmrwFd9CXPeCds4GtcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Russell,


2015-08-26 21:52 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday 26 August 2015 10:38:59 Masahiro Yamada wrote:
>>
>> 2015-08-25 4:59 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Monday 24 August 2015 11:18:10 Masahiro Yamada wrote:
>
>> Nothing.
>>
>> This outer cache is not a variant of l2x0/pl310.
>> It was designed only for our SoCs from scratch.
>
> Ok, I see.
>
>> > Would it make sense to at least share the
>> > common entry point at l2x0_of_init() so you don't need to call it from
>> > the platform file?
>>
>> I do not think so.
>>
>>
>> l2x0_of_init() checks L2X0_AUX_CTRL register,
>> but the cache-uniphier does not have such register,
>> so the boot code crashes.
>>
>>
>>
>> BTW, what makes l2x0_of_init() so special?
>>
>> Only L2x0/L310 and variants can be initialized
>> directly from init_IRQ().
>
> The only thing that is special about it is that almost everyone
> uses it because it is often licensed together with the Cortex-A
> cores from ARM. There are a few variants that are closely related
> (tauros3 and aurora, both from Marvell. All other outer_cache
> implementations (feroceon, xscale, tauros2) are for older
> Marvell (or Intel) cores that have since been replaced with
> Cortex-A cores in newer products.
>
>> Moreover, outer-cache init seems to be unrelated to
>> IRQ init.
>
> Agreed, this is also just a historic artifact, as we don't really
> have a place to put cache controller initialization, and the
> irq init callback was already there at the time when people
> added code to init their outer caches. It often does not matter
> much where you call it, but doing it early speeds up the boot
> time.
>
> It would be nice to unify the cache initialization a bit further,
> apparently only a few older platforms still call the l2x0 init
> manually and we can probably all convert them to the implicit
> configuration in one way or another.
>
> As we now have three kinds of cache controllers (l2x0, tauros2
> and uniphier) that we need to support using DT, it would be nice
> for generalize that init sequence a bit more.
>
> A first step would be to add the tauros2 and uniphier outer cache
> init to the init_IRQ() function, and then have another patch
> that moves all the outercache initialization into a new place
> like arch/arm/mm/outercache.c so we don't clutter up irq.c
> with unrelated stuff.
>
> Russell probably also has some ideas on this topic, in doubt
> just do what he suggests.

In my v1 patch, the outer cache init is called from .init_machine
as some other SoCs do, but if moving my cache_init to init_IRQ() is acceptable,
that would be better for faster boot.

I will follow Arnd's suggestion in v2 unless Russell is opposed to it.

Thanks!



-- 
Best Regards
Masahiro Yamada
