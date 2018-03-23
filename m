From: tharvey@gateworks.com (Tim Harvey)
Date: Fri, 23 Mar 2018 10:11:35 -0700
Subject: [PATCH v2 1/4] dt-bindings: mfd: Add Gateworks System Controller
 bindings
In-Reply-To: <20180309231433.tmlfy6vwbkvopmwd@rob-hp-laptop>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
 <1520287361-12569-2-git-send-email-tharvey@gateworks.com>
 <20180309231433.tmlfy6vwbkvopmwd@rob-hp-laptop>
Message-ID: <CAJ+vNU3Nm0b30pMm-8aGCcFbTA05hU=rfyKMMOgRubf_GK1WyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 9, 2018 at 3:14 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Mar 05, 2018 at 02:02:38PM -0800, Tim Harvey wrote:
>> This patch adds documentation of device-tree bindings for the
>> Gateworks System Controller (GSC).
>>
>> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
>> ---
>>  Documentation/devicetree/bindings/mfd/gsc.txt | 159 ++++++++++++++++++++++++++
>>  1 file changed, 159 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/gsc.txt
>>
<snip>
>> +
>> +* hwmon:
>> +The GSC provides a set of Analog to Digitcal Converter (ADC) pins used for
>> +temperature and/or voltage monitoring.
>> +
>> +Required properties:
>> +- compatible: must be "gw,gsc-hwmon"
>> +
<snip>
>> +
>> +             gsc_hwmon {
>
> hwmon {
>
>> +                     compatible = "gw,gsc-hwmon";
>> +                     #address-cells = <1>;
>> +                     #size-cells = <0>;
>> +
>> +                     hwmon at 0 { /* A0: Board Temperature */
>> +                             type = <0>;
>
> Not documented.
>
>> +                             reg = <0x00>;
>> +                             label = "temp";
>> +                     };
>> +
>> +                     hwmon at 1 { /* A1: Input Voltage */
>> +                             type = <1>;
>> +                             reg = <0x02>;
>> +                             label = "Vin";
>> +                     };
>> +
<snip>
>> +
>> +                     hwmon at 15 { /* fan0 */
>> +                             type = <2>;
>> +                             reg = <0x2c>;
>> +                             label = "fan_50p";
>> +                     };
>> +
<snip>
>> +             };
>> +     };

Hi Rob,

Thanks for the review. I will roll in your changes.

I'm looking for suggestions on how to better define the child nodes of
the hwmon sub-device:

I have 4 types of hwmon child nodes supported by this device:
1. temperature in C/10 (is that called deci-celcuis?): this is a 2byte value
2. input voltage in mV: this is a 3 byte value pre-scaled by the GSC
firmware from a 10bit ADC where the
ref/bit-resolution/resistor-divider info is baked into the per-board
firmware
3. fan setpoint in C/10
4. input voltage in mV: raw 2-byte value of a 12bit ADC that needs to
be scaled based on a voltage-devider (pre-scaler), a ref voltage, and
resolution (or bit width)

The example I posted above shows use of the first three types but not
the more complicated fourth which requires the driver know more
details in order to present a cooked milivolt value. Note that the two
input types above would not both be present in any single board dts as
they represent a change in the way ADC's are reported in the overall
GSC version. A GSC typically has up to 16 different input ADC's and
the voltage rails monitored vary per board.

You mention that I don't document 'type' and your correct. I'm
thinking this is best done with a string using compatible within the
child node.

Something like:

Required properties:
...
- hwmon: This is the list of child nodes that specify the hwmon nodes.
...

hwmon required properties:
- hwmon-compatible: Must be "fan-setpoint", "temperature",
"input-raw", "input-cooked"
- reg: register offset of the node
- label: name of the input node

hwmon optional properties:
- gw,voltage-divider: an array of two integers containing the resistor
values R1 and R2 of the voltage divider in ohms
- gw,reference-voltage: the internal reference voltage of the ADC
input in milivolts
- gw,resolution: the resolution of the ADC input (ie 4096 for 12bit resolution)
...

Example:
...
hwmon {
  compatible = "gw,gsc-hwmon";
  #address-cells = <1>;
  #size-cells = <0>;

  hwmon at 0 {
    compatible = "temperature";
    reg <0x00>;
    label = "temp";
  };

  hwmon at 2 {
    compatible = "fan-setpoint";
    reg <0x02>;
    label = "fan_setpoint0";
  };

  /* this one represents the 3-byte ADC value that has been
'pre-scaled' by the GSC from a raw 10bit ADC (older GSC
version/firmware) */
  hwmon at 4 {
    compatible = "input-cooked";
    reg <0x02>;
    label = "voltage1";
  };

  /* this one represents the 2-byte 12-bit ADC value that is 'raw'
from the GSC and needs to be scaled by driver (newer GSC
version/firmware) */
  hwmon at 4 {
    compatible = "input-raw";
    reg <0x04>;
    label = "voltage2";
    gw,voltage-divider = <10000 10000>; /* R1=10k R2=10k div-by-2 pre-scaler */
    gw,referance-voltage = <2500>; /* 2.5V reference */
    gw,resolution = <4096>; /* 12bit resolution */
  };
};

If I add a byte-size (2|3) or bit-width (16|24) I could essentially
combine the two input types.

Suggestions?

Regards,

Tim
