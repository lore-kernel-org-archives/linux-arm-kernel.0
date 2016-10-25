From: ahaslam@baylibre.com (Axel Haslam)
Date: Tue, 25 Oct 2016 11:56:11 +0200
Subject: [PATCH/RFT v2 15/17] usb: host: ohci-da8xx: Add devicetree
 bindings documentation
In-Reply-To: <523928a1-a321-abb6-504f-a1053c88ce53@lechnology.com>
References: <20161024164634.4330-1-ahaslam@baylibre.com>
 <20161024164634.4330-16-ahaslam@baylibre.com>
 <523928a1-a321-abb6-504f-a1053c88ce53@lechnology.com>
Message-ID: <CAKXjFTNyfJ5G1aGb9YxfKbpVEqwBR499rLWnamYXH27+X1j-vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 25, 2016 at 3:02 AM, David Lechner <david@lechnology.com> wrote:
> On 10/24/2016 11:46 AM, ahaslam at baylibre.com wrote:
>>
>> From: Axel Haslam <ahaslam@baylibre.com>
>>
>> This patch documents the device tree bindings required for
>> the ohci controller found in TI da8xx family of SoC's
>>
>> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
>> ---
>>  .../devicetree/bindings/usb/ohci-da8xx.txt         | 39
>> ++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/usb/ohci-da8xx.txt
>>
>> diff --git a/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
>> b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
>> new file mode 100644
>> index 0000000..4251c84
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/usb/ohci-da8xx.txt
>> @@ -0,0 +1,39 @@
>> +DA8XX USB OHCI controller
>> +
>> +Required properties:
>> +
>> + - compatible: Should be "ti,da830-ohci"
>> + - reg:        Should contain one register range i.e. start and length
>> + - interrupts: Description of the interrupt line
>> + - phys:       Phandle for the PHY device
>> + - phy-names:  Should be "usb-phy"
>> +
>> +Optional properties:
>> + - vbus-supply: Regulator that controls vbus power
>
>
>
> Isn't vbus-supply property required?
>
> If it is really supposed to be optional, the ohci driver needs to use
> devm_regulator_get_optional() and handle the case when there is no
> regulator.
>
> I don't see a problem with making it required though since one can just use
> a dummy supply if there is not a real one.

The regulator framework will use a dummy regulator if none is provided.

>
>> +
>> +Example for omap138-lck:
>> +
>> +vbus_fixed: fixed-regulator-vbus {
>> +        compatible = "regulator-fixed";
>> +        gpio = <&gpio 109 0>;
>> +        oc-gpio = <&gpio 36 0>;
>> +        regulator-boot-on;
>> +        enable-active-high;
>> +        regulator-name = "vbus";
>> +        regulator-min-microvolt = <5000000>;
>> +        regulator-max-microvolt = <5000000>;
>> +};
>> +
>> +usb_phy: usb-phy {
>> +        compatible = "ti,da830-usb-phy";
>> +        #phy-cells = <1>;
>> +        status = "disabled";
>
>
> why disabled?
>

yes, i copied from the device tree im using, but
i should enable these for the example,
i will fix.

>> +};
>> +usb: usb at 0225000 {
>> +        compatible = "ti,da830-ohci";
>> +        reg = <0x225000 0x1000>;
>> +        interrupts = <59>;
>> +        phys = <&usb_phy 1>;
>> +        phy-names = "usb-phy";
>
>
> missing vbus-supply property
>
>> +        status = "disabled";
>
>
> why disabled?
>
>> +};
>>
>
