From: kevin.bracey@broadcom.com (kevin.bracey at broadcom.com)
Date: Thu, 19 Dec 2013 10:49:46 +0000
Subject: pinctrl - detailed gpio-mode pinconf design
In-Reply-To: <CACRpkdYQyxsCWAhp9rFa3ZyfWuBqtoiMysRUEhi81XmevZjBGA@mail.gmail.com>
References: <EB2BCA6A838C7B4FB238C534ED5D770422395F79@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbpv3Vjt-=3_1XbrGaiEYqCgtJCGppvoL48gad+7Licdg@mail.gmail.com>
 <10664958.tMCNRkOk1E@avalon>
 <EB2BCA6A838C7B4FB238C534ED5D77042239D2A9@renexmb02.roe2.renesasmobile.com>
 <CACRpkdbzGokHHhR3GhLvF7KCFdAV=b0VHwUE4eHVfNFEGhx_Jg@mail.gmail.com>
 <EB2BCA6A838C7B4FB238C534ED5D7704223A3799@renexmb02.roe2.renesasmobile.com>
 <CACRpkdYQyxsCWAhp9rFa3ZyfWuBqtoiMysRUEhi81XmevZjBGA@mail.gmail.com>
Message-ID: <EB2BCA6A838C7B4FB238C534ED5D77045E001472@renexmb02.roe2.renesasmobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Linus Walleij wrote:
> On Fri, Dec 13, 2013 at 9:48 AM,  <kevin.bracey@broadcom.com> wrote:
> > Personally, I can see the merits of both approaches -
> >
> >  a) pinconf settings forcing mux to achieve the requested pin state - 
> > working to emulate orthogonality on non-orthogonal hardware;
> >  b) pinconf settings requiring an appropriate mux to be explicitly set 
> > for them to be available - machines/DT need to know about the mux/conf 
> > interactions.
> >
> > Main problem with (a) - how do you get back to "normal" mux, and is  
> > emulation just obfuscation?
> > Main problem with (b) - can you guarantee mux/conf ordering?
> 
> I'm not very fond of either solution really. Can we think of a third alternative
> where the pin control core is aware of the constraints and tries to verify and/or
> solve the situation?

I've realised there's one existing design issue that complicates this - I'd managed to miss it up until just now, when I tried to add some fixed ties to some pins in my DT.

Pinmux is per-group only, while pinconf is per-pin. So there's no way for consumers to request "gpio-mode" for a loose pin, and the core currently couldn't do it either.

So far this has been not been an issue for all my "sleep" states which manually flip the entirety of a function group to gpio-mode, but it can't handle an odd pin hog. (And the "default no-driver states" that have also been discussed recently in another thread would also need to be applied per-pin to mop up driverless gaps in pins).

That certainly does push me away from option (b) of requiring explicit gpio-mode function selection - it rules out per-pin operation. And this problem also limits what the core could do to solve conf/mux constraints; which leaves just verification.

Maybe we just have to make do with:

c) pinconf settings that would require the driver to internally select GPIO mux can only be selected if no pinmux function (or GPIO API?) is enabled on the pin.

I don't think there's a benefit to that test being enforced by the core - you'd have to have a way for the driver to specify the restrictions, and I don't think that's any easier or more reliable than the driver checking in pinconf_ops::pin_config_set.

That would then make this pair valid for my case:

	default {
		renesas,group="foo";
		renesas,function="bar";
	};
	sleep {
		renesas,group="foo";
		output-high;
	};

as the core will disable the group's function when it selects sleep state, helpfully before processing the new state's configs; and if the pinmux_ops::disable is electrically a no-op, as it currently is for sh-pfc, then that's good for glitch-free handover.

Now, on some other pinctrl driver, where the output isn't behind the mux, they might require a pinconf setting in the default state to undo the output-high; I guess they might need to explicitly put "drive-xxx" or "bias-high-impedance" properties. But in this case, I rely on it being implied/forced by the function select. (And neither property would be accepted anyway - drive-xxx isn't implemented at all, and bias-high-impedance would be refused with a function, as we have no control).

That now feels relatively neat and logical to me.

> > Now, going back to the pinconfs. The naming of the configs still 
> > throws me a little. Particularly all the "bias" settings. "BIAS_HIGH_IMPEDANCE"
> > doesn't feel like a "bias" to me. What does it mean to "BIAS_DISABLE"
> > a "BIAS_HIGH_IMPEDANCE"?
> 
[snip]
> Being able to disable biasing on a pin, i.e. by disconnecting any pull-up/pull-downs
> through software does not imply that it is necessarily in high-Z mode after that -
> this depends on any additional hardwired electronics, especially if the pin has been
> tailored for a specific purpose. It may very often be high-Z but this is a simplified
> view of the world and we cannot guarantee that. Not always are all aspects of a pin
> under software control.

Makes sense, thanks.

> > Should "BIAS_HIGH_IMPEDANCE" turn off "BIAS_PULL_UP"?
>
> It is *currently* up to the driver not to allow things that make no electrical sense, or take evasive action.

But does that make electrical sense or not? Is this a meaningfuly request to internally combine a pull with an otherwise-high-impedance (ie non-output) pin, or nonsense because overall, an external pin can't both be pulling up and high-impedance? Are they orthogonal settings, or exclusive?

Because all these settings are booleans, (mostly) without "disables", they can't be used to toggle between states without a definition of the exclusive sets (at least as of 3.10; 3.12 has changed things - see below). I think that's what needs to be pinned down here. There will some settings that will be mutually exclusive because of hardware limitations. But some of the exclusion has to be by definition. At least before 3.12, where we have to rely on exclusion to turn off the previous state.

I'm still not fully understanding the definitions here. I just don't have a feel for what pinconf state descriptions for the "ideal" maximally-flexible hardware with the "ideal" driver should look like.

Here's the possible implementation of the pinconfs on our hardware:

bias-disable:        PU:=0 PD:=0                                   (PU/D=Pull Up/Down)
bias-pull-up:        PU:=1 PD:=0 (MUX:=GPIO OE:=0 if no func?)     (OE=Output Enable)
bias-pull-down:      PU:=0 PD:=1 (MUX:=GPIO OE:=0 if no func?)
bias-high-impedance: MUX:=GPIO OE:=0         (PU:=0 PD:=0?) 
output-low:          MUX:=GPIO OE:=1 DATA:=0 (PU:=0 PD:=0?)
output-high:         MUX:=GPIO OE:=1 DATA:=1 (PU:=0 PD:=0?)

but I still can't figure out whether setting the controls in parentheses is desirable. Either with or without all the bits in brackets we would get a logically consistent and useable system, but they're two different possible "APIs" for our hardware, and I don't know which API is intended. They lead to two different DT descriptions.

Say I wanted two pinconf-only states that switched between driving low, and weakly pulling up. Should that be expressed in the DT/pinctrl tables like:

	state_a {
		output-low;	 // OE:=1
	};
	state_b {
		bias-pull-up; // OE:=0 implied by bias-pull-up? Pulling implies not driving?
		// Or is OE:=0 implied by lack of output-xxx in this state (possible from 3.12)?
	};

Or should it look like

	state_a {
		bias-disable;  // output-low won't touch the pulls
		output-low;    // OE:=1
	};
	state_b {
		bias-pull-up;        // only sets PU/PD - pulls are orthogonal to OE
		bias-high-impedance; // necessary to set OE:=0
	};

I genuinely have no idea whether combining those two bias settings in state_b is necessary or nonsense. The former feels neater as a consumer, but the latter's orthogonality is also compelling, despite the odd-looking "bias" combo.

> If you want to enforce such a semantic in a certain pin config driver - i.e.
> looking for forbidden states in the set_config() callback when looping over
> the requested settings - this is of course perfectly fine.

Hmm, this is an interesting point.

Up to now I've been viewing configs as being applied one-at-a-time, with no indication to the driver as to when the core has actually started selecting a new state. (Which is the way it is in 3.10, which is where I'm currently working). So there the driver can't tell if seeing "pull-up" followed by "pull-down" is an illegal combination within one state, or if it's a valid switch between two states.

It also means the need for exclusions to be part of the defined API is important, as we have to know how to make sure the configs in state B override all the configs in state A.

However, since commits ad42fc6c8 ("rip out the direct pinconf API") in 3.11 and 03b054e96 ("Pass all configs to driver on pin_config_set()") in 3.12, we now have the possibility that the driver could assume each pin_config_set() call represents a complete, new state.

So implicitly, any array that lacked "output-xxx" could be interpreted to mean "output not required", rather than needing to worry about which configs actually turn off the "output-xxx" from the previous state.

Corollary - given that view, it would seem logical for the core to automatically set an empty config array if the old state had a config array for a pin/group and the new one doesn't, akin to what it does for functions.

Kevin
