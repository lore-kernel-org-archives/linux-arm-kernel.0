From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Jul 2017 10:17:13 +0200
Subject: [PATCH 03/12] ARM: normalize clk API for older platforms
In-Reply-To: <b26930f6-3c57-7931-7f74-d0e07adb9cd7@ti.com>
References: <20170720154616.3250481-1-arnd@arndb.de>
 <20170720155132.3250812-1-arnd@arndb.de>
 <b26930f6-3c57-7931-7f74-d0e07adb9cd7@ti.com>
Message-ID: <CAK8P3a3C7xVmr6ZuJekhq8bdwqmoPeAkAqxJ+BUi9VrxkQpQZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 21, 2017 at 10:05 AM, Sekhar Nori <nsekhar@ti.com> wrote:

>> diff --git a/arch/arm/mach-davinci/clock.c b/arch/arm/mach-davinci/clock.c
>> index f5dce9b4e617..89586779526c 100644
>> --- a/arch/arm/mach-davinci/clock.c
>> +++ b/arch/arm/mach-davinci/clock.c
>> @@ -218,6 +218,12 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
>>  }
>>  EXPORT_SYMBOL(clk_set_parent);
>>
>> +struct clk *clk_get_parent(struct clk *clk)
>> +{
>> +     return clk->parent;
>> +}
>> +EXPORT_SYMBOL(clk_get_parent);
>
> For mach-davinci change:
>
> Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks!

>> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
>> index 39ef3b613912..c1c91fc6e178 100644
>> --- a/arch/arm/mach-ep93xx/clock.c
>> +++ b/arch/arm/mach-ep93xx/clock.c
>> @@ -323,6 +323,27 @@ unsigned long clk_get_rate(struct clk *clk)
>>  }
>>  EXPORT_SYMBOL(clk_get_rate);
>>
>> +long clk_round_rate(struct clk *clk, unsigned long rate)
>> +{
>> +     WARN_ON(clk);
>> +     return 0;
>> +}
>> +EXPORT_SYMBOL(clk_round_rate);
>
> Its probably better to WARN_ON_ONCE(). Also, since NULL clk is valid, it
> should be probably be WARN_ON_ONCE(1).

I thought about trying to make it as correct as possible, but then went for
the opposite approach and instead just made the functions as small as
possible to avoid bloat while having the warning in there along with an
obviously wrong implementation. Apparently the davinci version unlike
the others ended up being a correct one after all (let me know if you
want to have a NULL pointer check there).

I also remembered now that the mmp implementation is actually dead
code (we always use the COMMON_CLK implementation for mmp
these days). I think I'll just drop the mmp patch, and split out davinci,
w90x900 and sa1100 into separate patches now, as there are only
three of them left.

      Arnd
