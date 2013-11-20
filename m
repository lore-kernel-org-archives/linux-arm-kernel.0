From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 20 Nov 2013 04:40:28 +0400
Subject: [PATCH 0/9] ARM: sa1100: Rework IRQ handling
In-Reply-To: <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
References: <1384505280-25389-1-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdZU3_EqhBjV68+okJwh7QONuxWVjKkrUO4PkwJhKrP+mQ@mail.gmail.com>
 <528B811A.1030501@gmail.com>
 <CACRpkdbgn22xDX4nJZSDSE9-h+u1j5DQt=8arO7oS-UCBdBMUQ@mail.gmail.com>
Message-ID: <CALT56yMXyJAKM9ncHNg70S6oyG5tx99Cnzdn5+d8etj+fPYq7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 12:24 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Tue, Nov 19, 2013 at 4:17 PM, Dmitry Eremin-Solenikov
> <dbaryshkov@gmail.com> wrote:
>> On 11/19/2013 05:00 PM, Linus Walleij wrote:
>
>>> And that happens before the GPIO driver gets registered -> crash.
>>
>> That is not the issue. The real issue is h3xxx using those gpio's without
>> previously calling gpio_request.
>
> Really? But that wasn't done before this patch either.

I checked 4 different configurations.
3.12 + my patches, GPIO_SA1100 = y => ok
3.12 + my patches, GPIO_SA1100 = n => ok (few error messages, but no oops)
HEAD + my patches, GPIO_SA1100 = y => ok
HEAD + my patches, GPIO_SA1100 = n => Oops

It looks like something in v3.12..HEAD has increased requirements on the
gpio_set_value handling.

>
> It is basically OK to use the gpio_* functions before or
> without requesting the GPIOs, it won't look nice but it
> works.

Quoting comments from gpiolib.c: it is
'...legal but ill-advised when setting direction, and otherwise illegal.'

Indeed gpiod_direction_output checks for (!desc || !desc->chip).
gpiod_set_raw_value only checks for (!desc). So:

1) We can add checks to gpio_{g,s}et_value().
2) We can change h3xxx code to call gpio_direction_output instead
of gpio_set_value and add a call to gpio_direction_input before
gpio_get_value.
3) Add request-check code as I showed before
4) Make GPIO_SA1100 always-enabled on StrongARM

>> Unfortunately sa1100 driver doesn't have a
>> good place to request gpios. When faced this problem during locomo
>> refactoring, I ended up with the following piece of code:
> (...)
>> Russell, Linus, what do you think about the previous solution?
>
> That looks OK but is that really the problem?

Yes and no. Trigger is GPIO_SA1100=n. Problem In my opinion is
absense of gpio_request before.

-- 
With best wishes
Dmitry
