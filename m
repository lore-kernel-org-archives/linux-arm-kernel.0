From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 3 Mar 2015 10:25:50 +0000
Subject: [PATCH 1/5] MFD/OF: document MFD devices and handle simple-mfd
In-Reply-To: <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
References: <1425375148-4369-1-git-send-email-linus.walleij@linaro.org>
 <1425375148-4369-2-git-send-email-linus.walleij@linaro.org>
Message-ID: <20150303102550.GA32624@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 03 Mar 2015, Linus Walleij wrote:

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
> +These devices comprise a nexus for heterogeneous hardware blocks 

I don't think you meant 'comprise' here.  Perhaps 'represent' might
fit better?

> +spawning multiple child devices.

Spawning devices is something software will do.  Think less about what
the actions the OS will take order to handle these IPs and more about
what they are physically.  I would prefer the description mentions
that these chips are single pieces of silicon which contain >1 devices
with non-unique/varying functionality.

> +A typical MFD can be:
> +
> +- A mixed signal ASIC on an external bus, sometimes a PMIC (power management
> +  integrated circuit) that is manufactured in a lower technology node (rough

Please capitalise the expanded PMIC abbreviation.

> +  silicon) that handles analog drivers for things like audio amplifiers, LED
> +  drivers, level shifters, PHY (physical interfaces to things like USB or
> +  ethernet), regulators etc.
> +
> +- A range of memory registers containing "miscellaneous system registers" also
> +  known as a system controller "syscon" or any other memory range containing a
> +  mix of unrelated registers.

s/registers/{hardware|devices}/

> +Optional properties:
> +
> +- compatible : "simple-mfd" - this signifies that the operating system should
> +  spawn child devices for all the subnodes of the MFD device akin to how

This is pretty Linux specific IMHO.  Other OSes might not spawn
seperate devices to handle MFD type h/w.  The idea is fine, but please
generify a little.

> +  "simple-bus" inidicates when to spawn children for a simple memory-mapped
> +  bus. For more complex devices, when the nexus driver has to probe registers
> +  to figure out what children exist etc, this should not be used. In the latter
> +  case the child devices will be instantiated by the operating system.
> +
> +Example:
> +
> +foo at 1000 {

Should be 10000.
> +		compatible = "syscon", "simple-mfd";

Please address your tabbing issues.

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

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
