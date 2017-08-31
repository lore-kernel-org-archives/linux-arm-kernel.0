From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 Aug 2017 09:08:45 +0200
Subject: linux-next regression caused by "gpiolib: request the gpio before
 querying its direction"
In-Reply-To: <20170830161730.41919554@windsurf.lan>
References: <20170830112424.7a3a7c36@windsurf.lan>
 <3cce6903-d167-1bfc-38b4-1fdd7b3ff24b@codeaurora.org>
 <87ziah2m3f.fsf@free-electrons.com> <20170830161730.41919554@windsurf.lan>
Message-ID: <CACRpkdbxdkHukALfYMrM7w=1KNJKLBhGebbkEpMb3C3+nCfWOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 30, 2017 at 4:17 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:

> The call chain leading to the problem is:
>
>  gpiochip_add_data()
>   chip->request() == gpiochip_generic_request()
>    pinctrl_request_gpio()
>     pinmux_request_gpio()
>      pin_request()
>       ops->gpio_request_enable() == mvebu_pinmux_gpio_request_enable()
>        mvebu_pinconf_group_set()
>         grp->ctrl->mpp_set() == mvebu_regmap_mpp_ctrl_set()
>
> So what Timur is saying perhaps is that
> mvebu_pinmux_gpio_request_enable() shouldn't be changing the type of
> muxing, and therefore shouldn't be calling mvebu_pinconf_group_set().
>
> However, even the "reference" pinctrl-single.c implementation does it,
> in pcs_request_gpio().

Yeah so we have unclear semantics on this and that is just a fact of
life. It's a bit of pain as maintainer because I sometimes don't know
what to do when something makes superficial sense and the only thing
I can do is to toss it into linux-next and see what happens.

Look what happened :D

If the semantics should be changed, all drivers must be changed consistently
in a larger patch series, so until then, we revert this and leave it as it is.

Now this is reverted anyways.

Yours,
Linus Walleij
