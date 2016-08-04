From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 09:17:04 +0200
Subject: [PATCH 0/8] ARM: clean up PC-relative arithmetic
In-Reply-To: <20160803181739.GL1041@n2100.armlinux.org.uk>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160803181739.GL1041@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu-+ib-XuQfg8ZL4D7nSk5YRSYaCQyf+UdZPmg+5CxPmJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 August 2016 at 20:17, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Wed, Aug 03, 2016 at 05:38:42PM +0200, Ard Biesheuvel wrote:
>> There are various places in the ARM kernel where the following pattern
>> is used to create a PC-relative reference that is valid even before the
>> MMU is on:
>>
>>      adr    rX, 1f
>>      ldr    rY, [rX]
>>      add    rX, rX, rY
>>      ...
>>   1: .long  <symbol> - .
>>
>> or
>>      adr    rX, 1f
>>      ldmia  rX, {rY .. rY+n}
>>      sub    rX, rX, rY
>>      add    rY+1, rY+1, rX
>>      add    rY+2, rY+2, rX
>>      ...
>>   1: .long  .
>>      .long  <symbolY>
>>      .long  <symbolY+1>
>>      ...
>>
>> Both cases can be greatly simplified by letting the linker do the
>> calculations for us. This series implements adr_l, ldr_l and str_l
>> macros, and uses them to simplify a couple of instances of the above
>> patterns.
>
> I don't buy that argument, sorry, and the argument is actually wrong.
> No, we're _not_ letting the linker do the calculations for us, we're
> letting the linker do _some_ of the calculation, but not all.
>
> What you're replacing the above with is stuff like (I guess, because
> I've no idea what this :pc_g0: notation is):
>
>         add     rX, pc, #(sym - . - 8) & 0xff
>         add     rX, rX, #(sym - . - 4) & 0xff00
>         add     rX, rX, #(sym - .) & 0xff0000
>
> which I think is a more complex (and less obvious) way to calculate it.
> It's also buggy when we end up with a relative offset greater than 16MB,
> which we have in multi-zImage kernels.
>

Even if you think this is a more complex way to calculate it, at least
it is encapsulated in a single macro instead of having similar but not
identical open coded instances all over the place.

As for the range: the ldr/str variants have 28 bits of range (2x
scaled 8 bit immediate for the adds and a single unscaled 12 bit
immediate for the ldr/str). The adr variant has 26 bits (3x scaled
immediate counting from bit 2) range for word aligned symbols, which
gives us +/- 64 MB, which should be plenty. The only pathological
outlier is allyesconfig, but that uses Thumb2 anyway.

The relocations documented here
http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044f/IHI0044F_aaelf.pdf

> So no, I don't like this at all
>

Noted
