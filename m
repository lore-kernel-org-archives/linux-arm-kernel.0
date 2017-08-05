From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 5 Aug 2017 23:41:11 +0200
Subject: [PATCH] ARM: dts: Add DTS file for D-Link DIR-685
In-Reply-To: <CAMuHMdXmCOOuM_s1MS8o1RcAnV5mVfOwtj9DEuVisnQAT1tCVw@mail.gmail.com>
References: <20170715170511.16312-1-linus.walleij@linaro.org>
 <CAMuHMdXmCOOuM_s1MS8o1RcAnV5mVfOwtj9DEuVisnQAT1tCVw@mail.gmail.com>
Message-ID: <CACRpkdZtmMVQAsRsxfdyWH5xHv+5yP1AGpSTtNLCs+bAKbNYrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 17, 2017 at 9:54 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Sat, Jul 15, 2017 at 7:05 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>> This adds a device tree file for the Gemini-based D-Link DIR-685
>> router, supporting all devices that are currently supported in
>> the main DTSI SoC file.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

>> +       chosen {
>> +               bootargs = "console=ttyS0,19200n8";
>
> I think you can drop bootargs, as stdout-path is present.
>
>> +               stdout-path = &uart0;
>
> stdout-path = "uart0:115200n8";

OK this works fine! Thanks.

>> +               button at 8 {
>
> button-esc { ... } ?

>> +               button at 13 {
>
> button-eject { ... } ?

OK fixed this.

>> +               led at 7 {
>
> led-wps?
>
>> +               led at 11 {
>
> led-blue? (does it have a label on the box? HD1?)

OK fixed this.

>> +                       label = "dir685:blue:HD";
>
> Looks like a legacy platform device name, not a DT label.

That is coincidental. I was told in the past (by other reviewers)
to name LEDs as "platform:color:function".

c.f.
armada-370-dlink-dns327l.dts:

gpio-leds {
        sata-l-amber-pin {
                label = "dns327l:amber:sata-l";
(...)

>> +       gpio-i2c {
>> +               compatible = "i2c-gpio";
>> +               gpios = <&gpio0 5 0>, /* SDA */
>> +                       <&gpio0 6 0>; /* SCL */
>
> The i2c-gpio DT bindings really should be amended to support (optional)
> gpio-names.

It's not needed I think, I can name the lines with gpio-line-names
and the labels added by the subsystem in Linux looks really nice
in lsgpio:

GPIO chip: gpiochip0, "FTGPIO010", 32 GPIO lines
        line  0: unnamed unused
        line  1: unnamed unused
        line  2: unnamed unused
        line  3: unnamed unused
        line  4: unnamed unused
        line  5: unnamed "sda" [kernel]
        line  6: unnamed "scl" [kernel]
        line  7: unnamed "dir685:blue:WPS" [kernel output active-low]
        line  8: unnamed "reset" [kernel active-low]

Cool eh? :)

>> +                       /*
>> +                        * This "RedBoot" is the Storlink derivative.
>> +                        */
>> +                       partition at 0 {
>
> Shouldn't partitions be in a subnode named "partitions"?

Hm yeah that is the new style I guess. That requires a separate
patch to patch all DT[I|S] files though.

>> +               sata: sata at 46000000 {
>
> "&sata {", and move outside hierarchy.
>
> Add "pci" label to gemini.dtsi, "&pci {", and move outside hiearchy.
>
> Add "ata" label to gemini.dtsi, "&pci {", and move outside hiearchy.

I am under the impression that whether to use the &node style or
overlay style (use the same node names) is a matter of taste.
All other DTS files for this platform use this style, so I prefer to keep
to it.

Older DTSes and qcom DTs do this too... but others such as Marvell
use this &node style.

If some DT maintainers step out and say they want all to be done
this way for everyone I guess I can make a patch changing them
all and the base DTSI as well, but on top of this patch.

Yours,
Linus Walleij
