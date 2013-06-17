From: tony@atomide.com (Tony Lindgren)
Date: Mon, 17 Jun 2013 00:20:22 -0700
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <51BB3A2C.608@wwwdotorg.org>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
 <51BB3A2C.608@wwwdotorg.org>
Message-ID: <20130617072021.GB4465@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Stephen Warren <swarren@wwwdotorg.org> [130614 08:49]:
> On 06/13/2013 02:34 PM, Linus Walleij wrote:
> > On Thu, Jun 13, 2013 at 9:39 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> >> On 06/11/2013 01:59 PM, Linus Walleij wrote:
> >>> From: Linus Walleij <linus.walleij@linaro.org>
> >>>
> >>> This document snippet tries to be helpful and define the pin
> >>> PM states and helpers, and how they should be used to create
> >>> some kind of common ontology around this.
> >>
> >> Oops. I haven't been keeping up well. I propose we hold off on this
> >> patch for a short while until the other thread on this topic is finalized.
> > 
> > Isn't it better if I split it?
> > 
> > Most of this doc is about the default/sleep/idle states and
> > how that relates to runtime PM, and that seems to be
> > uncontroversial.
> 
> I would tend to prefer sorting out the issue fully, then documenting it
> once. This avoids churn.
> 
> I would consider the complete set of standard pinctrl states as an
> interface. If we add states, that actually changes the interface even
> though it might not affect the definition of any individual states.
> Since this also impacts DT which is supposed to be a stable ABI (or at
> least evolve in a backwards-compatible fashion), it seems better to get
> it right once.

Agreed, let's sort this out before it's too much of a pain to change.
Below are some reasonings and examples that I'm hoping just might do the
trick.

First, I think the concept of remuxing (or even checking) _all_ the pins
for a consumer device is wrong on most if not all hardware. For past 10
years I have not seen a case where _all_ the pins for a device would need
to be remuxed for any reason.

This means the named states "default", "idle" and "sleep" cannot represent
the needs of hardware. So need to have a bit finer granularity for this.

Maybe let's again try to first list all the known cases where we need to
do remuxing, and the pins we need to remux?

Below are the pin remuxing cases I'm aware of:

1. Remux UART RX pin of a device for a wake-up event

2. Remux whatever device interrupt line to a GPIO input for wake-up

3. Remux audio jack between UART RX and TX to provide a debug console

4. Remux MMC CMD and DAT lines for sleep with pulls to avoid device
   from resetting with lines floating or to save power

Please list any further use cases that I'm not familiar with. I'd like
to hear how messed up this remuxing business can get :)

Then for dealing with the above examples, I think we already have a
pretty good setup in pinctrl framework to deal with this with the
named modes. But I think that to do this properly with the named
modes we should have named modes like the following:

"static" && ("active" || "idle")
"static" && ("rx" || "tx")

Here the "static" pins would be set during driver probe and never
need to change until the driver is unloaded. This is close to what we
currently call "default". But we should probably make it clear that
these will not change to avoid confusion. See below for more info.

The the non-static states like "active"/"idle", or "rx"/"tx", can
be set in addition to "static", but they should not be subsets of
"static" to avoid the issues Stephen described earlier. This way we
allow the named modes to do the work for us while protecting the
claimed pins.

Note also how the remuxing needs are not PM related for the RX/TX case.
Also, the "static" + "active" set would have to be set also in many
cases even if PM is not enabled, while "idle" would be only needed if
we have PM enabled.

Then, based on what I've seen "idle" and "sleep" pins have been
the same. But I guess it's possible that some hardware needs different
states for "idle" and "sleep"? In that case we'd have to have:

"static" && ("active || "idle" || "sleep")

Then iff a device really needs all it's pins remuxed for idle, that
device should have the following sets:

"static"	0 pins
"active"	all pins when running
"idle"		all pins when idle
"sleep"		all pins when sleep if different from idle

Cheers,

Tony
