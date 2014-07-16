From: gnurou@gmail.com (Alexandre Courbot)
Date: Wed, 16 Jul 2014 16:28:33 +0900
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <20140716071237.GA7978@ulmo>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel> <20140714183624.GV6800@sirena.org.uk>
 <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
 <53C4DF0D.8010208@metafoo.de>
 <CAAVeFuJRCwSwcEOng2M6s+mWhJT8sUtsh7YGE-hBTGUFWAhtrQ@mail.gmail.com>
 <CAAVeFuLfgG6W1qK2ATTbq_ydEOjUuM8Wvftm6N1RK3Kz_y1zHg@mail.gmail.com>
 <20140716071237.GA7978@ulmo>
Message-ID: <CAAVeFuJEjMBX+7vsLk5zXV5Moy=WDmWidpVZjQ_=8VD45+QdHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 16, 2014 at 4:12 PM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jul 16, 2014 at 12:00:45PM +0900, Alexandre Courbot wrote:
>> On Tue, Jul 15, 2014 at 6:14 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> > On Tue, Jul 15, 2014 at 4:58 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
>> >> On 07/15/2014 09:36 AM, Alexandre Courbot wrote:
>> >>>
>> >>> On Tue, Jul 15, 2014 at 4:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> >>>>
>> >>>> On Monday 14 July 2014 19:36:24 Mark Brown wrote:
>> >>>>>
>> >>>>> On Mon, Jul 14, 2014 at 08:23:55PM +0200, Arnd Bergmann wrote:
>> >>>>>>
>> >>>>>> On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:
>> >>>>>
>> >>>>>
>> >>>>>>> Yes. But now that you say it the gpiod_direction_output() call is
>> >>>>>>> missing
>> >>>>>>> from this patch.
>> >>>>>
>> >>>>>
>> >>>>>> I'm lost now. The GPIO_ACTIVE_HIGH I added comes from
>> >>>>>> Documentation/gpio/board.txt
>> >>>>>> and as Linus Walleij explained to me the other day, the lookup is
>> >>>>>> supposed
>> >>>>>> to replace devm_gpio_request_one(), which in turn replaced both the
>> >>>>>> gpio_request and the gpio_direction_output(). Do I need to put the
>> >>>>>> gpiod_direction_output() back or is there another interface for that
>> >>>>>> when
>> >>>>>> registering the board gpios?
>> >>>>>
>> >>>>>
>> >>>>> Indeed.  If you *do* need an explicit _output() then that sounds to me
>> >>>>> like we either need a gpiod_get_one() or an extension to the table,
>> >>>>> looking at the code it seems like this is indeed the case.  We can set
>> >>>>> if the GPIO is active high/low, or open source/drain but there's no flag
>> >>>>> for the initial state.
>> >>>>
>> >>>>
>> >>>> (adding Alexandre and the gpio list)
>> >>>>
>> >>>> GPIO people: any guidance on how a board file should set a gpio to
>> >>>> output/default-high in a GPIO_LOOKUP() table to replace a
>> >>>> devm_gpio_request_one() call in a device driver with devm_gpiod_get()?
>> >>>> Do we need to add an interface extension to do this, e.g. passing
>> >>>> GPIOF_OUT_INIT_HIGH as the flags rather than GPIO_ACTIVE_HIGH?
>> >>>
>> >>>
>> >>> The way I see it, GPIO mappings (whether they are done using the
>> >>> lookup tables, DT, or ACPI) should only care about details that are
>> >>> relevant to the device layout and that should be abstracted to the
>> >>> driver (e.g. whether the GPIO is active low or open drain) so drivers
>> >>> do not need to check X conditions every time they want to drive the
>> >>> GPIO.
>> >>>
>> >>> Direction and initial value, on the other hand, are clearly properties
>> >>> that ought to be set by the driver itself. Thus my expectation here
>> >>> would be that the driver sets the GPIO direction and initial value as
>> >>> soon as it gets it using gpiod_direction_output(). In other words,
>> >>> there is no replacement for gpio_request_one() with the gpiod
>> >>> interface. Is there any use-case that cannot be covered by calling
>> >>> gpiod_direction_output() right after gpiod_get()? AFAICT this is what
>> >>> gpio_request_one() was doing anyway.
>> >>
>> >>
>> >> I agree with you that this is something that should be done in the driver
>> >> and not in the lookup table. I think that it is still a good idea to have a
>> >> replacement for gpio_request_one with the new GPIO descriptor API. A large
>> >> share of the drivers want to call either gpio_direction_input() or
>> >> gpio_direction_output() right after requesting the GPIO. Combining both the
>> >> requesting and the configuration of the GPIO into one function call makes
>> >> the code a bit shorter and also simplifies the error handling. Even more so
>> >> if e.g. the GPIO is optional. This was one of the main reasons why
>> >> gpio_request_one was introduced, see the commit[1] that added it.
>> >
>> > I am not opposed to it as a convenience function. Note that since the
>> > open-source and open-drain flags are already handled by the lookup
>> > table, the only flags it should handle are those related to direction,
>> > value, and (maybe) sysfs export.
>>
>> Problem is, too much convenience functions seems to ultimately kill convenience.
>>
>> The canonical way to request a GPIO is by providing a (device,
>> function, index) triplet to gpiod_get_index(). Since most functions
>> only need one GPIO, we have gpiod_get(device, function) which is
>> basically an alias to gpiod_get_index(device, function, 0) (note to
>> self: we should probably inline it).
>>
>> On top of these comes another set of convenience functions,
>> gpiod_get_optional() and gpiod_get_index_optional(), which return NULL
>> instead of -ENOENT if the requested GPIO mapping does not exist. This
>> is useful for the common case where a driver can work without a GPIO.
>>
>> Of course these functions all have devm counterparts, so we currently
>> have 8 (devm_)gpiod_get(_index)(_optional) functions.
>>
>> If we are to add functions with an init flags parameter, we will end
>> with 16 functions. That starts to be a bit too much to my taste, and
>> maybe that's where GPIO consumers should sacrifice some convenience to
>> preserve a comprehensible GPIO API.
>>
>> There might be other ways to work around this though. For instance, we
>> could replace the _optional functions by a GPIOF_OPTIONAL flag to be
>> passed to a more generic function that would also accept direction and
>> init value flags. Actually I am not seeing any user of the _optional
>> variant in -next, so maybe we should just do this. Thierry, since you
>> introduced the _optional functions, can we get your thoughts about
>> this?
>
> I personally prefer explicit naming of the functions rather than putting
> a bunch of flags into some parameter. If you're overly concerned about
> the amount of convenience functions, perhaps the _index variants can be
> left out for gpiod_get_one(). I'd argue that if drivers want to deal
> with that level of detail anyway, they may just as well add the index
> explicitly when calling the function.
>
> While we're at it, gpiod_get_one() doesn't sound like a very good name.
> All other variants only request "one" as well. Perhaps something like
> gpiod_get_with_flags() would be a better name.
>
> Then again, maybe rather than add a new set of functions we should bite
> the bullet and change gpiod_get() (and variants) to take an additional
> flags parameter. There aren't all that many users yet (I count 26
> outside of drivers/gpio), so maybe now would still be a good time to do
> that.

That sounds reasonable indeed. And preferable to getting an aneurysm
after trying to spell devm_gpiod_get_index_optional_with_flags().

This also makes the most sense since most GPIO users will want to set
a direction and value right after obtaining one. So if there is no
objection I will probably start refactoring gpiod_get() this week.
