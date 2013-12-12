From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 22:22:06 +0100
Subject: [PATCH v2 2/3] pinctrl: Add msm8x74 configuration
In-Reply-To: <20131213042416.GL11990@sonymobile.com>
References: <1386295805-13708-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1386295805-13708-3-git-send-email-bjorn.andersson@sonymobile.com>
 <52A24E08.706@codeaurora.org>
 <20131210084140.GF11990@sonymobile.com>
 <52A7C4BB.6000701@codeaurora.org>
 <CACRpkdY9Z71VcS6ERiaDbg9P7qPEK_jCVXLvoCDx6YztYCnR2Q@mail.gmail.com>
 <20131213042416.GL11990@sonymobile.com>
Message-ID: <CACRpkdYMcJQWxv-K0CZ-kyDCQ65pLLuHL5cAkG9sP7sn4znG1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 5:24 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:
> On Thu 12 Dec 11:15 PST 2013, Linus Walleij wrote:
>> On Wed, Dec 11, 2013 at 2:49 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> ...
>> > I don't follow what Linus is recommending. How could
>> > .gpio_request_enable()/.gpio_disable_free() help us here?
>>
>> That removes the need to define a single group for each pin that
>> can be used as GPIO.
>
> For the TLMM chip the pin can not be used as GPIO when another function is
> selected for the pin. And upon leaving a state with a function defined the
> choosen mux is disabled, turning the pin back to a GPIO pin.
> So I don't think this is applicable for us, any unused pin is a GPIO pin.

Well it can be used, it is not imperative to exploit the fact that the
subsystem this way allows you to use a pin as a function and GPIO
at the same time, and that is actually not why it is there.

It is there to avoid adding too many one-pin gpio groups :-)

If you still want to have the "check" that we don't enable GPIO
on something that is used by another function or vice versa
that can be NACKed by the driver, for example by using a
bitmap to indicate if the pin is used by a GPIO and NACKing
the mux setting on that pin in this case (etc).

However *I'm* OK with one pin group per pin if you prefer
it this way, it's just an option, no way is it compulsory, to
do it with the special callbacks.

Yours,
Linus Walleij
