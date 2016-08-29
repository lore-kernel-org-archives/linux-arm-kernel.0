From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Aug 2016 14:45:49 +0200
Subject: [PATCH 1/4] soc: qcom: add an EBI2 device tree bindings
In-Reply-To: <201608291351.12915.arnd@arndb.de>
References: <1470691445-27571-1-git-send-email-linus.walleij@linaro.org>
 <2988918.zNxvaGl6en@wuerfel>
 <CACRpkdZ=HU6j3=Ye4dm=tFU=KmG54bq06KDfxPViWUouOA=jOA@mail.gmail.com>
 <201608291351.12915.arnd@arndb.de>
Message-ID: <CACRpkdZ4bGJYuR+hJQ5sZR+pYQ5dnmtHY6RRS0oLtcd_N=akZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2016 at 1:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 18 August 2016, Linus Walleij wrote:

>> This is not looking good at all. First: the configuration settings for
>> the chipselect (i.e. all devices below it, both "foo" and "bar" are
>> just floating in space. When parsing the tree how should you know
>> what chipselect to set up the stuff on? Shall I check the child nodes
>> first value in the reg property and then make a majority vote on what
>> chipselect they apply to or what? That doesn't make sense.
>
> I would have one node per chip-select and then put the devices on
> that CS below it, with #address-cells=1 again.

Hm I already sent out a new version I think...
http://marc.info/?l=linux-arm-kernel&m=147202889722541&w=2
http://marc.info/?l=linux-arm-kernel&m=147202889622540&w=2
http://marc.info/?l=linux-arm-kernel&m=147202890622543&w=2
http://marc.info/?l=linux-arm-kernel&m=147202894222555&w=2
http://marc.info/?l=linux-arm-kernel&m=147202898022571&w=2

(OK I know, no patience this guy...)

Check it and see what you think.

>> ebi2 at 1a100000 {
>>        compatible = "qcom,msm8660-ebi2";
>>        #address-cells = <2>;
>>        #size-cells = <1>;
>>        qcom,xmem-recovery-cycles = <0>, <0>, <5>, <0>, <0>, <0>;
>
> No, better put the settings into one device per cs.

Yeah sigh I already made a version like this...

> Nothing wrong with having a hierarchy here, what I'm interested
> in is making the addressing reflect what the hardware actually
> does. With the empty "ranges", it looks like the entire 32-bit
> address is getting exposed to the external bus, which is usually
> not how things work: instead, each "cs" line gets raised by an I/O
> operation on a particular CPU address range, and that range should
> be part of the "ranges" propert of the main bus node, and the
> externally visible addresses should be the translated addresses
> in the child bus representation in DT.

I have fixed the ranges too in the new version.

Yours,
Linus Walleij
