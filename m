From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Dec 2013 11:48:07 +0100
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <EB2BCA6A838C7B4FB238C534ED5D7704223A3799@renexmb02.roe2.renesasmobile.com>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
 <10664958.tMCNRkOk1E@avalon>
 <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbzGokHHhR3GhLvF7KCFdAV=b0VHwUE4eHVfNFEGhx_Jg@mail.gmail.com>
 <EB2BCA6A838C7B4FB238C534ED5D7704223A3799@renexmb02.roe2.renesasmobile.com>
Message-ID: <CACRpkdYQyxsCWAhp9rFa3ZyfWuBqtoiMysRUEhi81XmevZjBGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 9:48 AM,  <kevin.bracey@broadcom.com> wrote:
> Linus Walleij wrote:

>> I'd recommend trying to keep as close to the semantics descrived in
>> <linux/pinctrl/pinconf-generic.h> and not add any implicit semantics.
>
> Yeah, but the catch is that the semantics described are on the assumption
> that pinconf is totally orthogonal to pinmux. That's not true on this platform,
> and on many others. I think we need some sort of general policy on how to
> handle conflicting requests.

Yes currently the kernel does assume these two things are orthogonal.
The implicit assumption is that if they are not, the driver gets to handle
it. It worked so far, but I'm all for a more general solution in the core
if we can come up with something elegant.

> Personally, I can see the merits of both approaches -
>
>  a) pinconf settings forcing mux to achieve the requested pin state -
> working to emulate orthogonality on non-orthogonal hardware;
>  b) pinconf settings requiring an appropriate mux to be explicitly set for
> them to be available - machines/DT need to know about the mux/conf
> interactions.
>
> Main problem with (a) - how do you get back to "normal" mux, and is
>  emulation just obfuscation?
> Main problem with (b) - can you guarantee mux/conf ordering?
>
> It sounds like you prefer (b),

I'm not very fond of either solution really. Can we think of a third
alternative where the pin control core is aware of the constraints and
tries to verify and/or solve the situation?

> and that is what my prototype does. It's what I
> originally decided, but I wasn't totally certain about how much
> pinconf-generic.h was intended to be a framework/language whose
> usage is always going to be very pin-driver-dependent, versus trying
> to make it an API trying to produce consistent behaviour.

The idea is to make the code as reusable as possible with
as many checks for physical constraints as possible, so as
to help the driver writers.

To achieve this the generic pin config tries to establish a
semantic on a best effort basis, sometimes leaving "fill in the blanks"
etc, as we're doing engineering not mathematics.

It currently has no concept of sequences or ordering however,
none whatsoever, all such details are left to the driver to
figure out. I don't know if this is good or bad.

>>> Well, the pinctrl core does process its tables in order. So in the
>>> case where a pinconf setting may interact with a pinmux setting, the
>>> ordering that the
>>> pinconf+pinmux entries get processed could be significant. Eg if
>>> PIN_CONFIG_OUTPUT requires the "gpio-mode" function selected first.
>
>> OK so we solved the similar situation where configs had to be applied
>> in some certain order for the pin config API by passing the array of
>> configs down to the driver and let is handle this.
>
> Well, ordering is already preserved by the pinctrl core. As far as I can
> see, when you're given a table of settings through pinctrl_register_map,
> you keep the ordering, and when that state is selected, the settings are
> passed down to the driver one-by-one in original order.

OK I see...

> If that can be guaranteed, then we may not need to be do anything else.

I suspect people are depending on this already to varying extent,
depending on the sophistication of the system HW.

>> So can we think of an API that gives the drivers the freedom to express
>> or behave differently here?
>
> I don't think it's necessary.
>
> For DT, the driver can control ordering in its parse routines. The sh-pfc
> driver does already put a node's function request first in its
>  dt_node_to_map(), which is what gpio-mode needs. If the core preserves
> that order, we're sorted.

OK I'm sort of aligned on this.

> For non-DT, I think it's acceptable to require that the tables should be
> ordered correctly by the board to meet the documented requirements
> of the driver - so sh-pfc board files would be required to put gpio-mode
> mux selections before
> PIN_CONFIG_OUTPUT/PIN_BIAS_CONFIG_HIGH_IMPEDANCE selections.

This seems like the most invasive action that needs to be taken is
a patch to Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
stating this, and the discussion needs to be with the DT people rather
than me I think. I cannot say much about ordering semantics in the
DTB, but to some extent I think it is already there in arrays and such.

> And either way, for glitch-free-handover, I'm also requiring that the
> configs always be specified - the mux won't be switched by the driver
> unless/until a config has been parsed and set. So in the driver - first
> pinmux "gpio-mode" primes it, and makes the output/high-impedance
> pinconfs legal. Then the pinconfs set the IE/OE/DATA bits in the GPIO
> registers and flip to GPIO mux.

OK if this is a driver detail it's all up to the driver writers.

> Now, going back to the pinconfs. The naming of the configs still throws
> me a little. Particularly all the "bias" settings. "BIAS_HIGH_IMPEDANCE"
> doesn't feel like a "bias" to me. What does it mean to "BIAS_DISABLE"
> a "BIAS_HIGH_IMPEDANCE"?

It is defined in the header file:

 * @PIN_CONFIG_BIAS_DISABLE: disable any pin bias on the pin, a
 *      transition from say pull-up to pull-down implies that you disable
 *      pull-up in the process, this setting disables all biasing.
 * @PIN_CONFIG_BIAS_HIGH_IMPEDANCE: the pin will be set to a high impedance
 *      mode, also know as "third-state" (tristate) or "high-Z" or "floating".
 *      On output pins this effectively disconnects the pin, which is useful
 *      if for example some other pin is going to drive the signal connected
 *      to it for a while. Pins used for input are usually always high
 *      impedance.

Being able to disable biasing on a pin, i.e. by disconnecting
any pull-up/pull-downs through software does not imply that
it is necessarily in high-Z mode after that - this depends on any
additional hardwired electronics, especially if the pin has been
tailored for a specific purpose. It may very often be high-Z
but this is a simplified view of the world and we cannot
guarantee that. Not always are all aspects of a pin under
software control.

> Should "BIAS_HIGH_IMPEDANCE" turn off "BIAS_PULL_UP"?

It is *currently* up to the driver not to allow things that make
no electrical sense, or take evasive action. But I can think of
doing code in the core actually doing this check if it makes
sense to most. Writing and testing patches for this is probably
more fruitful than just discussing it.

> My feeling is that it would be better named just
>  "CONFIG_HIGH_IMPEDANCE", making it a separate thing from
> all the other biases, akin to CONFIG_DRIVE_* and CONFIG_OUTPUT.

The documentation clearly states that this is the same as floating
or tristate.

I named it with the *BIAS* substring since a high-Z bias can
be conceived as a pull-up or pull-down with an infinite resistance.
I don't see any reason to change this, it would just lead to
a massive refactoring of all existing drivers using this, plus it
is already represented in device trees using "bias-high-impedance"
which cannot be changed as DT bindings are perpetual, changing
this would just cause chaos. I suggest to take a deep breath
and live with this terminology. :-)

> In summary, I think the two independent exclusive Boolean sets in the configs seem to be:
>
> (BIAS_DISABLE | BIAS_BUS_HOLD | BIAS_PULL_DOWN | BIAS_PULL_UP | BIAS_PULL_PIN_DEFAULT)
> ([BIAS_]HIGH_IMPEDANCE | DRIVE_PUSH_PULL | DRIVE_OPEN_DRAIN | DRIVE_OPEN_SOURCE | LOW_POWER_MODE | OUTPUT)
>
> And that's effectively how I'm treating them, for the 5 I'm handling for our hardware
> (BIAS_DISABLE|BIAS_PULL_DOWN|BIAS_PULL_UP)+(BIAS_HIGH_IMPEDANCE|OUTPUT).
>
> Does that make sense? Maybe it's hardware specific, but at least for our case,
> where the pulls are non-muxed and the drives are muxed, that separation seems logical.

We have not established any such semantic. It is also mostly
uselesss to do that through documentation or discussion about
it, as this doesn't really have any influence on what people
do in practice.

The only way to have a meaningful discussion around it is
by proposing a patch to drivers/pinctrl/pinconf-generic.c
actually *enforcing* that semantic, and have it tested and
accepted. That is the only way any such distinction would
make sense in practice.

Then we can state the obvious in the documentation...

I would really like to see such a patch, because what
you're saying makes a lot of sense, electrically speaking.
But I expect it to need some discussing and testing
and possibly debugging of existing drivers.

If you want to enforce such a semantic in a certain pin
config driver - i.e. looking for forbidden states in the
set_config() callback when looping over the requested
settings - this is of course perfectly fine.

Yours,
Linus Walleij
