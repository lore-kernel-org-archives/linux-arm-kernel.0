From: tharvey@gateworks.com (Tim Harvey)
Date: Mon, 3 Mar 2014 10:28:00 -0800
Subject: [PATCH 0/7] PCI irq mapping fixes and cleanups
In-Reply-To: <20140303180143.GC31062@obsidianresearch.com>
References: <1393608523-17509-1-git-send-email-l.stach@pengutronix.de>
 <CAJ+vNU2VN5haOU2GN5o7UUg9vgYh06pAhvDaoGw6EzTBEbD0mg@mail.gmail.com>
 <20140301183059.GA6315@obsidianresearch.com>
 <000601cf36b8$330b3a90$9921afb0$%han@samsung.com>
 <CAJ+vNU3UL+LTWnoxW7scAig19=z2xoYCA-HZ6a7GUyGEXtKK9Q@mail.gmail.com>
 <20140303180143.GC31062@obsidianresearch.com>
Message-ID: <CAJ+vNU1R_Oj0NEXxES+HDZg+7iaen5YuzBCgJGoy2iss44gZhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 3, 2014 at 10:01 AM, Jason Gunthorpe
<jgunthorpe@obsidianresearch.com> wrote:
> On Mon, Mar 03, 2014 at 09:49:52AM -0800, Tim Harvey wrote:
>
>> I'm not clear why irq 20 is getting returned for all the slots with
>> (slot%4)=0 and func=0.  If I start debugging of_irq_parse_pci() I see
>> that it walks up the tree until it gets to the pcie host controller
>> then calls of_irq_parse_raw() which is returning irq20 or -EINVAL.
>
> Can you share your DT as well?

sure - I'm not sure what the best way to show this is (a dtc
commandline probably?).  This is from u-boot:

/ {
        board = "GW5410-SP275-B";
        system-serial = [35 30 38 38 30];
        #address-cells = <0x00000001>;
        #size-cells = <0x00000001>;
        model = "Gateworks Ventana i.MX6 Quad GW54XX";
        compatible = "gw,imx6q-gw54xx", "gw,ventana", "fsl,imx6q";
        chosen {
                bootargs = "console=ttymxc1,115200";
        };
        aliases {
                gpio0 = "/soc/aips-bus at 02000000/gpio at 0209c000";
                gpio1 = "/soc/aips-bus at 02000000/gpio at 020a0000";
                gpio2 = "/soc/aips-bus at 02000000/gpio at 020a4000";
                gpio3 = "/soc/aips-bus at 02000000/gpio at 020a8000";
                gpio4 = "/soc/aips-bus at 02000000/gpio at 020ac000";
                gpio5 = "/soc/aips-bus at 02000000/gpio at 020b0000";
                gpio6 = "/soc/aips-bus at 02000000/gpio at 020b4000";
                i2c0 = "/soc/aips-bus at 02100000/i2c at 021a0000";
                i2c1 = "/soc/aips-bus at 02100000/i2c at 021a4000";
                i2c2 = "/soc/aips-bus at 02100000/i2c at 021a8000";
                serial0 =
"/soc/aips-bus at 02000000/spba-bus at 02000000/serial at 02020000";
                serial1 = "/soc/aips-bus at 02100000/serial at 021e8000";
                serial4 = "/soc/aips-bus at 02100000/serial at 021f4000";
                can0 = "/soc/aips-bus at 02000000/flexcan at 02090000";
                ethernet0 = "/soc/aips-bus at 02100000/ethernet at 02188000";
                led0 = "/leds/user1";
                led1 = "/leds/user2";
                led2 = "/leds/user3";
                nand = "/soc/gpmi-nand at 00112000";
                usb0 = "/soc/aips-bus at 02100000/usb at 02184200";
                usb1 = "/soc/aips-bus at 02100000/usb at 02184000";
                usdhc2 = "/soc/aips-bus at 02100000/usdhc at 02198000";
        };
        memory {
                device_type = "memory";
                reg = <0x10000000 0x40000000>;
        };
        interrupt-controller at 00a01000 {
                compatible = "arm,cortex-a9-gic";
                #interrupt-cells = <0x00000003>;
                #address-cells = <0x00000001>;
                #size-cells = <0x00000001>;
                interrupt-controller;
                reg = <0x00a01000 0x00001000 0x00a00100 0x00000100>;
                linux,phandle = <0x00000001>;
                phandle = <0x00000001>;
        };
        clocks {
                #address-cells = <0x00000001>;
                #size-cells = <0x00000000>;
                ckil {
                        compatible = "fsl,imx-ckil", "fixed-clock";
                        clock-frequency = <0x00008000>;
                };
                ckih1 {
                        compatible = "fsl,imx-ckih1", "fixed-clock";
                        clock-frequency = <0x00000000>;
                };
                osc {
                        compatible = "fsl,imx-osc", "fixed-clock";
                        clock-frequency = <0x016e3600>;
                };
        };
        soc {
                #address-cells = <0x00000001>;
                #size-cells = <0x00000001>;
                compatible = "simple-bus";
                interrupt-parent = <0x00000001>;
                ranges;
                dma-apbh at 00110000 {
                        compatible = "fsl,imx6q-dma-apbh", "fsl,imx28-dma-apbh";
                        reg = <0x00110000 0x00002000>;
                        interrupts = <0x00000000 0x0000000d 0x00000004
0x00000000 0x0000000d 0x00000004 0x00000000 0x0000000d 0x00000004
0x00000000 0x0000000d 0x00000004>;
                        interrupt-names = "gpmi0", "gpmi1", "gpmi2", "gpmi3";
                        #dma-cells = <0x00000001>;
                        dma-channels = <0x00000004>;
                        clocks = <0x00000002 0x0000006a>;
                        linux,phandle = <0x00000003>;
                        phandle = <0x00000003>;
                };
                gpmi-nand at 00112000 {
                        compatible = "fsl,imx6q-gpmi-nand";
                        #address-cells = <0x00000001>;
                        #size-cells = <0x00000001>;
                        reg = <0x00112000 0x00002000 0x00114000 0x00002000>;
                        reg-names = "gpmi-nand", "bch";
                        interrupts = <0x00000000 0x0000000f 0x00000004>;
                        interrupt-names = "bch";
                        clocks = <0x00000002 0x00000098 0x00000002
0x00000099 0x00000002 0x00000097 0x00000002 0x00000096 0x00000002
0x00000095>;
                        clock-names = "gpmi_io", "gpmi_apb",
"gpmi_bch", "gpmi_bch_apb", "per1_bch";
                        dmas = <0x00000003 0x00000000>;
                        dma-names = "rx-tx";
                        status = "okay";
                        pinctrl-names = "default";
                        pinctrl-0 = <0x00000004>;
                        partition at 0 {
                                label = "uboot";
                                reg = <0x00000000 0x01000000>;
                        };
                        partition at 1000000 {
                                label = "env";
                                reg = <0x01000000 0x00100000>;
                        };
                        partition at 1100000 {
                                label = "rootfs";
                                reg = <0x01100000 0x0ef00000>;
                        };
                };
                timer at 00a00600 {
                        compatible = "arm,cortex-a9-twd-timer";
                        reg = <0x00a00600 0x00000020>;
                        interrupts = <0x00000001 0x0000000d 0x00000f01>;
                        clocks = <0x00000002 0x0000000f>;
                };
                l2-cache at 00a02000 {
                        compatible = "arm,pl310-cache";
                        reg = <0x00a02000 0x00001000>;
                        interrupts = <0x00000000 0x0000005c 0x00000004>;
                        cache-unified;
                        cache-level = <0x00000002>;
                        arm,tag-latency = <0x00000004 0x00000002 0x00000003>;
                        arm,data-latency = <0x00000004 0x00000002 0x00000003>;
                        linux,phandle = <0x00000022>;
                        phandle = <0x00000022>;
                };
                pcie at 0x01000000 {
                        compatible = "fsl,imx6q-pcie", "snps,dw-pcie";
                        reg = <0x01ffc000 0x00004000>;
                        #address-cells = <0x00000003>;
                        #size-cells = <0x00000002>;
                        device_type = "pci";
                        ranges = * 0x18000ce0 [0x00000048];
                        num-lanes = <0x00000001>;
                        interrupts = <0x00000000 0x0000007b 0x00000004>;
                        #interrupt-cells = <0x00000001>;
                        interrupt-map-mask = <0x00000000 0x00000000
0x00000000 0x00000007>;
                        interrupt-map = * 0x18000d88 [0x00000080];
                        clocks = <0x00000002 0x000000bd 0x00000002
0x000000bb 0x00000002 0x000000ce 0x00000002 0x00000090>;
                        clock-names = "pcie_ref_125m",
"sata_ref_100m", "lvds_gate", "pcie_axi";
                        status = "okay";
                        reset-gpio = <0x00000005 0x0000001d 0x00000000>;
                };
                pmu {
                        compatible = "arm,cortex-a9-pmu";
                        interrupts = <0x00000000 0x0000005e 0x00000004>;
                };
                aips-bus at 02000000 {
                        compatible = "fsl,aips-bus", "simple-bus";
                        #address-cells = <0x00000001>;
                        #size-cells = <0x00000001>;
                        reg = <0x02000000 0x00100000>;
                        ranges;
                        spba-bus at 02000000 {
                                compatible = "fsl,spba-bus", "simple-bus";
                                #address-cells = <0x00000001>;
                                #size-cells = <0x00000001>;
                                reg = <0x02000000 0x00040000>;
                                ranges;
                                spdif at 02004000 {
                                        compatible = "fsl,imx35-spdif";
                                        reg = <0x02004000 0x00004000>;
                                        interrupts = <0x00000000
0x00000034 0x00000004>;
                                        dmas = <0x00000006 0x0000000e
0x00000012 0x00000000 0x00000006 0x0000000f 0x00000012 0x00000000>;
                                        dma-names = "rx", "tx";
                                        clocks = * 0x18001084 [0x00000048];
                                        clock-names = "core", "rxtx0",
"rxtx1", "rxtx2", "rxtx3", "rxtx4", "rxtx5", "rxtx6", "rxtx7";
                                        status = "disabled";
                                };
                                serial at 02020000 {
                                        compatible = "fsl,imx6q-uart",
"fsl,imx21-uart";
                                        reg = <0x02020000 0x00004000>;
                                        interrupts = <0x00000000
0x0000001a 0x00000004>;
                                        clocks = <0x00000002
0x000000a0 0x00000002 0x000000a1>;
                                        clock-names = "ipg", "per";
                                        dmas = <0x00000006 0x00000019
0x00000004 0x00000000 0x00000006 0x0000001a 0x00000004 0x00000000>;
                                        dma-names = "rx", "tx";
                                        status = "okay";
                                        pinctrl-names = "default";
                                        pinctrl-0 = <0x00000007>;
                                };
                                esai at 02024000 {
                                        reg = <0x02024000 0x00004000>;
                                        interrupts = <0x00000000
0x00000033 0x00000004>;
                                };
                                ssi at 0202c000 {
                                        compatible = "fsl,imx6q-ssi",
"fsl,imx21-ssi";
                                        reg = <0x0202c000 0x00004000>;
                                        interrupts = <0x00000000
0x0000002f 0x00000004>;
                                        clocks = <0x00000002 0x000000b3>;
                                        dmas = <0x00000006 0x00000029
0x00000001 0x00000000 0x00000006 0x0000002a 0x00000001 0x00000000>;
                                        dma-names = "rx", "tx";
                                        fsl,fifo-depth = <0x0000000f>;
                                        fsl,ssi-dma-events =
<0x0000002a 0x00000029>;
                                        status = "okay";
                                        fsl,mode = "i2s-slave";
                                };
                                ssi at 02030000 {
                                        compatible = "fsl,imx6q-ssi",
"fsl,imx21-ssi";
                                        reg = <0x02030000 0x00004000>;
                                        interrupts = <0x00000000
0x00000030 0x00000004>;
                                        clocks = <0x00000002 0x000000b4>;
                                        dmas = <0x00000006 0x0000002d
0x00000001 0x00000000 0x00000006 0x0000002e 0x00000001 0x00000000>;
                                        dma-names = "rx", "tx";
                                        fsl,fifo-depth = <0x0000000f>;
                                        fsl,ssi-dma-events =
<0x0000002e 0x0000002d>;
                                        status = "disabled";
                                };
                                asrc at 02034000 {
                                        reg = <0x02034000 0x00004000>;
                                        interrupts = <0x00000000
0x00000032 0x00000004>;
                                };
                                spba at 0203c000 {
                                        reg = <0x0203c000 0x00004000>;
                                };
                                ecspi at 02018000 {
                                        #address-cells = <0x00000001>;
                                        #size-cells = <0x00000000>;
                                        compatible =
"fsl,imx6q-ecspi", "fsl,imx51-ecspi";
                                        reg = <0x02018000 0x00004000>;
                                        interrupts = <0x00000000
0x00000023 0x00000004>;
                                        clocks = <0x00000002
0x00000074 0x00000002 0x00000074>;
                                        clock-names = "ipg", "per";
                                        status = "disabled";
                                };
                        };
                        vpu at 02040000 {
                                reg = <0x02040000 0x0003c000>;
                                interrupts = <0x00000000 0x00000003
0x00000004 0x00000000 0x0000000c 0x00000004>;
                        };
                        aipstz at 0207c000 {
                                reg = <0x0207c000 0x00004000>;
                        };
                        pwm at 02080000 {
                                #pwm-cells = <0x00000002>;
                                compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
                                reg = <0x02080000 0x00004000>;
                                interrupts = <0x00000000 0x00000053 0x00000004>;
                                clocks = <0x00000002 0x0000003e
0x00000002 0x00000091>;
                                clock-names = "ipg", "per";
                        };
                        pwm at 02084000 {
                                #pwm-cells = <0x00000002>;
                                compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
                                reg = <0x02084000 0x00004000>;
                                interrupts = <0x00000000 0x00000054 0x00000004>;
                                clocks = <0x00000002 0x0000003e
0x00000002 0x00000092>;
                                clock-names = "ipg", "per";
                        };
                        pwm at 02088000 {
                                #pwm-cells = <0x00000002>;
                                compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
                                reg = <0x02088000 0x00004000>;
                                interrupts = <0x00000000 0x00000055 0x00000004>;
                                clocks = <0x00000002 0x0000003e
0x00000002 0x00000093>;
                                clock-names = "ipg", "per";
                        };
                        pwm at 0208c000 {
                                #pwm-cells = <0x00000002>;
                                compatible = "fsl,imx6q-pwm", "fsl,imx27-pwm";
                                reg = <0x0208c000 0x00004000>;
                                interrupts = <0x00000000 0x00000056 0x00000004>;
                                clocks = <0x00000002 0x0000003e
0x00000002 0x00000094>;
                                clock-names = "ipg", "per";
                        };
                        flexcan at 02090000 {
                                compatible = "fsl,imx6q-flexcan";
                                reg = <0x02090000 0x00004000>;
                                interrupts = <0x00000000 0x0000006e 0x00000004>;
                                clocks = <0x00000002 0x0000006c
0x00000002 0x0000006d>;
                                clock-names = "ipg", "per";
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <0x00000008>;
                        };
                        flexcan at 02094000 {
                                compatible = "fsl,imx6q-flexcan";
                                reg = <0x02094000 0x00004000>;
                                interrupts = <0x00000000 0x0000006f 0x00000004>;
                                clocks = <0x00000002 0x0000006e
0x00000002 0x0000006f>;
                                clock-names = "ipg", "per";
                                status = "disabled";
                        };
                        gpt at 02098000 {
                                compatible = "fsl,imx6q-gpt", "fsl,imx31-gpt";
                                reg = <0x02098000 0x00004000>;
                                interrupts = <0x00000000 0x00000037 0x00000004>;
                                clocks = <0x00000002 0x00000077
0x00000002 0x00000078>;
                                clock-names = "ipg", "per";
                        };
                        gpio at 0209c000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x0209c000 0x00004000>;
                                interrupts = <0x00000000 0x00000042
0x00000004 0x00000000 0x00000043 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                                linux,phandle = <0x00000005>;
                                phandle = <0x00000005>;
                        };
                        gpio at 020a0000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x020a0000 0x00004000>;
                                interrupts = <0x00000000 0x00000044
0x00000004 0x00000000 0x00000045 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                        };
                        gpio at 020a4000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x020a4000 0x00004000>;
                                interrupts = <0x00000000 0x00000046
0x00000004 0x00000000 0x00000047 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                                linux,phandle = <0x00000027>;
                                phandle = <0x00000027>;
                        };
                        gpio at 020a8000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x020a8000 0x00004000>;
                                interrupts = <0x00000000 0x00000048
0x00000004 0x00000000 0x00000049 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                                linux,phandle = <0x00000026>;
                                phandle = <0x00000026>;
                        };
                        gpio at 020ac000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x020ac000 0x00004000>;
                                interrupts = <0x00000000 0x0000004a
0x00000004 0x00000000 0x0000004b 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                        };
                        gpio at 020b0000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x020b0000 0x00004000>;
                                interrupts = <0x00000000 0x0000004c
0x00000004 0x00000000 0x0000004d 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                        };
                        gpio at 020b4000 {
                                compatible = "fsl,imx6q-gpio", "fsl,imx35-gpio";
                                reg = <0x020b4000 0x00004000>;
                                interrupts = <0x00000000 0x0000004e
0x00000004 0x00000000 0x0000004f 0x00000004>;
                                gpio-controller;
                                #gpio-cells = <0x00000002>;
                                interrupt-controller;
                                #interrupt-cells = <0x00000002>;
                                linux,phandle = <0x00000018>;
                                phandle = <0x00000018>;
                        };
                        kpp at 020b8000 {
                                reg = <0x020b8000 0x00004000>;
                                interrupts = <0x00000000 0x00000052 0x00000004>;
                        };
                        wdog at 020bc000 {
                                compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
                                reg = <0x020bc000 0x00004000>;
                                interrupts = <0x00000000 0x00000050 0x00000004>;
                                clocks = <0x00000002 0x00000000>;
                        };
                        wdog at 020c0000 {
                                compatible = "fsl,imx6q-wdt", "fsl,imx21-wdt";
                                reg = <0x020c0000 0x00004000>;
                                interrupts = <0x00000000 0x00000051 0x00000004>;
                                clocks = <0x00000002 0x00000000>;
                                status = "disabled";
                        };
                        ccm at 020c4000 {
                                compatible = "fsl,imx6q-ccm";
                                reg = <0x020c4000 0x00004000>;
                                interrupts = <0x00000000 0x00000057
0x00000004 0x00000000 0x00000058 0x00000004>;
                                #clock-cells = <0x00000001>;
                                linux,phandle = <0x00000002>;
                                phandle = <0x00000002>;
                        };
                        anatop at 020c8000 {
                                compatible = "fsl,imx6q-anatop",
"syscon", "simple-bus";
                                reg = <0x020c8000 0x00001000>;
                                interrupts = <0x00000000 0x00000031
0x00000004 0x00000000 0x00000036 0x00000004 0x00000000 0x0000007f
0x00000004>;
                                linux,phandle = <0x00000009>;
                                phandle = <0x00000009>;
                                regulator-1p1 at 110 {
                                        compatible = "fsl,anatop-regulator";
                                        regulator-name = "vdd1p1";
                                        regulator-min-microvolt = "", "5";
                                        regulator-max-microvolt = <0x0014fb18>;
                                        regulator-always-on;
                                        anatop-reg-offset = <0x00000110>;
                                        anatop-vol-bit-shift = <0x00000008>;
                                        anatop-vol-bit-width = <0x00000005>;
                                        anatop-min-bit-val = <0x00000004>;
                                        anatop-min-voltage = "", "5";
                                        anatop-max-voltage = <0x0014fb18>;
                                };
                                regulator-3p0 at 120 {
                                        compatible = "fsl,anatop-regulator";
                                        regulator-name = "vdd3p0";
                                        regulator-min-microvolt = <0x002ab980>;
                                        regulator-max-microvolt = <0x003010b0>;
                                        regulator-always-on;
                                        anatop-reg-offset = <0x00000120>;
                                        anatop-vol-bit-shift = <0x00000008>;
                                        anatop-vol-bit-width = <0x00000005>;
                                        anatop-min-bit-val = <0x00000000>;
                                        anatop-min-voltage = <0x00280de8>;
                                        anatop-max-voltage = <0x0033e140>;
                                };
                                regulator-2p5 at 130 {
                                        compatible = "fsl,anatop-regulator";
                                        regulator-name = "vdd2p5";
                                        regulator-min-microvolt = <0x001e8480>;
                                        regulator-max-microvolt = <0x0029f630>;
                                        regulator-always-on;
                                        anatop-reg-offset = <0x00000130>;
                                        anatop-vol-bit-shift = <0x00000008>;
                                        anatop-vol-bit-width = <0x00000005>;
                                        anatop-min-bit-val = <0x00000000>;
                                        anatop-min-voltage = <0x001e8480>;
                                        anatop-max-voltage = <0x0029f630>;
                                };
                                regulator-vddcore at 140 {
                                        compatible = "fsl,anatop-regulator";
                                        regulator-name = "cpu";
                                        regulator-min-microvolt = <0x000b1008>;
                                        regulator-max-microvolt = <0x00162010>;
                                        regulator-always-on;
                                        anatop-reg-offset = <0x00000140>;
                                        anatop-vol-bit-shift = <0x00000000>;
                                        anatop-vol-bit-width = <0x00000005>;
                                        anatop-delay-reg-offset = <0x00000170>;
                                        anatop-delay-bit-shift = <0x00000018>;
                                        anatop-delay-bit-width = <0x00000002>;
                                        anatop-min-bit-val = <0x00000001>;
                                        anatop-min-voltage = <0x000b1008>;
                                        anatop-max-voltage = <0x00162010>;
                                        linux,phandle = <0x00000023>;
                                        phandle = <0x00000023>;
                                };
                                regulator-vddpu at 140 {
                                        compatible = "fsl,anatop-regulator";
                                        regulator-name = "vddpu";
                                        regulator-min-microvolt = <0x000b1008>;
                                        regulator-max-microvolt = <0x00162010>;
                                        regulator-always-on;
                                        anatop-reg-offset = <0x00000140>;
                                        anatop-vol-bit-shift = <0x00000009>;
                                        anatop-vol-bit-width = <0x00000005>;
                                        anatop-delay-reg-offset = <0x00000170>;
                                        anatop-delay-bit-shift = <0x0000001a>;
                                        anatop-delay-bit-width = <0x00000002>;
                                        anatop-min-bit-val = <0x00000001>;
                                        anatop-min-voltage = <0x000b1008>;
                                        anatop-max-voltage = <0x00162010>;
                                        linux,phandle = <0x00000024>;
                                        phandle = <0x00000024>;
                                };
                                regulator-vddsoc at 140 {
                                        compatible = "fsl,anatop-regulator";
                                        regulator-name = "vddsoc";
                                        regulator-min-microvolt = <0x000b1008>;
                                        regulator-max-microvolt = <0x00162010>;
                                        regulator-always-on;
                                        anatop-reg-offset = <0x00000140>;
                                        anatop-vol-bit-shift = <0x00000012>;
                                        anatop-vol-bit-width = <0x00000005>;
                                        anatop-delay-reg-offset = <0x00000170>;
                                        anatop-delay-bit-shift = <0x0000001c>;
                                        anatop-delay-bit-width = <0x00000002>;
                                        anatop-min-bit-val = <0x00000001>;
                                        anatop-min-voltage = <0x000b1008>;
                                        anatop-max-voltage = <0x00162010>;
                                        linux,phandle = <0x00000025>;
                                        phandle = <0x00000025>;
                                };
                        };
                        tempmon {
                                compatible = "fsl,imx6q-tempmon";
                                interrupts = <0x00000000 0x00000031 0x00000004>;
                                fsl,tempmon = <0x00000009>;
                                fsl,tempmon-data = <0x0000000a>;
                        };
                        usbphy at 020c9000 {
                                compatible = "fsl,imx6q-usbphy",
"fsl,imx23-usbphy";
                                reg = <0x020c9000 0x00001000>;
                                interrupts = <0x00000000 0x0000002c 0x00000004>;
                                clocks = <0x00000002 0x000000b6>;
                                linux,phandle = <0x00000010>;
                                phandle = <0x00000010>;
                        };
                        usbphy at 020ca000 {
                                compatible = "fsl,imx6q-usbphy",
"fsl,imx23-usbphy";
                                reg = <0x020ca000 0x00001000>;
                                interrupts = <0x00000000 0x0000002d 0x00000004>;
                                clocks = <0x00000002 0x000000b7>;
                                linux,phandle = <0x00000014>;
                                phandle = <0x00000014>;
                        };
                        snvs at 020cc000 {
                                compatible = "fsl,sec-v4.0-mon", "simple-bus";
                                #address-cells = <0x00000001>;
                                #size-cells = <0x00000001>;
                                ranges = <0x00000000 0x020cc000 0x00004000>;
                                snvs-rtc-lp at 34 {
                                        compatible = "fsl,sec-v4.0-mon-rtc-lp";
                                        reg = <0x00000034 0x00000058>;
                                        interrupts = <0x00000000
0x00000013 0x00000004 0x00000000 0x00000014 0x00000004>;
                                };
                        };
                        epit at 020d0000 {
                                reg = <0x020d0000 0x00004000>;
                                interrupts = <0x00000000 0x00000038 0x00000004>;
                        };
                        epit at 020d4000 {
                                reg = <0x020d4000 0x00004000>;
                                interrupts = <0x00000000 0x00000039 0x00000004>;
                        };
                        src at 020d8000 {
                                compatible = "fsl,imx6q-src", "fsl,imx51-src";
                                reg = <0x020d8000 0x00004000>;
                                interrupts = <0x00000000 0x0000005b
0x00000004 0x00000000 0x00000060 0x00000004>;
                                #reset-cells = <0x00000001>;
                                linux,phandle = <0x00000021>;
                                phandle = <0x00000021>;
                        };
                        gpc at 020dc000 {
                                compatible = "fsl,imx6q-gpc";
                                reg = <0x020dc000 0x00004000>;
                                interrupts = <0x00000000 0x00000059
0x00000004 0x00000000 0x0000005a 0x00000004>;
                        };
                        iomuxc-gpr at 020e0000 {
                                compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
                                reg = <0x020e0000 0x00000038>;
                                linux,phandle = <0x0000000c>;
                                phandle = <0x0000000c>;
                        };
                        iomuxc at 020e0000 {
                                compatible = "fsl,imx6q-iomuxc";
                                reg = <0x020e0000 0x00004000>;
                                pinctrl-names = "default";
                                pinctrl-0 = <0x0000000b>;
                                audmux {
                                        audmux-1 {
                                                fsl,pins = *
0x18002eb8 [0x00000060];
                                                linux,phandle = <0x0000001e>;
                                                phandle = <0x0000001e>;
                                        };
                                        audmux-2 {
                                                fsl,pins = *
0x18002f58 [0x00000060];
                                        };
                                        audmux-3 {
                                                fsl,pins = *
0x18002fd8 [0x00000048];
                                        };
                                        audmux-4 {
                                                fsl,pins = *
0x18003040 [0x00000048];
                                        };
                                };
                                ecspi1 {
                                        ecspi1grp-1 {
                                                fsl,pins = *
0x180030b8 [0x00000048];
                                        };
                                        ecspi1grp-2 {
                                                fsl,pins = *
0x18003120 [0x00000048];
                                        };
                                };
                                ecspi3 {
                                        ecspi3grp-1 {
                                                fsl,pins = *
0x18003198 [0x00000048];
                                        };
                                };
                                enet {
                                        enetgrp-1 {
                                                fsl,pins = *
0x18003210 [0x00000180];
                                                linux,phandle = <0x00000016>;
                                                phandle = <0x00000016>;
                                        };
                                        enetgrp-2 {
                                                fsl,pins = *
0x180033d0 [0x00000168];
                                        };
                                        enetgrp-3 {
                                                fsl,pins = *
0x18003558 [0x00000180];
                                        };
                                };
                                esai {
                                        esaigrp-1 {
                                                fsl,pins = *
0x18003708 [0x000000d8];
                                        };
                                        esaigrp-2 {
                                                fsl,pins = *
0x18003800 [0x000000f0];
                                        };
                                };
                                flexcan1 {
                                        flexcan1grp-1 {
                                                fsl,pins = <0x0000020c
0x000005dc 0x000007e4 0x00000002 0x00000000 0x80000000 0x00000208
0x000005d8 0x00000000 0x00000002 0x00000000 0x80000000>;
                                                linux,phandle = <0x00000008>;
                                                phandle = <0x00000008>;
                                        };
                                        flexcan1grp-2 {
                                                fsl,pins = <0x00000240
0x00000610 0x00000000 0x00000003 0x00000000 0x80000000 0x0000020c
0x000005dc 0x000007e4 0x00000002 0x00000000 0x80000000>;
                                        };
                                };
                                flexcan2 {
                                        flexcan2grp-1 {
                                                fsl,pins = <0x00000218
0x000005e8 0x00000000 0x00000000 0x00000000 0x80000000 0x0000021c
0x000005ec 0x000007e8 0x00000000 0x00000000 0x80000000>;
                                        };
                                };
                                gpmi-nand {
                                        gpmi-nand-1 {
                                                fsl,pins = *
0x18003a68 [0x00000198];
                                        };
                                        gpmi-nand-2 {
                                                fsl,pins = *
0x18003c20 [0x00000180];
                                                linux,phandle = <0x00000004>;
                                                phandle = <0x00000004>;
                                        };
                                };
                                hdmi_hdcp {
                                        hdmihdcpgrp-1 {
                                                fsl,pins = <0x00000210
0x000005e0 0x00000890 0x00000002 0x00000001 0x4001b8b1 0x00000214
0x000005e4 0x00000894 0x00000002 0x00000001 0x4001b8b1>;
                                        };
                                        hdmihdcpgrp-2 {
                                                fsl,pins = <0x0000008c
0x000003a0 0x00000890 0x00000004 0x00000000 0x4001b8b1 0x00000090
0x000003a4 0x00000894 0x00000004 0x00000000 0x4001b8b1>;
                                        };
                                        hdmihdcpgrp-3 {
                                                fsl,pins = <0x0000008c
0x000003a0 0x00000890 0x00000004 0x00000000 0x4001b8b1 0x00000214
0x000005e4 0x00000894 0x00000002 0x00000001 0x4001b8b1>;
                                        };
                                };
                                hdmi_cec {
                                        hdmicecgrp-1 {
                                                fsl,pins = <0x00000088
0x0000039c 0x0000088c 0x00000006 0x00000000 0x0001f8b0>;
                                        };
                                        hdmicecgrp-2 {
                                                fsl,pins = <0x0000020c
0x000005dc 0x0000088c 0x00000006 0x00000001 0x0001f8b0>;
                                        };
                                };
                                i2c1 {
                                        i2c1grp-1 {
                                                fsl,pins = <0x000000a4
0x000003b8 0x00000898 0x00000006 0x00000000 0x4001b8b1 0x000000c4
0x000003d8 0x0000089c 0x00000001 0x00000000 0x4001b8b1>;
                                                linux,phandle = <0x0000001a>;
                                                phandle = <0x0000001a>;
                                        };
                                        i2c1grp-2 {
                                                fsl,pins = <0x00000278
0x00000648 0x0000089c 0x00000004 0x00000001 0x4001b8b1 0x0000027c
0x0000064c 0x00000898 0x00000004 0x00000001 0x4001b8b1>;
                                        };
                                };
                                i2c2 {
                                        i2c2grp-1 {
                                                fsl,pins = <0x0000008c
0x000003a0 0x000008a0 0x00000006 0x00000000 0x4001b8b1 0x00000090
0x000003a4 0x000008a4 0x00000006 0x00000000 0x4001b8b1>;
                                        };
                                        i2c2grp-2 {
                                                fsl,pins = <0x00000210
0x000005e0 0x000008a0 0x00000004 0x00000001 0x4001b8b1 0x00000214
0x000005e4 0x000008a4 0x00000004 0x00000001 0x4001b8b1>;
                                                linux,phandle = <0x0000001b>;
                                                phandle = <0x0000001b>;
                                        };
                                        i2c2grp-3 {
                                                fsl,pins = <0x0000008c
0x000003a0 0x000008a0 0x00000006 0x00000000 0x4001b8b1 0x00000214
0x000005e4 0x000008a4 0x00000004 0x00000001 0x4001b8b1>;
                                        };
                                };
                                i2c3 {
                                        i2c3grp-1 {
                                                fsl,pins = <0x00000094
0x000003a8 0x000008a8 0x00000006 0x00000000 0x4001b8b1 0x00000098
0x000003ac 0x000008ac 0x00000006 0x00000000 0x4001b8b1>;
                                        };
                                        i2c3grp-2 {
                                                fsl,pins = <0x0000022c
0x000005fc 0x000008a8 0x00000002 0x00000001 0x4001b8b1 0x00000230
0x00000600 0x000008ac 0x00000002 0x00000001 0x4001b8b1>;
                                                linux,phandle = <0x0000001c>;
                                                phandle = <0x0000001c>;
                                        };
                                        i2c3grp-3 {
                                                fsl,pins = <0x0000023c
0x0000060c 0x000008a8 0x00000006 0x00000002 0x4001b8b1 0x00000248
0x00000618 0x000008ac 0x00000006 0x00000002 0x4001b8b1>;
                                        };
                                        i2c3grp-4 {
                                                fsl,pins = <0x0000022c
0x000005fc 0x000008a8 0x00000002 0x00000001 0x4001b8b1 0x00000098
0x000003ac 0x000008ac 0x00000006 0x00000000 0x4001b8b1>;
                                        };
                                };
                                ipu1 {
                                        ipu1grp-1 {
                                                fsl,pins = *
0x180042ec [0x000002b8];
                                        };
                                        ipu1grp-2 {
                                                fsl,pins = *
0x180045c4 [0x00000120];
                                        };
                                        ipu1grp-3 {
                                                fsl,pins = *
0x18004704 [0x000001c8];
                                        };
                                };
                                mlb {
                                        mlbgrp-1 {
                                                fsl,pins = *
0x180048f8 [0x00000048];
                                        };
                                        mlbgrp-2 {
                                                fsl,pins = *
0x18004960 [0x00000048];
                                        };
                                };
                                pwm0 {
                                        pwm0grp-1 {
                                                fsl,pins = <0x00000344
0x0000072c 0x00000000 0x00000003 0x00000000 0x0001b0b1>;
                                        };
                                };
                                pwm3 {
                                        pwm3grp-1 {
                                                fsl,pins = <0x00000320
0x00000708 0x00000000 0x00000002 0x00000000 0x0001b0b1>;
                                        };
                                };
                                spdif {
                                        spdifgrp-1 {
                                                fsl,pins = <0x00000210
0x000005e0 0x00000914 0x00000006 0x00000002 0x0001b0b0>;
                                        };
                                        spdifgrp-2 {
                                                fsl,pins = <0x00000248
0x00000618 0x00000914 0x00000004 0x00000003 0x0001b0b0 0x0000024c
0x0000061c 0x00000000 0x00000004 0x00000000 0x0001b0b0>;
                                        };
                                        spdifgrp-3 {
                                                fsl,pins = <0x000001e4
0x000004f8 0x00000000 0x00000003 0x00000000 0x0001b0b0>;
                                        };
                                };
                                uart1 {
                                        uart1grp-1 {
                                                fsl,pins = <0x00000280
0x00000650 0x00000000 0x00000003 0x00000000 0x0001b0b1 0x00000284
0x00000654 0x00000920 0x00000003 0x00000001 0x0001b0b1>;
                                        };
                                        uart1grp-2 {
                                                fsl,pins = <0x000002a8
0x00000690 0x00000000 0x00000001 0x00000000 0x0001b0b1 0x000002ac
0x00000694 0x00000920 0x00000001 0x00000003 0x0001b0b1>;
                                                linux,phandle = <0x00000007>;
                                                phandle = <0x00000007>;
                                        };
                                };
                                uart2 {
                                        uart2grp-1 {
                                                fsl,pins = <0x000000bc
0x000003d0 0x00000000 0x00000004 0x00000000 0x0001b0b1 0x000000c0
0x000003d4 0x00000928 0x00000004 0x00000001 0x0001b0b1>;
                                        };
                                        uart2grp-2 {
                                                fsl,pins = *
0x18004c58 [0x00000060];
                                        };
                                        uart2grp-3 {
                                                fsl,pins = <0x00000338
0x00000720 0x00000000 0x00000002 0x00000000 0x0001b0b1 0x0000032c
0x00000714 0x00000928 0x00000002 0x00000006 0x0001b0b1>;
                                                linux,phandle = <0x0000001f>;
                                                phandle = <0x0000001f>;
                                        };
                                };
                                uart3 {
                                        uart3grp-1 {
                                                fsl,pins = *
0x18004d58 [0x00000060];
                                        };
                                        uart3grp-2 {
                                                fsl,pins = *
0x18004dd8 [0x00000060];
                                        };
                                        uart3grp-3 {
                                                fsl,pins = <0x000000b4
0x000003c8 0x00000000 0x00000002 0x00000000 0x0001b0b1 0x000000b8
0x000003cc 0x00000930 0x00000002 0x00000001 0x0001b0b1>;
                                        };
                                };
                                uart4 {
                                        uart4grp-1 {
                                                fsl,pins = <0x000001f8
0x000005c8 0x00000000 0x00000004 0x00000000 0x0001b0b1 0x000001fc
0x000005cc 0x00000938 0x00000004 0x00000001 0x0001b0b1>;
                                        };
                                };
                                uart5 {
                                        uart5grp-1 {
                                                fsl,pins = <0x00000200
0x000005d0 0x00000000 0x00000004 0x00000000 0x0001b0b1 0x00000204
0x000005d4 0x00000940 0x00000004 0x00000001 0x0001b0b1>;
                                                linux,phandle = <0x00000020>;
                                                phandle = <0x00000020>;
                                        };
                                };
                                usbotg {
                                        usbotggrp-1 {
                                                fsl,pins = <0x00000224
0x000005f4 0x00000004 0x00000003 0xff0d0101 0x00017059>;
                                                linux,phandle = <0x00000013>;
                                                phandle = <0x00000013>;
                                        };
                                        usbotggrp-2 {
                                                fsl,pins = <0x000001d8
0x000004ec 0x00000004 0x00000000 0xff0d0100 0x00017059>;
                                        };
                                };
                                usbh2 {
                                        usbh2grp-1 {
                                                fsl,pins = <0x00000058
0x0000036c 0x00000000 0x00000000 0x00000000 0x40013030 0x00000074
0x00000388 0x00000000 0x00000000 0x00000000 0x40013030>;
                                        };
                                        usbh2grp-2 {
                                                fsl,pins = <0x00000074
0x00000388 0x00000000 0x00000000 0x00000000 0x40017030>;
                                        };
                                };
                                usbh3 {
                                        usbh3grp-1 {
                                                fsl,pins = <0x0000006c
0x00000380 0x00000000 0x00000000 0x00000000 0x40013030 0x00000084
0x00000398 0x00000000 0x00000000 0x00000000 0x40013030>;
                                        };
                                        usbh3grp-2 {
                                                fsl,pins = <0x00000084
0x00000398 0x00000000 0x00000000 0x00000000 0x40017030>;
                                        };
                                };
                                usdhc1 {
                                        usdhc1grp-1 {
                                                fsl,pins = *
0x18005168 [0x000000f0];
                                        };
                                        usdhc1grp-2 {
                                                fsl,pins = *
0x18005278 [0x00000090];
                                        };
                                };
                                usdhc2 {
                                        usdhc2grp-1 {
                                                fsl,pins = *
0x18005338 [0x000000f0];
                                        };
                                        usdhc2grp-2 {
                                                fsl,pins = *
0x18005448 [0x00000090];
                                        };
                                };
                                usdhc3 {
                                        usdhc3grp-1 {
                                                fsl,pins = *
0x18005508 [0x000000f0];
                                        };
                                        usdhc3grp-1-100mhz {
                                                fsl,pins = *
0x18005620 [0x000000f0];
                                        };
                                        usdhc3grp-1-200mhz {
                                                fsl,pins = *
0x18005738 [0x000000f0];
                                        };
                                        usdhc3grp-2 {
                                                fsl,pins = *
0x18005848 [0x00000090];
                                                linux,phandle = <0x00000017>;
                                                phandle = <0x00000017>;
                                        };
                                };
                                usdhc4 {
                                        usdhc4grp-1 {
                                                fsl,pins = *
0x18005928 [0x000000f0];
                                        };
                                        usdhc4grp-2 {
                                                fsl,pins = *
0x18005a38 [0x00000090];
                                        };
                                };
                                weim {
                                        weim_cs0grp-1 {
                                                fsl,pins = <0x000000f8
0x0000040c 0x00000000 0x00000000 0x00000000 0x0000b0b1>;
                                        };
                                        weim_norgrp-1 {
                                                fsl,pins = *
0x18005b38 [0x00000408];
                                        };
                                };
                                ipu2 {
                                        ipu2grp-1 {
                                                fsl,pins = *
0x18005f70 [0x000002b8];
                                        };
                                };
                                hog {
                                        hoggrp {
                                                fsl,pins = *
0x18006250 [0x00000138];
                                                linux,phandle = <0x0000000b>;
                                                phandle = <0x0000000b>;
                                        };
                                };
                        };
                        ldb at 020e0008 {
                                #address-cells = <0x00000001>;
                                #size-cells = <0x00000000>;
                                compatible = "fsl,imx6q-ldb", "fsl,imx53-ldb";
                                gpr = <0x0000000c>;
                                status = "okay";
                                clocks = <0x00000002 0x00000021
0x00000002 0x00000022 0x00000002 0x00000027 0x00000002 0x00000028
0x00000002 0x00000029 0x00000002 0x0000002a 0x00000002 0x00000087
0x00000002 0x00000088>;
                                clock-names = "di0_pll", "di1_pll",
"di0_sel", "di1_sel", "di2_sel", "di3_sel", "di0", "di1";
                                lvds-channel at 0 {
                                        reg = <0x00000000>;
                                        status = "disabled";
                                        crtcs = <0x0000000d 0x00000000
0x0000000d 0x00000001 0x0000000e 0x00000000 0x0000000e 0x00000001>;
                                };
                                lvds-channel at 1 {
                                        reg = <0x00000001>;
                                        status = "okay";
                                        crtcs = <0x0000000d 0x00000000
0x0000000d 0x00000001 0x0000000e 0x00000000 0x0000000e 0x00000001>;
                                        fsl,data-mapping = "spwg";
                                        fsl,data-width = <0x00000012>;
                                        display-timings {
                                                native-mode = <0x0000000f>;
                                                hsd100pxn1 {

clock-frequency = <0x03dfd240>;
                                                        hactive = <0x00000400>;
                                                        vactive = <0x00000300>;
                                                        hback-porch =
<0x000000dc>;
                                                        hfront-porch =
<0x00000028>;
                                                        vback-porch =
<0x00000015>;
                                                        vfront-porch =
<0x00000007>;
                                                        hsync-len =
<0x0000003c>;
                                                        vsync-len =
<0x0000000a>;
                                                        linux,phandle
= <0x0000000f>;
                                                        phandle = <0x0000000f>;
                                                };
                                        };
                                };
                        };
                        dcic at 020e4000 {
                                reg = <0x020e4000 0x00004000>;
                                interrupts = <0x00000000 0x0000007c 0x00000004>;
                        };
                        dcic at 020e8000 {
                                reg = <0x020e8000 0x00004000>;
                                interrupts = <0x00000000 0x0000007d 0x00000004>;
                        };
                        sdma at 020ec000 {
                                compatible = "fsl,imx6q-sdma", "fsl,imx35-sdma";
                                reg = <0x020ec000 0x00004000>;
                                interrupts = <0x00000000 0x00000002 0x00000004>;
                                clocks = <0x00000002 0x0000009b
0x00000002 0x0000009b>;
                                clock-names = "ipg", "ahb";
                                #dma-cells = <0x00000003>;
                                fsl,sdma-ram-script-name =
"imx/sdma/sdma-imx6q.bin";
                                linux,phandle = <0x00000006>;
                                phandle = <0x00000006>;
                        };
                };
                aips-bus at 02100000 {
                        compatible = "fsl,aips-bus", "simple-bus";
                        #address-cells = <0x00000001>;
                        #size-cells = <0x00000001>;
                        reg = <0x02100000 0x00100000>;
                        ranges;
                        caam at 02100000 {
                                reg = <0x02100000 0x00040000>;
                                interrupts = <0x00000000 0x00000069
0x00000004 0x00000000 0x0000006a 0x00000004>;
                        };
                        aipstz at 0217c000 {
                                reg = <0x0217c000 0x00004000>;
                        };
                        usb at 02184000 {
                                compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
                                reg = <0x02184000 0x00000200>;
                                interrupts = <0x00000000 0x0000002b 0x00000004>;
                                clocks = <0x00000002 0x000000a2>;
                                fsl,usbphy = <0x00000010>;
                                fsl,usbmisc = <0x00000011 0x00000000>;
                                status = "okay";
                                vbus-supply = <0x00000012>;
                                pinctrl-names = "default";
                                pinctrl-0 = <0x00000013>;
                                disable-over-current;
                        };
                        usb at 02184200 {
                                compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
                                reg = <0x02184200 0x00000200>;
                                interrupts = <0x00000000 0x00000028 0x00000004>;
                                clocks = <0x00000002 0x000000a2>;
                                fsl,usbphy = <0x00000014>;
                                fsl,usbmisc = <0x00000011 0x00000001>;
                                status = "okay";
                                vbus-supply = <0x00000015>;
                        };
                        usb at 02184400 {
                                compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
                                reg = <0x02184400 0x00000200>;
                                interrupts = <0x00000000 0x00000029 0x00000004>;
                                clocks = <0x00000002 0x000000a2>;
                                fsl,usbmisc = <0x00000011 0x00000002>;
                                status = "disabled";
                        };
                        usb at 02184600 {
                                compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
                                reg = <0x02184600 0x00000200>;
                                interrupts = <0x00000000 0x0000002a 0x00000004>;
                                clocks = <0x00000002 0x000000a2>;
                                fsl,usbmisc = <0x00000011 0x00000003>;
                                status = "disabled";
                        };
                        usbmisc at 02184800 {
                                #index-cells = <0x00000001>;
                                compatible = "fsl,imx6q-usbmisc";
                                reg = <0x02184800 0x00000200>;
                                clocks = <0x00000002 0x000000a2>;
                                linux,phandle = <0x00000011>;
                                phandle = <0x00000011>;
                        };
                        ethernet at 02188000 {
                                compatible = "fsl,imx6q-fec";
                                reg = <0x02188000 0x00004000>;
                                interrupts = <0x00000000 0x00000076
0x00000004 0x00000000 0x00000077 0x00000004>;
                                clocks = <0x00000002 0x00000075
0x00000002 0x00000075 0x00000002 0x000000be>;
                                clock-names = "ipg", "ahb", "ptp";
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <0x00000016>;
                                phy-mode = "rgmii";
                                phy-reset-gpios = <0x00000005
0x0000001e 0x00000000>;
                        };
                        mlb at 0218c000 {
                                reg = <0x0218c000 0x00004000>;
                                interrupts = <0x00000000 0x00000035
0x00000004 0x00000000 0x00000075 0x00000004 0x00000000 0x0000007e
0x00000004>;
                        };
                        usdhc at 02190000 {
                                compatible = "fsl,imx6q-usdhc";
                                reg = <0x02190000 0x00004000>;
                                interrupts = <0x00000000 0x00000016 0x00000004>;
                                clocks = <0x00000002 0x000000a3
0x00000002 0x000000a3 0x00000002 0x000000a3>;
                                clock-names = "ipg", "ahb", "per";
                                bus-width = <0x00000004>;
                                status = "disabled";
                        };
                        usdhc at 02194000 {
                                compatible = "fsl,imx6q-usdhc";
                                reg = <0x02194000 0x00004000>;
                                interrupts = <0x00000000 0x00000017 0x00000004>;
                                clocks = <0x00000002 0x000000a4
0x00000002 0x000000a4 0x00000002 0x000000a4>;
                                clock-names = "ipg", "ahb", "per";
                                bus-width = <0x00000004>;
                                status = "disabled";
                        };
                        usdhc at 02198000 {
                                compatible = "fsl,imx6q-usdhc";
                                reg = <0x02198000 0x00004000>;
                                interrupts = <0x00000000 0x00000018 0x00000004>;
                                clocks = <0x00000002 0x000000a5
0x00000002 0x000000a5 0x00000002 0x000000a5>;
                                clock-names = "ipg", "ahb", "per";
                                bus-width = <0x00000004>;
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <0x00000017>;
                                cd-gpios = <0x00000018 0x00000000 0x00000000>;
                                vmmc-supply = <0x00000019>;
                        };
                        usdhc at 0219c000 {
                                compatible = "fsl,imx6q-usdhc";
                                reg = <0x0219c000 0x00004000>;
                                interrupts = <0x00000000 0x00000019 0x00000004>;
                                clocks = <0x00000002 0x000000a6
0x00000002 0x000000a6 0x00000002 0x000000a6>;
                                clock-names = "ipg", "ahb", "per";
                                bus-width = <0x00000004>;
                                status = "disabled";
                        };
                        i2c at 021a0000 {
                                #address-cells = <0x00000001>;
                                #size-cells = <0x00000000>;
                                compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
                                reg = <0x021a0000 0x00004000>;
                                interrupts = <0x00000000 0x00000024 0x00000004>;
                                clocks = <0x00000002 0x0000007d>;
                                status = "okay";
                                clock-frequency = <0x000186a0>;
                                pinctrl-names = "default";
                                pinctrl-0 = <0x0000001a>;
                                eeprom at 50 {
                                        compatible = "atmel,24c02";
                                        reg = <0x00000050>;
                                        pagesize = <0x00000010>;
                                };
                                eeprom at 51 {
                                        compatible = "atmel,24c02";
                                        reg = <0x00000051>;
                                        pagesize = <0x00000010>;
                                };
                                eeprom at 52 {
                                        compatible = "atmel,24c02";
                                        reg = <0x00000052>;
                                        pagesize = <0x00000010>;
                                };
                                eeprom at 53 {
                                        compatible = "atmel,24c02";
                                        reg = <0x00000053>;
                                        pagesize = <0x00000010>;
                                };
                                pca9555 at 23 {
                                        compatible = "nxp,pca9555";
                                        reg = <0x00000023>;
                                        gpio-controller;
                                        #gpio-cells = <0x00000002>;
                                };
                                gsc at 29 {
                                        compatible = "gw,gsp";
                                        reg = <0x00000029>;
                                };
                                ds1672 at 68 {
                                        compatible = "dallas,ds1672";
                                        reg = <0x00000068>;
                                };
                        };
                        i2c at 021a4000 {
                                #address-cells = <0x00000001>;
                                #size-cells = <0x00000000>;
                                compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
                                reg = <0x021a4000 0x00004000>;
                                interrupts = <0x00000000 0x00000025 0x00000004>;
                                clocks = <0x00000002 0x0000007e>;
                                status = "okay";
                                clock-frequency = <0x000186a0>;
                                pinctrl-names = "default";
                                pinctrl-0 = <0x0000001b>;
                                pfuze100 at 08 {
                                        compatible = "fsl,pfuze100";
                                        reg = <0x00000008>;
                                        regulators {
                                                sw1ab {

regulator-min-microvolt = <0x000493e0>;

regulator-max-microvolt = <0x001c9c38>;
                                                        regulator-boot-on;
                                                        regulator-always-on;

regulator-ramp-delay = <0x0000186a>;
                                                };
                                                sw1c {

regulator-min-microvolt = <0x000493e0>;

regulator-max-microvolt = <0x001c9c38>;
                                                        regulator-boot-on;
                                                        regulator-always-on;

regulator-ramp-delay = <0x0000186a>;
                                                };
                                                sw2 {

regulator-min-microvolt = "", "5";

regulator-max-microvolt = <0x003c45b0>;
                                                        regulator-boot-on;
                                                        regulator-always-on;
                                                };
                                                sw3a {

regulator-min-microvolt = <0x00061a80>;

regulator-max-microvolt = <0x001e22d8>;
                                                        regulator-boot-on;
                                                        regulator-always-on;
                                                };
                                                sw3b {

regulator-min-microvolt = <0x00061a80>;

regulator-max-microvolt = <0x001e22d8>;
                                                        regulator-boot-on;
                                                        regulator-always-on;
                                                };
                                                sw4 {

regulator-min-microvolt = "", "5";

regulator-max-microvolt = <0x00325aa0>;
                                                        linux,phandle
= <0x0000001d>;
                                                        phandle = <0x0000001d>;
                                                };
                                                swbst {

regulator-min-microvolt = <0x004c4b40>;

regulator-max-microvolt = <0x004e9530>;
                                                };
                                                vsnvs {

regulator-min-microvolt = <0x000f4240>;

regulator-max-microvolt = <0x002dc6c0>;
                                                        regulator-boot-on;
                                                        regulator-always-on;
                                                };
                                                vrefddr {
                                                        regulator-boot-on;
                                                        regulator-always-on;
                                                };
                                                vgen1 {

regulator-min-microvolt = "", "5";

regulator-max-microvolt = <0x0017a6b0>;
                                                };
                                                vgen2 {

regulator-min-microvolt = "", "5";

regulator-max-microvolt = <0x0017a6b0>;
                                                };
                                                vgen3 {

regulator-min-microvolt = <0x001b7740>;

regulator-max-microvolt = <0x00325aa0>;
                                                };
                                                vgen4 {

regulator-min-microvolt = <0x001b7740>;

regulator-max-microvolt = <0x00325aa0>;
                                                        regulator-always-on;
                                                };
                                                vgen5 {

regulator-min-microvolt = <0x001b7740>;

regulator-max-microvolt = <0x00325aa0>;
                                                        regulator-always-on;
                                                };
                                                vgen6 {

regulator-min-microvolt = <0x001b7740>;

regulator-max-microvolt = <0x00325aa0>;
                                                        regulator-always-on;
                                                };
                                        };
                                };
                                pex8609 at 3f {
                                        compatible = "plx,pex8609";
                                        reg = <0x0000003f>;
                                };
                                si52147 at 6b {
                                        compatible = "sil,si52147";
                                        reg = <0x0000006b>;
                                };
                        };
                        i2c at 021a8000 {
                                #address-cells = <0x00000001>;
                                #size-cells = <0x00000000>;
                                compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
                                reg = <0x021a8000 0x00004000>;
                                interrupts = <0x00000000 0x00000026 0x00000004>;
                                clocks = <0x00000002 0x0000007f>;
                                status = "okay";
                                clock-frequency = <0x000186a0>;
                                pinctrl-names = "default";
                                pinctrl-0 = <0x0000001c>;
                                fxos8700 at 1e {
                                        compatible = "fsl,fxos8700";
                                        reg = <0x0000001e>;
                                };
                                sgtl5000 at 0a {
                                        compatible = "fsl,sgtl5000";
                                        reg = <0x0000000a>;
                                        clocks = <0x00000002 0x000000c9>;
                                        VDDA-supply = <0x0000001d>;
                                        VDDIO-supply = <0x00000019>;
                                        linux,phandle = <0x00000029>;
                                        phandle = <0x00000029>;
                                };
                                adv7611 at 4c {
                                        compatible = "adi,adv7611";
                                        reg = <0x0000004c>;
                                };
                                egalax_ts at 04 {
                                        compatible = "eeti,egalax_ts";
                                        reg = <0x00000004>;
                                        interrupt-parent = <0x00000018>;
                                        interrupts = <0x0000000c 0x00000002>;
                                        wakeup-gpios = <0x00000018
0x0000000c 0x00000000>;
                                };
                                adv7393 at 2a {
                                        compatible = "adi,adv7393";
                                        reg = <0x0000002a>;
                                };
                                adv7180 at 20 {
                                        compatible = "adi,adv7180";
                                        reg = <0x00000020>;
                                };
                        };
                        romcp at 021ac000 {
                                reg = <0x021ac000 0x00004000>;
                        };
                        mmdc at 021b0000 {
                                compatible = "fsl,imx6q-mmdc";
                                reg = <0x021b0000 0x00004000>;
                        };
                        mmdc at 021b4000 {
                                reg = <0x021b4000 0x00004000>;
                        };
                        weim at 021b8000 {
                                compatible = "fsl,imx6q-weim";
                                reg = <0x021b8000 0x00004000>;
                                interrupts = <0x00000000 0x0000000e 0x00000004>;
                                clocks = <0x00000002 0x000000c4>;
                        };
                        ocotp at 021bc000 {
                                compatible = "fsl,imx6q-ocotp", "syscon";
                                reg = <0x021bc000 0x00004000>;
                                linux,phandle = <0x0000000a>;
                                phandle = <0x0000000a>;
                        };
                        tzasc at 021d0000 {
                                reg = <0x021d0000 0x00004000>;
                                interrupts = <0x00000000 0x0000006c 0x00000004>;
                        };
                        tzasc at 021d4000 {
                                reg = <0x021d4000 0x00004000>;
                                interrupts = <0x00000000 0x0000006d 0x00000004>;
                        };
                        audmux at 021d8000 {
                                compatible = "fsl,imx6q-audmux",
"fsl,imx31-audmux";
                                reg = <0x021d8000 0x00004000>;
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <0x0000001e>;
                        };
                        mipi at 021dc000 {
                                reg = <0x021dc000 0x00004000>;
                        };
                        mipi at 021e0000 {
                                reg = <0x021e0000 0x00004000>;
                        };
                        vdoa at 021e4000 {
                                reg = <0x021e4000 0x00004000>;
                                interrupts = <0x00000000 0x00000012 0x00000004>;
                        };
                        serial at 021e8000 {
                                compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
                                reg = <0x021e8000 0x00004000>;
                                interrupts = <0x00000000 0x0000001b 0x00000004>;
                                clocks = <0x00000002 0x000000a0
0x00000002 0x000000a1>;
                                clock-names = "ipg", "per";
                                dmas = <0x00000006 0x0000001b
0x00000004 0x00000000 0x00000006 0x0000001c 0x00000004 0x00000000>;
                                dma-names = "rx", "tx";
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <0x0000001f>;
                        };
                        serial at 021f4000 {
                                compatible = "fsl,imx6q-uart", "fsl,imx21-uart";
                                reg = <0x021f4000 0x00004000>;
                                interrupts = <0x00000000 0x0000001e 0x00000004>;
                                clocks = <0x00000002 0x000000a0
0x00000002 0x000000a1>;
                                clock-names = "ipg", "per";
                                dmas = <0x00000006 0x00000021
0x00000004 0x00000000 0x00000006 0x00000022 0x00000004 0x00000000>;
                                dma-names = "rx", "tx";
                                status = "okay";
                                pinctrl-names = "default";
                                pinctrl-0 = <0x00000020>;
                        };
                };
                ipu at 02400000 {
                        #crtc-cells = <0x00000001>;
                        compatible = "fsl,imx6q-ipu";
                        reg = <0x02400000 0x00400000>;
                        interrupts = <0x00000000 0x00000006 0x00000004
0x00000000 0x00000005 0x00000004>;
                        clocks = <0x00000002 0x00000082 0x00000002
0x00000083 0x00000002 0x00000084>;
                        clock-names = "bus", "di0", "di1";
                        resets = <0x00000021 0x00000002>;
                        linux,phandle = <0x0000000d>;
                        phandle = <0x0000000d>;
                };
                sram at 00900000 {
                        compatible = "mmio-sram";
                        reg = <0x00900000 0x00040000>;
                        clocks = <0x00000002 0x0000008e>;
                };
                sata at 02200000 {
                        compatible = "fsl,imx6q-ahci";
                        reg = <0x02200000 0x00004000>;
                        interrupts = <0x00000000 0x00000027 0x00000004>;
                        clocks = <0x00000002 0x0000009a 0x00000002
0x000000bb 0x00000002 0x00000069>;
                        clock-names = "sata", "sata_ref", "ahb";
                        status = "okay";
                };
                ipu at 02800000 {
                        #crtc-cells = <0x00000001>;
                        compatible = "fsl,imx6q-ipu";
                        reg = <0x02800000 0x00400000>;
                        interrupts = <0x00000000 0x00000008 0x00000004
0x00000000 0x00000007 0x00000004>;
                        clocks = <0x00000002 0x00000085 0x00000002
0x00000086 0x00000002 0x00000089>;
                        clock-names = "bus", "di0", "di1";
                        resets = <0x00000021 0x00000004>;
                        linux,phandle = <0x0000000e>;
                        phandle = <0x0000000e>;
                };
        };
        cpus {
                #address-cells = <0x00000001>;
                #size-cells = <0x00000000>;
                cpu at 0 {
                        compatible = "arm,cortex-a9";
                        device_type = "cpu";
                        reg = <0x00000000>;
                        next-level-cache = <0x00000022>;
                        operating-points = <0x00124f80 0x00137478
0x000f32a0 0x001312d0 0x000c15c0 0x00118c30 0x00060ae0 0x000e7ef0>;
                        clock-latency = <0x0000ee6c>;
                        clocks = <0x00000002 0x00000068 0x00000002
0x00000006 0x00000002 0x00000010 0x00000002 0x00000011 0x00000002
0x000000aa>;
                        clock-names = "arm", "pll2_pfd2_396m", "step",
"pll1_sw", "pll1_sys";
                        arm-supply = <0x00000023>;
                        pu-supply = <0x00000024>;
                        soc-supply = <0x00000025>;
                };
                cpu at 1 {
                        compatible = "arm,cortex-a9";
                        device_type = "cpu";
                        reg = <0x00000001>;
                        next-level-cache = <0x00000022>;
                };
                cpu at 2 {
                        compatible = "arm,cortex-a9";
                        device_type = "cpu";
                        reg = <0x00000002>;
                        next-level-cache = <0x00000022>;
                };
                cpu at 3 {
                        compatible = "arm,cortex-a9";
                        device_type = "cpu";
                        reg = <0x00000003>;
                        next-level-cache = <0x00000022>;
                };
        };
        leds {
                compatible = "gpio-leds";
                user1 {
                        label = "user1";
                        gpios = <0x00000026 0x00000006 0x00000000>;
                        default-state = "on";
                        linux,default-trigger = "heartbeat";
                };
                user2 {
                        label = "user2";
                        gpios = <0x00000026 0x00000007 0x00000000>;
                        default-state = "off";
                };
                user3 {
                        label = "user3";
                        gpios = <0x00000026 0x0000000f 0x00000001>;
                        default-state = "off";
                };
        };
        pps {
                compatible = "pps-gpio";
                gpios = <0x00000005 0x0000001a 0x00000000>;
                status = "okay";
        };
        regulators {
                compatible = "simple-bus";
                1p0v {
                        compatible = "regulator-fixed";
                        regulator-name = "1P0V";
                        regulator-min-microvolt = <0x000f4240>;
                        regulator-max-microvolt = <0x000f4240>;
                        regulator-always-on;
                };
                3p3v {
                        compatible = "regulator-fixed";
                        regulator-name = "3P3V";
                        regulator-min-microvolt = <0x00325aa0>;
                        regulator-max-microvolt = <0x00325aa0>;
                        regulator-always-on;
                        linux,phandle = <0x00000019>;
                        phandle = <0x00000019>;
                };
                usb_h1_vbus {
                        compatible = "regulator-fixed";
                        regulator-name = "usb_h1_vbus";
                        regulator-min-microvolt = <0x004c4b40>;
                        regulator-max-microvolt = <0x004c4b40>;
                        regulator-always-on;
                        linux,phandle = <0x00000015>;
                        phandle = <0x00000015>;
                };
                usb_otg_vbus {
                        compatible = "regulator-fixed";
                        regulator-name = "usb_otg_vbus";
                        regulator-min-microvolt = <0x004c4b40>;
                        regulator-max-microvolt = <0x004c4b40>;
                        gpio = <0x00000027 0x00000016 0x00000000>;
                        enable-active-high;
                        linux,phandle = <0x00000012>;
                        phandle = <0x00000012>;
                };
        };
        sound {
                compatible = "fsl,imx6q-sabrelite-sgtl5000",
"fsl,imx-audio-sgtl5000";
                model = "imx6q-sabrelite-sgtl5000";
                ssi-controller = <0x00000028>;
                audio-codec = <0x00000029>;
                audio-routing = "MIC_IN", "Mic Jack", "Mic Jack", "Mic
Bias", "Headphone Jack", "HP_OUT";
                mux-int-port = <0x00000001>;
                mux-ext-port = <0x00000004>;
        };
};


Tim

>
> Jason
