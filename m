From: jhautbois@gmail.com (Jean-Michel Hautbois)
Date: Fri, 2 Nov 2018 14:35:26 +0100
Subject: sama5d: using the ebi interface from another driver
Message-ID: <CAL8zT=imudTXvbsxx42mPSQj7Qt1b=44wnPHpb09-sOqLewu-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I have a custom board based on a sama5d3 chip. The SoC is connected to
2 pef24628 SHDSL transceivers, the first one on ebi at 40000000 and the
second one on ebi at 50000000.
I tried to write a basic char driver, using request_mem_region and
ioremap but I can't read or write into the device.
I have to say that the driver is based on a proprietary one, and
tested years ago on a PowerPC board.

Then, after looking into deeper details in the datasheet I understand
it is connected through EBI and it sounds not so easy :D.

I would appreciate some help/pointers on this, as there is (at least,
I could find) few documentation on how to use it except for NAND
cases.

I have something like that in my DTS, but not sure this is the correct
way to do it :

        ebi: ebi at 10000000 {
            pinctrl-0 = <&pinctrl_ebi_nand_addr>;
            pinctrl-names = "default";
            status = "okay";

            dsp0: pef24628 at 1 {
                status = "okay";
                compatible = "intel,pef24628";
                #address-cells = <1>;
                #size-cells = <1>;
                reg = <0x1 0x0 0x8000>;
                pinctrl-0 = <&pinctrl_dsp_cs1>;
            };

            dsp1: pef24628 at 2 {
                status = "okay";
                compatible = "intel,pef24628";
                #address-cells = <1>;
                #size-cells = <1>;
                reg = <0x2 0x0 0x8000>;
                pinctrl-0 = <&pinctrl_dsp_cs2>;
            };

            nand_controller: nand-controller {
                status = "okay";

                nand at 3 {
                    reg = <0x3 0x0 0x2>;
                    atmel,rb = <0>;
                    nand-bus-width = <8>;
                    nand-ecc-mode = "hw";
                    nand-ecc-strength = <4>;
                    nand-ecc-step-size = <512>;
                    nand-on-flash-bbt;
                    label = "atmel_nand";

                    partitions {
                        compatible = "fixed-partitions";
                        #address-cells = <1>;
                        #size-cells = <1>;
[...]
                    };
                };
            };

The pinctrl for ebi should probably be changed however, I am wondering
how the (platform ?) driver can access the adress ? Should it parse
itself the parent, and find range, etc. Or is there an accessor for it
?

Maybe can I just manually toggle the CS GPIO, and don't try to make
anything more complex than what it should be ? The driver should not
be atmel dependant...

Thanks !
JM
