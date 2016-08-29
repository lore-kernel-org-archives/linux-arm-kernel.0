From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 29 Aug 2016 09:06:49 -0500
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <CACRpkdaRPa=tCH2FQUOUzp0Q2YvdLNA7R2y3w==sH40DwJ2vGA@mail.gmail.com>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <2988918.zNxvaGl6en@wuerfel>
 <CACRpkdZ=HU6j3=Ye4dm=tFU=KmG54bq06KDfxPViWUouOA=jOA@mail.gmail.com>
 <201608291351.12915.arnd@arndb.de>
 <CAL_JsqJPckLGDSiqnspvtP_=t+yZ+0vO-8MxGB6x7poOZiyK+Q@mail.gmail.com>
 <CACRpkdaRPa=tCH2FQUOUzp0Q2YvdLNA7R2y3w==sH40DwJ2vGA@mail.gmail.com>
Message-ID: <CAL_JsqJSO4Bco_BJqYFVEQ73_-nm_QeHy=HF3u6bNhxsikOAGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 8:13 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Aug 29, 2016 at 2:24 PM, Rob Herring <robh+dt@kernel.org> wrote:
>> On Mon, Aug 29, 2016 at 6:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>>> I would have one node per chip-select and then put the devices on
>>> that CS below it, with #address-cells=1 again.
>>
>> Actually, how I've been guiding folks is 2 levels of nodes.
>>
>> eim {
>>   #address-cells = <3>;
>>   cs at 0,0 {
>>     compatible = "bar,some-device";
>>     foo,eim-timing-prop = <0>;
>>   };
>>
>> This is how most bindings have been done. There's not really any point
>> to 3 levels other than keeping CS properties separate, but they don't
>> need to be if they are properly prefixed. The timing for a device is a
>> property of the device even though we express them in terms of the
>> controller.
>
> This is what I'm doing in the most recent version from aug 24 I think.
> http://marc.info/?l=linux-arm-kernel&m=147202889622540&w=2
>
>>>> ebi2 at 1a100000 {
>>>>        compatible = "qcom,msm8660-ebi2";
>>>>        #address-cells = <2>;
>>>>        #size-cells = <1>;
>>>>        qcom,xmem-recovery-cycles = <0>, <0>, <5>, <0>, <0>, <0>;
>>>
>>> No, better put the settings into one device per cs.
>>
>> Yes.
>
> Gnah. Each chipselect can (in theory) house several memory-mapped
> devices at different offsets. Like two ethernet controllers. It gets a bit
> weird.

Then perhaps that is a case for a middle CS node. Or you can have 2
nodes on same CS with different offsets:

dev at 0,0 {};
dev at 0,10000 {};
dev at 1,0 {};

I guess either timing props get duplicated or you designate the first
node has them (2 devices on the same CS need to have the same timing
or have s/w setup per access).

> This is how it currently looks (v2):
>
> ebi2 at 1a100000 {
>     compatible = "qcom,apq8060-ebi2";
>     #address-cells = <2>;
>     #size-cells = <1>;
>     ranges = <0 0x0 0x1a800000 0x00800000>,
>         <1 0x0 0x1b000000 0x00800000>,
>         <2 0x0 0x1b800000 0x00800000>,
>         <3 0x0 0x1d000000 0x00800000>,
>         <4 0x0 0x1c800000 0x00800000>,
>         <5 0x0 0x1c000000 0x00800000>;
>     reg = <0x1a100000 0x1000>, <0x1a110000 0x1000>;
>     reg-names = "ebi2", "xmem";
>     qcom,xmem-recovery-cycles = <0>, <0>, <0>, <0>, <0>, <0>;
>     qcom,xmem-write-hold-cycles = <0>, <0>, <3>, <0>, <0>, <0>;
>     qcom,xmem-write-delta-cycles = <0>, <0>, <31>, <0>, <0>, <0>;
>     qcom,xmem-read-delta-cycles = <0>, <0>, <28>, <0>, <0>, <0>;
>     qcom,xmem-write-wait-cycles = <0>, <0>, <9>, <0>, <0>, <0>;
>     qcom,xmem-read-wait-cycles = <0>, <0>, <9>, <0>, <0>, <0>;
>
>     foo-ebi2 at 1b800000 {
>         compatible = "foo";
>         reg = <2 0x0 0x100>;
>         (...)
>     };
> };
>
> That is very close to how
> Documentation/devicetree/bindings/bus/imx-weim.txt
> drivers/bus/imx-weim.c
> does things, just with the additional property arrays.

Maybe so, but I'm trying to bring some consistency here, so I'd
suggest looking at newer ones like atmel IIRC.

> By looping over the subnodes and inspecting the first address cell of
> them I can figure out what chipselects need to be turned on, and
> the settings for those chipselects I need to activate are taken from
> those 6 qcom,xmem* arrays of timings.
>
> So if I reintroduce the cs nodes how do you imagine it'd look? Like this?

Between the 3 choices, what I've said is obviously my 1st choice. This
one would be 2nd (though chipselect should be part of the address
translation as Arnd suggested). The one above would be last.

> ebi2 at 1a100000 {
>     compatible = "qcom,apq8060-ebi2";
>     #address-cells = <1>;
>     #size-cells = <1>;
>     reg = <0x1a100000 0x1000>, <0x1a110000 0x1000>;
>     reg-names = "ebi2", "xmem";
>
>    cs at 2 {
>        compatible = "bar,some-device";
>        #address-cells = <1>;
>        #size-cells = <1>;
>        ranges = <0x0 0x1b800000 0x00800000>;
>        chipselect = <2>;
>        foo,eim-timing-prop = <0>;
>        qcom,xmem-recovery-cycles = <0>;
>        qcom,xmem-write-hold-cycles = <3>;
>        qcom,xmem-write-delta-cycles = <31>;
>        qcom,xmem-read-delta-cycles = <28>;
>        qcom,xmem-write-wait-cycles = <9>;
>        qcom,xmem-read-wait-cycles = <9>;
>
>        foo-ebi2 at 0 {
>            compatible = "foo";
>            reg = <0x0 0x100>;
>            (...)
>        };
>
>        bar-ebi2 at 100 {
>            compatible = "bar";
>            reg = <0x100 0x100>;
>            (...)
>        };
>
>     };
> };
>
> Note: the chipselect goes out of the address cell, into the old
> chipselect = <n> property, because we have no other way to know
> which chipselect the settings apply to! (It's not like we can parse
> the subnodes and make a majority decision...)
>
> I kind of think both are non-perfect but the first one is the lesser
> evil.
>
> Yours,
> Linus Walleij
