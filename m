From: manabian@gmail.com (Joachim Eastwood)
Date: Mon, 4 May 2015 23:41:27 +0200
Subject: [PATCH 2/2] doc: dt: add documentation for lpc1850-rgu reset
 driver
In-Reply-To: <1430729465.3722.26.camel@pengutronix.de>
References: <1430173843-11648-1-git-send-email-manabian@gmail.com>
 <1430173843-11648-3-git-send-email-manabian@gmail.com>
 <1430729465.3722.26.camel@pengutronix.de>
Message-ID: <CAGhQ9VyB-k_hw=RJjeOK_r=fGZ55sPNCUpOA2zXgNkgbZpU3hA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 May 2015 at 10:51, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Joachim,
>
> please Cc: devicetree at vger.kernel.org for new device tree binding
> documentation.

okey, sorry about that. Will do for the next version.

> Am Dienstag, den 28.04.2015, 00:30 +0200 schrieb Joachim Eastwood:
>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>> ---
>>  .../devicetree/bindings/reset/nxp,lpc1850-rgu.txt  | 38 ++++++++++++++++++++++
>>  1 file changed, 38 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
>>
>> diff --git a/Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt b/Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
>> new file mode 100644
>> index 000000000000..45dbd6087731
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
>> @@ -0,0 +1,38 @@
>> +NXP LPC1850  Reset Generation Unit (RGU)
>> +========================================
>> +
>> +Please also refer to reset.txt in this directory for common reset
>> +controller binding usage.
>> +
>> +Required properties:
>> +- compatible: Should be "nxp,lpc1850-rgu"
>> +- reg: register base and length
>> +- clocks: phandle and clock specifier to RGU clocks
>> +- clock-names: should contain "delay" and "reg"
>> +- #reset-cells: should be 1
>> +
>> +Refer to NXP LPC18xx or LPC43xx user manual for a description of the
>> +reset signals and the connected block/peripheral.
>> +
>> +Reset provider example:
>> +rgu: reset-controller at 40053000 {
>> +     compatible = "nxp,lpc1850-rgu";
>> +     reg = <0x40053000 0x1000>;
>> +     clocks = <&cgu BASE_SAFE_CLK>, <&ccu1 CLK_CPU_BUS>;
>> +     clock-names = "delay", "reg";
>> +     #reset-cells = <1>;
>> +};
>> +
>> +Reset consumer example:
>> +mac: ethernet at 40010000 {
>> +     compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
>> +     reg = <0x40010000 0x2000>;
>> +     interrupts = <5>;
>> +     interrupt-names = "macirq";
>> +     clocks = <&ccu1 CLK_CPU_ETHERNET>;
>> +     clock-names = "stmmaceth";
>> +     resets = <&rgu 22>;
>
> I'd like the reset numbers to be documented in the binding docs.

Yes, that is good idea. I'll add it.

>The reset ordering seems to be the same across all users of this
>core?

Yes, there are no overlapping reset numbers between the LPC18xx and
LPC43xx. The new lines that were added on LPC43xx used reserved
numbers on the LPC18xx.

> Personally, I'd even prefer #defines like you have for the clock
> indices. I know others dislike this, though.

Like Arnd I prefer the raw numbers in DT. At least for this controller
where the number are consistent between the parts and there is a nice
table in the data sheet.

So if you don't mind I would like to keep using the raw numbers.

>> +     reset-names = "stmmaceth";
>> +     status = "disabled";
>> +};
>> +
>  ^^
> Superfluous whitespace.

I'll remove it.


Thanks for reviewing.

regards,
Joachim Eastwood
