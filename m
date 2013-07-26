From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 27 Jul 2013 00:39:58 +0200
Subject: Issue with gpio and pinmux
In-Reply-To: <20130726092601.GA1909@ab42.lan>
References: <51E667BC.3070804@parrot.com> <51E82FBB.1080905@wwwdotorg.org>
 <CACRpkdb1n07KoQZSme1EMJfV-9pHr-kd_1eJ6HsBV5gz7Dh3Ww@mail.gmail.com>
 <51EB590A.4010600@wwwdotorg.org>
 <CACRpkdZdbxEt67+YBKif4-BKAToOmN0_c8HFOdjSG91dtJwJQw@mail.gmail.com>
 <20130726092601.GA1909@ab42.lan>
Message-ID: <CACRpkdbLJYOJYLf-KWkxXzJD6tn6h139PPLMk=zGXfQfFHwWAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 26, 2013 at 11:26 AM, Christian Ruppert
<christian.ruppert@abilis.com> wrote:

> I like Stephen's proposal (in another mail) to claim GPIOs from the
> pinctrl drivers but instead of modifying the callback prototypes I
> suggest to add the following functions:
>
> /*
>  * Claim GPIO pin (in the sense: forbid acutal GPIO usage)
>  */
> int claim_gpios(struct pinctrl_dev *pctl, unsigned *pins
>                 unsigned port_selector, unsigned func_selector);
>
> /* allow GPIO usage of the given pins */
> void unclaim_gpios(struct pinctrl_dev *pctl, unsigned *pins);

I would keep ports out of this discussion to begin with,
that can be discussed and patched separately. Let's focus on
GPIO exclusivity WRT other functions.

And these should not be separate functions right? It should
be new members of struct pinmux_ops in <linux/pinctrl/pinmux.h>
right?

And there we already have these:

 * @gpio_request_enable: requests and enables GPIO on a certain pin.
 *      Implement this only if you can mux every pin individually as GPIO. The
 *      affected GPIO range is passed along with an offset(pin number) into that
 *      specific GPIO range - function selectors and pin groups are orthogonal
 *      to this, the core will however make sure the pins do not collide.
 * @gpio_disable_free: free up GPIO muxing on a certain pin, the reverse of
 *      @gpio_request_enable


        int (*gpio_request_enable) (struct pinctrl_dev *pctldev,
                                    struct pinctrl_gpio_range *range,
                                    unsigned offset);
        void (*gpio_disable_free) (struct pinctrl_dev *pctldev,
                                   struct pinctrl_gpio_range *range,
                                   unsigned offset);


> Claiming could be fully dynamic. This way, driver authors don't need to
> implement additional callbacks or modify their existing ones. In the
> simplest case they do nothing. The entire conflict-checking logic is
> confined inside the core.

This is the idea.

The core can already do this, basically, it is just that it's
pin_request() from drivers/pinctrl/pinmux.c.

As you can see if it is passed a gpio range, the GPIO request is
handled orhogonal to any other pin request, and calling the above
functions. What we want to do is basically selectively remove the
orthogonality. It should be very simple at this point.

> Alternatively, a similar set of functions could make the use of GPIOs
> exclusive with other functions for a given set of pins. This would work
> very well with the proposal below and would be easier to manage for most
> driver authors: The configuration would be static in most cases.
> (We just have to discuss about the default mode, do we want to keep the
> backward-compatible inclusive default or change everything to exclusive
> by default?).

I'm not following this, sorry.

> A last point I would like to address before passing on to implementation
> is to introduce the notion of interfaces: I think it is important to
> introduce some orthogonality between unrelated interfaces which happen
> to be muxed on the same port and ideally we implement this coherently
> with the above.

The ports concept should be handled separately.

Yours,
Linus Walleij
