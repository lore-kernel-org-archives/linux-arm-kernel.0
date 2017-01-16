From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 16 Jan 2017 11:13:16 +0100
Subject: [PATCH 03/10] devicetree: bindings: add bindings for ahci-da850
In-Reply-To: <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com>
References: <1484311084-31547-1-git-send-email-bgolaszewski@baylibre.com>
 <1484311084-31547-4-git-send-email-bgolaszewski@baylibre.com>
 <35ff358d-9b17-b2be-38d8-6a51cdddc1a1@lechnology.com>
Message-ID: <CAMpxmJUau9BgAOhacPvcA=NwyE6-yEfDgPdcCZ_JCuNH-amJSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-01-13 20:25 GMT+01:00 David Lechner <david@lechnology.com>:
> On 01/13/2017 06:37 AM, Bartosz Golaszewski wrote:
>>
>> Add DT bindings for the TI DA850 AHCI SATA controller.
>>
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>  .../devicetree/bindings/ata/ahci-da850.txt          | 21
>> +++++++++++++++++++++
>>  1 file changed, 21 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/ata/ahci-da850.txt
>>
>> diff --git a/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> new file mode 100644
>> index 0000000..d07c241
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/ata/ahci-da850.txt
>> @@ -0,0 +1,21 @@
>> +Device tree binding for the TI DA850 AHCI SATA Controller
>> +---------------------------------------------------------
>> +
>> +Required properties:
>> +  - compatible: must be "ti,da850-ahci"
>> +  - reg: physical base addresses and sizes of the controller's register
>> areas
>> +  - interrupts: interrupt specifier (refer to the interrupt binding)
>> +
>> +Optional properties:
>> +  - clocks: clock specifier (refer to the common clock binding)
>> +  - da850,clk_multiplier: the multiplier for the reference clock needed
>> +                          for 1.5GHz PLL output
>
>
> A clock multiplier property seems redundant if you are specifying a clock.
> It should be possible to get the rate from the clock to determine which
> multiplier is needed.
>

I probably should have named it differently. This is not a multiplier
of a clock derived from PLL0 or PLL1. Instead it's a value set by
writing to the Port PHY Control Register (MPY bits) of the SATA
controller that configures the multiplier for the external low-jitter
clock. On the lcdk the signals (REFCLKP, REFCLKN) are provided by
CDCM61001 (SATA OSCILLATOR component on the schematics).

I'll find a better name and comment the property accordingly.

FYI: the da850 platform does not use the common clock framework, so I
don't specify the clock property on the sata node in the device tree.
Instead I add the clock lookup entry in patch [01/10]. This is
transparent for AHCI which can get the clock as usual by calling
clk_get() in ahci_platform_get_resources().

Thanks,
Bartosz Golaszewski
