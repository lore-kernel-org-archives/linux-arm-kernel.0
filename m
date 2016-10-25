From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 25 Oct 2016 13:23:46 -0700
Subject: [RFC v2] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <7hy41ctipa.fsf@baylibre.com> (Kevin Hilman's message of "Tue, 25
 Oct 2016 10:57:37 -0700")
References: <1477402876-22472-1-git-send-email-bgolaszewski@baylibre.com>
 <1477402876-22472-2-git-send-email-bgolaszewski@baylibre.com>
 <7hy41ctipa.fsf@baylibre.com>
Message-ID: <7hoa28tbxp.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@baylibre.com> writes:

> Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:
>
>> Create a new driver for the da8xx DDR2/mDDR controller and implement
>> support for writing to the Peripheral Bus Burst Priority Register.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  .../memory-controllers/ti-da8xx-ddrctl.txt         |  20 +++
>>  drivers/memory/Kconfig                             |   8 +
>>  drivers/memory/Makefile                            |   1 +
>>  drivers/memory/da8xx-ddrctl.c                      | 175 +++++++++++++++++++++
>>  4 files changed, 204 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>>  create mode 100644 drivers/memory/da8xx-ddrctl.c
>>
>> diff --git
>> a/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>> b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>> new file mode 100644
>> index 0000000..7e271dd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
>> @@ -0,0 +1,20 @@
>> +* Device tree bindings for Texas Instruments da8xx DDR2/mDDR memory controller
>> +
>> +The DDR2/mDDR memory controller present on Texas Instruments da8xx SoCs features
>> +a set of registers which allow to tweak the controller's behavior.
>> +
>> +Documentation:
>> +OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
>> +
>> +Required properties:
>> +
>> +- compatible:		"ti,da850-ddr-controller" - for da850 SoC based boards
>> +- reg:			a tuple containing the base address of the memory
>> +			controller and the size of the memory area to map
>> +
>> +Example for da850 shown below.
>> +
>> +ddrctl {
>> +	compatible = "ti,da850-ddr-controller";
>> +	reg = <0xB0000000 0x100>;
>> +};
>
> Axel's series for the USB PHY reminded me that the PHY also has some
> config registers in this same area, and his series creates a syscon for
> a similar range of registers.
>
> Could you create a syscon for the SYSCFG0 registers, which would then
> be used by ths driver and your other drivers/bus driver?  Then the
> binding  would just reference the sysconf via phandle, and your driver
> can use syscon_regmap_lookup_by_phandle()

Nevermind. I though that the config register in this driver was also in
SYSCFG0, but I see now that it's in the reg region of the DDR controller
itself, so no syscon is needed.

Kevin
