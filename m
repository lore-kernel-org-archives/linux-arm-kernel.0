From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Dec 2017 08:12:24 +0100
Subject: [PATCH] ARM: realview: remove eb-mp clcd IRQ
In-Reply-To: <CACRpkdbCWZB1ZkrdGe0s0GfNVWEYY+NThy4ce-+SBtU-s=WNbQ@mail.gmail.com>
References: <20171221213146.3146805-1-arnd@arndb.de>
 <CACRpkdbCWZB1ZkrdGe0s0GfNVWEYY+NThy4ce-+SBtU-s=WNbQ@mail.gmail.com>
Message-ID: <CAK8P3a1e87EKuV9gPO9H-D4rhBxx-GecWowkpLPDJ33HPQk3FQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 21, 2017 at 11:08 PM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Thu, Dec 21, 2017 at 10:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>
>> We get a dtc warning about the CLCD interrupt being invalid:
>>
>> arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /fpga/charlcd at 10008000
>>
>> According to the datasheet I found and the old board file, this
>> line is not connected, so I'm removing the respective properties here.
>>
>> Link: http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0411d/index.html
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> There is some confusion here. There is CLCD "Color LCD"
> which is just a code name for PrimeCell PL111 and there is the actual
> character LCD which is a hardware thin to talk to a character LCD with
> some characters on.
>
>> diff --git a/arch/arm/boot/dts/arm-realview-eb-mp.dtsi b/arch/arm/boot/dts/arm-realview-eb-mp.dtsi
>
> So this DTS is for the ARM 11 MP core tile which is described in
> DUI0318F. It doesn't even list an IRQ for the character LCD.
>
>>  &charlcd {
>> -       interrupt-parent = <&intc>;
>> -       interrupts = <0  IRQ_TYPE_LEVEL_HIGH>;
>
> This was probably me thinking to go back and fill in the right
> IRQ and forgetting to actually do it. Sorry :(
>
>> +       /* CLCD is not connected here */
>
> Call it character LCD instead to avoid confusion please.
>
>> +       /delete-property/interrupt-parent;
>> +       /delete-property/interrupts;
>
> I don't understand this delete-property business (first time
> I see it, but the top level
> DTSI (arm-realview-eb.dtsi) does not define any interrupt
> so can't you just delete this whole &charlcd?
>
> I do think the reference design has a character LCD, and I
> do think it has an interrupt, it's just undocumented so
> someone with this board would have to test it manually
> to figure out which line it is. Whoever uses this design
> will get to it if ever.

Sounds good, can you prepare a patch for this?

We are getting very close to zero warnings now with the
latest arm-soc/for-next branch:

arch/arm/boot/dts/arm-realview-eb-11mp.dtb: Warning
(interrupts_property): interrupts size is (8), expected multiple of 12
in /fpga/charlcd at 10008000
arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd.dtb: Warning
(interrupts_property): interrupts size is (8), expected multiple of 12
in /fpga/charlcd at 10008000
arch/arm/boot/dts/arm-realview-eb-11mp-ctrevb.dtb: Warning
(interrupts_property): interrupts size is (8), expected multiple of 12
in /fpga/charlcd at 10008000
arch/arm/boot/dts/arm-realview-eb-a9mp.dtb: Warning
(interrupts_property): interrupts size is (8), expected multiple of 12
in /fpga/charlcd at 10008000
arch/arm/boot/dts/arm-realview-eb-11mp-bbrevd-ctrevb.dtb: Warning
(interrupts_property): interrupts size is (8), expected multiple of 12
in /fpga/charlcd at 10008000
arch/arm/boot/dts/arm-realview-eb-a9mp-bbrevd.dtb: Warning
(interrupts_property): interrupts size is (8), expected multiple of 12
in /fpga/charlcd at 10008000
arch/arm/boot/dts/s5pv210-smdkv210.dtb: Warning (interrupts_property):
Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-smdkc110.dtb: Warning (interrupts_property):
arch/arm/boot/dts/s5pv210-goni.dtb: Warning (interrupts_property):
Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-aquila.dtb: Warning (interrupts_property):
Missing interrupt-parent for /soc/ohci at ec300000
Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/s5pv210-torbreck.dtb: Warning (interrupts_property):
Missing interrupt-parent for /soc/ohci at ec300000
arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property):
Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi at e0100000
arch/arm/boot/dts/spear1310-evb.dtb: Warning (gpios_property): Missing
property '#gpio-cells' in node /interrupt-controller at ec801000 or bad
phandle (referred from /ahb/apb/spi at e0100000:cs-gpios[6])
arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Property
'dmas', cell 4 is not a phandle reference in /ahb/apb/serial at b4100000
arch/arm/boot/dts/spear1340-evb.dtb: Warning (dmas_property): Missing
property '#dma-cells' in node /interrupt-controller at ec801000 or bad
phandle (referred from /ahb/apb/serial at b4100000:dmas[4])
arch/arm/boot/dts/stih407-b2120.dtb: Warning (gpios_property):
hdmi,hpd-gpio property size (8) too small for cell size 2 in
/soc/sti-display-subsystem/sti-hdmi at 8d04000
arch/arm/boot/dts/stih410-b2120.dtb: Warning (gpios_property):
hdmi,hpd-gpio property size (8) too small for cell size 2 in
/soc/sti-display-subsystem/sti-hdmi at 8d04000
arch/arm/boot/dts/stih410-b2260.dtb: Warning (gpios_property):
hdmi,hpd-gpio property size (8) too small for cell size 2 in
/soc/sti-display-subsystem/sti-hdmi at 8d04000
arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property):
power-gpio property size (12) too small for cell size 3 in
/ahb/apb/i2c at 400A0000/uda1380 at 18
arch/arm/boot/dts/lpc3250-ea3250.dtb: Warning (gpios_property):
reset-gpio property size (12) too small for cell size 3 in
/ahb/apb/i2c at 400A0000/uda1380 at 18
arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property):
power-gpio property size (12) too small for cell size 3 in
/ahb/apb/i2c at 400A0000/uda1380 at 18
arch/arm/boot/dts/lpc3250-phy3250.dtb: Warning (gpios_property):
reset-gpio property size (12) too small for cell size 3 in
/ahb/apb/i2c at 400A0000/uda1380 at 18
arch/arm/boot/dts/ste-nomadik-s8815.dtb: Warning
(interrupts_property): Missing interrupt-parent for
/amba/clcd at 10120000
arch/arm/boot/dts/ste-nomadik-nhk15.dtb: Warning
(interrupts_property): Missing interrupt-parent for
/amba/clcd at 10120000
arch/arm/boot/dts/spear600-evb.dtb: Warning (interrupts_property):
Missing interrupt-parent for /ahb/apb/rtc at fc900000

Can you also look at the nomadik warnings and possibly some of the others
if you have time? Unfortunately I'm heading out for my Christmas vacation
and can't do any others of these any more.

      Arnd
