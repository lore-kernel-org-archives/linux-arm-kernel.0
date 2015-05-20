From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 20 May 2015 13:00:05 +0200
Subject: [PATCH v4 1/1] ARM: mvebu: dts: Add dts file for DLink DNS-327L
In-Reply-To: <699cee8678f6e671bd1457aa06180ccf@mail.ncrmnt.org>
References: <1432069858-10958-1-git-send-email-andrew@ncrmnt.org>
 <1432069858-10958-2-git-send-email-andrew@ncrmnt.org>
 <555C4E48.6020707@gmail.com>
 <699cee8678f6e671bd1457aa06180ccf@mail.ncrmnt.org>
Message-ID: <555C6935.4000405@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20.05.2015 12:20, Andrew wrote:
> Sebastian Hesselbarth ????? 20.05.2015 12:05:
>> On 19.05.2015 23:10, Andrew Andrianov wrote:
>>> DNS-327L is a 2-bay NAS with the following specs:
>> [...]
>>> Signed-off-by: Andrew Andrianov <andrew@ncrmnt.org>
>>> ---
>>>   arch/arm/boot/dts/Makefile                     |   1 +
>>>   arch/arm/boot/dts/armada-370-dlink-dns327l.dts | 356
>>> +++++++++++++++++++++++++
>>>   2 files changed, 357 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>> [...]
>>> diff --git a/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>>> b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>>> new file mode 100644
>>> index 0000000..0f4555c4
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/armada-370-dlink-dns327l.dts
>>> @@ -0,0 +1,356 @@
>> [...]
>>> +    regulators {
>>> +        compatible = "simple-bus";
>>> +        #address-cells = <1>;
>>> +        #size-cells = <0>;
>>> +        pinctrl-0 = <&xhci_pwr_pin
>>> +            &sata_l_pwr_pin
>>> +            &sata_r_pwr_pin>;
>>> +
>>> +        pinctrl-names = "default";
>>
>> I doubt pinctrl will not work as you expected. For regulators, unlike
>> gpio-keys/leds above, this node just describes the "bus" of regulators.
>
> Are you sure about this moment? FYI: I've taken
> armada-370-synology-ds213j.dts
> as the reference which happens to list regulator pinctrl (As of 4.1-rc1)
> just the same way:
>
>      compatible = "simple-bus";
>          #address-cells = <1>;
>          #size-cells = <0>;
>          pinctrl-0 = <&sata1_pwr_pin &sata2_pwr_pin>;
>          pinctrl-names = "default";
>                  ...

Well, even if it works the pinctrl should be claimed by the device that
actually depends on it, i.e. the regulator itself.

> If that's erroneous we should fix armada-370-synology-ds213j.dts as well.

Most likely nobody ever noticed if that didn't work because (a) usually
gpio functions are setup by the bootloader or (b) gpio is default reset
value of the pinctrl registers anyway.

I'd say move the pinctrl properties to regulator nodes for dns-327l now
and we move the properties for ds213j in a separate patch.

Sebastian

>>> +
>>> +        usb_power: regulator at 1 {
>>> +            compatible = "regulator-fixed";
>>> +            reg = <1>;
>>> +            regulator-name = "USB3.0 Port Power";
>>> +            regulator-min-microvolt = <5000000>;
>>> +            regulator-max-microvolt = <5000000>;
>>> +            enable-active-high;
>>> +            regulator-boot-on;
>>> +            regulator-always-on;
>>> +            gpio = <&gpio0 13 GPIO_ACTIVE_HIGH>;
>>
>> Instead you'll have to put the corresponding pinctrl-0/names properties
>> in each of the regulator nodes, i.e.
>>
>>         pinctrl-0 = <&xhci_pwr_pin>
>>         pinctrl-names = "default";
>>
>> here and similar for the other regulator nodes.
>>
>>> +        };
>>> +
>>> +        sata_r_power: regulator at 2 {
>>> +            compatible = "regulator-fixed";
>>> +            reg = <2>;
>>> +            regulator-name = "SATA-R Power";
>>> +            regulator-min-microvolt = <5000000>;
>>> +            regulator-max-microvolt = <5000000>;
>>> +            startup-delay-us = <2000000>;
>>> +            enable-active-high;
>>> +            regulator-always-on;
>>> +            regulator-boot-on;
>>> +            gpio = <&gpio1 22 GPIO_ACTIVE_HIGH>;
>>> +        };
>>> +
>>> +        sata_l_power: regulator at 3 {
>>> +            compatible = "regulator-fixed";
>>> +            reg = <3>;
>>> +            regulator-name = "SATA-L Power";
>>> +            regulator-min-microvolt = <5000000>;
>>> +            regulator-max-microvolt = <5000000>;
>>> +            startup-delay-us = <4000000>;
>>> +            enable-active-high;
>>> +            regulator-always-on;
>>> +            regulator-boot-on;
>>> +            gpio = <&gpio1 24 GPIO_ACTIVE_HIGH>;
>>> +        };
>>> +    };
>>> +};
