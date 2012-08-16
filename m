From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 16 Aug 2012 13:51:54 -0500
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120816033006.GA11999@shlinux2.ap.freescale.net>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
 <20120816033006.GA11999@shlinux2.ap.freescale.net>
Message-ID: <CAKGA1bkDL=-NCvSNSb8t4LA6wjfDTi-L042ix6n-nEZpap5szQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:30 PM, Dong Aisheng <b29396@freescale.com> wrote:
> On Wed, Aug 15, 2012 at 09:59:50PM +0800, Shawn Guo wrote:
> ...
>> > Another known issue is that via this way, that means the pinctrl subsystem
>> > can only see the using pads, this is a bit not align with the pinctrl
>> > subsystem design. No sure if Linus would like to see it.
>> >
>> I do not quite follow on this.  The "enum imx51_pads" will still be
>> there, so all the pads will still be visible to the pinctrl system.
>
> Sorry, i did not describe it accurately.
> The problem is that those pins are visible to pinctrl subystem, but the pinctrl
> subsystem can not manage them all.

Why not? It only needs to "manage" the ones the DT defines or the ones
you specify.

The rest of the data is there as a convenience for debug and naming of
pins, a cross-reference that could be compiled out for non-debug
kernels since there's not a lot of point wasting 64kb or possibly more
of memory on naming every pin on the chip statically. The name of the
pad is in pin_desc and can be marked dynamic (a small function at
get_pin_desc can work out the string and vsprintf the correct string,
and put_pin_desc can free it again). The name of the groups/configs
etc. is also dynamic, no?

> Because for the way proposed, all the pin's basic properties like mux_reg, config_reg
> are parsed from device tree at runtime.

The ones you want to perform anyway.

> If a pin is not used in device tree, the driver can not know this pin's
> corresponding registers.

It would. I'm not saying get rid of the table, just remove the
redundancy - if you don't reference pins by "arbitrary id" anymore,
why include an arbitrary id?

At the moment you've got a redundant list of enums to define offsets
into an array which is.. an array anyway. You can always work out the
position in the array from it's address and the structure size
(offsetof or some clever math).

If you're not referencing the pin by index into the array anyway which
is bad behavior, the other data serves as cross-reference - the
register offsets defined are unique to the pin in question. So the
enums go away, and the first element of imx_pin_reg goes away. The
rest is just debug data.

The static pinctrl_pin_desc array can go away as well. As it stands
it's a waste of memory - MX6Q_PAD_ in every string cannot be merged by
the compiler, that's 329 multiplied 9 bytes you're compiling into the
kernel redundantly. The name can be referenced - I'm gonna use
MX6Q_PAD_SD4_CMD__SD4_CMD as an example here to reduce confusion.

> Then imx_pinconf_dbg_show in current driver may need change since it does not
> support show all pins's config value.

You will need the huge static array to cross-reference the pins
canonical name and generated configuration, sure, I don't want to
remove it, just.. not use array index to reference it from the device
tree.

If you imagine building a string like "MX6Q_PAD_" "SD4_CMD" "__"
"SD4_CMD" - this is defined by the SoC in use and the DT binding, the
default pad name from the docs, a couple underscores to match the old
iomux-v3 definition which we are still clinging on to (and should
since this is what's used in U-Boot right now) and the ALT mode from
the MUX_MODE bits.

The enum id can be replaced with a pin name string pointer "SD4_CMD"
which is static per pin. The imx_pin_reg struct would become

struct imx_pin_reg {
   const char *pad_name;
   u32 mux_reg;
   u32 ctl_reg;
   u32 ipp_reg;
   const char *mux_modes;
   u32 nmodes;
};

This can be used to build strings for debug. You're not using much
more space than the existing model, and the array contains strings
defining the last part of the debug string representing the alt mode -
saving a little bit of memory besides. And of course, it's not needed
to actually perform the muxing since that's just adding register
offsets to bases and writel() a value direct from the DT (although,
imx_pin_reg could be used to verify that the 3 pairs correspond to
each other...)

And you'd need strings to define the CTL settings like HYS, ODE, PKE,
PUE settings from the registers and give them human readable names as
per the device tree binding, as they were set, but this is not in the
imx_pin_regs array (or maybe it is, someone should put all the default
pad settings in there?).

Build the string like you want and you reproduce the naming in the
comments. Some other debug data needs to be exposed to define the bits
in the register as above, which isn't done right now. As such the
debug currently isn't so useful - it only describes the pad itself,
the MUX_MODE in an i.MX IOMUXC and the rest of the information is lost
since it does not take into account the pad control itself. This is
lucky as it's less work for now.

> If it supports, will imx driver also support config unused pins in devicetree
> via sysfs?

Setting up the stuff from the device tree wouldn't involve the
imx_pin_reg array so you could compile the whole thing out if you
didn't want the space usage or the chattiness of debug logs.

> Probably it may be rarely used and imx just does not support it.
> Then we can get register data from devicetree.

-- 
Matt
