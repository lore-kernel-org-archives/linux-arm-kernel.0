From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 9 Apr 2013 13:58:45 +0200
Subject: [RFC PATCH arm: initial TI-Nspire support]
In-Reply-To: <EE94A8F2-2BC2-446E-B0B2-1E1803E240F2@gmail.com>
References: <6FE4B33E-A503-4A75-AEED-831CB2C06D83@gmail.com>
 <CACRpkdbuAvRzVdzKL51k5d7vVpGNUHh_f_ZAxP4m3zFdBOV=xw@mail.gmail.com>
 <EE94A8F2-2BC2-446E-B0B2-1E1803E240F2@gmail.com>
Message-ID: <CACRpkdaFS=ZM6dTtD3ziBTfVJzwOU2x8gfyYutogkYL8LEo8qQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 9, 2013 at 1:39 PM, Daniel Tang <dt.tangr@gmail.com> wrote:

>>> +union reg_clk_speed {
>>> +       unsigned long raw;
>>> +       struct {
>>> +               unsigned long __padding0:1;
>>> +               unsigned long base_cpu_ratio:7;
>>> +               unsigned long is_base_27mhz:1;
>>> +               unsigned long __padding1:3;
>>> +               unsigned long cpu_ahb_ratio:3;
>>> +               unsigned long __padding2:1;
>>> +               unsigned long base_val:5;
>>> +       } val;
>>> +};
>>
>> Usually to try to fit a struct over a register range is not such a good
>> idea in Linux.
>>
>> Instead define abstract representations of what you want to do
>> (remove everything named "padding" above, use proper data types instead
>> of these unsigned longs and that complex union) then use offsets to
>> registers and remap the base offset in memory.
>>
>> It makes for simpler debugging and ability to properly use read|write[lwb]
>> macros.
>
> The structure is actually a bitfield. We'd readl() the raw unsigned long into the 'raw' field and then access the data via the 'val' structure.
>
> Should we be using bitmasks and bitshifting to get at those values instead?

I personally think that is better because it avoids complex structures
and strange helper functions.

When it really shows it's ugly face is when you get a second generation
of the hardware that have some other bits in slightly different places,
and you have to create another struct to map a small difference instead
of being able to just tweak the code slightly.

>> Not only should this be done from devicetree, but exactly which
>> synaptics driver are you using with this?
>>
>> I don't think there is one in the kernel tree yet.
>>
>
> It's this one here http://lxr.free-electrons.com/source/drivers/input/mouse/synaptics_i2c.c

Aha I thought it was one of those modern RMI4 things.
OK then...

> Also, how would you like us to submit updates? Should we continue posting updated patches as replies to this thread?

Just repost it somehow, include relevant people on To/Cc. No need
to use the same thread I think?

Yours,
Linus Walleij
