From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 14:56:38 +0100
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
 <10664958.tMCNRkOk1E@avalon>
 <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
Message-ID: <CACRpkdbzGokHHhR3GhLvF7KCFdAV=b0VHwUE4eHVfNFEGhx_Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 5, 2013 at 11:15 AM,  <kevin.bracey@broadcom.com> wrote:
> Laurent Pinchart wrote:
>> On Tuesday 03 December 2013 11:04:48 Linus Walleij wrote:

>> Controlling GPIO through pinconf seems to be very twisted.
>> Usually it is the other way around.
>
> I refer you to pinctrl.txt. What I'm trying to avoid here is the "GPIO mode pitfall", where we can /only/ usefully manipulate the lines through the Linux gpio API.
>
> I want to be able to drive a function line low in sleep mode, without having to write code that uses the gpio_ API. I want to be able to express that as PIN_CONFIG_OUTPUT 0.
>
> Where we currently stand locally is that we have a load of code that use the legacy function GPIOs thus:
>
> resume:
>     gpio_request(GPIO_FN_XXX)  // Set function mux on GPIO36 pin
> suspend:
>     gpio_request(GPIO_PORT36)  // Set GPIO mux on pin
>     gpio_direction_output(GPIO_PORT36, 0);
>
> which is exactly the scenario described in "GPIO mode pitfalls". Some drivers do this manually, and some use a local pinctrl-ish framework; they're passed big platform data tables with lists of suspend+active GPIO numbers, directions, values and pulls, and then pass those tables back to a library mux-change routine in their suspend/resume handlers.
>
> By my understanding of the general pinctrl concept, we should be converting that to the lovely:
>
> resume:
>     pinctrl_pm_select_default_state(dev);
> suspend:
>     pinctrl_pm_select_sleep_state(dev);

This observation is correct, and I agree with this reasoning. The PM
states are quite new and may
take some time before they "sink in" in the kernel though, but ideally
people should be using
them like that (atleast IMO).

>> > This looks messy. The intention with the pin config subsystem is to
>> > break things apart and make them understandable that way, and to
>> > handle electronic stuff in pin config whereas driving a line high/low
>> > happens in the GPIO subsystem.
>
> Which is basically an argument against ever using PIN_CONFIG_OUTPUT 0, and the
> whole of "GPIO mode pitfalls" in pinctrl.txt, isn't it? It means we can't specify idle pinctrl
> states that drive lines. We have to do the GPIO/function shuffle.

Well maybe. My point was that it is OK to drive GPIO lines as part of a state
which is only relevant for a device driver, and where using the GPIO API
in top would only bloat and make things hard to follow.

> And you're right, it is a little messy in the pin driver implementation, which is
> what I'm finding, and what leads me here to question the detail. Nevertheless,
> I've found implementing PIN_CONFIG_OUTPUT on this hardware design is
> possible, and produces elegant driver+board code.

I believe you.

> In my initial prototype, PIN_CONFIG_OUTPUT is only available if the gpio-mode
> function has been selected.

That is even more careful code than most drivers write, so sounds
very nice.

> But maybe this could be made hidden and implicit,
> as per the GPIO API. Eg PIN_CONFIG_OUTPUT/PIN_CONFIG_LOW_POWER_MODE
> implicitly selects the GPIO mux (for output/input), and
> PIN_CONFIG_DRIVE_PUSH_PULL/PIN_CONFIG_BIAS_HIGH_IMPEDANCE
> restores the previously requested?

I'd recommend trying to keep as close to the semantics descrived
in <linux/pinctrl/pinconf-generic.h> and not add any implicit semantics.

>> > This must be some misunderstanding. DT does not specify
>> > application/ordering semantics. It does not define sequences at all.
>> > The device driver parsing out whatever is in the device tree has to
>> > take care of ordering stuff and driving the hardware.
>
> Well, the pinctrl core does process its tables in order. So in the case where a
> pinconf setting may interact with a pinmux setting, the ordering that the
> pinconf+pinmux entries get processed could be significant. Eg if
> PIN_CONFIG_OUTPUT requires the "gpio-mode" function selected first.

OK so we solved the similar situation where configs had to be
applied in some certain order for the pin config API by passing
the array of configs down to the driver and let is handle this.

So can we think of an API that gives the drivers the freedom to
express or behave differently here?

We *could* add something like void (* pin_state_commence) ()
to the pinctrl_ops so the driver could cache mux and config ops
and wait for the commence signal before writing anything to the
hardware, and that would be pretty complex.

If it is always the same for every state setting then maybe we
can move this to the core so that we'd add some semantic
flag like

enum state_application_order {
  PINCTRL_ORDER_UNDEFINED,
  PINCTRL_MUX_THEN_CONFIG,
  PINCTRL_CONFIG_THEN_MUX,
};

Then the core needs to alter behaviour on this flag. Any
suggestions welcome, but I won't apply any patches like that
unless there is a driver making use of it.

Yours,
Linus Walleij
