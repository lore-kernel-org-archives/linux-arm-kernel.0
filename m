From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 24 Oct 2016 10:35:30 -0700
Subject: [RFC] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <20161024170035.GO15620@leverpostej> (Mark Rutland's message of
 "Mon, 24 Oct 2016 18:00:36 +0100")
References: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
 <1477327596-16060-2-git-send-email-bgolaszewski@baylibre.com>
 <20161024170035.GO15620@leverpostej>
Message-ID: <7hd1ipzm3h.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Oct 24, 2016 at 06:46:36PM +0200, Bartosz Golaszewski wrote:
>> Create a new driver for the da8xx DDR2/mDDR controller and implement
>> support for writing to the Peripheral Bus Burst Priority Register.
>> 
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++
>>  drivers/memory/Kconfig                             |   8 +
>>  drivers/memory/Makefile                            |   1 +
>>  drivers/memory/da8xx-ddrctl.c                      | 187 +++++++++++++++++++++
>>  4 files changed, 216 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>>  create mode 100644 drivers/memory/da8xx-ddrctl.c
>> 
>> diff --git
>> a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>> b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>> new file mode 100644
>> index 0000000..f0eda59
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>> @@ -0,0 +1,20 @@
>> +* Device tree bindings for Texas Instruments da8xx DDR2/mDDR memory controller
>> +
>> +The DDR2/mDDR memory controller present on Texas Instruments da8xx SoCs memory
>> +maps a set of registers which allow to tweak the controller's behavior.
>
> This is a description of the *driver*. The device itself doesn't map
> some registers, it features them. Please descrive the *device*.
>
>> +
>> +Documentation:
>> +OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
>> +
>> +Required properties:
>> +
>> +- compatible:		"ti,da850-ddrctl" - for da850 SoC based boards
>
> Perhaps:
>
> 	"ti,da850-ddr-controller"
>
>> +static int da8xx_ddrctl_probe(struct platform_device *pdev)
>> +{
>> +	const struct da8xx_ddrctl_config_knob *knob;
>> +	const struct da8xx_ddrctl_setting *setting;
>> +	u32 regprop[2], base, memsize, reg;
>> +	struct device_node *node, *parent;
>> +	void __iomem *ddrctl;
>> +	const char *board;
>> +	struct device *dev;
>> +	int ret;
>> +
>> +	dev = &pdev->dev;
>> +	node = dev->of_node;
>> +
>> +	/* Find the board name. */
>> +	for (parent = node;
>> +	     !of_node_is_root(parent);
>> +	     parent = of_get_parent(parent));
>> +
>> +	ret = of_property_read_string(parent, "compatible", &board);
>> +	if (ret) {
>> +		dev_err(dev, "unable to read the soc model\n");
>> +		return ret;
>> +	}
>
> I can see that you want to expose sysfs knobs for this, but is it really
> necessary to match boards like this? It's very fragile, and commits us
> to maintaining a database of board data (i.e. a board file).
>
> I am very much not keen on that.

The original proposal[1] was to create DT properties reflecting the
various knobs in the DDR Controller, but that was frowned upon since
that was more HW configuration than hardware description.

That resulted in this approach which keeps the HW configuration values
in the driver, and selectable based on DT compatible.

IMO, neither aproach is pretty.  From a DT maintainer perspective, can
you comment on your preference?

Thanks,

Kevin

[1] https://marc.info/?l=linux-arm-kernel&m=147672200715076&w=2
