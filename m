From: florian@openwrt.org (Florian Fainelli)
Date: Mon, 08 Sep 2014 13:33:39 -0700
Subject: [PATCH 5/7 v6] ARM: l2c: parse 'cache-size' and 'cache-sets'
 properties
In-Reply-To: <3479071.8nx1ubr8a9@wuerfel>
References: <1410176286-32533-1-git-send-email-linus.walleij@linaro.org>
 <4685530.jbNLD4yaA8@wuerfel>
 <CACRpkdb_bS0P-fGxogiyCzG9CRPhJK1Gro=H3X1Ks_-UoXh52w@mail.gmail.com>
 <3479071.8nx1ubr8a9@wuerfel>
Message-ID: <540E12A3.2080705@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2014 06:16 AM, Arnd Bergmann wrote:
> On Monday 08 September 2014 14:36:48 Linus Walleij wrote:
>> On Mon, Sep 8, 2014 at 2:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Monday 08 September 2014 13:38:04 Linus Walleij wrote:
>>>> +       of_property_read_u32(np, "cache-size", &size);
>>>> +       of_property_read_u32(np, "cache-sets", &sets);
>>>> +
>>>> +       if (!size || !sets)
>>>> +               return;
>>>> +
>>>> +       way_size = size / sets;
>>>
>>> Going back to this one: Isn't (size / sets) the set-size rather
>>> than the way-size?
>>>
>>> After we discussed this on IRC, I had expected a calculation like
>>>
>>>         set_size = size / sets;
>>>         ways = set_size / line_size;
>>>         way_size = size / ways;
>>
>> First: in this PB1176 case:
>>
>> set_size = 128K/8 = 16K
>> ways = 16K/32 = 512 bytes
>> way_size = 128K/512 = 128 bytes
> 
> I guess we should first try to find the right units so we know what
> we are talking about. I was under the impression that the set size
> is the number of bytes in a set, while 'ways' is counting the
> associativity and has no unit.

I agree with that.

> 
> The last line also seems to incorrectly computed. Dividing 128KB
> by 512 bytes should be 256 (no unit).
> 
>> Well maybe it's the ARM reference manual internal lingo that
>> is actually causing the confusion here. It will say something
>> like:
>>
>> [19:17] Way-size 3?b000 = Reserved, internally mapped to 16KB
>> 3?b001 = 16KB, this is the default value
>> 3?b010 = 32KB
>> 3?b011 = 64KB
>> 3?b100 = 128KB
>> 3?b101 = 256KB
>> 3?b110 to 3?b111 = Reserved, internally mapped to 256 KB
>>
>> OK way-size ... is in the 16 thru 256KB range, which fits nicely
>> with set size incidentally. And also corresponds to current
>> comments in the code such as this from
>> arch/arm/mach-realview/realview_pb1176.c:
>>
>> #ifdef CONFIG_CACHE_L2X0
>>         /*
>>          * The PL220 needs to be manually configured as the hardware
>>          * doesn't report the correct sizes.
>>          * 128kB (16kB/way), 8-way associativity, event monitor and
>>          * parity enabled, ignore share bit, no force write allocate
>>          * Bits:  .... ...0 0111 0011 0000 .... .... ....
>>          */
>>         l2x0_init(__io_address(REALVIEW_PB1176_L220_BASE), 0x00730000,
>> 0xfe000fff);
>> #endif
> 
> 16KB way-size seems realistic, yes.
> 
>> I can add a comment explaining that ARMs terminology does
>> not match the academic terminology or something, and say that
>> the thing we poke into "way-size" is actually "set size", if we agree
>> that is what we're seeing here.
> 
> Let's see again: 16KB way-size * 8 ways = 128KB, that seems correct.
> 16KB way-size / 32B line-size = 512 sets, that also seems realistic.
> 128KB cache-size / 512 sets = 256B set-size. 256B / 32B = 8 ways,
> so everything fits together.
> 
> Now in the code:
> 
> +      of_property_read_u32(np, "cache-size", &size);
> 
> 131072
> 
> +       of_property_read_u32(np, "cache-sets", &sets);
> 
> 512
> 
> +
> +       if (!size || !sets)
> +               return;
> +
> +       way_size = size / sets;
> 
> 256 -> impossible.
> 
> 
>          set_size = size / sets;
> 
> 256
> 
>          ways = set_size / line_size;
> 
> 8
> 
>          way_size = size / ways;
> 
> 16KB -> ok

So what we are missing right now is just a 'cache-line-size' property to
get the maths right.
--
Florian
