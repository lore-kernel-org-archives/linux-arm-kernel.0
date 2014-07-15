From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 15 Jul 2014 09:58:05 +0200
Subject: [alsa-devel] [PATCH 2/4] ASoC: s3c64xx/smartq: use dynamic
 registration
In-Reply-To: <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
References: <1405086308-1461192-1-git-send-email-arnd@arndb.de>
 <16507628.c6raaN50oI@wuerfel> <20140714183624.GV6800@sirena.org.uk>
 <4657735.1VKsbQGuH6@wuerfel>
 <CAAVeFu+Z2xzUy6pGWu3H4MXdkBq39-USHbwNU9ih6AvvxPyu5A@mail.gmail.com>
Message-ID: <53C4DF0D.8010208@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 09:36 AM, Alexandre Courbot wrote:
> On Tue, Jul 15, 2014 at 4:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Monday 14 July 2014 19:36:24 Mark Brown wrote:
>>> On Mon, Jul 14, 2014 at 08:23:55PM +0200, Arnd Bergmann wrote:
>>>> On Monday 14 July 2014 18:18:12 Lars-Peter Clausen wrote:
>>>
>>>>> Yes. But now that you say it the gpiod_direction_output() call is missing
>>>>> from this patch.
>>>
>>>> I'm lost now. The GPIO_ACTIVE_HIGH I added comes from Documentation/gpio/board.txt
>>>> and as Linus Walleij explained to me the other day, the lookup is supposed
>>>> to replace devm_gpio_request_one(), which in turn replaced both the
>>>> gpio_request and the gpio_direction_output(). Do I need to put the
>>>> gpiod_direction_output() back or is there another interface for that when
>>>> registering the board gpios?
>>>
>>> Indeed.  If you *do* need an explicit _output() then that sounds to me
>>> like we either need a gpiod_get_one() or an extension to the table,
>>> looking at the code it seems like this is indeed the case.  We can set
>>> if the GPIO is active high/low, or open source/drain but there's no flag
>>> for the initial state.
>>
>> (adding Alexandre and the gpio list)
>>
>> GPIO people: any guidance on how a board file should set a gpio to
>> output/default-high in a GPIO_LOOKUP() table to replace a
>> devm_gpio_request_one() call in a device driver with devm_gpiod_get()?
>> Do we need to add an interface extension to do this, e.g. passing
>> GPIOF_OUT_INIT_HIGH as the flags rather than GPIO_ACTIVE_HIGH?
>
> The way I see it, GPIO mappings (whether they are done using the
> lookup tables, DT, or ACPI) should only care about details that are
> relevant to the device layout and that should be abstracted to the
> driver (e.g. whether the GPIO is active low or open drain) so drivers
> do not need to check X conditions every time they want to drive the
> GPIO.
>
> Direction and initial value, on the other hand, are clearly properties
> that ought to be set by the driver itself. Thus my expectation here
> would be that the driver sets the GPIO direction and initial value as
> soon as it gets it using gpiod_direction_output(). In other words,
> there is no replacement for gpio_request_one() with the gpiod
> interface. Is there any use-case that cannot be covered by calling
> gpiod_direction_output() right after gpiod_get()? AFAICT this is what
> gpio_request_one() was doing anyway.

I agree with you that this is something that should be done in the driver 
and not in the lookup table. I think that it is still a good idea to have a 
replacement for gpio_request_one with the new GPIO descriptor API. A large 
share of the drivers want to call either gpio_direction_input() or 
gpio_direction_output() right after requesting the GPIO. Combining both the 
requesting and the configuration of the GPIO into one function call makes 
the code a bit shorter and also simplifies the error handling. Even more so 
if e.g. the GPIO is optional. This was one of the main reasons why 
gpio_request_one was introduced, see the commit[1] that added it.

- Lars

[1] 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=3e45f1d1155894e6f4291f5536b224874d52d8e2
