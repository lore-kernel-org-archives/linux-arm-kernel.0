From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Sep 2011 11:21:51 +0200
Subject: [PATCH 1/4 v6] drivers: create a pin control subsystem v6
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF04B327A58F@HQMAIL01.nvidia.com>
References: <1314869536-5495-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A3FD@HQMAIL01.nvidia.com>
	<CACRpkdYBaWq3BuXNvMtgaS1nMzU-vArRB9_y5WE3Zqp9idaOuA@mail.gmail.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A58F@HQMAIL01.nvidia.com>
Message-ID: <CACRpkdbMP8=BoNq63DVKoRwqw7zwyK4kLy3p1EhaCDfLt-+=zw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[I know Stephen is on vacation, just stacking up some nice reading for
when he gets back and for others to enjoy]

On Fri, Sep 2, 2011 at 6:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
> Linus Walleij wrote at Friday, September 02, 2011 6:59 AM:

>> >> diff --git a/include/linux/pinctrl/pinmux.h b/include/linux/pinctrl/pinmux.h
>> >
>> >> +/**
>> >> + * struct pinmux_ops - pinmux operations, to be implemented by pin controller
>> >> + * drivers that support pinmuxing
>> >> + * @request: called by the core to see if a certain pin can be made available
>> >> + * ? available for muxing. This is called by the core to acquire the pins
>> >> + * ? before selecting any actual mux setting across a function. The driver
>> >> + * ? is allowed to answer "no" by returning a negative error code
>> >> + * @free: the reverse function of the request() callback, frees a pin after
>> >> + * ? being requested
>> >
>> > Shouldn't request/free be for a pingroup, not a pin, since that's what
>> > functions are assigned to? Also, the function should be passed, since
>> > some restrictions these functions might need to check for might depend
>> > on what the pin/group will be used for.
>>
>> This is not for checking anything on function or group level.
>> It's exclusively for things that need to be on a per-pin level, so any
>> pin can deny being selected for muxing at any time.
>>
>> So what you're saying is that you need a function to check
>> also on group level as part of the pinmux_get() sematics?
>>
>> We can add that and have two optional checks: @request_pin()
>> on pin level and say @request_function_and_group() on the
>> group+function level, would that work for your scenarios?
>
> Well, that's a move in the right direction, but not quite everything I'd
> like.
>
> The basic issue is that a single logical function (I2C controller 0) can
> be mux'd out onto more than one pingroup. However, the HW requires that
> at /any given time/ it only be mux'd out onto a single pingroup.
>
> To fully enforce this, the request() function needs to know what the
> complete state will be after the entire (set of) mapping entries is
> processed.

I'm not quite following this, but I'm pretty sure that this verification
can be bolted onto the subsystem later with apropriate callbacks.

It looks like you're after a state holder to avoid pinmux_get() to
activate the same muxing in two different places, it's then a
safety mechanism agains supplying bad mappings and doing
pinmux_get() on stuff before doing pinmux_put() on conflicting
mappings.

> When the core can only process 1 mapping entry at a time, this is trivial,
> since there's only 1 change relative to current HW to process in request().

You will have this in v7 :-)

I was aware that this would cause new semantic issues, but since I
think only Tegra will use that feature as of now, we can postpone
this group denial stuff until there is a driver for it I think, it shouldn't
be too hard to add, and you can still get the driver to a working
state, it's just that it'll be possible to do some nasty things with it
if you give it weird mapping tables and calls.

> The only way I can see this being implementable is:
>
> a) Add request_start() and request_end() functions, so the driver can
> copy HW state to SW state in request_start(), and modify this cached
> state in each request() call, and hence has access to all state changes
> to-date in each request() call. Then, request_end() to finalize the
> whole set of changes.
>
> Or:
>
> b) request() passes an array of changes at once, instead of many calls
> each requesting a single .change
>
> This is certainly a tough problem. The current Tegra pinmux driver doesn't
> actually make any attempt to enforce this, so perhaps it's not worth
> worrying about; we just assume people write sensible mapping tables.

Ok we are at that stage with the subsystem now so let's wait
with that until we have a driver we can fix.

>> > When the core is modified to support applying n entries in the mapping
>> > table for each pinmux_get() call, how will request/free be aware of the
>> > partial pending state?
>>
>> That is like answering how code I haven't yet written will
>> look like... The easiest answer is to implement it I think,
>> then you can check if it looks sane.
>
> :-)

As it is implemented now it backs off and free all pins if there
is an error on any group when doing pinmux_get().

Yours,
Linus Walleij
