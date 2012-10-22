From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 14:30:05 -0600
Subject: [PATCH v2] pinctrl: reserve pins when states are activated
In-Reply-To: <CACRpkdZazjMoSzkr5t15-GeCnQKCJDsZyvT=KVMyw5XhjDybGQ@mail.gmail.com>
References: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
 <20121019181019.GP4730@atomide.com>
 <CACRpkdZazjMoSzkr5t15-GeCnQKCJDsZyvT=KVMyw5XhjDybGQ@mail.gmail.com>
Message-ID: <5085ACCD.3040203@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 02:21 AM, Linus Walleij wrote:
> On Fri, Oct 19, 2012 at 8:10 PM, Tony Lindgren <tony@atomide.com> wrote:
>> [Me]
>>> Instead: let use reserve the pins when the state is activated
>>> and drop them when the state is disabled, i.e. when we move to
>>> another state. This way different devices/functions can use the
>>> same pins at different times.
>>
>> Hmm doesn't this mean that we are now doing lots of extra
>> reserving and dropping of pins? Performance is important from
>> latency point of view for cases where we need to remux pins
>> constantly runtime PM.
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
> 
> If this turns out to be a severe performance bottleneck, I
> suggest to add some additional constraint API, like
> pinctrl_set_pinmux_homegeneous_pinsets(true) that will
> at runtime select whether the pin allocation is done when
> getting the pinctrl handle instead.

That API sounds like something system-wide, which seems like it would be
rather presumptuous (CPU/SoC support code couldn't execute it, since
that would presume a facet of all board designs that could change in the
future). Even a driver shouldn't be assuming this; it can't know what
boards it gets used in ahead of time.

Instead, it seems like the map registration code could easily look at
all states defined for a device, and determine if the set of pins/groups
used by those states was identical, and switch between up-front or
dynamic registration as needed by the specific map entries.
