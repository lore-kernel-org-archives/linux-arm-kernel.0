From: swarren@nvidia.com (Stephen Warren)
Date: Wed, 11 Jan 2012 16:15:39 -0800
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0E1843.7030207@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0E1843.7030207@firmworks.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF177EE3A848@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote at Wednesday, January 11, 2012 4:16 PM:
> On 1/11/2012 10:29 AM, Stephen Warren wrote:
> > Mitch Bradley wrote at Tuesday, January 10, 2012 11:43 PM:
> >> On 1/10/2012 2:28 PM, Timur Tabi wrote:
> >>> Mitch Bradley wrote:
> > ...
> >>>> That GPIO pin thing is annoying, but not sufficiently complex or common
> >>>> that it warrants having a separate EDID driver.  You could define a
> >>>> platform-specific property to tell your framebuffer driver that it needs
> >>>> to do that GPIO thing.  It's a hack, but the GPIO thing is inherently a
> >>>> hack, so there will be some ugliness somewhere as a result.
> >>>
> >>> I have two platform-specific functions, "enabled_edid" and "disable_edid", that I call
> before/after
> >>> calling fb_ddc_read().  This seems to work well, and I already have a mechanism for calling
> platform-
> >>> specific functions from the framebuffer driver.
> >>>
> >>> However, Stephen Warren said I should be using the I2C mux feature instead.
> >>
> >> I2C mux is a plausible solution, as is your enable/disable thing.  At
> >> some level they are equivalent.  I2C mux is a formalization of your
> >> solution, in which the mux device's select method must be written to
> >> perform the function of your enable/disable edid functions.
> >>
> >> Either way, you need platform-dependent functions to do the switching,
> >> and you need to select the appropriate channel.  Personally, I don't see
> >> the advantage of using the mux device in this case.
> >
> > The main advantage I see is that you explicitly don't need any platform-
> > specific functions to do the switching; you end up with platform-agnostic
> > code (the I2C GPIO mux driver) and platform-specific configuration for
> > that driver (the GPIO ID to use).
> 
> 
> Oh, I didn't know about the I2C GPIO Mux driver.  I was looking at
> i2c-mux.c .  I now see gpio-i2cmux.c, which indeed seems to do the right
> thing.
> 
> > The display driver just talks to the
> > I2C API for the DDC I2C bus, and doesn't do anything to switch between
> > the busses; the I2C GPIO mux driver does all that internally. Thus, the
> > display driver will work fine on boards that don't need this muxing with
> > zero changes; the board simply wouldn't register the mux driver.
> >
> >> It's just adding
> >> complexity with no payback.  If there were several channels that needed
> >> to be accessed in an interspersed fashion, the mux device would  be much
> >> cleaner.  But in this case, there is a single "back channel" that only
> >> needs to be accessed once and can subsequently be ignored.
> >
> > Well, the EDID needs to be read on every hotplug event, so it's certainly
> > not a one-time thing.
> >
> >> The video
> >> driver can grab a lock, call enable_edid(), read out the EDID data into
> >> an array, call disable_edid(), release the lock, and that is it.  The
> >> other users of that I2C bus can ignore the hidden EDID.
> >
> > Other I2C users/devices also shouldn't be impacted by the mux; they
> > would continue to use the existing I2C APIs for the bus their devices
> > are attached to, and not know about the mux.
> 
> If other devices that are on the same bus as the EDID don't use the mux,
> how does one ensure that the GPIO is restored to the non-EDID
> setting when the display driver is finished?

The I2C busses are set up like this:

                bus 0        bus 1
I2C controller -------> mux ------> dev a, dev b, dev c, ...
                           \------> dev x, dev y, dev z, ...
                             bus 2

Thus all devices are on a child I2C bus of the mux and none on the raw
HW bus exposed by the I2C controller itself.

The I2C core will always call gpiomux_select before each transaction,
which will set the GPIOs appropriately for bus 1 or bus 2, depending
on which device is being communicated with.

> Perhaps I'm missing something, but it appears to me that the model is to
> set the correct GPIO state before each use, instead of a
> save-set-use-restore model.

That's true, but the select action happens implicitly inside the I2C
core for any and all transactions, AIUI, so the two modes are equivalent.

> In any case, if there is a good way to instantiate the GPIO mux device
> from the device tree, it certainly provides a ready-made solution.  Each
> device that is on the bus in question would have a device node that is a
> child of the GPIO mux node, and the display driver could have a
> phandle-valued property pointing to the mux node, plus a property
> declaring the selection value (or perhaps a single 2-cell property with
> phandle, selection-value).

That's probably the difficult part.

For an I2C mux that is controlled via I2C, you can just add the mux
node as a child of the I2C controller, since it has an I2C address,
and so putting it there makes sense.

But for an I2C mux that's controlled using GPIOs or pinmux, there's no
I2C address so I guess the mux shouldn't be directly underneath the I2C
controller.

Perhaps the DT binding for such an I2C mux can refer to the parent I2C
controller by phandle?

Inside the I2C mux DT node, I think we can have a child node for each
bus, and then use standard I2C child node addressing for all the nodes
within these bus nodes.

Perhaps:

i2c1: i2c at 7000c000 {
    #address-cells = <1>;
    #size-cells = <0>;
    compatible = "nvidia,tegra20-i2c";
    reg = <0x7000C000 0x100>;
    interrupts = <0 38 0x04>;
};

mux at 0 {
    #address-cells = <1>;
    #size-cells = <0>;
    compatible = "nvidia,tegra20-i2c";
    parent-bus = <&i2c1>;
    gpios = <&gpio 100 0 &gpio 101 0>;
    gpio-values-idle = <0>; /* bitmask of values */

    bus at 0 {
        #address-cells = <1>;
        #size-cells = <0>;
        /*
         * The GPIO values to set as a bitmask.
         * Formatted like gpio-i2cmux.c's mux->data.values[i].
         * Or name this gpio-values?
         */
        reg = <1>;

        wm8903: wm8903 at 1a {
            compatible = "wlf,wm8903";
            reg = <0x1a>;
            ...
        };
    };

    bus at 1 {
        #address-cells = <1>;
        #size-cells = <0>;
        reg = <2>;

        light-sensor at 44 {
            compatible = "isil,isl29018";
            reg = <0x44>;
            ...
        };
    };
};

-- 
nvpublic
