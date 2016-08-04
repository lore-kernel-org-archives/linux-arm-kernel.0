From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Aug 2016 12:11:23 +0200
Subject: [PATCH 0/8] ARM: clean up PC-relative arithmetic
In-Reply-To: <20160804100329.GO1041@n2100.armlinux.org.uk>
References: <1470238730-30038-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160803181739.GL1041@n2100.armlinux.org.uk>
 <CAKv+Gu-+ib-XuQfg8ZL4D7nSk5YRSYaCQyf+UdZPmg+5CxPmJw@mail.gmail.com>
 <20160804094940.GM1041@n2100.armlinux.org.uk>
 <CAKv+Gu_6WhyStkOygiM2OLA6wgZsH2KEaV2L4-yPrRUfBGewtA@mail.gmail.com>
 <20160804100329.GO1041@n2100.armlinux.org.uk>
Message-ID: <CAKv+Gu9fQa9hHgHmjzyzAtapfGoidFfd3RVyeH6M1pFscZWNbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 August 2016 at 12:03, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Thu, Aug 04, 2016 at 11:54:25AM +0200, Ard Biesheuvel wrote:
>> On 4 August 2016 at 11:49, Russell King - ARM Linux
>> <linux@armlinux.org.uk> wrote:
>> > On Thu, Aug 04, 2016 at 09:17:04AM +0200, Ard Biesheuvel wrote:
>> >> On 3 August 2016 at 20:17, Russell King - ARM Linux
>> >> <linux@armlinux.org.uk> wrote:
>> >> > I don't buy that argument, sorry, and the argument is actually wrong.
>> >> > No, we're _not_ letting the linker do the calculations for us, we're
>> >> > letting the linker do _some_ of the calculation, but not all.
>> >> >
>> >> > What you're replacing the above with is stuff like (I guess, because
>> >> > I've no idea what this :pc_g0: notation is):
>> >> >
>> >> >         add     rX, pc, #(sym - . - 8) & 0xff
>> >> >         add     rX, rX, #(sym - . - 4) & 0xff00
>> >> >         add     rX, rX, #(sym - .) & 0xff0000
>> >> >
>> >> > which I think is a more complex (and less obvious) way to calculate it.
>> >> > It's also buggy when we end up with a relative offset greater than 16MB,
>> >> > which we have in multi-zImage kernels.
>> >> >
>> >>
>> >> Even if you think this is a more complex way to calculate it, at least
>> >> it is encapsulated in a single macro instead of having similar but not
>> >> identical open coded instances all over the place.
>> >
>> > ... and, it may come as a shocker, but I don't have a problem with
>> > that.
>> >
>> >> As for the range: the ldr/str variants have 28 bits of range (2x
>> >> scaled 8 bit immediate for the adds and a single unscaled 12 bit
>> >> immediate for the ldr/str). The adr variant has 26 bits (3x scaled
>> >> immediate counting from bit 2) range for word aligned symbols, which
>> >> gives us +/- 64 MB, which should be plenty. The only pathological
>> >> outlier is allyesconfig, but that uses Thumb2 anyway.
>> >
>> > Our existing code allows for a range of the full address space - the only
>> > thing it relies upon is that the literal data is placed within reach of
>> > the code - which it will be, because it's always placed near the code
>> > which is using it.
>> >
>> >> The relocations documented here
>> >> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0044f/IHI0044F_aaelf.pdf
>> >
>> > Right, so it's an EABI thing, and I guess you haven't tested OABI
>> > builds, where I suspect these relocations aren't supported.
>> >
>>
>> I suppose that's a fair point. But then, I'm only 40 so I am too young
>> to remember this OABI stuff anyway. Does it require GCC 2.95 from your
>> toolchain museum?
>
> I'm sorry, but that's really no excuse, we're of similar ages, so...
> <expletive deleted>.

Just countering the unnecessary sarcasm ... :-)

>  And GCC 4 is capable of building OABI.
>
> OABI is going to have to live for a long time yet, I still rely on
> OABI - and this is something that most people ignored when I raised
> it in the EABI discussions - when I said that there needed to be a
> sane transition path between OABI and EABI which didn't involve
> "shut the machine down, totally replace the rootfs".  I'm not at
> liberty to shut my machines down while I rebuild everything that's
> on them as EABI.
>
> So, OABI support will live on for as long as I'm involved in Linux
> and have a need for it.  _All_ my pre-ARMv6 machines (which run
> everything I rely upon) are OABI.
>

But seriously, it appears that the group relocations are simply too
problematic to support at the moment, and I don't see a way to fix
that.
