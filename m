From: kevin.bracey@broadcom.com (kevin.bracey at broadcom.com)
Date: Fri, 13 Dec 2013 08:48:33 +0000
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <CACRpkdbzGokHHhR3GhLvF7KCFdAV=b0VHwUE4eHVfNFEGhx_Jg@mail.gmail.com>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
 <10664958.tMCNRkOk1E@avalon>
 <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbzGokHHhR3GhLvF7KCFdAV=b0VHwUE4eHVfNFEGhx_Jg@mail.gmail.com>
Message-ID: <EB2BCA6A838C7B4FB238C534ED5D7704223A3799@renexmb02.roe2.renesasmobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> On Thu, Dec 5, 2013 at 11:15 AM,  <kevin.bracey@broadcom.com> wrote:
>> Laurent Pinchart wrote:
>>> On Tuesday 03 December 2013 11:04:48 Linus Walleij wrote:
>
>>> Controlling GPIO through pinconf seems to be very twisted.
>>> Usually it is the other way around.
>>
>> By my understanding of the general pinctrl concept, we should be converting that to the lovely:
>>
>> resume:
>>     pinctrl_pm_select_default_state(dev);
>> suspend:
>>     pinctrl_pm_select_sleep_state(dev);

> This observation is correct, and I agree with this reasoning. The PM states
> are quite new and may take some time before they "sink in" in the kernel though,
> but ideally people should be using them like that (atleast IMO).

I strongly approve of the PM state concept, having seen the alternative. It slots in very nicely. I'm working on 3.10-based systems, but the pinctrl_pm_select is being cherry-picked in because it makes life so much easier.

>>> > This looks messy. The intention with the pin config subsystem is to 
>>> > break things apart and make them understandable that way, and to 
>>> > handle electronic stuff in pin config whereas driving a line 
>>> > high/low happens in the GPIO subsystem.
>>
>> Which is basically an argument against ever using PIN_CONFIG_OUTPUT 0, 
>> and the whole of "GPIO mode pitfalls" in pinctrl.txt, isn't it? It 
>> means we can't specify idle pinctrl states that drive lines. We have to do the GPIO/function shuffle.
>
> Well maybe. My point was that it is OK to drive GPIO lines as part of
> a state which is only relevant for a device driver, and where using the
> GPIO API in top would only bloat and make things hard to follow.

In practice, this is the case for the majority of the code I'm looking at. We have a large number of function drivers which have to be told their pins' GPIO numbers in platform data, solely for their suspend setting. Otherwise the pins would be entirely driven as a function, and no need for the GPIO API.

> > In my initial prototype, PIN_CONFIG_OUTPUT is only available if the 
> > gpio-mode function has been selected.

> That is even more careful code than most drivers write, so sounds very nice.

> > But maybe this could be made hidden and implicit, as per the GPIO API. 
> > Eg PIN_CONFIG_OUTPUT/PIN_CONFIG_LOW_POWER_MODE
> > implicitly selects the GPIO mux (for output/input), and 
> > PIN_CONFIG_DRIVE_PUSH_PULL/PIN_CONFIG_BIAS_HIGH_IMPEDANCE
> > restores the previously requested?
>
> I'd recommend trying to keep as close to the semantics descrived in <linux/pinctrl/pinconf-generic.h> and not add any implicit semantics.

Yeah, but the catch is that the semantics described are on the assumption that pinconf is totally orthogonal to pinmux. That's not true on this platform, and on many others. I think we need some sort of general policy on how to handle conflicting requests.

Personally, I can see the merits of both approaches -

 a) pinconf settings forcing mux to achieve the requested pin state - working to emulate orthogonality on non-orthogonal hardware;

 b) pinconf settings requiring an appropriate mux to be explicitly set for them to be available - machines/DT need to know about the mux/conf interactions.

Main problem with (a) - how do you get back to "normal" mux, and is emulation just obfuscation?
Main problem with (b) - can you guarantee mux/conf ordering?

It sounds like you prefer (b), and that is what my prototype does. It's what I originally decided, but I wasn't totally certain about how much pinconf-generic.h was intended to be a framework/language whose usage is always going to be very pin-driver-dependent, versus trying to make it an API trying to produce consistent behaviour.

>>> > This must be some misunderstanding. DT does not specify 
>>> > application/ordering semantics. It does not define sequences at all.
>>> > The device driver parsing out whatever is in the device tree has to 
>>> > take care of ordering stuff and driving the hardware.
>
>> Well, the pinctrl core does process its tables in order. So in the 
>> case where a pinconf setting may interact with a pinmux setting, the 
>> ordering that the
>> pinconf+pinmux entries get processed could be significant. Eg if
>> PIN_CONFIG_OUTPUT requires the "gpio-mode" function selected first.

> OK so we solved the similar situation where configs had to be applied in some certain order for the pin config API by passing the array of configs down to the driver and let is handle this.

Well, ordering is already preserved by the pinctrl core. As far as I can see, when you're given a table of settings through pinctrl_register_map, you keep the ordering, and when that state is selected, the settings are passed down to the driver one-by-one in original order.

If that can be guaranteed, then we may not need to be do anything else.

> So can we think of an API that gives the drivers the freedom to express or behave differently here?

I don't think it's necessary.

For DT, the driver can control ordering in its parse routines. The sh-pfc driver does already put a node's function request first in its dt_node_to_map(), which is what gpio-mode needs. If the core preserves that order, we're sorted.

For non-DT, I think it's acceptable to require that the tables should be ordered correctly by the board to meet the documented requirements of the driver - so sh-pfc board files would be required to put gpio-mode mux selections before PIN_CONFIG_OUTPUT/PIN_BIAS_CONFIG_HIGH_IMPEDANCE selections.

And either way, for glitch-free-handover, I'm also requiring that the configs always be specified - the mux won't be switched by the driver unless/until a config has been parsed and set. So in the driver - first pinmux "gpio-mode" primes it, and makes the output/high-impedance pinconfs legal. Then the pinconfs set the IE/OE/DATA bits in the GPIO registers and flip to GPIO mux.


Now, going back to the pinconfs. The naming of the configs still throws me a little. Particularly all the "bias" settings. "BIAS_HIGH_IMPEDANCE" doesn't feel like a "bias" to me. What does it mean to "BIAS_DISABLE" a "BIAS_HIGH_IMPEDANCE"? Should "BIAS_HIGH_IMPEDANCE" turn off "BIAS_PULL_UP"?

My feeling is that it would be better named just "CONFIG_HIGH_IMPEDANCE", making it a separate thing from all the other biases, akin to CONFIG_DRIVE_* and CONFIG_OUTPUT.

In summary, I think the two independent exclusive Boolean sets in the configs seem to be:

(BIAS_DISABLE | BIAS_BUS_HOLD | BIAS_PULL_DOWN | BIAS_PULL_UP | BIAS_PULL_PIN_DEFAULT)
([BIAS_]HIGH_IMPEDANCE | DRIVE_PUSH_PULL | DRIVE_OPEN_DRAIN | DRIVE_OPEN_SOURCE | LOW_POWER_MODE | OUTPUT)

And that's effectively how I'm treating them, for the 5 I'm handling for our hardware (BIAS_DISABLE|BIAS_PULL_DOWN|BIAS_PULL_UP)+(BIAS_HIGH_IMPEDANCE|OUTPUT).

Does that make sense? Maybe it's hardware specific, but at least for our case, where the pulls are non-muxed and the drives are muxed, that separation seems logical.

Regards,

Kevin
