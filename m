From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 12:07:45 -0700
Subject: [PATCH v2] pinctrl: reserve pins when states are activated
In-Reply-To: <CACRpkdZazjMoSzkr5t15-GeCnQKCJDsZyvT=KVMyw5XhjDybGQ@mail.gmail.com>
References: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
 <20121019181019.GP4730@atomide.com>
 <CACRpkdZazjMoSzkr5t15-GeCnQKCJDsZyvT=KVMyw5XhjDybGQ@mail.gmail.com>
Message-ID: <20121022190743.GE4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Linus Walleij <linus.walleij@linaro.org> [121022 01:22]:
> On Fri, Oct 19, 2012 at 8:10 PM, Tony Lindgren <tony@atomide.com> wrote:
> > [Me]
> >> Instead: let use reserve the pins when the state is activated
> >> and drop them when the state is disabled, i.e. when we move to
> >> another state. This way different devices/functions can use the
> >> same pins at different times.
> >
> > Hmm doesn't this mean that we are now doing lots of extra
> > reserving and dropping of pins? Performance is important from
> > latency point of view for cases where we need to remux pins
> > constantly runtime PM.
> 
> It is only done in case the pinmux state is switched in runtime
> suspend/resume, so it's e.g. possible to just alter the pin config.
> 
> But in general what you say is true.
> 
> We used to to the same thing by having drivers call
> pinctrl_get()/pinctrl_put() in this case instead, but that went
> away with the introduction of states, so we cannot encode
> different pin sets with say
> pinctrl_get(dev, "foo")/pinctrl_get(dev, "bar")
> anymore since there is only one pinctrl handle per device,
> but multiple states.

OK
 
> If this turns out to be a severe performance bottleneck, I
> suggest to add some additional constraint API, like
> pinctrl_set_pinmux_homegeneous_pinsets(true) that will
> at runtime select whether the pin allocation is done when
> getting the pinctrl handle instead.

Or maybe you could release + reserve the pins only if the
pins change?

Regards,

Tony
