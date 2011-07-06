From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 6 Jul 2011 14:01:24 +0800
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <CAGsJ_4xV7ecdqnB5gJDUDSg4nvebgubBj4qGJGaCtcpbj-b0gQ@mail.gmail.com>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106292329.44447.arnd@arndb.de>
	<BANLkTinfKCMcutMDQ+mpdD4EUy9mCpZs+w@mail.gmail.com>
	<201106301236.25822.arnd@arndb.de>
	<BANLkTikoMu3ccUxj5KRmKzdReQcBqK4Y9Q@mail.gmail.com>
	<CAGsJ_4wSKP6EUihOVbUJJ+HUynWGp8PA=8J_WhgmOtVhpd5_Lg@mail.gmail.com>
	<20110706053026.GB9978@ponder.secretlab.ca>
	<CAGsJ_4xV7ecdqnB5gJDUDSg4nvebgubBj4qGJGaCtcpbj-b0gQ@mail.gmail.com>
Message-ID: <CAGsJ_4yxUzMr4EJd5i0oW1tOa2oK7jicAehKVXXiU_SMDpTQ0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/6 Barry Song <21cnbao@gmail.com>:
> 2011/7/6 Grant Likely <grant.likely@secretlab.ca>:
>> On Tue, Jul 05, 2011 at 04:34:05PM +0800, Barry Song wrote:
>>> Hi Arnd,
>>>
>>> 2011/7/1 Barry Song <21cnbao@gmail.com>:
>>> > Hi Arnd,
>>> >
>>> > 2011/6/30 Arnd Bergmann <arnd@arndb.de>:
>>> >> On Thursday 30 June 2011, Barry Song wrote:
>>> >>
>>> >>> > Is this really just one bus with a huge address space, or rather some
>>> >>> > nested buses? I'd prefer to have the device tree representation as
>>> >>> > close as possible to the actual layout.
>>> >>>
>>> >>> there are two AXI buses in prima2. AXI-1 connect to memory, AXI-2 is
>>> >>> transferred to CSR self-defined IOBUS by CPUIF, then 1 intterupt
>>> >>> controller and 9 IO bridges are connected to the IOBUS .
>>> >>> The 9 IO bridges are SYSIOBG, PERIIOBG,CPURTCIOBG, UUSIOBG, GRAPHIOBG,
>>> >>> MEDIAIOBG, DSPIOBG, DISPIOBG, MEMIOBG. Every iobrg connect to a group
>>> >>> of controllers.
>>> >>> For example, DISPIOBG connect to VPP and LCD, SYSIOBG connect to CLKC,
>>> >>> RSTC, RSC and CPHIFBG, DSPIOBG connect to DSPIF, GPS and DSP.
>>> >>> PERIIOBG connect to TIMER, NAND, AUDIO, UART0, UART1, UART2, USP0,
>>> >>> USP1, USP2, SPI0, I2C0, I2C1, GPIO, *SYS2PCI* and so on. Then
>>> >>> *SYS2PCI* connect to SD.
>>> >>>
>>> >>> The indendation descible the device hierarchy
>>> >>> AXI-1
>>> >>> ? ? ? ? ?Memory
>>> >>> AXI-2
>>> >>> ? ? ? ? ?interrupt controller
>>> >>> ? ? ? ? ?IOBG...
>>> >>> ? ? ? ? ? ? ? ? ? xxxx
>>> >>> ? ? ? ? ?IOBG...
>>> >>> ? ? ? ? ? ? ? ? ? xxxx
>>> >>> ? ? ? ? ?IOBG...
>>> >>> ? ? ? ? ? ? ? ? ? xxxx
>>> >>> ? ? ? ? ?IOBG...
>>> >>> ? ? ? ? ? ? ? ? ? xxxx
>>> >>> ? ? ? ? ?IOBG...
>>> >>> ? ? ? ? ? ? ? ? ? xxxx
>>> >>> ? ? ? ? ?IOBG...
>>> >>> ? ? ? ? ? ? ? ? ? SYS2PCI
>>> >>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? SD
>>> >>>
>>> >>> i have get the IC guy Weizeng involved, maybe he can explain better than me :-)
>>> >>
>>> >> I think it would be good to represent the IOBG devices in the device tree then.
>>> >> You don't need to represent AXI-1 because memory is special anyway, and I would
>>> >> not bother to list SYS2PCI if the intention of that block was to hide the fact
>>> >> that it's PCI behind it. Properly instantiating it as a PCI bridge would be
>>> >> a lot of work that is probably not worth it.
>>> >>
>>> >> My usual plea to hardware developers: Please make the registers
>>> >> autodiscoverable from software! On an AMBA bus, please use the PrimeCell
>>> >> register layout. If you always have an IOBG device behind, they should
>>> >> all have the same identifier for that kind of bus bridge.
>>> >>
>>> >> For the IOBG, it would be ideal to have a similar way of finding and
>>> >> configuring the connected hardware, including:
>>> >>
>>> >> * unique identifier for each distinct IP block
>>> >> * revision of that block
>>> >> * MMIO ranges and sizes, relative to the bus
>>> >> * interrupt numbers, relative to a local interrupt controller
>>> >> * location identifier (like PCI bus/device/fn number) that can be
>>> >> ?referred to by other devices
>>> >> * clock management for that device
>>> >> * power management for that device
>>> >>
>>> >> If your IODB infrastructure already has this, you should create a new
>>> >> bus-type for this in Linux, which will let you detect all devices
>>> >> in a consistent manner without having to list them in the device tree.
>>> >
>>> > IO bridges in prima2 don't have that. Configuration is hardcoded now.
>>> > but we have learned so much from you and hope to improve our future IC
>>> > design.
>>>
>>>
>>> i have tried to figure out the full DT:
>>>
>>> /dts-v1/;
>>> / {
>>> ? ? ? model = "SiRF Prima2 EVB";
>>> ? ? ? compatible = "sirf,prima2-cb", "sirf,prima2";
>>> ? ? ? #address-cells = <1>;
>>> ? ? ? #size-cells = <1>;
>>> ? ? ? interrupt-parent = <&intc>;
>>>
>>> ? ? ? memory {
>>
>> memory at 0
>>
>>> ? ? ? ? ? ? ? reg = <0x00000000 0x20000000>;
>>> ? ? ? };
>>>
>>> ? ? ? chosen {
>>> ? ? ? ? ? ? ? bootargs = "mem=512M real_root=/dev/mmcblk0p2 console=ttyS0 panel=1
>>> bootsplash=true bpp=16 androidboot.console=ttyS1";
>>> ? ? ? ? ? ? ? linux,stdout-path = &uart1;
>>> ? ? ? };
>>>
>>> ? ? ? cpus {
>>> ? ? ? ? ? ? ? #address-cells = <1>;
>>> ? ? ? ? ? ? ? #size-cells = <0>;
>>>
>>> ? ? ? ? ? ? ? ARM-CortexA9,SiRFprimaII at 0 {
>>
>> cpu at 0 {
>>
>> Don't duplicate the crack that powerpc did for cpu node names. ?Use a
>> compatible property to identify the specific CPU model.
>>
>>> ? ? ? ? ? ? ? ? ? ? ? device_type = "cpu";
>>
>> Drop device_type here.
>>
>>> ? ? ? ? ? ? ? ? ? ? ? reg = <0x0>;
>>> ? ? ? ? ? ? ? ? ? ? ? d-cache-line-size = <32>;
>>> ? ? ? ? ? ? ? ? ? ? ? i-cache-line-size = <32>;
>>> ? ? ? ? ? ? ? ? ? ? ? d-cache-size = <32768>;
>>> ? ? ? ? ? ? ? ? ? ? ? i-cache-size = <32768>;
>>> ? ? ? ? ? ? ? ? ? ? ? /* from bootloader */
>>> ? ? ? ? ? ? ? ? ? ? ? timebase-frequency = <0>;
>>> ? ? ? ? ? ? ? ? ? ? ? bus-frequency = <0>;
>>> ? ? ? ? ? ? ? ? ? ? ? clock-frequency = <0>;
>>> ? ? ? ? ? ? ? };
>>> ? ? ? };
>>>
>>> ? ? ? axi {
>>> ? ? ? ? ? ? ? compatible = "simple-bus";
>>> ? ? ? ? ? ? ? #address-cells = <1>;
>>> ? ? ? ? ? ? ? #size-cells = <1>;
>>> ? ? ? ? ? ? ? ranges = <0x40000000 0x40000000 0x80000000>;
>>>
>>> ? ? ? ? ? ? ? l2-cache-controller at 0x80040000 {
>>
>> l2-cache-controller at 80040000 ?(Drop the '0x' from node names; address
>> in the node name is always hex.
>>
>>> ? ? ? ? ? ? ? ? ? ? ? compatible = "arm,pl310-cache", "cache";
>>
>> Drop the "cache" compatible value here.
>>
>>> ? ? ? ? ? ? ? ? ? ? ? reg = <0x80040000 0x1000>;
>>> ? ? ? ? ? ? ? ? ? ? ? interrupts = <59>;
>>> ? ? ? ? ? ? ? };
>>>
>>> ? ? ? ? ? ? ? sirfsoc-iobus {
>>> ? ? ? ? ? ? ? ? ? ? ? compatible = "simple-bus";
>>> ? ? ? ? ? ? ? ? ? ? ? #address-cells = <1>;
>>> ? ? ? ? ? ? ? ? ? ? ? #size-cells = <1>;
>>> ? ? ? ? ? ? ? ? ? ? ? ranges = <0x56000000 0x56000000 0x1b0000
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x80010000 0x80010000 0x30000
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? 0x88000000 0x88000000 0x40040000>;
>>>
>>> ? ? ? ? ? ? ? ? ? ? ? intc: interrupt-controller at 0x80020000 {
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? #interrupt-cells = <1>;
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? interrupt-controller;
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? compatible = "sirf,intc", "sirf,prima2-intc";
>>
>> This looks backwards. ?Most specific values should appear first.
>> "sirf,intc" looks to be generic when compared to "sirf,prima2-intc".
>> I'm also concerned that "sirf,intc" is trying to be too generic. ?As
>> much as possible compatible values should reflect a real
>> implementation of the interface, not a generic abstract name. ?Future
>> hardware can always claim compatibility with existing older hardware.
>> You're probably better off dropping "sirf,intc" entirely, and doing
>> the same for similar properties throughout the file.
>
> i have been confused by compatible in dts and drivers for some time.
> if an intc ip core is shared by two chips, for example, prima2 and
> atlas6. is the following right?
>
> in dts for prima2: compatible = "sirf,prima2-intc";
> in dts for atlas6: ?compatible = "sirf,prima2-atlas6";

sorry for typo. in dts for atlas6:  compatible = "sirf,atlas6-intc";

> in intc drivers shared for both: ? ? compatible = "sirf,prima2-intc",
> "sirf,prima2-atlas6";

sorry for typo.  compatible = "sirf,prima2-intc", "sirf,atlas6-intc";

>
> in my understanding, dts for special soc/board contains special
> compatible for the chip, drivers shared by multi-soc/board contain all
> compatible lists which can be supported by them?
>
> what's the generic way for this?
>
>>
>> Also, for every new compatible value make sure you add documentation
>> for it to Documentation/devicetree/bindings. (You may have already
>> done so, it's just something I remind people about a lot).
>>
>> These comments also apply through the rest of the file.
>>
>>
>
