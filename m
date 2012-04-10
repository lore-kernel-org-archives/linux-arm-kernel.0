From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 10 Apr 2012 08:24:49 +0100
Subject: [PATCH 4/7] drivers/gpio: gpio-nomadik: Provide documentation
 for Device Tree bindings
In-Reply-To: <20120406042054.C0C433E0C86@localhost>
References: <1333619748-16126-1-git-send-email-lee.jones@linaro.org>
 <1333619748-16126-5-git-send-email-lee.jones@linaro.org>
 <20120406042054.C0C433E0C86@localhost>
Message-ID: <4F83E041.7040108@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/12 05:20, Grant Likely wrote:
> On Thu,  5 Apr 2012 10:55:45 +0100, Lee Jones<lee.jones@linaro.org>  wrote:
>> Add required documentation for specific gpio-nomadik DT bindings.
>>
>> Signed-off-by: Lee Jones<lee.jones@linaro.org>
>> ---
>>   .../devicetree/bindings/gpio/gpio-nmk.txt          |   29 ++++++++++++++++++++
>>   1 files changed, 29 insertions(+), 0 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/gpio/gpio-nmk.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-nmk.txt b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
>> new file mode 100644
>> index 0000000..1555029
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-nmk.txt
>> @@ -0,0 +1,29 @@
>> +Nomadik GPIO controller
>> +
>> +Required properties:
>> +- compatible           : Should be "stmicroelectronics,nomadik-gpio".
>
> "stmicroelectronics," is a really long prefix.  You can use simply
> "st," here since it has already been defined and documented in
> Documentation/devicetree/bindings/vendor-prefixes.txt

Absolutely.

>> +- reg                  : Physical base address and length of the controller's registers.
>> +- interrupts           : The interrupt outputs from the controller.
>> +- #gpio-cells          : Should be two:
>> +                           The first cell is the pin number.
>> +                           The second cell is used to specify optional parameters:
>> +                             - bits[3:0] trigger type and level flags:
>> +                                 1 = low-to-high edge triggered.
>> +                                 2 = high-to-low edge triggered.
>> +                                 4 = active high level-sensitive.
>> +                                 8 = active low level-sensitive.
>
> Those look like interrupt flags, not gpio flags.  If the gpio lines
> can be used as generic irq input lines, then this node should also
> declare itself as an interrupt controller.

They can and it will do in an up-coming patch.

>> +- gpio-controller      : Marks the device node as a GPIO controller.
>> +- supports-sleepmode   : Specifies whether controller can sleep or not
>
> Typically, custom properites that are for a specific device should be
> prefixed with the manufacturer name.  So, something like:
> "st,has-sleepmode".

No problem.

>> +- gpio-bank            : Specifies which bank a controller owns.
>
> What is this for (how is it used)?  It shouldn't be needed to specify
> a bank number.

Briefly, it is used like this:

of_property_read_u32(np, "gpio-bank", &bank);
chip->base = bank * NMK_GPIO_PER_CHIP;
nmk_chip->bank = bank;

Is that wrong? If so, is there a better way to do it?

Thanks Grant.

Kind regards,
Lee

>> +
>> +Example:
>> +
>> +                gpio1: gpio at 8012e080 {
>> +                        compatible = "stmicroelectronics,nomadik-gpio";
>> +                        reg =<0x8012e080 0x80>;
>> +                        interrupts =<0 120 0x4>;
>> +                        #gpio-cells =<2>;
>> +                        gpio-controller;
>> +                        supports-sleepmode;
>> +                        gpio-bank =<1>;
>> +                };
>> --
>> 1.7.9.1
>>
>


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
