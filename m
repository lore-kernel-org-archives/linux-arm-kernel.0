From: martinez.javier@gmail.com (Javier Martinez Canillas)
Date: Mon, 11 Feb 2013 11:40:08 +0100
Subject: [PATCH RFC 3/7] ARM: OMAP: gpmc-smsc911x: add DT dev node init
 function
In-Reply-To: <20130211103051.GA32455@e106331-lin.cambridge.arm.com>
References: <1360442671-15216-1-git-send-email-javier.martinez@collabora.co.uk>
 <1360442671-15216-4-git-send-email-javier.martinez@collabora.co.uk>
 <20130211103051.GA32455@e106331-lin.cambridge.arm.com>
Message-ID: <CAAwP0s0gO-FEv=RKUw+HWS3PyovaDP8_sV8n3AOC1xuRpY9xvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 11, 2013 at 11:30 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> I have a few comments on the binding and the way it's parsed.
>
> On Sat, Feb 09, 2013 at 08:44:27PM +0000, Javier Martinez Canillas wrote:
>> This patch adds a helper function to parse a device node that
>> contains all the properties needed to initialize an smsc911x
>> device connected to an OMAP processor through OMAP's GPMC.
>>
>> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>> ---
>>  .../devicetree/bindings/net/gpmc-smsc911x.txt      |   39 ++++++++++++++++++++
>>  arch/arm/mach-omap2/gpmc-smsc911x.c                |   29 +++++++++++++++
>>  arch/arm/mach-omap2/gpmc-smsc911x.h                |    6 +++
>>  3 files changed, 74 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-smsc911x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/net/gpmc-smsc911x.txt b/Documentation/devicetree/bindings/net/gpmc-smsc911x.txt
>> new file mode 100644
>> index 0000000..8bb0df2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/gpmc-smsc911x.txt
>> @@ -0,0 +1,39 @@
>> +* GPMC connected Smart Mixed-Signal Connectivity (SMSC) LAN911x/912x Controller
>> +
>> +GPMC connected SMSC LAN911x/912x Controllers are represented as child nodes
>> +of the OMAP General-Purpose Memory Controller with a name of "gpmc_smsc911x".
>> +
>> +All timing relevant properties as well as generic gpmc child properties are
>> +explained in a separate documents - please refer to
>> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> +
>> +Required properties:
>> +- gpmc,cs : The chip select line the pheripheral is connected to
>> +- gpmc,gpio_irq : The GPIO pin that is connected to the SMSC LAN IRQ line
>
> In devicetree land, we use '-' in preference of '_' in property names.
>
> So this should be "gpio-irq"
>
>> +
>> +Optional properties:
>> +- gpmc,flags : SMSC LAN flags - please refer to include/linux/smsc911x.h
>
> Please don't do this. It should only be necessary to read binding documents and
> hardware datasheets to write a dts. Referring to Linux internals creates a
> flaky ABI that's only going to break when things get renamed/moved/modified.
>
> The flags variable used internally by the driver don't have to have a 1-1
> correspondence with a single property in the binding. You can have boolean
> properties (named, but without a value) in the dt specifying each flag
> individually. That way the dts is easier to read, is less tied to linux
> internals (and every property is *fully* documented), and it's far easier to
> add new flags in future if necessary.
>
>> +- gpmc,gpio_reset : The GPIO pin connected to the SMSC LAN reset line
>
> Preferably: "gpio-reset".
>
>> +
>> +Note: Besides these properties, the gpmc_smsc911x device node could need
>> +aditional setup such as pin/pad mux settings and voltage regulators. This
>> +depend on how the pheripheral is wired and his board specific.
>> +
>> +Example (for an OMAP3 board):
>> +
>> +gpmc at 6e000000 {
>> +           compatible = "ti,omap3430-gpmc";
>> +           ti,hwmods = "gpmc";
>> +           reg = <0x6e000000 0x1000000>;
>> +           interrupts = <20>;
>> +           gpmc,num-cs = <8>;
>> +           gpmc,num-waitpins = <4>;
>> +           #address-cells = <2>;
>> +           #size-cells = <1>;
>> +
>> +           gpmc_smsc911x at 0 {
>> +                           gpmc,cs = <5>;
>> +                           gpmc,gpio_irq = <176>;
>> +                           gpmc,flags = <4>; /* SMSC911X_USE_32BIT */
>
> Here you could have a boolean property "gpmc,use-32bit" (or possibly
> "gpmc,use-bits", which can either be 32 or 16).
>
>> +           };
>> +};
>> diff --git a/arch/arm/mach-omap2/gpmc-smsc911x.c b/arch/arm/mach-omap2/gpmc-smsc911x.c
>> index 5ce00ad2..59a2ee4 100644
>> --- a/arch/arm/mach-omap2/gpmc-smsc911x.c
>> +++ b/arch/arm/mach-omap2/gpmc-smsc911x.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/io.h>
>>  #include <linux/smsc911x.h>
>> +#include <linux/of.h>
>>
>>  #include "gpmc.h"
>>  #include "gpmc-smsc911x.h"
>> @@ -98,3 +99,31 @@ free1:
>>
>>       pr_err("Could not initialize smsc911x device\n");
>>  }
>> +
>> +int gpmc_smsc911x_init_dt(struct device_node *node)
>> +{
>> +     struct omap_smsc911x_platform_data gpmc_cfg;
>> +
>> +     if (WARN_ON(!node))
>> +             return -ENODEV;
>> +
>> +     if (of_property_read_u32(node, "gpmc,cs", &gpmc_cfg.cs)) {
>> +             pr_err("Unable to get GPMC smsc911x chip select\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (of_property_read_u32(node, "gpmc,gpio_irq", &gpmc_cfg.gpio_irq)) {
>> +             pr_err("Unable to get GPMC smsc911x GPIO IRQ\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     if (of_property_read_u32(node, "gpmc,gpio_reset", &gpmc_cfg.gpio_reset))
>> +             gpmc_cfg.gpio_reset = -EINVAL;
>> +
>> +     if (of_property_read_u32(node, "gpmc,flags", &gpmc_cfg.flags))
>> +             gpmc_cfg.flags = 0;
>
> Is no sanity checking required for any of the above properties?
>
> To handle separate flags here, you can use something like:
>
> if (of_property_read_bool(node, "gpmc,use-32bit")
>         flags |= SMSC911X_USE_32BIT;
>
> [...]
>
> Thanks,
> Mark.
>

Hello Mark,

I really appreciate your feedback.

I'll drop this binding anyways and try to reuse the generic SMSC LAN binding
so it won't be necessary to manually asign the device node to the platform
device.

But I'll keep in mind your comments for the next time I need to write
a DT binding

Thanks a lot and best regards,
Javier
