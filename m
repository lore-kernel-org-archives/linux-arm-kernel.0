From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 22 Oct 2012 10:21:19 +0200
Subject: [PATCH v2] pinctrl: reserve pins when states are activated
In-Reply-To: <20121019181019.GP4730@atomide.com>
References: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
 <20121019181019.GP4730@atomide.com>
Message-ID: <CACRpkdZazjMoSzkr5t15-GeCnQKCJDsZyvT=KVMyw5XhjDybGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 8:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> [Me]
>> Instead: let use reserve the pins when the state is activated
>> and drop them when the state is disabled, i.e. when we move to
>> another state. This way different devices/functions can use the
>> same pins at different times.
>
> Hmm doesn't this mean that we are now doing lots of extra
> reserving and dropping of pins? Performance is important from
> latency point of view for cases where we need to remux pins
> constantly runtime PM.

It is only done in case the pinmux state is switched in runtime
suspend/resume, so it's e.g. possible to just alter the pin config.

But in general what you say is true.

We used to to the same thing by having drivers call
pinctrl_get()/pinctrl_put() in this case instead, but that went
away with the introduction of states, so we cannot encode
different pin sets with say
pinctrl_get(dev, "foo")/pinctrl_get(dev, "bar")
anymore since there is only one pinctrl handle per device,
but multiple states.

If this turns out to be a severe performance bottleneck, I
suggest to add some additional constraint API, like
pinctrl_set_pinmux_homegeneous_pinsets(true) that will
at runtime select whether the pin allocation is done when
getting the pinctrl handle instead.

Yours,
Linus Walleij
