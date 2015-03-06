From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Fri, 06 Mar 2015 10:32:26 -0500
Subject: [PATCH 1/5] mtd: nand: vf610_nfc: Freescale NFC for VF610,
 MPC5125 and others
In-Reply-To: <fdfc84d92bbcb8abc98f2c29e1aa368b@agner.ch> (Stefan Agner's
 message of "Fri, 06 Mar 2015 14:31:51 +0100")
References: <1425510624-22250-1-git-send-email-stefan@agner.ch>
 <1425510624-22250-2-git-send-email-stefan@agner.ch>
 <20150306061502.GB10997@pengutronix.de>
 <fdfc84d92bbcb8abc98f2c29e1aa368b@agner.ch>
Message-ID: <87sidi3zw5.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On  6 Mar 2015, stefan at agner.ch wrote:

> On 2015-03-06 07:15, Sascha Hauer wrote:
>> Hi Stefan,

>> On Thu, Mar 05, 2015 at 12:10:20AM +0100, Stefan Agner wrote:
>>> +
>>> +static int vf610_nfc_probe_dt(struct device *dev, struct
>>> vf610_nfc_config *cfg)
>>> +{
>>> +	struct device_node *np = dev->of_node;
>>> +	int buswidth;
>>> +	u32 clkrate;
>>> +
>>> +	if (!np)
>>> +		return 1;
>>> +
>>> +	cfg->flash_bbt = of_get_nand_on_flash_bbt(np);
>>> +
>>> +	if (!of_property_read_u32(np, "clock-frequency", &clkrate))
>>> +		cfg->clkrate = clkrate;

>> Normally the clock-frequency property tells the driver at which
>> frequency the device actually is running, not to tell the driver at
>> which frequency the device *should* run. It's strange to use the
>> value of the clock-frequency property as input to
>> clk_set_rate(). Maybe the assigned clock binding is more appropriate
>> here, see Documentation/devicetree/bindings/clock/clock-bindings.txt.

> What we try to do here is to specify the hardware limitations. There
> seem to be some hardware restrictions when it comes to clock
> frequencies. There has been a rather long discussion over at
> Freescales community about it:
> https://community.freescale.com/thread/317074

> Not sure if this is the right way to specify the supported
> frequencies, or should we create a custom property for this, something
> like fsl,max-nfc-frequency = <33000000>?

On most SOC's with this controller, the input clock to the controller
affects the NAND flash timing and other factors; so you will want to set
it based on the board/NAND stuffed.  The clock is for synchronous logic
in the controller and affects many properties.  

I guess Sascha's point is, the board's DT should just have some
'&nfc_clk' node and not have this part of the driver?  Either way works.
However, this clock is very important to get the driver to function.  It
seem better for a user/porter to have this info in the node.  I guess
you need to be trained to look at every node in the sub-tree for a
device.  I think the other way might be better or a sub-system
maintainer.  I looked at 'i2c' and other node which have a
'clock-frequency' parameter. 

In the Documentation/devicetree/bindings/clock/clock-bindings.txt,

    uart at a000 {
        compatible = "fsl,imx-uart";
        reg = <0xa000 0x1000>;
        interrupts = <33>;
        clocks = <&osc 0>, <&pll 1>;
        clock-names = "baud", "register";
    };

Here, this uart clock may affect the maximum baud rate supported by the
device.  For this controller (vf610_nfc), the clock is like setting the
'baud rate'; it affect the NAND memory cycles.  There is not really any
'wait state' type logic in the controller register set that would allow
the driver to work with a 'given clock' rate.  For certain a board
should set this clock for the NAND chips they wish to support.

What would the board file look like to use clock node?

[generic]
        nfc: nand at 400e0000 {
                compatible = "fsl,vf610-nfc";
                reg = <0x400e0000 0x4000>;
                clocks = <&clks VF610_CLK_NFC>;
                clock-names = "nfc_clk";
                status = "disabled";
        };

[board]

&nfc {
        nand-bus-width = <16>;
        nand-ecc-mode = "hw";
        nand-on-flash-bbt;
        nand-ecc-strength = <24>;
        nand-ecc-step-size = <2048>;
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_nfc_1>;
        status = "okay";
        &nfc_clk { frequency = <33000000>}  /* Like this? */
};

I don't know how to do the 'Like this?' part.  I don't think the
'clock-bindings.txt' explains it.  I see this is better as the the
driver needs no 'clock handling' code.  It is definitely a little more
obtuse for the users.

[snip]

>> Does this driver work without device tree or not? Currently the
>> driver bails out when device tree support is enabled but no device
>> node is given. When device tree support is disabled in the kernel
>> though the driver happily continues here.

> Hm, I never tried using this Driver without DT. 

[snip]

I also didn't test this.  The driver was ported from Linux versions
where DT did not exist.  It is used in some OpenWRT/68k/coldfire
(patched) kernels and I wanted it to be useful for them.  However, we
could probably remove the 'platform support'.  Other people are using
this on PPC platforms and they will also have dt/of.

Currently the platform control has no way to 'pass data', so the driver
only works with whatever defaults it has (or that is my belief).  For
instance, those OpenWRT kernels have a 'machine file' which will set the
'clock-frequency' and other parameters.  We could remove the platform
support completely if it is misleading.  I guess the KConfig would need
a 'depends on CONFIG_OF'.

Thanks for the review,
Bill Pringlemeir.
