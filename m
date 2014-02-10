From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 10 Feb 2014 10:51:02 +0100
Subject: [PATCH v3 06/15] at91: dt: at91sam9261ek: Adds DT entries for the
 4 user buttons
In-Reply-To: <52F4B3E7.2080000@atmel.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
 <1390492639-7299-7-git-send-email-jjhiblot@traphandler.com>
 <20140207082752.GV9558@ns203013.ovh.net>
 <CACh+v5O_CMcYKBKLzbcD2ypGLX_Pp+64fiqO4MWYw-J4h0KA7A@mail.gmail.com>
 <52F4B3E7.2080000@atmel.com>
Message-ID: <CACRpkdagVxVkknt5xob=QqnK8gQfK6KvNC_CMXPsjWK5Rh1bQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 7, 2014 at 11:22 AM, Nicolas Ferre <nicolas.ferre@atmel.com> wrote:
> On 07/02/2014 10:30, Jean-Jacques Hiblot :
>> 2014-02-07 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>:
>>> On 16:57 Thu 23 Jan     , Jean-Jacques Hiblot wrote:
>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>> ---
>>>>  arch/arm/boot/dts/at91sam9261ek.dts | 39 +++++++++++++++++++++++++++++++++++++
>>>>  1 file changed, 39 insertions(+)
>>>
>>> do only one patch for the 9261ek support no nned to clean
>>>>
>>>> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
>>>> index 8909217..5555e9f5 100644
>>>> --- a/arch/arm/boot/dts/at91sam9261ek.dts
>>>> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
>>>> @@ -83,6 +83,15 @@
>>>>                                               AT91_PIOA 23  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>>>>                                       };
>>>>                               };
>>>> +
>>>> +                             keys {
>>>> +                                     pinctrl_keys: keys-0 {
>>>> +                                             atmel,pins = <AT91_PIOA 27  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>>>> +                                             AT91_PIOA 26  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>>>> +                                             AT91_PIOA 25  AT91_PERIPH_GPIO AT91_PINCTRL_NONE
>>>> +                                             AT91_PIOA 24  AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
>>>> +                                     };
>>>> +                             };
>>>
>>> no need this you can drop it
>> ok. I thought that it would help the user to understand the GPIO usage.
>> I'll remove all pinmux for GPIO that don't require a special hardware
>> configuration
>
> Well, me also, I like to see what the board requires for functioning
> properly. It is convenient for:
> - understanding clearly what is used and what is not
> - doing a grep when searching where a particular GPIO is used
> - describing completely the hardware (which is the purpose of DT)
>
> So, I would like additional consideration by more AT91 users before
> following this rule... And maybe a note by Linus W.

So this is something like a grey area, it's not like there is a definitive
answer to it. It just reflects the fact that the pin control and GPIO
hardware is closely connected and we're cross-talking between
the subsystems to set up GPIOs when requested, i.e.
gpio_request_enable() is implemented.

If that function was *not* implemented, we'd have to do it like
this.

What happens in this case I guess, is that if &pinctrl_keys would
be tied to a default state, the GPIO pins would be muxed in
twice, which is not so horrible.

It becomes very interesting the day you want to add something
else than AT91_PINCTRL_NONE as the last flag, for example
pull-up or drive strength. Then you need both orthogonal interfaces
to be used, so then it's helpful to have this snippet there to fill
in the right biasing etc.

So I would say something lame like it depends on the suspected
use cases.

Yours,
Linus Walleij
