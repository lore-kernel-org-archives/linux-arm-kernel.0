From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 24 Feb 2015 22:01:26 +0800
Subject: [PATCH 2/4] i2c: sunxi: Add Reduced Serial Bus (RSB) DT bindings
 documentation
In-Reply-To: <9851276.8ZCd3XfZle@wuerfel>
References: <1424773744-15106-1-git-send-email-wens@csie.org>
 <1424773744-15106-3-git-send-email-wens@csie.org> <9851276.8ZCd3XfZle@wuerfel>
Message-ID: <CAGb2v66ru6Yurt1CFn-zocAuqen8GWSm8y9dHRf=-OOcc-DR7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 24, 2015 at 6:37 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 24 February 2015 18:29:02 Chen-Yu Tsai wrote:
>>
>> +       rsb at 01f03400 {
>> +               compatible = "allwinner,sun8i-a23-rsb";
>> +               reg = <0x01f03400 0x400>;
>> +               interrupts = <0 39 4>;
>> +               clocks = <&apb0_gates 3>;
>> +               clock-frequency = <3000000>;
>> +               resets = <&apb0_rst 3>;
>> +
>> +               axp223: pmic at 2d {
>> +                       compatible = "x-powers,axp223", "x-powers,axp221";
>> +                       reg = <0x2d>;
>> +                       allwinner,rsb-hw-addr = <0x3e3>;
>> +
>> +                       /* ... */
>> +               };
>> +       };
>
> The child node cannot have a 'reg' property if the parent does not
> have #address-cells/#size-cells. You should add these as mandatory
> properties in the list.

Oops. I'll add them. A few of the other i2c bindings seem to be missing
it as well. Probably why I missed it.

> I don't really understand the need for having two addresses (runtime
> and hardware). Could the runtime address be configured at runtime?

You can, though the driver doesn't support this. I don't think the
I2C subsystem allows arbitrary device insertion during normal
operation, but maybe i2c-dev? I've tried using different addresses
for devices so they do get changed during the probe phase, just
to be sure that the code works, and it's not just sitting at
the address the bootloader used.

In any case, the distinction is more like burnt-in or hardwired
addresses vs software configurable addresses.

> Alternatively, could you use #address-cells=<2> and put both into
> 'reg'?

I sort of looked into it, and it seems the I2C subsystem won't mind
the extra address cell. Maxime also asked whether we could use 2
addresses, possibly with a reg-names property. Using 2 cells is simpler
though.

I'm open to other options, but I'd like to get some input, especially
from the device tree maintainers, before I change it.


Regards,
ChenYu
