From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 12 Jan 2012 08:45:03 -0800
Subject: [PATCH] ARM: vexpress: initial device tree support
In-Reply-To: <4F0E2B95.7070402@firmworks.com>
References: <1316596786-2539-1-git-send-email-dave.martin@linaro.org>
 <CAOZdJXXPJEaFO-ymvb_TsTJ6W2T7_aWXA=9RZprVmKBOn9cu8A@mail.gmail.com>
 <4F0B897A.20502@firmworks.com>
 <20120110122252.GA7180@jl-vm1.vm.bytemark.co.uk>
 <4F0CB485.9010106@freescale.com> <4F0CBD46.2010909@firmworks.com>
 <4F0CD7BC.7080409@freescale.com> <4F0D2F90.8020801@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A770@HQMAIL01.nvidia.com>
 <4F0E1843.7030207@firmworks.com>
 <74CDBE0F657A3D45AFBB94109FB122FF177EE3A848@HQMAIL01.nvidia.com>
 <4F0E2B95.7070402@firmworks.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF17801D1C98@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mitch Bradley wrote at Wednesday, January 11, 2012 5:39 PM:
> On 1/11/2012 2:15 PM, Stephen Warren wrote:
> > Mitch Bradley wrote at Wednesday, January 11, 2012 4:16 PM:
...
> >> In any case, if there is a good way to instantiate the GPIO mux device
> >> from the device tree, it certainly provides a ready-made solution.  Each
> >> device that is on the bus in question would have a device node that is a
> >> child of the GPIO mux node, and the display driver could have a
> >> phandle-valued property pointing to the mux node, plus a property
> >> declaring the selection value (or perhaps a single 2-cell property with
> >> phandle, selection-value).
> >
> > That's probably the difficult part.
> >
> > For an I2C mux that is controlled via I2C, you can just add the mux
> > node as a child of the I2C controller, since it has an I2C address,
> > and so putting it there makes sense.
> >
> > But for an I2C mux that's controlled using GPIOs or pinmux, there's no
> > I2C address so I guess the mux shouldn't be directly underneath the I2C
> > controller.
> >
> > Perhaps the DT binding for such an I2C mux can refer to the parent I2C
> > controller by phandle?
> >
> > Inside the I2C mux DT node, I think we can have a child node for each
> > bus, and then use standard I2C child node addressing for all the nodes
> > within these bus nodes.
> >
> > Perhaps:
> 
> The scheme below looks good to me, with minor nits picked...
> 
> > i2c1: i2c at 7000c000 {
> >      #address-cells =<1>;
> >      #size-cells =<0>;
> >      compatible = "nvidia,tegra20-i2c";
> >      reg =<0x7000C000 0x100>;
> >      interrupts =<0 38 0x04>;
> > };
> >
> > mux at 0 {
> >      #address-cells =<1>;
> >      #size-cells =<0>;
> >      compatible = "nvidia,tegra20-i2c";
> 
> Shouldn't this compatible value be set up to bind to gpio_i2cmux?  The
> node doesn't seem to be hardware-specific.

Yes, cut/paste mistake.

> >      parent-bus =<&i2c1>;
> >      gpios =<&gpio 100 0&gpio 101 0>;
> >      gpio-values-idle =<0>; /* bitmask of values */
> >
> >      bus at 0 {
> >          #address-cells =<1>;
> >          #size-cells =<0>;
> >          /*
> >           * The GPIO values to set as a bitmask.
> >           * Formatted like gpio-i2cmux.c's mux->data.values[i].
> >           * Or name this gpio-values?
> >           */
> 
> Did you mean for the comment above to be associated with the
> "gpio-values-idle" property?  It seems out of place here.

The comment applies to both gpio-values-idle at the top-level, and the
reg values within each of the mux's I2C child busses.

In this binding, I assume that the reg value in the I2C child bus is the
value mux->data.values[i] in the driver code, and gpio-values-idle is
value mux->data.idle. That way, we don't need each child bus to have a
separate property to represent mux->data.values[i]. If we don't want to
overload reg this way, perhaps we could represent child busses as:

i2c at 0 {
    reg = <0>; /* arbitrary ID */
    gpio-values = <1>; /* Value determined by HW mux's GPIO values */
    ...
};
i2c at 1 {
    reg = <1>;
    gpio-values = <2>;
    ...
};

> >          reg =<1>;
> 
> reg =<0>  because this is bus at 0
> 
> >
> >          wm8903: wm8903 at 1a {
> >              compatible = "wlf,wm8903";
> >              reg =<0x1a>;
> >              ...
> >          };
> >      };
> >
> >      bus at 1 {
> >          #address-cells =<1>;
> >          #size-cells =<0>;
> >          reg =<2>;
> 
> reg =<1> because this is bus at 1
> 
> >
> >          light-sensor at 44 {
> >              compatible = "isil,isl29018";
> >              reg =<0x44>;
> >              ...
> >          };
> >      };
> > };

-- 
nvpublic
