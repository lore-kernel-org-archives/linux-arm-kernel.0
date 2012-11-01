From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 1 Nov 2012 15:01:28 +0100
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <20121101120713.GA4413@opensource.wolfsonmicro.com>
References: <1350911580-20307-1-git-send-email-sourav.poddar@ti.com>
 <20121024161429.GA16350@core.coreip.homeip.net>
 <CACRpkdai3NocZQnW6YRF+k6GXUSx3P_Ge=F-tkuivrFm6tBbLg@mail.gmail.com>
 <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <CACRpkdaiLXVeUg1quuw3XPTenbKOjn+aWbGQezpcyvzQCtCWow@mail.gmail.com>
 <20121030113407.GA24335@sirena.org.uk>
 <CACRpkdapQJY0aoam741O0fb8EeM9BLk_Psq5TaPG84J7wEvCLw@mail.gmail.com>
 <87obji8kta.fsf@deeprootsystems.com>
 <CACRpkdbCk9+HSBPtfT-1dO8paSRYJ5VXX_0SxiyxgrObnJEvmQ@mail.gmail.com>
 <20121101120713.GA4413@opensource.wolfsonmicro.com>
Message-ID: <CACRpkdawAdbwackZeST4iDkFZx9-exhTVoUzAABaWr1G89tATg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 1, 2012 at 1:07 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Thu, Nov 01, 2012 at 09:54:00AM +0100, Linus Walleij wrote:

> For the pin hogging I'd actually been thinking separately that we should
> just have the device core do a devm_pinctrl_get_set_default() prior to
> probing the device and store the result in the struct device.  That
> would immediately remove almost all of the current pinctrl users, users
> that do need to do things with the data or check the result can then
> pick up the pinctrl pointer from the device struct.

I never thought of that. This sounds like it would work.

And the good thing is that this is a clean cut so we
will centralized code without having to decide right now
how to handle the pm idle/sleep cases.

Talking here with Kevin Hilman on my left and Grant
Likely on my right (they're physically here) there is some
worry about stashing stuff into struct device.

What if I retrieve this in the pinctrl subsystem using
bus notifiers and then expose the struct pinctrl * to
the clients by using pinctrl_get() and when you get
such a handle in your probe() you know that the
pinctrl subsystem has already fetched the handle and
set it to "default" at that point?

I just worry whether there is a fringe case where the default
state is not be be default-selected in probe(), the API
semantics does not mandate that. But I think this is the case
for all in-kernel drivers so we wouldn't be breaking anything
by doing this right now. And platforms can just leave the
"default" state undefined in that case.

>> It's actually something that needs to be acknowledged by the
>> ARM SoC maintainers, because they will be the ones telling
>> all subarch maintainers to go implement full PM handling
>> with these three frameworks whenever an SoC driver want
>> to handle pins.
>
> Well, they're going to have to implement it somewhere anyway - either in
> the drivers or in the SoC stuff.

Sure I just worry about it being done is several different ways
and creating a mess so they need to be involved to block
other approaches.

>> I can surely fix these for "my" systems, but it really needs
>> to be enforced widely or it will be a mess.
>
> We definitely need to decide if it's something that should be open coded
> everywhere.

If I prepare a patch to move the fetch+set defaul to the pinctrl
core using notifiers, we centralize one piece and we get the
currently floating patches out of the way.

Then what to do with sleep and idle is a question we need
to handle next. Requiring PM domains for this is one
approach, albeit a bit controversial.

Yours,
Linus Walleij
