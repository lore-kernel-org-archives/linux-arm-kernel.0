From: swarren@nvidia.com (Stephen Warren)
Date: Mon, 23 Jan 2012 15:08:31 -0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120123210052.GS22818@atomide.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120123210052.GS22818@atomide.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178CB81C0D@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren wrote at Monday, January 23, 2012 2:01 PM:
> This mostly looks pretty good to me, few more comments below.
> 
> * Stephen Warren <swarren@nvidia.com> [120120 13:51]:
> > Here's V2 of my pinmux binding proposal, after incorporating some feedback
> > from Shawn Guo and Dong Aisheng. Main changes:
> >
> > 1) Require the "pin config" nodes the be children of the pinmux controller
> >    node, rather than allowing them to alternatively be children of the
> >    device node that's using them. This allows removal of the pin controller
> >    phandle as the first entry in each specifier.
> 
> If you really want to leave out the phandle for each mux entry, this would
> require supporting multiple "pin config" entries in a device driver node.

Yes. And that's already supported using the pinctrl-entries property;
you can reference n nodes at once for each named state in pinctrl-names,
and each of those nodes could easily be from a different pin controller.

> >                 pmx_sdhci_active: pinconfig-sdhci-active {
> >                         /*
> >                          * In each of these nodes, both the mux and config
> >                          * properties are optional. This node represents the
> >                          * additions to pmx_sdhci that are specific to an
> >                          * active state. In this case, only pin configuration
> >                          * settings are different.
> >                          */
> >                         config =
> >                                 <TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_TRISTATE 0>
> >                                 <TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_TRISTATE 0>;
> >                 };
> >                 pmx_sdhci_standby: pinconfig-sdhci-standby {
> >                         config =
> >                                 <TEGRA_PMX_PG_DTA TEGRA_PMX_CONF_TRISTATE 1>
> >                                 <TEGRA_PMX_PG_DTD TEGRA_PMX_CONF_TRISTATE 1>;
> >                 };
> 
> After thinking about this a bit more, I'm now thinking that we should
> probably only describe the active state in the device tree to keep things
> simple.
> 
> Anything PM related could be initialized later on during the boot by the
> device driver, or even from userspace using /lib/firmware or /sys entries.
> This would cut down the device tree bloat quite a bit.

I think it makes sense to describe everything in one place. It's much
easier to ensure everything is consistent and correct if you don't have
to cross-check two sources of data for the same thing.

> Setting the initial state from device tree makes sense, but I'm afraid
> the standby and off states will require driver interaction depending on
> how the user wants to configure the system.
> 
> For example, allowing a device to wake up a system might be user
> configurable option, such as "Wake up on tapping the touchscreen".

That can be supported pretty easily.

The driver for a simple device can require two named states: "active"
and "standby". In your more complex example, the driver can require
three named states: "active", "standby", "standby-wake". During suspend,
it'll simply select the appropriate of the latter two states based on
user request.

You can even retrofit this capability to a previously simple driver that
Originally did:

suspend() {
    pinconf_select(dev, "suspend");
}

To make it do the following instead:

suspend() {
    if (wake)
        state = "suspend-wake";
    else
        state = "suspend-nowake";
    err = pinconf_select(dev, state);
    if (err < 0)
        pinconf_select(dev, "suspend";
}

... which should allow old device trees to work fine, but new device
trees to specify a different if they need.

> Then I'd rather not use "config" at all, and just put the value for
> initial state mux register(s) in the mux to avoid repeating the same data
> multiple time. Looks like with the mux + config/mux-config option you
> need to duplicate at least TEGRA_PMX_PG_DTA.
>
> BTW, maybe the name "config" should probably be "mux-config" instead?

Mux and config are two unrelated things though. Mux is the function
(signal, alternate function, mission mode, ...) that is selected for
the pin/group in question. Config is anything else, but explicitly not
mux, such as pull-up, pull-down, tri-state, drive-strength, etc.

> >                 /*
> >                  * Each device node contains a few properties to describe
> >                  * the named pinmux states that are available to it.
> >                  *
> >                  * The binding for the device node specifies the state names
> >                  * that must be described; common examples such as "default"
> >                  * or "active" and "suspend" may be universal, but the IO
> >                  * protocol that a device supports may demand that more
> >                  * states be defined, such as "active-12mhz", "active-50mhz",
> >                  * "suspend". Drivers request these named states e.g. using
> >                  * pinctrl's pinmux_get("state_name") API.
> >                  *
> >                  * pinctrl-names lists the available state names.
> >                  *
> >                  * Unlike the common clock binding, I assume here that states
> >                  * are always requested by name. If we don't like that idea,
> >                  * we'd could make this property optional, and add a new API
> >                  * pinmux_get(state_id) to the pinctrl subsystem.
> >                  */
> >                 pinctrl-names = "active", "suspend";
> 
> If we only allow describing the initial state in device tree, then we can
> leave out pinctrl-names, and assume the setting is always the initial bootup
> state desired.

That's true, but people have already discussed the usefulness of having
multiple named states, e.g. an SDHCI controller that needs different pin
configuration (perhaps drive strength or slew rate?) depending on the
clock rate of the SD interface itself.

> So to summarize: I suggest we'll just stick to basics to get the system
> booting and devices working using device tree. In most cases the device
> drivers should be able to configure the suspend and off states in a generic
> way using pinctrl API. Everything else, like debugging, we can probably
> do with userspace tools.

But how will they configure suspend/off states in a generic way using the
pinctrl API if the pinctrl API has no way of knowing how to configure the
pins in suspend...

> This would mean just using a minimal subset of your binding, probably
> very close to what you originally suggested.

-- 
nvpublic
