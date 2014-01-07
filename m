From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 7 Jan 2014 17:40:30 +0100
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <EB2BCA6A838C7B4FB238C534ED5D77045E001472@renexmb02.roe2.renesasmobile.com>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
 <10664958.tMCNRkOk1E@avalon>
 <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbzGokHHhR3GhLvF7KCFdAV=b0VHwUE4eHVfNFEGhx_Jg@mail.gmail.com>
 <EB2BCA6A838C7B4FB238C534ED5D7704223A3799@renexmb02.roe2.renesasmobile.com>
 <CACRpkdYQyxsCWAhp9rFa3ZyfWuBqtoiMysRUEhi81XmevZjBGA@mail.gmail.com>
 <EB2BCA6A838C7B4FB238C534ED5D77045E001472@renexmb02.roe2.renesasmobile.com>
Message-ID: <CACRpkdYGjz50fxr2KAG7gQ88F_dWCi+NGFTLDP0BHvdYbxohkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 19, 2013 at 11:49 AM,  <kevin.bracey@broadcom.com> wrote:
>> Linus Walleij wrote:

>> > Main problem with (a) - how do you get back to "normal" mux, and is
>> > emulation just obfuscation?
>> > Main problem with (b) - can you guarantee mux/conf ordering?
>>
>> I'm not very fond of either solution really. Can we think of a third alternative
>> where the pin control core is aware of the constraints and tries to verify and/or
>> solve the situation?
>
> I've realised there's one existing design issue that complicates this - I'd managed to miss it up until just now, when I tried to add some fixed ties to some pins in my DT.
>
> Pinmux is per-group only, while pinconf is per-pin. So there's no way for consumers to request "gpio-mode" for a loose pin, and the core currently couldn't do it either.

I don't know what you mean by this. It is possible to use the same pin for
GPIO and a certain device at the same time even, since this may be possible
in hardware (e.g. to use a GPIO to "spy" on a device line).

Also define what you mean by "gpio-mode", as can be seen from
Documentation/pinctrl.txt section "GPIO mode pitfalls" this is a
dangerously ambigous term.

> So far this has been not been an issue for all my "sleep" states which manually

What do you mean by "manually" here? That is a very unclear term that
I prefer that we do not use at all in the kernel. There is no man inside
the system.

> flip the entirety of a function group to gpio-mode, but it can't handle an odd
> pin hog. (And the "default no-driver states" that have also been discussed
> recently in another thread would also need to be applied per-pin to mop
> up driverless gaps in pins).

Hm I might understand what a "default no-driver state" is but ... sorry
I have a hard time following this paragraph :-/

What is an "odd pin hog"?

> Maybe we just have to make do with:
>
> c) pinconf settings that would require the driver to internally select GPIO mux can only be selected if no pinmux function (or GPIO API?) is enabled on the pin.

I don't understand what you mean by this, but I guess you're after
som driver intrinsic detail so let's see the patch so we can see
clearly what you mean here.

>> > Should "BIAS_HIGH_IMPEDANCE" turn off "BIAS_PULL_UP"?
>>
>> It is *currently* up to the driver not to allow things that make no electrical sense, or take evasive action.
>
> But does that make electrical sense or not?

It makes sense if the HW has two knobs: one for setting pull up
and one for setting the pin into High-Z.

If it has only one or the other, there is not much it can do anyway.

> Is this a meaningfuly request to internally combine a pull with an
> otherwise-high-impedance (ie non-output) pin, or nonsense because
> overall, an external pin can't both be pulling up and high-impedance?
> Are they orthogonal settings, or exclusive?

They may be orthogonal in the hardware register sense, i.e. you
can turn on both at the same time by setting two bits, but still they are
not orthogonal in the electrical sense, because the outcome is
ambigous. What happens if you enable both at the same time
must be understood by reading the HW documentation or talking
to the HW engineer who implemented it.

> Because all these settings are booleans, (mostly) without "disables",
> they can't be used to toggle between states without a definition of
> the exclusive sets (at least as of 3.10; 3.12 has changed things -
> see below). I think that's what needs to be pinned down here. There
> will some settings that will be mutually exclusive because of hardware
> limitations. But some of the exclusion has to be by definition. At least
> before 3.12, where we have to rely on exclusion to turn off the previous
> state.

OK I'm following. How do you plan to implement this?

> I'm still not fully understanding the definitions here. I just don't
> have a feel for what pinconf state descriptions for the "ideal"
> maximally-flexible hardware with the "ideal" driver should look like.

As no such hardware exist this is a question relating to the
ideal world.

Bringing such mental figures into the resoning invokes Plato's
metaphor of the Cave and the debate between philosophical idealism
and philisophical realism.
http://en.wikipedia.org/wiki/Idealism
http://en.wikipedia.org/wiki/Philosophical_realism
This relates to mathematical formalism vs. Platonism and whether
our mental models are inventions or discoveries.

I don't know such stuff! All I want to do is manage this subsystem
for the set of pin controllers out there and close the necessary
gaps to make it useful in practice. This is called pragmatism.
http://en.wikipedia.org/wiki/Pragmatism

So let's keep a pragmatic stance - rough consensus and running
code.

> Here's the possible implementation of the pinconfs on our hardware:
>
> bias-disable:        PU:=0 PD:=0                                   (PU/D=Pull Up/Down)
> bias-pull-up:        PU:=1 PD:=0 (MUX:=GPIO OE:=0 if no func?)     (OE=Output Enable)
> bias-pull-down:      PU:=0 PD:=1 (MUX:=GPIO OE:=0 if no func?)
> bias-high-impedance: MUX:=GPIO OE:=0         (PU:=0 PD:=0?)
> output-low:          MUX:=GPIO OE:=1 DATA:=0 (PU:=0 PD:=0?)
> output-high:         MUX:=GPIO OE:=1 DATA:=1 (PU:=0 PD:=0?)
>
> but I still can't figure out whether setting the controls in parentheses is desirable.

The documentation should say, else I think you should ask a renesas
HW engineer about that. I don't know how that hardware will react
to some of these settings...

> Either with or without all the bits in brackets we would get a logically
> consistent and useable system, but they're two different possible
> "APIs" for our hardware, and I don't know which API is intended.

What are the two APIs you're referring to here? Pinctrl and
GPIO?

Since both aspects are joined in the subsystem and even in the
same driver file (I think) it is perfectly possible to handle this
in the PFC driver.

> They lead to two different DT descriptions.
>
> Say I wanted two pinconf-only states that switched between driving low, and weakly pulling up. Should that be expressed in the DT/pinctrl tables like:
>
>         state_a {
>                 output-low;      // OE:=1
>         };
>         state_b {
>                 bias-pull-up; // OE:=0 implied by bias-pull-up? Pulling implies not driving?
>                 // Or is OE:=0 implied by lack of output-xxx in this state (possible from 3.12)?
>         };
>
> Or should it look like
>
>         state_a {
>                 bias-disable;  // output-low won't touch the pulls
>                 output-low;    // OE:=1
>         };
>         state_b {
>                 bias-pull-up;        // only sets PU/PD - pulls are orthogonal to OE
>                 bias-high-impedance; // necessary to set OE:=0
>         };

>From a DT code parsing point of view I think both are OK?

I think the best approach is that the driver check both current
and requested state in the .pin_config_set() callback.

> I genuinely have no idea whether combining those two bias settings in state_b is
> necessary or nonsense.

You need to know this first before developing code for
driving the hardware.

> The former feels neater as a consumer, but the latter's orthogonality is also
> compelling, despite the odd-looking "bias" combo.

The framework does not constrain which version you use, and
any hard constraints should probably be in the driver.

Maybe the generic pinconf core could print warnings about
strange configurations though, maybe as a debug option?

> Up to now I've been viewing configs as being applied one-at-a-time,

They are *not* applied one-at-a-time. The driver is given an
array of configs and can inspect this array and take decisions
on whether it is possible to satisfy this config and in case it
cannot it may return an error code.

> with no indication to the driver as to when the core has actually
> started selecting a new state. (Which is the way it is in 3.10, which
> is where I'm currently working).

So don't use such ancient codebase, I'm developing v3.14 now.

> It also means the need for exclusions to be part of the defined
> API is important, as we have to know how to make sure the
> configs in state B override all the configs in state A.

As mentioned this is for the driver to handle.

> Corollary - given that view, it would seem logical for the core to
> automatically set an empty config array if the old state had a
> config array for a pin/group and the new one doesn't, akin to
> what it does for functions.

Please elaborate with an example what you mean by this.

Yours,
Linus Walleij
