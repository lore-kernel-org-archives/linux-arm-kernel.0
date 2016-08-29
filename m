From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 29 Aug 2016 07:24:15 -0500
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <201608291351.12915.arnd@arndb.de>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <2988918.zNxvaGl6en@wuerfel>
 <CACRpkdZ=HU6j3=Ye4dm=tFU=KmG54bq06KDfxPViWUouOA=jOA@mail.gmail.com>
 <201608291351.12915.arnd@arndb.de>
Message-ID: <CAL_JsqJPckLGDSiqnspvtP_=t+yZ+0vO-8MxGB6x7poOZiyK+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 6:51 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 August 2016, Linus Walleij wrote:
>> On Mon, Aug 8, 2016 at 11:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Monday, August 8, 2016 11:24:02 PM CEST Linus Walleij wrote:
>
>>
>> So two devices "foo" and "bar" on the EBI2 bus, in the old
>> scheme.
>>
>> So I need to encode the CS in the first cell of the reg for
>> foo-ebi2, and get rid of chipselect = <2> fine:
>>
>> ebi2 at 1a100000 {
>>        compatible = "qcom,msm8660-ebi2";
>>        #address-cells = <1>;
>>        #size-cells = <1>;
>>        (...)
>>        cs2 at 1b800000 {
>>                #address-cells = <2>;
>>                #size-cells = <1>;
>>                qcom,xmem-recovery-cycles = <5>;
>>                foo-ebi2 at 1b800000 {
>>                        compatible = "foo";
>>                        reg = <2 0x1b800000 0x100>;
>>                        (...)
>>                };
>>                bar-ebi2 at 1ba00000 {
>>                        compatible = "bar";
>>                        reg = <2 0x1ba00000 0x100>;
>>                        (...)
>>                };
>>        };
>> };
>>
>> This is not looking good at all. First: the configuration settings for
>> the chipselect (i.e. all devices below it, both "foo" and "bar" are
>> just floating in space. When parsing the tree how should you know
>> what chipselect to set up the stuff on? Shall I check the child nodes
>> first value in the reg property and then make a majority vote on what
>> chipselect they apply to or what? That doesn't make sense.
>
> I would have one node per chip-select and then put the devices on
> that CS below it, with #address-cells=1 again.

Actually, how I've been guiding folks is 2 levels of nodes.

eim {
  #address-cells = <3>;
  cs at 0,0 {
    compatible = "bar,some-device";
    foo,eim-timing-prop = <0>;
  };

This is how most bindings have been done. There's not really any point
to 3 levels other than keeping CS properties separate, but they don't
need to be if they are properly prefixed. The timing for a device is a
property of the device even though we express them in terms of the
controller.

>> So I assume doing away with the chipselect node altogether would
>> be prefered. But then: where do I put stuff like "qcom,xmem-recovery-cycles"
>> that apply to the whole chipselect, not just a single subdevice on that
>> chipselect? I certainly cannot encode it in the reg since it needs
>> to be the same for all devices and it's not about addressing.
>>
>> The only thing I can reasonably come up with would be this:
>>
>> ebi2 at 1a100000 {
>>        compatible = "qcom,msm8660-ebi2";
>>        #address-cells = <2>;
>>        #size-cells = <1>;
>>        qcom,xmem-recovery-cycles = <0>, <0>, <5>, <0>, <0>, <0>;
>
> No, better put the settings into one device per cs.

Yes.

>
>> So the chip select settings are shoehorned into an array in the top
>> node that is then indexed to find the settings for cs0, cs1 etc.
>>
>> There will be 6 such arrays for the different per-cs settings.
>>
>> Is this what you want? I kind of thought the hierarchical model
>> was nice since each device was below its chipselect node, but
>> I understand that it breaks the pattern of other similar bus drivers.
>
> Nothing wrong with having a hierarchy here, what I'm interested
> in is making the addressing reflect what the hardware actually
> does. With the empty "ranges", it looks like the entire 32-bit
> address is getting exposed to the external bus, which is usually
> not how things work: instead, each "cs" line gets raised by an I/O
> operation on a particular CPU address range, and that range should
> be part of the "ranges" propert of the main bus node, and the
> externally visible addresses should be the translated addresses
> in the child bus representation in DT.

Yes.
