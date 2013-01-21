From: 21cnbao@gmail.com (Barry Song)
Date: Mon, 21 Jan 2013 10:44:20 +0800
Subject: [PATCH v2 1/9] ARM: PRIMA2: add CSR SiRFmarco device tree .dts
In-Reply-To: <20130116113759.GB10218@e106331-lin.cambridge.arm.com>
References: <1358315610-25001-1-git-send-email-Barry.Song@csr.com>
 <20130116113759.GB10218@e106331-lin.cambridge.arm.com>
Message-ID: <CAGsJ_4wk-4E6bFnyBO=YHbuo1eEkrSDGxu+BCP1=nW4JQ19Tkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,
thanks very much for reviewing.

2013/1/16 Mark Rutland <mark.rutland@arm.com>:
> Hello,
>
> This looks pretty good. I've tried to give a more thorough review this time,
> so hopefully these comments should be my last.
>
> On Wed, Jan 16, 2013 at 05:53:27AM +0000, Barry Song wrote:
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> SiRFmarco is a dual-core cortex-a9 SMP SoC from CSR. this patch
>> adds the .dtsi and a basic evb board .dts for it.
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> Cc: Mark Rutland <mark.rutland@arm.com>
>> ---
>>  arch/arm/boot/dts/marco-evb.dts |   51 +++
>>  arch/arm/boot/dts/marco.dtsi    |  756 +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 807 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/marco-evb.dts
>>  create mode 100644 arch/arm/boot/dts/marco.dtsi
>>
>> diff --git a/arch/arm/boot/dts/marco-evb.dts b/arch/arm/boot/dts/marco-evb.dts
>> new file mode 100644
>> index 0000000..4e68d3c
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/marco-evb.dts
>> @@ -0,0 +1,51 @@
>> +/*
>> + * DTS file for CSR SiRFmarco Evaluation Board
>> + *
>> + * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +/include/ "marco.dtsi"
>> +
>> +/ {
>> +       model = "CSR SiRFmarco Evaluation Board";
>> +       compatible = "sirf,marco", "sirf,marco-cb";
>
> Shouldn't "sirf,marco-cb" come before "sirf,marco", so we have the most
> specific match first?

agree.
>
> It would also be nice if both compatible strings were documented.

will have it in Documentation/devicetree/bindings/arm/sirf.txt

>
>> +
>> +       memory {
>> +               reg = <0x40000000 0x60000000>;
>> +       };
>> +
>> +       axi {
>> +               peri-iobg {
>> +                       uart1: uart at cc060000 {
>> +                               status = "okay";
>> +                       };
>> +                       i2c0: i2c at cc0e0000 {
>> +                             status = "okay";
>> +                             fpga-cpld at 4d {
>> +                                     compatible = "sirf,fpga-cpld";
>> +                                     reg = <0x4d>;
>> +                             };
>> +                       };
>> +                       spi1: spi at cc170000 {
>> +                               status = "okay";
>> +                               pinctrl-names = "default";
>> +                               pinctrl-0 = <&spi1_pins_a>;
>> +                               spi at 0 {
>> +                                       compatible = "spidev";
>> +                                       reg = <0>;
>> +                                       spi-max-frequency = <1000000>;
>> +                               };
>> +                       };
>> +                       pci-iobg {
>> +                               sd0: sdhci at cd000000 {
>> +                                       bus-width = <8>;
>> +                                       status = "okay";
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +};
>> diff --git a/arch/arm/boot/dts/marco.dtsi b/arch/arm/boot/dts/marco.dtsi
>> new file mode 100644
>> index 0000000..d6bad50
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/marco.dtsi
>> @@ -0,0 +1,756 @@
>> +/*
>> + * DTS file for CSR SiRFmarco SoC
>> + *
>> + * Copyright (c) 2012 Cambridge Silicon Radio Limited, a CSR plc group company.
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +/include/ "skeleton.dtsi"
>> +/ {
>> +       compatible = "sirf,marco";
>> +       #address-cells = <1>;
>> +       #size-cells = <1>;
>> +       interrupt-parent = <&gic>;
>> +
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               cpu at 0 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a9";
>> +                       reg = <0>;
>> +               };
>> +               cpu at 1 {
>> +                       device_type = "cpu";
>> +                       compatible = "arm,cortex-a9";
>> +                       reg = <1>;
>> +               };
>> +       };
>
> Nice to see the reg properties present :)
>
> Do the CPUs support the performance monitors extension, and if so are
> interrupts wired up?
>
> If so it'd be nice to see a pmu node:
>
> pmu {
>         compatible = "arm,cortex-a9-pmu";
>         interrupts = <cpu0-irq>,
>                      <cpu1-irq>;
> };
>

as there is a driver arch/arm/kernel/perf_event_cpu.c commited on Jul
29 2012, pmu nodes are really necessary if there is one in SoC.
the problem is we are using a fpga,  and not sure the final design, so
i'd like to keep this and some following detailed IC issues you
comment to the future fixes.

>> +
>> +       axi {
>> +               compatible = "simple-bus";
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               ranges = <0x40000000 0x40000000 0xa0000000>;
>> +
>> +               l2-cache-controller at c0030000 {
>> +                       compatible = "sirf,marco-pl310-cache", "arm,pl310-cache";
>> +                       reg = <0xc0030000 0x1000>;
>> +                       interrupts = <0 59 0>;
>> +                       arm,tag-latency = <1 1 1>;
>> +                       arm,data-latency = <1 1 1>;
>> +                       arm,filter-ranges = <0x40000000 0x80000000>;
>> +               };
>> +
>> +               gic: interrupt-controller at c0011000 {
>> +                       compatible = "arm,cortex-a9-gic";
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <3>;
>> +                       reg = <0xc0011000 0x1000>,
>> +                             <0xc0010100 0x0100>;
>> +               };
>> +
>> +               rstc-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc2000000 0xc2000000 0x1000000>;
>> +
>> +                       reset-controller at c2000000 {
>> +                               compatible = "sirf,marco-rstc";
>> +                               reg = <0xc2000000 0x10000>;
>> +                       };
>> +               };
>> +
>> +               sys-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc3000000 0xc3000000 0x1000000>;
>> +
>> +                       clock-controller at c3000000 {
>> +                               compatible = "sirf,marco-clkc";
>> +                               reg = <0xc3000000 0x1000>;
>> +                               interrupts = <0 3 0>;
>> +                       };
>> +
>> +                       rsc-controller at c3010000 {
>> +                               compatible = "sirf,marco-rsc";
>> +                               reg = <0xc3010000 0x1000>;
>> +                       };
>
> I assume an update for the clk-prima2 driver is going out in a separate series
> to enable these compatible strings?

yes. there are more PLLs, dividers and clk gates in marco than prima2.
i'll have seperate patches for them, for the moment, i can't as clk
tree is not included in the fpga.

>
> Is the hardware backwards compatible with the prima2 variant? If so, you could
> append the sirf,prima2 variant to the compatible lists and save a lot of churn
> in drivers.

not completely compatible. for the performance consideration, marco
has splitted many shared registers to SET/CLEAR pair to avoid frequent
read-modify-write.

>
>> +               };
>> +
>> +               mem-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc4000000 0xc4000000 0x1000000>;
>> +
>> +                       memory-controller at c4000000 {
>> +                               compatible = "sirf,marco-memc";
>> +                               reg = <0xc4000000 0x10000>;
>> +                               interrupts = <0 27 0>;
>> +                       };
>
> Again, if this is compatible with the prima2 variant, it'd be good to append
> the prima2 variant's compatible string.
>
>> +               };
>> +
>> +               disp-iobg0 {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc5000000 0xc5000000 0x1000000>;
>> +
>> +                       display0 at c5000000 {
>> +                               compatible = "sirf,marco-lcd";
>> +                               reg = <0xc5000000 0x10000>;
>> +                               interrupts = <0 30 0>;
>> +                       };
>> +
>> +                       vpp0 at c5010000 {
>> +                               compatible = "sirf,marco-vpp";
>> +                               reg = <0xc5010000 0x10000>;
>> +                               interrupts = <0 31 0>;
>> +                       };
>
> And again, though I can't find any string matching "sirf,.*-lcd" or
> "sirf,.*-vpp" in v3.8-rc3.

i'd like to leave the confirmation of them to the day IC is fixed and
related drivers are begun.
for the moment, all teams need a basic Linux infrasture and baseline
to move things ahead.

>
>> +               };
>> +
>> +               disp-iobg1 {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc6000000 0xc6000000 0x1000000>;
>> +
>> +                       display1 at c6000000 {
>> +                               compatible = "sirf,marco-lcd";
>> +                               reg = <0xc6000000 0x10000>;
>> +                               interrupts = <0 62 0>;
>> +                       };
>> +
>> +                       vpp1 at c6010000 {
>> +                               compatible = "sirf,marco-vpp";
>> +                               reg = <0xc6010000 0x10000>;
>> +                               interrupts = <0 63 0>;
>> +                       };
>
> And again.
>
>> +               };
>> +
>> +               graphics-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc8000000 0xc8000000 0x1000000>;
>> +
>> +                       graphics at c8000000 {
>> +                               compatible = "powervr,sgx540";
>> +                               reg = <0xc8000000 0x1000000>;
>> +                               interrupts = <0 6 0>;
>> +                       };
>> +               };
>> +
>> +               multimedia-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xc9000000 0xc9000000 0x1000000>;
>> +
>> +                       multimedia at a0000000 {
>> +                               compatible = "sirf,marco-video-codec";
>
> And again. I'll stop with the compatible string pedantry here, but if any
> hardware with a "sirf,marco-.*" string is compatible with a prima2 variant,
> it'd be good to append the prima2 string to the end of the compatible list.

agree.

>
>> +                               reg = <0xc9000000 0x1000000>;
>> +                               interrupts = <0 5 0>;
>> +                       };
>> +               };
>> +
>> +               dsp-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xca000000 0xca000000 0x2000000>;
>> +
>> +                       dspif at ca000000 {
>> +                               compatible = "sirf,marco-dspif";
>> +                               reg = <0xca000000 0x10000>;
>> +                               interrupts = <0 9 0>;
>> +                       };
>> +
>> +                       gps at ca010000 {
>> +                               compatible = "sirf,marco-gps";
>> +                               reg = <0xca010000 0x10000>;
>> +                               interrupts = <0 7 0>;
>> +                       };
>> +
>> +                       dsp at cb000000 {
>> +                               compatible = "sirf,marco-dsp";
>> +                               reg = <0xcb000000 0x1000000>;
>> +                               interrupts = <0 8 0>;
>> +                       };
>> +               };
>> +
>> +               peri-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xcc000000 0xcc000000 0x2000000>;
>> +
>> +                       timer at cc020000 {
>> +                               compatible = "sirf,marco-tick";
>> +                               reg = <0xcc020000 0x1000>;
>> +                               interrupts = <0 0 0>,
>> +                                          <0 1 0>,
>> +                                          <0 2 0>,
>> +                                          <0 49 0>,
>> +                                          <0 50 0>,
>> +                                          <0 51 0>;
>> +                       };
>> +
>> +                       nand at cc030000 {
>> +                               compatible = "sirf,marco-nand";
>> +                               reg = <0xcc030000 0x10000>;
>> +                               interrupts = <0 41 0>;
>> +                       };
>> +
>> +                       audio at cc040000 {
>> +                               compatible = "sirf,marco-audio";
>> +                               reg = <0xcc040000 0x10000>;
>> +                               interrupts = <0 35 0>;
>> +                       };
>> +
>> +                       uart0: uart at cc050000 {
>> +                               cell-index = <0>;
>> +                               compatible = "sirf,marco-uart";
>> +                               reg = <0xcc050000 0x1000>;
>> +                               interrupts = <0 17 0>;
>> +                               fifosize = <128>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       uart1: uart at cc060000 {
>> +                               cell-index = <1>;
>> +                               compatible = "sirf,marco-uart";
>> +                               reg = <0xcc060000 0x1000>;
>> +                               interrupts = <0 18 0>;
>> +                               fifosize = <32>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       uart2: uart at cc070000 {
>> +                               cell-index = <2>;
>> +                               compatible = "sirf,marco-uart";
>> +                               reg = <0xcc070000 0x1000>;
>> +                               interrupts = <0 19 0>;
>> +                               fifosize = <128>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       uart3: uart at cc190000 {
>> +                               cell-index = <3>;
>> +                               compatible = "sirf,marco-uart";
>> +                               reg = <0xcc190000 0x1000>;
>> +                               interrupts = <0 66 0>;
>> +                               fifosize = <128>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       uart4: uart at cc1a0000 {
>> +                               cell-index = <4>;
>> +                               compatible = "sirf,marco-uart";
>> +                               reg = <0xcc1a0000 0x1000>;
>> +                               interrupts = <0 69 0>;
>> +                               fifosize = <128>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       usp0: usp at cc080000 {
>> +                               cell-index = <0>;
>> +                               compatible = "sirf,marco-usp";
>> +                               reg = <0xcc080000 0x10000>;
>> +                               interrupts = <0 20 0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       usp1: usp at cc090000 {
>> +                               cell-index = <1>;
>> +                               compatible = "sirf,marco-usp";
>> +                               reg = <0xcc090000 0x10000>;
>> +                               interrupts = <0 21 0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       usp2: usp at cc0a0000 {
>> +                               cell-index = <2>;
>> +                               compatible = "sirf,marco-usp";
>> +                               reg = <0xcc0a0000 0x10000>;
>> +                               interrupts = <0 22 0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       dmac0: dma-controller at cc0b0000 {
>> +                               cell-index = <0>;
>> +                               compatible = "sirf,marco-dmac";
>> +                               reg = <0xcc0b0000 0x10000>;
>> +                               interrupts = <0 12 0>;
>> +                       };
>> +
>> +                       dmac1: dma-controller at cc160000 {
>> +                               cell-index = <1>;
>> +                               compatible = "sirf,marco-dmac";
>> +                               reg = <0xcc160000 0x10000>;
>> +                               interrupts = <0 13 0>;
>> +                       };
>> +
>> +                       vip at cc0c0000 {
>> +                               compatible = "sirf,marco-vip";
>> +                               reg = <0xcc0c0000 0x10000>;
>> +                       };
>> +
>> +                       spi0: spi at cc0d0000 {
>> +                               cell-index = <0>;
>> +                               compatible = "sirf,marco-spi";
>> +                               reg = <0xcc0d0000 0x10000>;
>> +                               interrupts = <0 15 0>;
>> +                               sirf,spi-num-chipselects = <1>;
>> +                               cs-gpios = <&gpio 0 0>;
>> +                               sirf,spi-dma-rx-channel = <25>;
>> +                               sirf,spi-dma-tx-channel = <20>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       spi1: spi at cc170000 {
>> +                               cell-index = <1>;
>> +                               compatible = "sirf,marco-spi";
>> +                               reg = <0xcc170000 0x10000>;
>> +                               interrupts = <0 16 0>;
>> +                               sirf,spi-num-chipselects = <1>;
>> +                               cs-gpios = <&gpio 0 0>;
>> +                               sirf,spi-dma-rx-channel = <12>;
>> +                               sirf,spi-dma-tx-channel = <13>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       i2c0: i2c at cc0e0000 {
>> +                               cell-index = <0>;
>> +                               compatible = "sirf,marco-i2c";
>> +                               reg = <0xcc0e0000 0x10000>;
>> +                               interrupts = <0 24 0>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       i2c1: i2c at cc0f0000 {
>> +                               cell-index = <1>;
>> +                               compatible = "sirf,marco-i2c";
>> +                               reg = <0xcc0f0000 0x10000>;
>> +                               interrupts = <0 25 0>;
>> +                               #address-cells = <1>;
>> +                               #size-cells = <0>;
>> +                               status = "disabled";
>> +                       };
>> +
>> +                       tsc at cc110000 {
>> +                               compatible = "sirf,marco-tsc";
>> +                               reg = <0xcc110000 0x10000>;
>> +                               interrupts = <0 33 0>;
>> +                       };
>> +
>> +                       gpio: pinctrl at cc120000 {
>> +                               #gpio-cells = <2>;
>> +                               #interrupt-cells = <2>;
>> +                               compatible = "sirf,marco-pinctrl";
>
> It would be nice if there were a patch adding the "sirf,marco-pinctrl"
> compatible string to the pinctrl/pinctrl-sirf.txt devicetree binding doc (given
> the pinctrl-sirf driver handles the string already).

yes. definitely there will be when i make pinctrl-sirf completely work
on marco, for the moment, it is not verifiable as pinmux is not
enabled in the fpga.

>
>> +                               reg = <0xcc120000 0x10000>;
>> +                               interrupts = <0 43 0>,
>> +                                          <0 44 0>,
>> +                                          <0 45 0>,
>> +                                          <0 46 0>,
>> +                                          <0 47 0>;
>> +                               gpio-controller;
>> +                               interrupt-controller;
>> +
>> +                               lcd_16pins_a: lcd0 at 0 {
>
> Is the lcd0 name special to the driver/subsystem?
>
> If not, it would be nice to change lcd0 at N to lcd0_N -- ePAPR says the
> unit-address should match the reg property, and if there's no reg property the
> unit-address must be omitted.

agree. it seems prima2.dtsi has the same issue. i'll have a fix for
prima2 as well.
we will still have some chances to change the pinmux mapping in the
marco.dtsi in the future with the fix of ic.

>
> The same goes for all the remaining nodes within gpio.
>
>> +                                       lcd {
>> +                                               sirf,pins = "lcd_16bitsgrp";
>> +                                               sirf,function = "lcd_16bits";
>> +                                       };
>> +                               };
>> +                               lcd_18pins_a: lcd0 at 1 {
>> +                                       lcd {
>> +                                               sirf,pins = "lcd_18bitsgrp";
>> +                                               sirf,function = "lcd_18bits";
>> +                                       };
>> +                               };
>> +                               lcd_24pins_a: lcd0 at 2 {
>> +                                       lcd {
>> +                                               sirf,pins = "lcd_24bitsgrp";
>> +                                               sirf,function = "lcd_24bits";
>> +                                       };
>> +                               };
>> +                               lcdrom_pins_a: lcdrom0 at 0 {
>> +                                       lcd {
>> +                                               sirf,pins = "lcdromgrp";
>> +                                               sirf,function = "lcdrom";
>> +                                       };
>> +                               };
>> +                               uart0_pins_a: uart0 at 0 {
>> +                                       uart {
>> +                                               sirf,pins = "uart0grp";
>> +                                               sirf,function = "uart0";
>> +                                       };
>> +                               };
>> +                               uart1_pins_a: uart1 at 0 {
>> +                                       uart {
>> +                                               sirf,pins = "uart1grp";
>> +                                               sirf,function = "uart1";
>> +                                       };
>> +                               };
>> +                               uart2_pins_a: uart2 at 0 {
>> +                                       uart {
>> +                                               sirf,pins = "uart2grp";
>> +                                               sirf,function = "uart2";
>> +                                       };
>> +                               };
>> +                               uart2_noflow_pins_a: uart2 at 1 {
>> +                                       uart {
>> +                                               sirf,pins = "uart2_nostreamctrlgrp";
>> +                                               sirf,function = "uart2_nostreamctrl";
>> +                                       };
>> +                               };
>> +                               spi0_pins_a: spi0 at 0 {
>> +                                       spi {
>> +                                               sirf,pins = "spi0grp";
>> +                                               sirf,function = "spi0";
>> +                                       };
>> +                               };
>> +                               spi1_pins_a: spi1 at 0 {
>> +                                       spi {
>> +                                               sirf,pins = "spi1grp";
>> +                                               sirf,function = "spi1";
>> +                                       };
>> +                               };
>> +                               i2c0_pins_a: i2c0 at 0 {
>> +                                       i2c {
>> +                                               sirf,pins = "i2c0grp";
>> +                                               sirf,function = "i2c0";
>> +                                       };
>> +                               };
>> +                               i2c1_pins_a: i2c1 at 0 {
>> +                                       i2c {
>> +                                               sirf,pins = "i2c1grp";
>> +                                               sirf,function = "i2c1";
>> +                                       };
>> +                               };
>> +                               pwm0_pins_a: pwm0 at 0 {
>> +                                       pwm {
>> +                                               sirf,pins = "pwm0grp";
>> +                                               sirf,function = "pwm0";
>> +                                       };
>> +                               };
>> +                               pwm1_pins_a: pwm1 at 0 {
>> +                                       pwm {
>> +                                               sirf,pins = "pwm1grp";
>> +                                               sirf,function = "pwm1";
>> +                                       };
>> +                               };
>> +                               pwm2_pins_a: pwm2 at 0 {
>> +                                       pwm {
>> +                                               sirf,pins = "pwm2grp";
>> +                                               sirf,function = "pwm2";
>> +                                       };
>> +                               };
>> +                               pwm3_pins_a: pwm3 at 0 {
>> +                                       pwm {
>> +                                               sirf,pins = "pwm3grp";
>> +                                               sirf,function = "pwm3";
>> +                                       };
>> +                               };
>> +                               gps_pins_a: gps at 0 {
>> +                                       gps {
>> +                                               sirf,pins = "gpsgrp";
>> +                                               sirf,function = "gps";
>> +                                       };
>> +                               };
>> +                               vip_pins_a: vip at 0 {
>> +                                       vip {
>> +                                               sirf,pins = "vipgrp";
>> +                                               sirf,function = "vip";
>> +                                       };
>> +                               };
>> +                               sdmmc0_pins_a: sdmmc0 at 0 {
>> +                                       sdmmc0 {
>> +                                               sirf,pins = "sdmmc0grp";
>> +                                               sirf,function = "sdmmc0";
>> +                                       };
>> +                               };
>> +                               sdmmc1_pins_a: sdmmc1 at 0 {
>> +                                       sdmmc1 {
>> +                                               sirf,pins = "sdmmc1grp";
>> +                                               sirf,function = "sdmmc1";
>> +                                       };
>> +                               };
>> +                               sdmmc2_pins_a: sdmmc2 at 0 {
>> +                                       sdmmc2 {
>> +                                               sirf,pins = "sdmmc2grp";
>> +                                               sirf,function = "sdmmc2";
>> +                                       };
>> +                               };
>> +                               sdmmc3_pins_a: sdmmc3 at 0 {
>> +                                       sdmmc3 {
>> +                                               sirf,pins = "sdmmc3grp";
>> +                                               sirf,function = "sdmmc3";
>> +                                       };
>> +                               };
>> +                               sdmmc4_pins_a: sdmmc4 at 0 {
>> +                                       sdmmc4 {
>> +                                               sirf,pins = "sdmmc4grp";
>> +                                               sirf,function = "sdmmc4";
>> +                                       };
>> +                               };
>> +                               sdmmc5_pins_a: sdmmc5 at 0 {
>> +                                       sdmmc5 {
>> +                                               sirf,pins = "sdmmc5grp";
>> +                                               sirf,function = "sdmmc5";
>> +                                       };
>> +                               };
>> +                               i2s_pins_a: i2s at 0 {
>> +                                       i2s {
>> +                                               sirf,pins = "i2sgrp";
>> +                                               sirf,function = "i2s";
>> +                                       };
>> +                               };
>> +                               ac97_pins_a: ac97 at 0 {
>> +                                       ac97 {
>> +                                               sirf,pins = "ac97grp";
>> +                                               sirf,function = "ac97";
>> +                                       };
>> +                               };
>> +                               nand_pins_a: nand at 0 {
>> +                                       nand {
>> +                                               sirf,pins = "nandgrp";
>> +                                               sirf,function = "nand";
>> +                                       };
>> +                               };
>> +                               usp0_pins_a: usp0 at 0 {
>> +                                       usp0 {
>> +                                               sirf,pins = "usp0grp";
>> +                                               sirf,function = "usp0";
>> +                                       };
>> +                               };
>> +                               usp1_pins_a: usp1 at 0 {
>> +                                       usp1 {
>> +                                               sirf,pins = "usp1grp";
>> +                                               sirf,function = "usp1";
>> +                                       };
>> +                               };
>> +                               usp2_pins_a: usp2 at 0 {
>> +                                       usp2 {
>> +                                               sirf,pins = "usp2grp";
>> +                                               sirf,function = "usp2";
>> +                                       };
>> +                               };
>> +                               usb0_utmi_drvbus_pins_a: usb0_utmi_drvbus at 0 {
>> +                                       usb0_utmi_drvbus {
>> +                                               sirf,pins = "usb0_utmi_drvbusgrp";
>> +                                               sirf,function = "usb0_utmi_drvbus";
>> +                                       };
>> +                               };
>> +                               usb1_utmi_drvbus_pins_a: usb1_utmi_drvbus at 0 {
>> +                                       usb1_utmi_drvbus {
>> +                                               sirf,pins = "usb1_utmi_drvbusgrp";
>> +                                               sirf,function = "usb1_utmi_drvbus";
>> +                                       };
>> +                               };
>> +                               warm_rst_pins_a: warm_rst at 0 {
>> +                                       warm_rst {
>> +                                               sirf,pins = "warm_rstgrp";
>> +                                               sirf,function = "warm_rst";
>> +                                       };
>> +                               };
>> +                               pulse_count_pins_a: pulse_count at 0 {
>> +                                       pulse_count {
>> +                                               sirf,pins = "pulse_countgrp";
>> +                                               sirf,function = "pulse_count";
>> +                                       };
>> +                               };
>> +                               cko0_rst_pins_a: cko0_rst at 0 {
>> +                                       cko0_rst {
>> +                                               sirf,pins = "cko0_rstgrp";
>> +                                               sirf,function = "cko0_rst";
>> +                                       };
>> +                               };
>> +                               cko1_rst_pins_a: cko1_rst at 0 {
>> +                                       cko1_rst {
>> +                                               sirf,pins = "cko1_rstgrp";
>> +                                               sirf,function = "cko1_rst";
>> +                                       };
>> +                               };
>> +                       };
>> +
>> +                       pwm at cc130000 {
>> +                               compatible = "sirf,marco-pwm";
>> +                               reg = <0xcc130000 0x10000>;
>> +                       };
>> +
>> +                       efusesys at cc140000 {
>> +                               compatible = "sirf,marco-efuse";
>> +                               reg = <0xcc140000 0x10000>;
>> +                       };
>> +
>> +                       pulsec at cc150000 {
>> +                               compatible = "sirf,marco-pulsec";
>> +                               reg = <0xcc150000 0x10000>;
>> +                               interrupts = <0 48 0>;
>> +                       };
>> +
>> +                       pci-iobg {
>> +                               compatible = "sirf,marco-pciiobg", "simple-bus";
>> +                               #address-cells = <1>;
>> +                               #size-cells = <1>;
>> +                               ranges = <0xcd000000 0xcd000000 0x1000000>;
>> +
>> +                               sd0: sdhci at cd000000 {
>> +                                       cell-index = <0>;
>> +                                       compatible = "sirf,marco-sdhc";
>> +                                       reg = <0xcd000000 0x100000>;
>> +                                       interrupts = <0 38 0>;
>> +                                       status = "disabled";
>> +                               };
>> +
>> +                               sd1: sdhci at cd100000 {
>> +                                       cell-index = <1>;
>> +                                       compatible = "sirf,marco-sdhc";
>> +                                       reg = <0xcd100000 0x100000>;
>> +                                       interrupts = <0 38 0>;
>> +                                       status = "disabled";
>> +                               };
>> +
>> +                               sd2: sdhci at cd200000 {
>> +                                       cell-index = <2>;
>> +                                       compatible = "sirf,marco-sdhc";
>> +                                       reg = <0xcd200000 0x100000>;
>> +                                       interrupts = <0 23 0>;
>> +                                       status = "disabled";
>> +                               };
>> +
>> +                               sd3: sdhci at cd300000 {
>> +                                       cell-index = <3>;
>> +                                       compatible = "sirf,marco-sdhc";
>> +                                       reg = <0xcd300000 0x100000>;
>> +                                       interrupts = <0 23 0>;
>> +                                       status = "disabled";
>> +                               };
>> +
>> +                               sd4: sdhci at cd400000 {
>> +                                       cell-index = <4>;
>> +                                       compatible = "sirf,marco-sdhc";
>> +                                       reg = <0xcd400000 0x100000>;
>> +                                       interrupts = <0 39 0>;
>> +                                       status = "disabled";
>> +                               };
>> +
>> +                               sd5: sdhci at cd500000 {
>> +                                       cell-index = <5>;
>> +                                       compatible = "sirf,marco-sdhc";
>> +                                       reg = <0xcd500000 0x100000>;
>> +                                       interrupts = <0 39 0>;
>> +                                       status = "disabled";
>> +                               };
>> +
>> +                               pci-copy at cd900000 {
>> +                                       compatible = "sirf,marco-pcicp";
>> +                                       reg = <0xcd900000 0x100000>;
>> +                                       interrupts = <0 40 0>;
>> +                               };
>> +
>> +                               rom-interface at cda00000 {
>> +                                       compatible = "sirf,marco-romif";
>> +                                       reg = <0xcda00000 0x100000>;
>> +                               };
>> +                       };
>> +               };
>> +
>> +               rtc-iobg {
>> +                       compatible = "sirf,marco-rtciobg", "sirf-marco-rtciobg-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       reg = <0xc1000000 0x10000>;
>> +
>> +                       gpsrtc at 1000 {
>> +                               compatible = "sirf,marco-gpsrtc";
>> +                               reg = <0x1000 0x1000>;
>> +                               interrupts = <0 55 0>,
>> +                                          <0 56 0>,
>> +                                          <0 57 0>;
>> +                       };
>> +
>> +                       sysrtc at 2000 {
>> +                               compatible = "sirf,marco-sysrtc";
>> +                               reg = <0x2000 0x1000>;
>> +                               interrupts = <0 52 0>,
>> +                                          <0 53 0>,
>> +                                          <0 54 0>;
>> +                       };
>> +
>> +                       pwrc at 3000 {
>> +                               compatible = "sirf,marco-pwrc";
>> +                               reg = <0x3000 0x1000>;
>> +                               interrupts = <0 32 0>;
>> +                       };
>> +               };
>> +
>> +               uus-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xce000000 0xce000000 0x1000000>;
>> +
>> +                       usb0: usb at ce000000 {
>> +                               compatible = "chipidea,ci13611a-marco";
>> +                               reg = <0xce000000 0x10000>;
>> +                               interrupts = <0 10 0>;
>> +                       };
>> +
>> +                       usb1: usb at ce010000 {
>> +                               compatible = "chipidea,ci13611a-marco";
>> +                               reg = <0xce010000 0x10000>;
>> +                               interrupts = <0 11 0>;
>> +                       };
>> +
>> +                       security at ce020000 {
>> +                               compatible = "sirf,marco-security";
>> +                               reg = <0xce020000 0x10000>;
>> +                               interrupts = <0 42 0>;
>> +                       };
>> +               };
>> +
>> +               can-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xd0000000 0xd0000000 0x1000000>;
>> +
>> +                       can0: can at d0000000 {
>> +                               compatible = "sirf,marco-can";
>> +                               reg = <0xd0000000 0x10000>;
>> +                       };
>> +
>> +                       can1: can at d0010000 {
>> +                               compatible = "sirf,marco-can";
>> +                               reg = <0xd0010000 0x10000>;
>> +                       };
>> +               };
>> +
>> +               lvds-iobg {
>> +                       compatible = "simple-bus";
>> +                       #address-cells = <1>;
>> +                       #size-cells = <1>;
>> +                       ranges = <0xd1000000 0xd1000000 0x1000000>;
>> +
>> +                       lvds at d1000000 {
>> +                               compatible = "sirf,marco-lvds";
>> +                               reg = <0xd1000000 0x10000>;
>> +                               interrupts = <0 64 0>;
>> +                       };
>> +               };
>> +       };
>> +};
>
> If you're able to deal with all that, you can add:
>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
>
> For the compatible strings, it would be good if those devices which need
> special treatment compared to prima2 (and thus can't fall back on the prima2
> compatible strings) were listed in the commit message to aid review. Either
> that or list the ones which are compatible, whichever list is shorter.

yes. almost all can handled except some detailed and compatible
hardware  isssues, as i want to leave them to the day ic is fixed and
related drivers are begun.
for the moment, building the infrasture is necessary as other teams
can build their drivers and verified apps on it.

>
> Thanks,
> Mark.
>
-barry
