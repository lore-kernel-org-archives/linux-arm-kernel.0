From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 04 Dec 2013 23:44:04 +0100
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
Message-ID: <10664958.tMCNRkOk1E@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus and Kevin,

On Tuesday 03 December 2013 11:04:48 Linus Walleij wrote:
> On Thu, Nov 28, 2013 at 11:07 AM,  <kevin.bracey@broadcom.com> wrote:
> > I'm working on converting an shmobile-based system that has a lot of
> > custom GPIO/pin manipulation to use pure pinctrl.  I'm a bit stuck on
> > some of the design details.

Kevin, what SoC do you use ? The GPIO+pinmux hardware architecture varies 
between models (with a single driver handling both GPIO and pinmux versus two 
separate drivers), I'd like to know the exact target before replying to your 
questions below.

> OK I have forwarded this post to Laurent Pinchart who wrote the shmobile pin
> control implementation so we can reach some clarity on how this is supposed
> to work.

By the way, Kevin, feel free to CC linux-sh at vger.kernel.org on Renesas-related 
topics.

> > I'm going to have to extend the sh-pfc pinctrl driver a fair bit to
> > support all the necessary functionality, but I'm not quite sure how some
> > of it should look. I have a first-pass prototype, but I'm worried that
> > the consumer API just isn't right.
> 
> Let's figure this out.
> 
> > Basically, our system has an existing mechanism to get pins into "safe"
> > state for sleep. It uses the legacy SH "gpio_request(FN)" mechanism to
> > switch pinmux between function and GPIO, and then sets GPIO direction
> > through normal GPIO APIs, and pin pulls through a custom API.
> 
> I cannot really say very much about the legacy stuff as I have no clue how
> that works. Paul Mundt and Magnus Damm may know.

The legacy API used fake GPIOs for pinmux and pinconf. We don't really need to 
care about it, but we need to ensure that that pinctrl API covers all the use 
cases.

> > Clearly, this can now be replaced with default+sleep pinctrl states. But
> > I'm not seeing a clear model to follow in the upstream code at the level
> > of detail I need.
>
> So this is what we need to discuss with Laurent.

I'll reply to the rest of the e-mail as soon as Kevin gives me the SoC model 
he's using.

> > The pins that we're dealing with basically look like this diagram from
> > pinctrl.txt:
> >                        pin config
> >                        logic regs
> >                        |               +- SPI
> >      Physical pins --- pad --- pinmux -+- I2C
> >                                |       +- mmc
> >                                |       +- GPIO
> >                                pin
> >                                multiplex
> >                                logic regs
> > 
> > The control bits we have in the GPIO function are "input enable", "output
> > enable" and "output data". Those manual controls are only effective when
> > the GPIO mux is selected. The pad config bits are "pull up enable" and
> > "pull down enable", and they're always manually controllable.
> 
> "Manually" is a very strange word that we use from time to time with a
> very fuzzy semantic meaning.
> 
> I start to think about Charlie Chaplin in the factory in "modern times"
> when I hear this word.
> 
> I guess what you mean is that pulls can always be controlled, no matter
> if the GPIO block is in use or not, so it corresponds to the diagram above.
> 
> > So adding a "gpio-mode" function to each pin group as per pinctrl.txt
> > seems the obvious thing to do.
> 
> This is *one* way to do it that some implementers have opted for. The other
> way is to implement the .gpio_request_enable(), .gpio_disable_free()
> functions in struct pinmux_ops so as to shortcut and simplify matters.
> 
> Either way works.
> 
> > And we need to extend the sh-pfc driver to let us control the GPIO
> > through pinconf once the "gpio-mode" function is selected. But how
> > exactly should this work?
> 
> Controlling GPIO through pinconf seems to be very twisted.
> Usually it is the other way around.
> 
> When  a GPIO driver is using pin control as back-end it calls specific
> helpers from <linux/pinctrl/consumer.h>:
> 
> pinctrl_request_gpio()
> pinctrl_free_gpio()
> pinctrl_gpio_direction_input()
> pinctrl_gpio_direction_output()
> 
> > The questions are really about the intent of generic pinconf, rather
> > than anything platform-specific.
> > 
> > At present, the sh-pfc driver only supports BIAS_PULL_UP,
> > BIAS_PULL_DOWN, and BIAS_DISABLE, which control only the
> > pad pulls, and don't touch the GPIO bits.
> > 
> > Now, if specifying hi-Z/output for a "gpio-mode" pin, it seems that
> > we should use generic pinconf BIAS_HIGH_IMPEDANCE and
> > OUTPUT(0,1). Yes?
> > 
> > But then how do we describe a pull? It seems most natural for
> > pinctrl consumers to express this as simply MUX("gpio-mode"),
> > CONF(BIAS_PULL_UP).
> > 
> > So, should BIAS_PULL_UP automatically select "input" in
> > gpio-mode? Or does the DT/board have to explicitly say
> > MUX("gpio-mode"), CONF(BIAS_PULL_UP, BIAS_HIGH_IMPEDANCE)
> > to select pull up and input? Or does that just make no sense - it
> > certainly looks odd. What's the intent here in the generic pinconf design?
> 
> Nominally the pin config and GPIO portions are treated ortogonally, and the
> four calls above take care of the interaction between the two systems.
> 
> Note that it is perfectly legal for a pin to be used by the pin control and
> GPIO subsystems simultaneously: e.g. a pin control hog can set up a bias and
> then the GPIO subsystem can drive that pin without any cross-talk.
> 
> > Looking at it another way - do we model the pinconf as these
> > 2 sets of independent settings - you can always set 1 of the
> > 
> > first 3, and you can also set 1 of the second 3 in gpio-mode:
> >   (BIAS_PULL_UP | BIAS_PULL_DOWN | BIAS_DISABLE)  = (pull=UP | pull=DOWN |
> >   pull=OFF)
> >   (BIAS_HIGH_IMPEDANCE | OUTPUT 0 | OUTPUT 1)     = (IEN=OEN=0 |
> >   IEN=0,OEN=1,DATA=0 | IEN=0,OEN=1,DATA=1 )
>
> Yes this makes perfect sense. I would sat the first (bias) parameter should
> be handled by the pin control subsystem.
> 
> The latter setting should be controlled by the GPIO subsystem only, right?
> Because BIAS_HIGH_IMPEDANCE is usually the same as input. Maybe you want
> this to happen inside of the pin control driver as a result of the GPIO
> driver calling pinctrl_gpio_direction_input() or
> pinctrl_gpio_direction_output(), that is up to the implementation but it is
> one way to do it, Laurent can comment on this I guess.
> 
> > Or we treat it as one set where you can only ever enable 1:
> >    BIAS_PULL_UP                         pull=UP, IEN=OEN=0
> >    BIAS_PULL_DOWN                       pull=DOWN, IEN=OEN=0
> >    BIAS_HIGH_IMPEDANCE                  pull=OFF, IEN=OEN=0
> >    OUTPUT 0                             pull=OFF, IEN=0, OEN=1, DATA=0
> >    OUTPUT 1                             pull=OFF, IEN=0, OEN=1, DATA=1
> > 
> > (and I guess BIAS_DISABLE is equivalent then to BIAS_HIGH_IMPEDANCE
> > in gpio-mode; with other functions selected, or a real GPIO request, you
> > would only be able to modify the pulls with pinconf, as with the current
> > driver).
>
> This looks messy. The intention with the pin config subsystem is to break
> things apart and make them understandable that way, and to handle electronic
> stuff in pin config whereas driving a line high/low happens in the GPIO
> subsystem.
> 
> It's the divide-and-conquer design pattern if you like.
> 
> > And once you have the answer to that, what about glitch-free handover?
> 
> Usually this is a matter for the device driver, for example you can find
> interesting glitch workarounds in drivers/pinctrl-nomadik.c.
> 
> If you need help from the subsystem to do this let's see what is needed.
> 
> > What is the canonical ordering for MUX+CONF in state tables/DT?
> > If MUX comes first, should the driver defer the actual GPIO mux
> > switch until the CONF specification, to avoid glitches?
> 
> This must be some misunderstanding. DT does not specify application/ordering
> semantics. It does not define sequences at all. The device driver parsing
> out whatever is in the device tree has to take care of ordering stuff and
> driving the hardware.
> 
> On all of these problems we need Laurent's input I think.

-- 
Regards,

Laurent Pinchart
