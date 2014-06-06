From: robherring2@gmail.com (Rob Herring)
Date: Fri, 6 Jun 2014 09:05:03 -0500
Subject: [PATCH v2 3/3] Documentation: gpio: Add APM X-Gene SoC GPIO
 controller DTS binding
In-Reply-To: <CAAVeFuK_r0HcTAy+BCYZM0+PrqSrduQgOeqggYtSdAgzAxbx+A@mail.gmail.com>
References: <1401391413-3833-1-git-send-email-fkan@apm.com>
 <1401391413-3833-4-git-send-email-fkan@apm.com>
 <CAAVeFuK_r0HcTAy+BCYZM0+PrqSrduQgOeqggYtSdAgzAxbx+A@mail.gmail.com>
Message-ID: <CAL_JsqJeC9AVDGcu6TK4fRGGWVYxt36BHNfObhu68mm6XNzs7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 6, 2014 at 12:04 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Fri, May 30, 2014 at 4:23 AM, Feng Kan <fkan@apm.com> wrote:
>> Documentation for APM X-Gene SoC GPIO controller DTS binding.
>
> This patch should come before 2/3. You want the binding to be visible
> before adding entries following it.
>
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  .../devicetree/bindings/gpio/gpio-xgene.txt        | 37 ++++++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>>
>> diff --git a/Documentation/devicetree/bindings/gpio/gpio-xgene.txt b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>> new file mode 100644
>> index 0000000..7219575
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/gpio/gpio-xgene.txt
>> @@ -0,0 +1,37 @@
>> +APM X-Gene SoC GPIO controller bindings
>> +
>> +This is a gpio controller that is part of the flash controller.
>> +All registers are 32bit and in little endian format.
>
> Mmm, does your driver take care of endianness issue if this controller
> is used on big-endian architectures?
>
>> +
>> +There are three flash controller gpio banks, each bank have 16
>> +gpio pins.
>> +
>> +Required properties:
>> +- compatible: "apm,xgene-gpio" for X-Gene GPIO controller
>> +- reg: Physical base address and size of the controller's registers
>> +- #gpio-cells: Should be two.
>> +       - first cell is the pin number
>> +       - second cell is used to specify optional parameters (unused)
>> +- gpio-controller: Marks the device node as a GPIO controller.
>> +
>> +Example:
>> +       gpio0: gpio0 at 1701c00c {
>> +               compatible = "apm,xgene-gpio";
>> +               reg = <0x0 0x1701c00c 0x0 0x30>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +       };
>> +
>> +       gpio1: gpio1 at 1701c018 {
>> +               compatible = "apm,xgene-gpio";
>> +               reg = <0x0 0x1701c018 0x0 0x30>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +       };
>> +
>> +       gpio2: gpio2 at 1701c024 {
>> +               compatible = "apm,xgene-gpio";
>> +               reg = <0x0 0x1701c024 0x0 0x30>;
>> +               gpio-controller;
>> +               #gpio-cells = <2>;
>> +       };
>
> While I like this better than the first version, I wonder if we should
> not have this as a single device, with each bank having an entry in
> the reg property. Something like:
>
> gpio at 1701c00c {
>         compatible = "apm,xgene-gpio";
>         reg = <0x0 0x1701c00c 0x0 0x30
>                0x0 0x1701c018 0x0 0x30
>                0x0 0x1701c024 0x0 0x30>;

In both versions, these sizes create overlapping resources. Don't do that.

You could fix it with a size of 0xC, but I think that is overkill.
Just put the knowledge that the bank stride is 0xC in the driver and
do a single node. Otherwise you end up with 3 mappings to the same
address or complex parsing code to avoid that.

Unless the h/w is really so configurable that it could be any sets of
addresses, just describe the base address. If the number of banks is
configurable, then add a property for that.

Rob
