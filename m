From: kevin.bracey@broadcom.com (kevin.bracey at broadcom.com)
Date: Thu, 5 Dec 2013 10:15:25 +0000
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <10664958.tMCNRkOk1E@avalon>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
 <10664958.tMCNRkOk1E@avalon>
Message-ID: <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus & Laurent,

Thanks for taking the time to think about this.

Laurent Pinchart wrote:
> On Tuesday 03 December 2013 11:04:48 Linus Walleij wrote:
> > On Thu, Nov 28, 2013 at 11:07 AM,  <kevin.bracey@broadcom.com> wrote:
> > > I'm working on converting an shmobile-based system that has a lot of 
> > > custom GPIO/pin manipulation to use pure pinctrl.  I'm a bit stuck 
> > > on some of the design details.

> Kevin, what SoC do you use ? The GPIO+pinmux hardware architecture varies
> between models (with a single driver handling both GPIO and pinmux versus
> two separate drivers), I'd like to know the exact target before replying
> to your questions below.

I'm working on the non-upstreamed r8a7373. The closest relative in the PFC area is the r8a73a4, so pfc-r8a7373 is primarily modelled on that, and I'm trying to devise extensions that could be upstreamed in the form of r8a73a4 patches, even if we don't get the r8a7373 itself upstreamed. I do have access to an APE6EVM for testing that if necessary, but I'm not currently working on it.

> > OK I have forwarded this post to Laurent Pinchart who wrote the 
> > shmobile pin control implementation so we can reach some clarity on 
> > how this is supposed to work.
> 
> By the way, Kevin, feel free to CC linux-sh at vger.kernel.org on Renesas-related topics.

Yeah, I'll CC them in from now on. My questions seemed more generic, but obviously there are per-platform design choices to be made here.

> The legacy API used fake GPIOs for pinmux and pinconf. We don't really need to
> care about it, but we need to ensure that that pinctrl API covers all the use cases.

That's exactly my concern. We've got a large mass of code that aggressively uses the legacy APIs, together with some local extensions, and as such we need to get pinctrl/pinconf to cover all of that. And preferably more elegantly. :)

> > > The pins that we're dealing with basically look like this diagram 
> > > from
> > > pinctrl.txt:
> > >                        pin config
> > >                        logic regs
> > >                        |               +- SPI
> > >      Physical pins --- pad --- pinmux -+- I2C
> > >                                |       +- mmc
> > >                                |       +- GPIO
> > >                                pin
> > >                                multiplex
> > >                                logic regs
> > > 
> > > The control bits we have in the GPIO function are "input enable", 
> > > "output enable" and "output data". Those manual controls are only 
> > > effective when the GPIO mux is selected. The pad config bits are 
> > > "pull up enable" and "pull down enable", and they're always manually controllable.
> >
> > I guess what you mean is that pulls can always be controlled, no 
> > matter if the GPIO block is in use or not, so it corresponds to the diagram above.

Correct. The mux is only switching IE+OE+DATA, not PU+PD.


> > > So adding a "gpio-mode" function to each pin group as per 
> > > pinctrl.txt seems the obvious thing to do.
> > 
> > This is *one* way to do it that some implementers have opted for. The 
> > other way is to implement the .gpio_request_enable(), 
> > .gpio_disable_free() functions in struct pinmux_ops so as to shortcut and simplify matters.
> > 
> > Either way works.

Yes, we do have automatic switch to the GPIO mux when someone uses the GPIO API, thanks to gpio_request_enable. Thus there is no need for gpio-mode for the GPIO API. But I think it may still needed for elegant sleep/idle handling.

> Controlling GPIO through pinconf seems to be very twisted.
> Usually it is the other way around.

I refer you to pinctrl.txt. What I'm trying to avoid here is the "GPIO mode pitfall", where we can /only/ usefully manipulate the lines through the Linux gpio API.

I want to be able to drive a function line low in sleep mode, without having to write code that uses the gpio_ API. I want to be able to express that as PIN_CONFIG_OUTPUT 0.

Where we currently stand locally is that we have a load of code that use the legacy function GPIOs thus:

resume:
    gpio_request(GPIO_FN_XXX)  // Set function mux on GPIO36 pin
suspend:
    gpio_request(GPIO_PORT36)  // Set GPIO mux on pin
    gpio_direction_output(GPIO_PORT36, 0);

which is exactly the scenario described in "GPIO mode pitfalls". Some drivers do this manually, and some use a local pinctrl-ish framework; they're passed big platform data tables with lists of suspend+active GPIO numbers, directions, values and pulls, and then pass those tables back to a library mux-change routine in their suspend/resume handlers.

By my understanding of the general pinctrl concept, we should be converting that to the lovely:

resume:
    pinctrl_pm_select_default_state(dev);
suspend:
    pinctrl_pm_select_sleep_state(dev);

But that means we need to be able to specify the line drives for sleep state through pinctrl tables, which leads us to PIN_CONFIG_OUTPUT, which means controlling the GPIO registers to achieve that. We can do this pretty straightforwardly for the r8a73a4-type case of integrated GPIO+pinctrl - for non-integrated ones, I'm less sure how easy it would be to arrange.

> > This looks messy. The intention with the pin config subsystem is to 
> > break things apart and make them understandable that way, and to 
> > handle electronic stuff in pin config whereas driving a line high/low 
> > happens in the GPIO subsystem.

Which is basically an argument against ever using PIN_CONFIG_OUTPUT 0, and the whole of "GPIO mode pitfalls" in pinctrl.txt, isn't it? It means we can't specify idle pinctrl states that drive lines. We have to do the GPIO/function shuffle.

And you're right, it is a little messy in the pin driver implementation, which is what I'm finding, and what leads me here to question the detail. Nevertheless, I've found implementing PIN_CONFIG_OUTPUT on this hardware design is possible, and produces elegant driver+board code.

In my initial prototype, PIN_CONFIG_OUTPUT is only available if the gpio-mode function has been selected. But maybe this could be made hidden and implicit, as per the GPIO API. Eg PIN_CONFIG_OUTPUT/PIN_CONFIG_LOW_POWER_MODE implicitly selects the GPIO mux (for output/input), and PIN_CONFIG_DRIVE_PUSH_PULL/PIN_CONFIG_BIAS_HIGH_IMPEDANCE restores the previously requested?

> > > What is the canonical ordering for MUX+CONF in state tables/DT?
> > > If MUX comes first, should the driver defer the actual GPIO mux 
> > > switch until the CONF specification, to avoid glitches?
> >
> > This must be some misunderstanding. DT does not specify 
> > application/ordering semantics. It does not define sequences at all. 
> > The device driver parsing out whatever is in the device tree has to 
> > take care of ordering stuff and driving the hardware.

Well, the pinctrl core does process its tables in order. So in the case where a pinconf setting may interact with a pinmux setting, the ordering that the pinconf+pinmux entries get processed could be significant. Eg if PIN_CONFIG_OUTPUT requires the "gpio-mode" function selected first.

Kevin
