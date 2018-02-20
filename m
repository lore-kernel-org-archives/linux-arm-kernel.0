From: db@donbowman.ca (Don Bowman)
Date: Tue, 20 Feb 2018 13:13:49 -0500
Subject: PCI on alpine soc
In-Reply-To: <20180220124113.GA22547@kwain>
References: <CADJev7948TA_FU-3+Z8KNCbQgvApLfe8n6jP-wCbJeU2R4d26w@mail.gmail.com>
 <20180220124113.GA22547@kwain>
Message-ID: <CADJev78MK0AmaPRwT9BAroLHqLMdER+cheCJcf8Kjxj3wTvbYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 February 2018 at 07:41, Antoine Tenart <antoine.tenart@bootlin.com> wrote:
> Hi Don,
>
> I almost missed your email :)
>
> On Wed, Feb 14, 2018 at 11:18:15PM -0500, Don Bowman wrote:
>>
>> When i compile and run them, things generally work, but the PCI
>> devices are not discovered.
>>
>> the fdt is passed in the same from the u-boot in both cases 94.4 and 4.16rc)
>
> You're using the device tree from the upstream tree right?
>
>> is it expected that this chip works? Does anyone have any suggestions?
>
> I'm not sure I can help you a lot with this, but I do have a patch
> related to the PCI on Alpine-v2 chips. Could you try:
> https://paste.ack.tf/dc6630 at raw
>
> Please let me know if this helps in any way, so that I can sent the
> patch if needed.
>
> Also be aware the upstream support for such SoCs is *very* minimal (i.e.
> it boots), but if you're willing to improve this you'll be more than
> welcome!
>
> Thanks!
> Antoine
>
> --
> Antoine T?nart, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com


Thanks for the response.
Your patch does not seem to affect.

I've put the diff against the 4.4.111 tree @
https://gist.github.com/donbowman/2630241daadd43122163a7fae57e10b3
 (its a bit big to put in an email). This is the Netgear
4.4.111-alpine vs git w/ the v4.4.111 tag.

Indeed the dts is coming from u-boot. I have extracted and dumped it
(below), and its also in the gist.


/dts-v1/;
// magic: 0xd00dfeed
// totalsize: 0x6080 (24704)
// off_dt_struct: 0x68
// off_dt_strings: 0x58e8
// off_mem_rsvmap: 0x28
// version: 17
// last_comp_version: 16
// boot_cpuid_phys: 0x0
// size_dt_strings: 0x411
// size_dt_struct: 0x5880

/memreserve/ 0 0x100000;
/memreserve/ 0x7000000 0x6000;
/memreserve/ 0x1633000 0x505573;
/ {
    #address-cells = <0x00000002>;
    #size-cells = <0x00000002>;
    compatible = "annapurna-labs,alpine", "al,alpine",
"netgear,readynas-20x", "netgear,readynas-204";
    clock-ranges;
    version = "2.5";
    chosen {
        linux,initrd-end = <0x01b38573>;
        linux,initrd-start = <0x01633000>;
        bootargs = "rootdelay=4 console=ttyS0,115200 pci=pcie_bus_perf
root=UUID=a0027444-4343-4d80-afd0-ae64504cf887";
    };
    aliases {
    };
    memory {
        device_type = "memory";
        reg = <0x00000000 0x00000000 0x00000000 0x20000000 0x00000000
0x20000000 0x00000000 0x20000000 0x00000000 0x40000000 0x00000000
0x20000000 0x00000000 0x60000000 0x00000000 0x20000000>;
    };
    cpus {
        #address-cells = <0x00000001>;
        #size-cells = <0x00000000>;
        enable-method = "al,alpine-smp";
        cpu at 0 {
            compatible = "arm,cortex-a15";
            device_type = "cpu";
            reg = <0x00000000>;
            clocks = <0x00000001>;
            clock-names = "cpu";
            clock-frequency = "SrN";
        };
        cpu at 1 {
            compatible = "arm,cortex-a15";
            device_type = "cpu";
            reg = <0x00000001>;
            clocks = <0x00000001>;
            clock-names = "cpu";
            clock-frequency = "SrN";
        };
        cpu at 2 {
            compatible = "arm,cortex-a15";
            device_type = "cpu";
            reg = <0x00000002>;
            clocks = <0x00000001>;
            clock-names = "cpu";
            clock-frequency = "SrN";
        };
        cpu at 3 {
            compatible = "arm,cortex-a15";
            device_type = "cpu";
            reg = <0x00000003>;
            clocks = <0x00000001>;
            clock-names = "cpu";
            clock-frequency = "SrN";
        };
    };
    soc {
        #address-cells = <0x00000002>;
        #size-cells = <0x00000002>;
        compatible = "simple-bus";
        interrupt-parent = <0x00000002>;
        ranges;
        arch-timer {
            compatible = "arm,cortex-a15-timer", "arm,armv7-timer";
            interrupts = <0x00000001 0x0000000d 0x00000f08 0x00000001
0x0000000e 0x00000f08 0x00000001 0x0000000b 0x00000f08 0x00000001
0x0000000a 0x00000f08>;
            clock-frequency = <0x02faf080>;
        };
        gic_main {
            compatible = "arm,cortex-a15-gic";
            #interrupt-cells = <0x00000003>;
            #size-cells = <0x00000000>;
            #address-cells = <0x00000000>;
            interrupt-controller;
            reg = <0x00000000 0xfb001000 0x00000000 0x00001000
0x00000000 0xfb002000 0x00000000 0x00002000 0x00000000 0xfb004000
0x00000000 0x00001000 0x00000000 0xfb006000 0x00000000 0x00002000>;
            interrupts = <0x00000001 0x00000009 0x00000f04>;
            linux,phandle = <0x00000002>;
            phandle = <0x00000002>;
        };
        cpu_resume {
            compatible = "annapurna-labs,al-cpu-resume", "al,alpine-cpu-resume";
            reg = <0x00000000 0xfbff5ec0 0x00000000 0x00000030>;
        };
        ccu {
            compatible = "annapurna-labs,al-ccu", "al,alpine-ccu";
            reg = <0x00000000 0xfb090000 0x00000000 0x00010000>;
            io_coherency = <0x00000001>;
        };
        nb_service {
            compatible = "annapurna-labs,al-nb-service",
"al,alpine-sysfabric-service", "syscon";
            reg = <0x00000000 0xfb070000 0x00000000 0x00010000>;
            interrupts = <0x00000000 0x00000040 0x00000004 0x00000000
0x00000041 0x00000004 0x00000000 0x00000042 0x00000004 0x00000000
0x00000043 0x00000004>;
            dev_ord_relax = <0x00000000>;
        };
        pbs {
            compatible = "annapurna-labs,al-pbs";
            reg = <0x00000000 0xfd8a8000 0x00000000 0x00001000>;
        };
        msix {
            compatible = "annapurna-labs,al-msix", "annapurna-labs,alpine-msix";
            reg = <0x00000000 0xfbe00000 0x00000000 0x00100000>;
            interrupts = <0x00000000 0x00000060 0x00000001 0x00000000
0x0000009f 0x00000001>;
            interrupt-controller;
            msi-controller;
            interrupt-parent = <0x00000002>;
            linux,phandle = <0x00000006>;
            phandle = <0x00000006>;
        };
        pmu {
            compatible = "arm,cortex-a15-pmu";
            interrupts = <0x00000000 0x00000044 0x00000004 0x00000000
0x00000045 0x00000004 0x00000000 0x00000046 0x00000004 0x00000000
0x00000047 0x00000004>;
        };
        timer0 {
            compatible = "arm,sp804", "arm,primecell";
            reg = <0x00000000 0xfd890000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000009 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "sbclk";
            status = "disabled";
        };
        timer1 {
            compatible = "arm,sp804", "arm,primecell";
            reg = <0x00000000 0xfd891000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x0000000a 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "sbclk";
            status = "disabled";
        };
        timer2 {
            compatible = "arm,sp804", "arm,primecell";
            reg = <0x00000000 0xfd892000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x0000000b 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "sbclk";
            status = "disabled";
        };
        timer3 {
            compatible = "arm,sp804", "arm,primecell";
            reg = <0x00000000 0xfd893000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x0000000c 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "sbclk";
            status = "disabled";
        };
        wdt0 {
            compatible = "arm,sp805", "arm,primecell";
            reg = <0x00000000 0xfd88c000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x0000000d 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            linux,phandle = <0x00000005>;
            phandle = <0x00000005>;
        };
        wdt1 {
            compatible = "arm,sp805", "arm,primecell";
            reg = <0x00000000 0xfd88d000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x0000000e 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            status = "disabled";
        };
        wdt2 {
            compatible = "arm,sp805", "arm,primecell";
            reg = <0x00000000 0xfd88e000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x0000000f 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            status = "disabled";
        };
        wdt3 {
            compatible = "arm,sp805", "arm,primecell";
            reg = <0x00000000 0xfd88f000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000010 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            status = "disabled";
        };
        i2c-pld {
            #address-cells = <0x00000001>;
            #size-cells = <0x00000000>;
            compatible = "snps,designware-i2c";
            reg = <0x00000000 0xfd880000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000015 0x00000004>;
            clocks = <0x00000003>;
            clock-frequency = <0x00061a80>;
            i2c_mux at 70 {
                compatible = "pca9548";
                reg = <0x00000070>;
            };
            rtc at 68 {
                compatible = "ds1337";
                reg = <0x00000068>;
            };
            g762 at 3e {
                compatible = "gmt,g762";
                reg = <0x0000003e>;
                clocks = <0x00000004>;
                fan_gear_mode = <0x00000000>;
                fan_startv = <0x00000003>;
                pwm_polarity = <0x00000000>;
            };
        };
        i2c-gen {
            #address-cells = <0x00000001>;
            #size-cells = <0x00000000>;
            compatible = "snps,designware-i2c";
            reg = <0x00000000 0xfd894000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000008 0x00000004>;
            clocks = <0x00000003>;
            clock-frequency = <0x00061a80>;
            status = "disabled";
        };
        gpio0 {
            #gpio-cells = <0x00000002>;
            compatible = "arm,pl061", "arm,primecell";
            gpio-controller;
            reg = <0x00000000 0xfd887000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000002 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            baseidx = <0x00000000>;
        };
        gpio1 {
            #gpio-cells = <0x00000002>;
            compatible = "arm,pl061", "arm,primecell";
            gpio-controller;
            reg = <0x00000000 0xfd888000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000003 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            baseidx = <0x00000008>;
        };
        gpio2 {
            #gpio-cells = <0x00000002>;
            compatible = "arm,pl061", "arm,primecell";
            gpio-controller;
            reg = <0x00000000 0xfd889000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000004 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            baseidx = <0x00000010>;
            linux,phandle = <0x0000000d>;
            phandle = <0x0000000d>;
        };
        gpio3 {
            #gpio-cells = <0x00000002>;
            compatible = "arm,pl061", "arm,primecell";
            gpio-controller;
            reg = <0x00000000 0xfd88a000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000005 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            baseidx = <0x00000018>;
            linux,phandle = <0x0000000c>;
            phandle = <0x0000000c>;
        };
        gpio4 {
            #gpio-cells = <0x00000002>;
            compatible = "arm,pl061", "arm,primecell";
            gpio-controller;
            reg = <0x00000000 0xfd88b000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000006 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            baseidx = <0x00000020>;
            linux,phandle = <0x0000000e>;
            phandle = <0x0000000e>;
        };
        gpio5 {
            #gpio-cells = <0x00000002>;
            compatible = "arm,pl061", "arm,primecell";
            gpio-controller;
            reg = <0x00000000 0xfd897000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000007 0x00000004>;
            clocks = <0x00000003>;
            clock-names = "apb_pclk";
            baseidx = <0x00000028>;
            linux,phandle = <0x0000000f>;
            phandle = <0x0000000f>;
        };
        uart0 {
            compatible = "ns16550a";
            reg = <0x00000000 0xfd883000 0x00000000 0x00001000>;
            clock-frequency = <0x165a0bc0>;
            interrupts = <0x00000000 0x00000011 0x00000004>;
            reg-shift = <0x00000002>;
            reg-io-width = <0x00000004>;
        };
        uart1 {
            compatible = "ns16550a";
            reg = <0x00000000 0xfd884000 0x00000000 0x00001000>;
            clock-frequency = <0x165a0bc0>;
            interrupts = <0x00000000 0x00000012 0x00000004>;
            reg-shift = <0x00000002>;
            reg-io-width = <0x00000004>;
        };
        uart2 {
            compatible = "ns16550a";
            reg = <0x00000000 0xfd885000 0x00000000 0x00001000>;
            clock-frequency = <0x165a0bc0>;
            interrupts = <0x00000000 0x00000013 0x00000004>;
            reg-shift = <0x00000002>;
            reg-io-width = <0x00000004>;
            status = "disabled";
        };
        uart3 {
            compatible = "ns16550a";
            reg = <0x00000000 0xfd886000 0x00000000 0x00001000>;
            clock-frequency = <0x165a0bc0>;
            interrupts = <0x00000000 0x00000014 0x00000004>;
            reg-shift = <0x00000002>;
            reg-io-width = <0x00000004>;
            status = "disabled";
        };
        reboot {
            compatible = "annapurna-labs,alpine-reboot";
            wdt-parent = <0x00000005>;
        };
        pcie-internal-3-10-20 {
            compatible = "annapurna-labs,al-internal-pcie";
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x0000f800 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00004000 0x00000000 0x00000000
0x00000001 0x00000002 0x00000000 0x0000002b 0x00000004 0x00004800
0x00000000 0x00000000 0x00000001 0x00000002 0x00000000 0x0000002c
0x00000004>;
            ranges = <0x00000000 0x00000000 0xfbc00000 0x00000000
0xfbc00000 0x00000000 0x00100000 0x02000000 0x00000000 0xfe000000
0x00000000 0xfe000000 0x00000000 0x01000000>;
            bus-range = <0x00000000 0x00000000>;
        };
        pcie-internal-3-19 {
            compatible = "annapurna-labs,alpine-internal-pcie";
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            reg = <0x00000000 0xfbc00000 0x00000000 0x00100000>;
            reg-names = "ecam";
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x0000f800 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00004000 0x00000000 0x00000000
0x00000001 0x00000002 0x00000000 0x0000002b 0x00000004 0x00004800
0x00000000 0x00000000 0x00000001 0x00000002 0x00000000 0x0000002c
0x00000004>;
            msi-parent = <0x00000006>;
            ranges = <0x00000000 0x00000000 0xfbc00000 0x00000000
0xfbc00000 0x00000000 0x00100000 0x02000000 0x00000000 0xfe000000
0x00000000 0xfe000000 0x00000000 0x01000000>;
            bus-range = <0x00000000 0x00000000>;
        };
        pcie-external0 {
            compatible = "annapurna-labs,alpine-external-pcie";
            reg = <0x00000000 0xfd800000 0x00000000 0x00020000>;
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            reg-names = "ecam";
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x00000000 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00000000 0x00000000 0x00000000
0x00000001 0x00000001 0x00000000 0x00000029 0x00000004>;
            msi-parent = <0x00000006>;
            cfg-space-offset = <0x00002000>;
            ranges = <0x00000000 0x00000000 0xfb600000 0x00000000
0xfb600000 0x00000000 0x00200000 0x01000000 0x00000000 0x00010000
0x00000000 0xe0000000 0x00000000 0x00010000 0x02000000 0x00000000
0xe0010000 0x00000000 0xe0010000 0x00000000 0x07ff0000>;
            bus-range = <0x00000000 0x000000ff>;
        };
        pcie-external1 {
            compatible = "annapurna-labs,alpine-external-pcie";
            reg = <0x00000000 0xfd820000 0x00000000 0x00020000>;
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            reg-names = "ecam";
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x00000000 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00000000 0x00000000 0x00000000
0x00000001 0x00000001 0x00000000 0x0000002a 0x00000004>;
            msi-parent = <0x00000006>;
            cfg-space-offset = <0x00002000>;
            ranges = <0x00000000 0x00000000 0xfb800000 0x00000000
0xfb800000 0x00000000 0x00200000 0x01000000 0x00000000 0x00020000
0x00000000 0xe8000000 0x00000000 0x00010000 0x02000000 0x00000000
0xe8010000 0x00000000 0xe8010000 0x00000000 0x03ff0000>;
            bus-range = <0x00000000 0x000000ff>;
        };
        pcie-external2 {
            status = "disabled";
            compatible = "annapurna-labs,alpine-external-pcie";
            reg = <0x00000000 0xfd840000 0x00000000 0x00020000>;
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            reg-names = "ecam";
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x00000000 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00000000 0x00000000 0x00000000
0x00000001 0x00000001 0x00000000 0x0000002b 0x00000004>;
            msi-parent = <0x00000006>;
            cfg-space-offset = <0x00002000>;
            ranges = <0x00000000 0x00000000 0xfba00000 0x00000000
0xfba00000 0x00000000 0x00200000 0x01000000 0x00000000 0x00030000
0x00000000 0xec000000 0x00000000 0x00010000 0x02000000 0x00000000
0xec010000 0x00000000 0xec010000 0x00000000 0x03ff0000>;
            bus-range = <0x00000000 0x000000ff>;
        };
        pcie-external0-3-10 {
            compatible = "annapurna-labs,al-pci";
            reg = <0x00000000 0xfd800000 0x00000000 0x00020000>;
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x00000000 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00000000 0x00000000 0x00000000
0x00000001 0x00000002 0x00000000 0x00000028 0x00000004>;
            ranges = <0x00000000 0x00000000 0xfb600000 0x00000000
0xfb600000 0x00000000 0x00200000 0x01000000 0x00000000 0x00010000
0x00000000 0xe0000000 0x00000000 0x00010000 0x02000000 0x00000000
0xe0010000 0x00000000 0xe0010000 0x00000000 0x07ff0000>;
            bus-range = <0x00000000 0x000000ff>;
        };
        pcie-external1-3-10 {
            compatible = "annapurna-labs,al-pci";
            reg = <0x00000000 0xfd820000 0x00000000 0x00020000>;
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x00000000 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00000000 0x00000000 0x00000000
0x00000001 0x00000002 0x00000000 0x00000029 0x00000004>;
            ranges = <0x00000000 0x00000000 0xfb800000 0x00000000
0xfb800000 0x00000000 0x00200000 0x01000000 0x00000000 0x00020000
0x00000000 0xe8000000 0x00000000 0x00010000 0x02000000 0x00000000
0xe8010000 0x00000000 0xe8010000 0x00000000 0x03ff0000>;
            bus-range = <0x00000000 0x000000ff>;
        };
        pcie-external2-3-10 {
            compatible = "annapurna-labs,al-pci";
            reg = <0x00000000 0xfd840000 0x00000000 0x00020000>;
            device_type = "pci";
            #size-cells = <0x00000002>;
            #address-cells = <0x00000003>;
            #interrupt-cells = <0x00000001>;
            interrupt-parent = <0x00000002>;
            interrupt-map-mask = <0x00000000 0x00000000 0x00000000 0x00000007>;
            interrupt-map = <0x00000000 0x00000000 0x00000000
0x00000001 0x00000002 0x00000000 0x0000002a 0x00000004>;
            ranges = <0x00000000 0x00000000 0xfba00000 0x00000000
0xfba00000 0x00000000 0x00200000 0x01000000 0x00000000 0x00030000
0x00000000 0xec000000 0x00000000 0x00010000 0x02000000 0x00000000
0xec010000 0x00000000 0xec010000 0x00000000 0x03ff0000>;
            bus-range = <0x00000000 0x000000ff>;
        };
        thermal {
            compatible = "annapurna-labs,al-thermal";
            reg = <0x00000000 0xfd860a00 0x00000000 0x00000100>;
        };
        nor_flash {
            compatible = "cfi-flash";
            reg = <0x00000000 0xf4000000 0x00000000 0x04000000>;
            bank-width = <0x00000001>;
            device-width = <0x00000001>;
            status = "disabled";
        };
        nand-flash {
            compatible = "annapurna-labs,al-nand";
            reg = <0x00000000 0xfa100000 0x00000000 0x00202000>;
            interrupts = <0x00000000 0x00000001 0x00000004>;
            #address-cells = <0x00000001>;
            #size-cells = <0x00000001>;
            partition at 0 {
                label = "u-boot";
                reg = <0x00000000 0x001c0000>;
            };
            partition at 1 {
                label = "u-boot-env";
                reg = <0x001c0000 0x00040000>;
            };
            partition at 2 {
                label = "uImage";
                reg = <0x00200000 0x00600000>;
            };
            partition at 3 {
                label = "minirootfs";
                reg = <0x00800000 0x00400000>;
            };
            partition at 4 {
                label = "ubifs";
                reg = <0x00c00000 0x06400000>;
            };
            partition at 5 {
                label = "dts";
                reg = <0x00080000 0x00020000>;
            };
            partition at 6 {
                label = "factory-diag";
                reg = <0x07000000 0x01000000>;
            };
        };
        spi-3-10-20 {
            compatible = "snps,dw-spi-mmio";
            #address-cells = <0x00000001>;
            #size-cells = <0x00000000>;
            reg = <0x00000000 0xfd882000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000017 0x00000004>;
            num-chipselect = <0x00000004>;
            bus-num = <0x00000000>;
            clocks = <0x00000003>;
            clock-names = "sbclk";
        };
        spi {
            compatible = "snps,dw-apb-ssi";
            #address-cells = <0x00000001>;
            #size-cells = <0x00000000>;
            reg = <0x00000000 0xfd882000 0x00000000 0x00001000>;
            interrupts = <0x00000000 0x00000017 0x00000004>;
            num-cs = <0x00000004>;
            bus-num = <0x00000000>;
            clocks = <0x00000003>;
            clock-names = "sbclk";
            status = "disabled";
        };
        clocks {
            #address-cells = <0x00000001>;
            #size-cells = <0x00000000>;
            refclk {
                #clock-cells = <0x00000000>;
                compatible = "fixed-clock";
                clock-frequency = <0x05f5e100>;
            };
            sbclk {
                #clock-cells = <0x00000000>;
                compatible = "fixed-clock";
                clock-frequency = <0x165a0bc0>;
                linux,phandle = <0x00000003>;
                phandle = <0x00000003>;
            };
            nbclk {
                #clock-cells = <0x00000000>;
                compatible = "fixed-clock";
                clock-frequency = <0x2faf0800>;
            };
            cpuclk {
                #clock-cells = <0x00000000>;
                compatible = "fixed-clock";
                clock-frequency = "SrN";
                linux,phandle = <0x00000001>;
                phandle = <0x00000001>;
            };
            fixedclk {
                #clock-cells = <0x00000000>;
                compatible = "fixed-clock";
                clock-frequency = <0x00001964>;
                linux,phandle = <0x00000004>;
                phandle = <0x00000004>;
            };
        };
        serdes {
            compatible = "annapurna-labs,al-serdes";
            reg = <0x00000000 0xfd8c0000 0x00000000 0x00001000>;
        };
        mc {
            compatible = "annapurna-labs,al-mc";
            reg = <0x00000000 0xfb080000 0x00000000 0x00010000>;
        };
        pinctrl {
            compatible = "annapurna-labs,al-pinctrl";
            reg = <0x00000000 0xfd8a8000 0x00000000 0x00001000>;
            if_nor_8 {
                id = "if_nor_8";
                arg = <0x00000000>;
            };
            if_nor_16 {
                id = "if_nor_16";
                arg = <0x00000000>;
            };
            if_nor_cs_0 {
                id = "if_nor_cs_0";
                arg = <0x00000000>;
            };
            if_nor_cs_1 {
                id = "if_nor_cs_1";
                arg = <0x00000000>;
            };
            if_nor_cs_2 {
                id = "if_nor_cs_2";
                arg = <0x00000000>;
            };
            if_nor_cs_3 {
                id = "if_nor_cs_3";
                arg = <0x00000000>;
            };
            if_nor_wp {
                id = "if_nor_wp";
                arg = <0x00000000>;
            };
            if_nand_8 {
                id = "if_nand_8";
                arg = <0x00000000>;
                linux,phandle = <0x00000007>;
                phandle = <0x00000007>;
            };
            if_nand_16 {
                id = "if_nand_16";
                arg = <0x00000000>;
            };
            if_nand_cs_0 {
                id = "if_nand_cs_0";
                arg = <0x00000000>;
                linux,phandle = <0x00000008>;
                phandle = <0x00000008>;
            };
            if_nand_cs_1 {
                id = "if_nand_cs_1";
                arg = <0x00000000>;
            };
            if_nand_cs_2 {
                id = "if_nand_cs_2";
                arg = <0x00000000>;
            };
            if_nand_cs_3 {
                id = "if_nand_cs_3";
                arg = <0x00000000>;
            };
            if_nand_wp {
                id = "if_nand_wp";
                arg = <0x00000000>;
            };
            if_sram_8 {
                id = "if_sram_8";
                arg = <0x00000000>;
            };
            if_sram_16 {
                id = "if_sram_16";
                arg = <0x00000000>;
            };
            if_sram_cs_0 {
                id = "if_sram_cs_0";
                arg = <0x00000000>;
            };
            if_sram_cs_1 {
                id = "if_sram_cs_1";
                arg = <0x00000000>;
            };
            if_sram_cs_2 {
                id = "if_sram_cs_2";
                arg = <0x00000000>;
            };
            if_sram_cs_3 {
                id = "if_sram_cs_3";
                arg = <0x00000000>;
            };
            if_sata_0_leds {
                id = "if_sata_0_leds";
                arg = <0x00000000>;
            };
            if_sata_1_leds {
                id = "if_sata_1_leds";
                arg = <0x00000000>;
                linux,phandle = <0x00000009>;
                phandle = <0x00000009>;
            };
            if_eth_leds {
                id = "if_eth_leds";
                arg = <0x00000000>;
                linux,phandle = <0x0000000a>;
                phandle = <0x0000000a>;
            };
            if_eth_gpio {
                id = "if_eth_gpio";
                arg = <0x00000000>;
            };
            if_uart_1 {
                id = "if_uart_1";
                arg = <0x00000000>;
                linux,phandle = <0x0000000b>;
                phandle = <0x0000000b>;
            };
            if_uart_1_modem {
                id = "if_uart_1_modem";
                arg = <0x00000000>;
            };
            if_uart_2 {
                id = "if_uart_2";
                arg = <0x00000000>;
            };
            if_uart_3 {
                id = "if_uart_3";
                arg = <0x00000000>;
            };
            if_i2c_gen {
                id = "if_i2c_gen";
                arg = <0x00000000>;
            };
            if_ulpi_0_rst_n {
                id = "if_ulpi_0_rst_n";
                arg = <0x00000000>;
            };
            if_ulpi_1_rst_n {
                id = "if_ulpi_1_rst_n";
                arg = <0x00000000>;
            };
            if_pci_ep_int_a {
                id = "if_pci_ep_int_a";
                arg = <0x00000000>;
            };
            if_pci_ep_reset_out {
                id = "if_pci_ep_reset_out";
                arg = <0x00000000>;
            };
            if_spim_a_ss_1 {
                id = "if_spim_a_ss_1";
                arg = <0x00000000>;
            };
            if_spim_a_ss_2 {
                id = "if_spim_a_ss_2";
                arg = <0x00000000>;
            };
            if_spim_a_ss_3 {
                id = "if_spim_a_ss_3";
                arg = <0x00000000>;
            };
            if_ulpi_1_b {
                id = "if_ulpi_1_b";
                arg = <0x00000000>;
            };
            if_gpio0 {
                id = "if_gpio";
                arg = <0x00000000>;
            };
            if_gpio1 {
                id = "if_gpio";
                arg = <0x00000001>;
            };
            if_gpio2 {
                id = "if_gpio";
                arg = <0x00000002>;
            };
            if_gpio3 {
                id = "if_gpio";
                arg = <0x00000003>;
            };
            if_gpio4 {
                id = "if_gpio";
                arg = <0x00000004>;
            };
            if_gpio5 {
                id = "if_gpio";
                arg = <0x00000005>;
            };
            if_gpio6 {
                id = "if_gpio";
                arg = <0x00000006>;
            };
            if_gpio7 {
                id = "if_gpio";
                arg = <0x00000007>;
            };
            if_gpio8 {
                id = "if_gpio";
                arg = <0x00000008>;
            };
            if_gpio9 {
                id = "if_gpio";
                arg = <0x00000009>;
            };
            if_gpio10 {
                id = "if_gpio";
                arg = <0x0000000a>;
            };
            if_gpio11 {
                id = "if_gpio";
                arg = <0x0000000b>;
            };
            if_gpio12 {
                id = "if_gpio";
                arg = <0x0000000c>;
            };
            if_gpio13 {
                id = "if_gpio";
                arg = <0x0000000d>;
            };
            if_gpio14 {
                id = "if_gpio";
                arg = <0x0000000e>;
            };
            if_gpio15 {
                id = "if_gpio";
                arg = <0x0000000f>;
            };
            if_gpio16 {
                id = "if_gpio";
                arg = <0x00000010>;
            };
            if_gpio17 {
                id = "if_gpio";
                arg = <0x00000011>;
            };
            if_gpio18 {
                id = "if_gpio";
                arg = <0x00000012>;
            };
            if_gpio19 {
                id = "if_gpio";
                arg = <0x00000013>;
            };
            if_gpio20 {
                id = "if_gpio";
                arg = <0x00000014>;
            };
            if_gpio21 {
                id = "if_gpio";
                arg = <0x00000015>;
            };
            if_gpio22 {
                id = "if_gpio";
                arg = <0x00000016>;
            };
            if_gpio23 {
                id = "if_gpio";
                arg = <0x00000017>;
            };
            if_gpio24 {
                id = "if_gpio";
                arg = <0x00000018>;
            };
            if_gpio25 {
                id = "if_gpio";
                arg = <0x00000019>;
            };
            if_gpio26 {
                id = "if_gpio";
                arg = <0x0000001a>;
            };
            if_gpio27 {
                id = "if_gpio";
                arg = <0x0000001b>;
            };
            if_gpio28 {
                id = "if_gpio";
                arg = <0x0000001c>;
            };
            if_gpio29 {
                id = "if_gpio";
                arg = <0x0000001d>;
            };
            if_gpio30 {
                id = "if_gpio";
                arg = <0x0000001e>;
            };
            if_gpio31 {
                id = "if_gpio";
                arg = <0x0000001f>;
            };
            if_gpio32 {
                id = "if_gpio";
                arg = <0x00000020>;
            };
            if_gpio33 {
                id = "if_gpio";
                arg = <0x00000021>;
            };
            if_gpio34 {
                id = "if_gpio";
                arg = <0x00000022>;
            };
            if_gpio35 {
                id = "if_gpio";
                arg = <0x00000023>;
            };
            if_gpio36 {
                id = "if_gpio";
                arg = <0x00000024>;
            };
            if_gpio37 {
                id = "if_gpio";
                arg = <0x00000025>;
            };
            if_gpio38 {
                id = "if_gpio";
                arg = <0x00000026>;
            };
            if_gpio39 {
                id = "if_gpio";
                arg = <0x00000027>;
            };
            if_gpio40 {
                id = "if_gpio";
                arg = <0x00000028>;
            };
            if_gpio41 {
                id = "if_gpio";
                arg = <0x00000029>;
            };
            if_gpio42 {
                id = "if_gpio";
                arg = <0x0000002a>;
            };
            if_gpio43 {
                id = "if_gpio";
                arg = <0x0000002b>;
            };
        };
        board-cfg {
            id = "Netgear NAS RN20x";
            u-boot-offset = <0x00020000>;
            pinctrl_init {
                pinctrl-0 = <0x00000007 0x00000008 0x00000009
0x0000000a 0x0000000b>;
            };
            gpio_init {
                gpio-list = <0x00000004 0x00000000 0x00000000
0x00000005 0x00000000 0x00000000 0x00000014 0x00000001 0x00000000
0x00000015 0x00000001 0x00000000 0x00000016 0x00000001 0x00000000
0x00000017 0x00000001 0x00000000 0x0000001c 0x00000001 0x00000000
0x0000001d 0x00000001 0x00000001 0x0000001e 0x00000001 0x00000001
0x0000001f 0x00000001 0x00000001 0x00000020 0x00000000 0x00000000
0x00000021 0x00000001 0x00000000 0x00000022 0x00000001 0x00000000
0x00000023 0x00000001 0x00000000 0x00000024 0x00000001 0x00000000
0x00000025 0x00000001 0x00000000 0x00000026 0x00000001 0x00000000
0x00000027 0x00000001 0x00000000 0x00000028 0x00000001 0x00000000
0x00000029 0x00000001 0x00000000 0x0000002a 0x00000001 0x00000000
0x0000002b 0x00000000 0x00000000 0x0000002c 0x00000000 0x00000000
0x0000002d 0x00000001 0x00000000 0x0000002e 0x00000001 0x00000000
0x0000002f 0x00000001 0x00000001>;
            };
            serdes {
                group0 {
                    interface = "pcie_g3x4";
                    ref-clock = "100Mhz";
                    active-lanes = <0x00000000 0x00000001 0x00000002
0x00000003>;
                    inv-tx-lanes;
                    inv-rx-lanes;
                    ssc = "disabled";
                    lane_0_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                    lane_1_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                    lane_2_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                    lane_3_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                };
                group1 {
                    interface = "sata";
                    ref-clock = "100Mhz";
                    active-lanes = <0x00000000 0x00000001 0x00000002
0x00000003>;
                    inv-tx-lanes;
                    inv-rx-lanes;
                    ssc = "disabled";
                    lane_0_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                    lane_1_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                    lane_2_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                    lane_3_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                };
                group2 {
                    interface = "sata";
                    ref-clock = "100Mhz";
                    active-lanes = <0x00000000 0x00000001 0x00000002
0x00000003>;
                    inv-tx-lanes;
                    inv-rx-lanes;
                    ssc = "disabled";
                    lane_0_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                    lane_1_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                    lane_2_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                    lane_3_params {
                        rx {
                            override = "enabled";
                            dcgain = <0x00000000>;
                            dfe_3db_freq = <0x00000007>;
                            dfe_gain = <0x00000000>;
                            dfe_1st_tap_ctrl = <0x00000000>;
                            dfe_2nd_tap_ctrl = <0x00000008>;
                            dfe_3rd_tap_ctrl = <0x00000000>;
                            dfe_4th_tap_ctrl = <0x00000008>;
                            low_freq_agc_gain = <0x00000007>;
                            high_freq_agc_boost = <0x00000000>;
                            precal_code_sel = <0x00000000>;
                        };
                        tx {
                            override = "enabled";
                            amp = <0x00000001>;
                            total_driver_units = <0x00000013>;
                            post_emph = <0x00000002>;
                            pre_emph = <0x00000000>;
                            slew_rate = <0x00000000>;
                        };
                    };
                };
                group3 {
                    interface = "10gbe";
                    ref-clock = "156.25Mhz";
                    active-lanes = <0x00000001 0x00000003>;
                    inv-tx-lanes;
                    inv-rx-lanes;
                    ssc = "disabled";
                    lane_0_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                    lane_1_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                    lane_2_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                    lane_3_params {
                        rx {
                            override = "disabled";
                        };
                        tx {
                            override = "disabled";
                        };
                    };
                };
            };
            ethernet {
                port0 {
                    status = "disabled";
                };
                port1 {
                    status = "enabled";
                    mode = "rgmii";
                    ext_phy {
                        phy_mgmt_if = "mdc-mdio";
                        phy-addr = <0x00000004>;
                        mdc-mdio-freq = "1.0Mhz";
                        auto-neg-mode = "out-of-band";
                    };
                };
                port2 {
                    status = "disabled";
                };
                port3 {
                    status = "enabled";
                    mode = "rgmii";
                    ext_phy {
                        phy_mgmt_if = "mdc-mdio";
                        phy-addr = <0x00000005>;
                        mdc-mdio-freq = "1.0Mhz";
                        auto-neg-mode = "out-of-band";
                    };
                };
            };
            pcie {
                ep-ports;
                port0 {
                    status = "enabled";
                    gen = <0x00000002>;
                    width = <0x00000002>;
                };
                port1 {
                    status = "enabled";
                    gen = <0x00000002>;
                    width = <0x00000002>;
                };
                port2 {
                    status = "disabled";
                    gen = <0x00000003>;
                    width = <0x00000004>;
                };
            };
        };
    };
    leds {
        compatible = "gpio-leds";
        backup-led {
            label = "backup";
            gpios = <0x0000000c 0x00000004 0x00000000>;
            default-state = "off";
        };
        sata1-led {
            label = "sata1";
            gpios = <0x0000000d 0x00000004 0x00000000>;
            default-state = "keep";
        };
        sata2-led {
            label = "sata2";
            gpios = <0x0000000d 0x00000005 0x00000000>;
            default-state = "keep";
        };
        sata3-led {
            label = "sata3";
            gpios = <0x0000000d 0x00000006 0x00000000>;
            default-state = "keep";
        };
        sata4-led {
            label = "sata4";
            gpios = <0x0000000d 0x00000007 0x00000000>;
            default-state = "keep";
        };
        act-led {
            label = "act";
            gpios = <0x0000000e 0x00000002 0x00000000>;
            default-state = "off";
        };
        power-led {
            label = "pwr";
            gpios = <0x0000000e 0x00000001 0x00000000>;
            default-state = "keep";
        };
    };
    gpio_keys {
        compatible = "gpio-keys";
        #address-cells = <0x00000001>;
        #size-cells = <0x00000000>;
        button at 1 {
            label = "Power Button";
            linux,code = <0x00000074>;
            gpios = <0x0000000f 0x00000003 0x00000000>;
        };
        button at 2 {
            label = "Reset Button";
            linux,code = <0x00000198>;
            gpios = <0x0000000f 0x00000004 0x00000001>;
        };
        button at 3 {
            label = "Backup Button";
            linux,code = <0x00000085>;
            gpios = <0x0000000e 0x00000000 0x00000001>;
        };
    };
    gpio_lcd {
        compatible = "gpio-lcd";
        lcm-data-4bit;
        lcm-lines = <0x00000002>;
        lcm-bits = <0x0000000e 0x00000004 0x00000000 0x0000000e
0x00000005 0x00000000 0x0000000e 0x00000006 0x00000000 0x0000000e
0x00000007 0x00000000>;
        lcm-rs = <0x0000000e 0x00000003 0x00000000>;
        lcm-bl = <0x0000000f 0x00000000 0x00000000>;
        lcm-rw = <0x0000000f 0x00000001 0x00000000>;
        lcm-en = <0x0000000f 0x00000002 0x00000000>;
        linux,phandle = <0x00000010>;
        phandle = <0x00000010>;
    };
    readynas_lcd {
        compatible = "readynas-lcd";
        lcd-device = <0x00000010>;
    };
    gpio_pwr {
        compatible = "gpio-power-off";
        gpios = <0x0000000c 0x00000007 0x00000000>;
    };
};
