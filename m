From: dongas86@gmail.com (Dong Aisheng)
Date: Sat, 4 Feb 2012 01:21:39 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <20120203140238.GC12915@S2101-09.ap.freescale.net>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <20120201143530.GA2203@S2101-09.ap.freescale.net>
 <74CDBE0F657A3D45AFBB94109FB122FF178E124AC5@HQMAIL01.nvidia.com>
 <CAA+hA=RpkP-FFAr8wqVPjSKEMvO_sRHmOK_9nUYfuW=ps0O_=Q@mail.gmail.com>
 <20120203140238.GC12915@S2101-09.ap.freescale.net>
Message-ID: <CAA+hA=TYt7iFbLkSLfOMe8z1-dJGufqFDuZGarRx-ioHkf3sRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 3, 2012 at 10:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Fri, Feb 03, 2012 at 04:07:23AM +0800, Dong Aisheng wrote:
> ...
>> However If IMX uses the data model i described above, the binding is
>> then a little different from tegra. that means we may need to change
>> to ?let each soc's pinctrl driver do real pinmux map parsing (maybe
>> add a callback in pinctrl.ops) based on their soc specific pinctrl
>> configuration node like pmx_usdhc4 above instread of let pinctrl core
>> do a standard pinmux map parsing which is our target we discussed so
>> long for.
>>
> Yeah, this seems a reasonable alternative to me. ?Pushing the pinmux_map
> construction down to individual pinctrl driver, who can interpret 'mux'
> property best, will relieve the pinctrl core from understanding the
> property for different cases, so that we can even save the property
> 'mux-unit' I asked for. ?And doing so somehow aligns with non-dt case,
> where the pinmux_map is constructed by individual pinctrl driver too
> (with help from PINMUX_MAP_* macros in board file).
>
Yes, that's i think may be right way we should go now.
The reasons are as we met so many issues and discussed so long, we
feel like that it's hard to make a standard dt binding in pintrl core
based on one mux property format to cover all the differences for
different SOCs likeTegra(using HW group) and IMX(using virtual group).
We need to fix these issues on a higher level that each SOC pinctrl
driver implements their pinmux map parsing function, pinctrl core
calls these functions to get the pinmux maps the driver parsed instead
of pinctrl core parsing itself.
It could be something like:
in pinmux_get() {
    struct pinmux_map *maps;
    u32 num;
    ...
    maps = pinctrl.ops.get_pinmux_map(pinmux_node, &num);
    ret = pinmux_map_register(maps, num);
    ...
    ret = pinmux_enable_maps(maps, num);
}

The basic binding idea for this way is:
1) pinctrl core is only responsible for the pinmux map parsing.
Each pinctrl driver is responsible for the function and group creation
no matter whether they're defined in drivers or parsed from device
tree.
2) The pinctrl driver is responsible for their pinmux node definitions
to cover their hw difference. However we prefer to reference the
format as Stephen proposed to align each SOC best. And each pinctrl
driver is responsible for the real pinmux map parsing by implementing
the pinmux_map_parse callback function.
3) when calling pinmux_get, we dynamically parse and create the pinmux
map table for each device.
4) the hog_on_boot map nodes are defined under SoC's pinctrl device node.
The pinctrl driver is responsible for parsing and register them.

Generally speaking, this way is very flexible and can cover most
differences between each SoCs.
It should work for both IMX and Tegra well. Tegra can still do on the
same binding as before as Stephen proposed. The only difference is
that the real pinmux map parsing is moved from pinctrl core to Tegra
pinctrl driver. And IMX can still use virtual group as we wished(i
think this is correct since pinctrl subsystem does not have a
restriction that user can only use pure hw group).
For other SOCs, i guess it should also work.

Regards
Dong Aisheng
