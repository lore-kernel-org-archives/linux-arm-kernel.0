From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Mon, 17 Feb 2014 12:31:37 -0300
Subject: [PATCH 0/4] clk: mvebu: fix clk init order
In-Reply-To: <53022504.1010908@free-electrons.com>
References: <1390673950-4521-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140205183457.GW8533@titan.lakedaemon.net>
 <20140217141336.GA2765@localhost> <53021BD2.3090301@free-electrons.com>
 <53021FD9.2070406@elopez.com.ar> <53022504.1010908@free-electrons.com>
Message-ID: <53022B59.3060905@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

El 17/02/14 12:04, Gregory CLEMENT escribi?:
(snip)
> Please read what I have written: "if there is no output-name, which is our
> default case) this proposal just ignored the parent clock given by the device
> tree".
>
> Extract of your code from the link you pointed:
>
> const char *default_parent = "tclk";
>
> [...]
>
> of_property_read_string_index(clkspec.np, "clock-output-names",
> 					      clkspec.args_count ? clkspec.args[0] : 0,
> 					      &default_parent);
>
> example of a valid dts:
> 			gateclk: clock-gating-control at 18220 {
> 				compatible = "marvell,foo-bar-gating-clock";
> 				reg = <0x18220 0x4>;
> 				clocks = <&coreclk 1>;
> 				#clock-cells = <1>;
> 			};
>
> So in this fictional but still valid example, the device tree indicates that the parent
> clock of the gating clock is the 2nd clock provided by the coreclk which is currently
> "cpuclk". As no clock-output-names is used, then this will be totally ignore and instead
> of using "cpuclk" as parent "tclk" will be used.

I can see your point now, but as this is completely fictional, I'd say 
it's irrelevant. You can just add the names if Marvell ever makes a chip 
that sources the gates from the second coreclk. As far as I can see on 
the device trees in Linux, all mvebu hardware always sources them from 
tclk. Don't try to over-engineer your driver for something that is 
unlikely to happen in reality.

If you in the future need to support another legacy platform with a 
half-cooked DT not listing the names, you can always list the right 
parent on the divisor table (see link for example) and override the default.

http://lxr.free-electrons.com/source/drivers/clk/mvebu/kirkwood.c?v=3.13#L222

> I hope this example will show you, what I disagree with this proposal and why it
> introduce some regression.

It's not a regression if things don't break :-)

Cheers,

Emilio
