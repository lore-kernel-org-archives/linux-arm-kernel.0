From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 22 Aug 2013 01:07:30 +0200
Subject: [PATCH v2] pinctrl: queue GPIO operations instead of defering
In-Reply-To: <52126EDE.5060000@wwwdotorg.org>
References: <1376751410-14560-1-git-send-email-linus.walleij@linaro.org>
 <52126EDE.5060000@wwwdotorg.org>
Message-ID: <CACRpkdasWurMctYTMZCHS+fwhvmnREaQD1vN54QYpMToTuFjsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 9:15 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/17/2013 08:56 AM, Linus Walleij wrote:

>> and the pin controller need the GPIO driver to be ready.
>
> Why does that happen?

The pin controller call back into the GPIO-side controller
functions by utilizing the GPIO ranges.
(Maybe the code is silly, I dunno, check drivers/pinctrl/pinctrl-nomadik.c)

>> This also happens if
>> pin controllers and GPIO controllers compiled as modules
>> are inserted in a certain order.
>
> Shouldn't deferred probe resolve that just fine, assuming there are no
> circular dependencies?

The above leads to circular dependencies so that is what I'm
trying to fix with this.

>> On the Nomadik we get this situation with the pinctrl
>> driver when moving to requesting GPIOs off the gpiochip
>> right after it has been added,
>
> So, the pinctrl driver calls gpio_request()? Surely the solution is
> simply not to do that?

This is what the other patch we're discussing is doing.
The one that harvests and requests interrupt GPIO's when
a gpiochip is added...

Yours,
Linus Walleij
