From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 21 Jul 2013 00:44:21 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <51E82FBB.1080905@wwwdotorg.org>
References: <51E667BC.3070804@parrot.com>
	<51E82FBB.1080905@wwwdotorg.org>
Message-ID: <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 18, 2013 at 8:11 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> The issue is that some HW muxes groups of pins at a time, so simply
> because that group of pins is "claimed" by a mux function, implies
> nothing about which specific pins in that group are actually used; some
> may actually still be free for usage as a GPIO.

This we need to get into the documentation.

> The solution here may be one of:
>
> a) Modify pinctrl /not/ to allow both a GPIO and a mux function to claim
> a pin *if* the group that contains the pin only contains a single pin.
> This is a bit of a hacky special case though; there are other situations
> where "dual claiming" shouldn't be allowed, and this doesn't solve those.
>
> b) Ignore the issue; if the system configuration is correct, the issue
> won't cause problems in practice, since nothing will be configured to
> "dual claim" any pin.
>
> c) Enhance pinctrl with extra information, so it knows which pins in a
> group are usable as GPIO even when the group is claimed by a mux
> function. The list of pins could theoretically vary per mux function, so
> you'd need a table with lookup key (pin group, mux function) and output
> data (list of pins that can be "dual claimed"). This would be a complete
> solution. If a list wasn't provided, the pinctrl core could assume that
> mean no dual claim was allowed.

I guess (b) is what we have.

But it really feels incomplete does it not? IIRC the system was strict
not to allow simultaneous use of pins for GPIO and other functions
at all until the above corner case made it necessary to relax this
restriction.

A simple way to get (a) would be to just add a flag like ".strict"
to struct pinmux_ops but it feels cheap.

What do we need for (c)? I think we can refactor this as the Tegra
and U300 should be the two platforms with such tricky groups so
the impact should be fairly small right now. I'm just worried it would
be a complex and memory-consuming thing :-/

Yours,
Linus Walleij
