From: grant.likely@linaro.org (Grant Likely)
Date: Sat, 28 Mar 2015 13:41:56 +0000
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150328134157.000A3C40AE0@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  3 Mar 2015 10:32:24 +0100
, Linus Walleij <linus.walleij@linaro.org>
 wrote:
> This defines a new compatible option for MFD devices "simple-mfd" that will
> make the OF core spawn child devices for all subnodes of that MFD device.
> It is optional but handy for things like syscon and possibly other
> simpler MFD devices.
> 
> Since there was no file to put the documentation in, I took this opportunity
> to make a small writeup on MFD devices and add the compatible definition
> there.
> 
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Devicetree <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I make the patch to the OF core in this one, it makes much more sense since
> it's a oneliner
> 
> Lee: this is a (tested!) implementation of your suggestion for simple-mfd.
> If you can eventually ACK this from the MFD side, I think it should be
> funneled through the ARM SoC tree.
> 
> Grant/Rob: if either of you can ACK the change to the OF core likewise it can
> be taken through ARM SoC.
> 
> DT binings maintainers: there is some background discussion on this here:
> http://marc.info/?l=linux-arm-kernel&m=142486676603889&w=2
> http://marc.info/?l=devicetree&m=142166313621469&w=2
> ---
>  Documentation/devicetree/bindings/mfd/mfd.txt | 40 +++++++++++++++++++++++++++
>  drivers/of/platform.c                         |  1 +
>  2 files changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mfd.txt b/Documentation/devicetree/bindings/mfd/mfd.txt
> new file mode 100644
> index 000000000000..cc057438abe8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/mfd.txt
> @@ -0,0 +1,40 @@
> +Multi-Function Devices (MFD)
> +
> +These devices comprise a nexus for heterogeneous hardware blocks spawning
> +multiple child devices.
> +
> +A typical MFD can be:
> +
> +- A mixed signal ASIC on an external bus, sometimes a PMIC (power management
> +  integrated circuit) that is manufactured in a lower technology node (rough
> +  silicon) that handles analog drivers for things like audio amplifiers, LED
> +  drivers, level shifters, PHY (physical interfaces to things like USB or
> +  ethernet), regulators etc.
> +
> +- A range of memory registers containing "miscellaneous system registers" also
> +  known as a system controller "syscon" or any other memory range containing a
> +  mix of unrelated registers.
> +
> +Optional properties:
> +
> +- compatible : "simple-mfd" - this signifies that the operating system should
> +  spawn child devices for all the subnodes of the MFD device akin to how
> +  "simple-bus" inidicates when to spawn children for a simple memory-mapped
> +  bus. For more complex devices, when the nexus driver has to probe registers
> +  to figure out what children exist etc, this should not be used. In the latter
> +  case the child devices will be instantiated by the operating system.
> +
> +Example:
> +
> +foo at 1000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x010000 0x1000>;
> +
> +		led at 08.0 {
> +			compatible = "register-bit-led";
> +			offset = <0x08>;
> +			mask = <0x01>;
> +			label = "myled";
> +			default-state = "on";
> +		};
> +};
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b189733a1539..969ba4e1460c 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -26,6 +26,7 @@
>  
>  const struct of_device_id of_default_bus_match_table[] = {
>  	{ .compatible = "simple-bus", },
> +	{ .compatible = "simple-mfd", },
>  #ifdef CONFIG_ARM_AMBA
>  	{ .compatible = "arm,amba-bus", },
>  #endif /* CONFIG_ARM_AMBA */

Alright, so:

Acked-by: Grant Likely <grant.likely@linaro.org>

However, I think this is going to lead to a future problem. It solves
the immediate case of getting an MFD device to be auto populated when
the kernel doesn't need to immediately do something. However, I can
forsee a situation where the device can be supported by simple-mfd, but
at some point it is discovered that better features can be enabled if
the mfd device has a proper driver.

If/when we get into that situation, the above still works, but we're
going to need to add a blacklist match table so that simple-mfd can be
overridden by a more-specific compatible value. I don't have any
problems with doing that, but someone needs to implement it.

g.
