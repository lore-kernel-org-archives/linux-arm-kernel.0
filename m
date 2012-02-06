From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 6 Feb 2012 18:29:35 +0100
Subject: An extremely simplified pinctrl bindings proposal
In-Reply-To: <4F2F6AE2.1040504@nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF178E5D3160@HQMAIL01.nvidia.com>
 <CACRpkdahin4srDh7dphgvq306gjz7CGP=h4dVkUY+w0z0wpXRQ@mail.gmail.com>
 <4F2F6AE2.1040504@nvidia.com>
Message-ID: <CACRpkdbtTPSoX1x4aBtNVGZ2Qex9t77D09V9JgON_jfShQdx6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2012 at 6:53 AM, Stephen Warren <swarren@nvidia.com> wrote:

> I think the main argument to call it pinctrl/pinmux still is to provide
> some named API and reason for drivers to invoke when they wanted to make
> use of the feature.
>
> In other words, it's pretty easy to see why and when a driver would
> invoke a pin control API to configure the HW surrounding the HW module
> that driver controls. If we don't call that pinctrl, what else might we
> call it? That said, I'm sure we can come up with some reasonable more
> general-purpose name.

I feel pinctrl would be misleading and overly specific. Maybe something
like "hwstates" or "initvectors" or similar is more to the point. Or
just "soc-bios" :-)

An elegant way of doing it would be to hide the current pinctrl calls
behind the new API, say

hws = hardware_state_get(dev);
hardware_state_enable(hws);
hardware_state_disable(hws);
hardware_state_put(hws);

Then these can boil down to simple register read/writes or divert to
pinctrl or pinconfig.

>> A controlled set of register read/writes and maybe also conditionals
>> (...)
>
> I think anything beyond a simple linear list of register writes would
> get a /lot/ of pushback. See for example Grant's comments in one of the
> links I referenced:

OK. Keeping it simple is best then I guess.

> I can imagine the data including flags like 8/16/32/64-bit register
> accesses, or read-modify-write vs. just write (i.e. do we need to
> include a mask or not) being reasonable, but any state, looping, delay,
> conditionals etc. being nak'd.

Sure.

I have this mux on the AB8500 on the Ux500 that is on I2C.
So this off-chip device can mux its pins between GPIO and some
other functions. So I'd need something that can provide a
read/write function handle or so rather than plain register writes.
Or is this concept only for memory-mapped stuff?

>> While I would probably mourn the death of sematics I also see
>> that if the goal is to get huge static data sets out of the kernel,
>> something like this may be the best way to get there.
>
> Yes, the loss of semantics also doesn't entirely appeal to me. However,
> I wonder if the other advantages don't outweigh that.

I will certainly finalize the pinctrl subsystem as-is, adding the
pin configurations states as the last major piece. If for nothing
else it provides some understanding of the problem space.

I think we should keep both for the time being and consider the
alternative approach when patches appear. So if/when someone
creates a new subsystem like this, drivers can move over to it on a
per-driver basis. If there are zero drivers left in pinctrl it can be
deleted.

Yours,
Linus Walleij
