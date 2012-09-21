From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 20 Sep 2012 22:40:57 -0600
Subject: bcm2835: device tree for mbox-driven devices in upstream
Message-ID: <505BEFD9.1020809@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As background for those not familiar with the BCM2835 SoC, many aspects
of the HW are controlled by firmware running on the VideoCore processor
that exists alongside the ARM CPU, and communication to that core is via
a "mailbox" interface, with SW-defined/implemented messages. The mailbox
interface defines so-called channels, and on each channel a certain
format of messages and protocol is expected.

The existing downstream rpi-split branch uses the following structure
for regulators implemented using the firmware mailbox interface:

vc_mbox: mbox {
    compatible = "broadcom,bcm2835-mbox";
    reg = <0xB880 0x40>;
    interrupts = <0 1>;
    #channel-cells = <1>;
};

power {
    compatible = "broadcom,bcm2835-power-mgr", "simple-bus";
    #address-cells = <1>;
    #size-cells = <0>;

    /* This is assuming the old dedicated channel 0 for power */
    broadcom,vc-mailbox = <&vc_mbox 0>;

    reg_sd: regulator at 0 {
        compatible = "broadcom,bcm2835-power-dev";
        reg = <0>;
    };

    reg_usbhcd: regulator at 3 {
        compatible = "broadcom,bcm2835-power-dev";
        reg = <3>;
    };
};

display {
    compatible = "broadcom,bcm2835-fb";
    /* This is assuming the old dedicated channel 1 for fb */
    broadcom,vc-mailbox = <&vc_mbox 1>;
};

Thinking about this a bit, I see:

a) A parallel between the mailbox node/device and the virtual buses used
by hypervisors for para-virtualized devices.

b) The devices that implement communication across the mailbox API are
logically children of the mailbox device, being addressed/controlled via
the bus.

As such, I think it'd make more sense to rework the device tree along
the following lines while upstreaming the code:

vc_mbox: mbox {
    compatible = "broadcom,bcm2835-mbox";
    reg = <0xB880 0x40>;
    interrupts = <0 1>;

    channels {
        #address-cells = <1>;
        #size-cells = <0>;

        channel at 2 {
            /* This is the mbox channel ID */
            reg = <2>;

            uart {
                /* MBOX-based virtual UART */
                compatible = "broadcom,bcm2835-mbox-vuart";
            };
        };

        channel at 8 {
            /*
             * This is the mbox channel ID. Here we assume the new
             * property mailbox channel for most devices; see my
             * previous email.
             */
            reg = <8>;

            /*
             * Multiple independant ojects may communicate over the same
             * channel, for the protocol on some channels at least.
             */
            reg_sd: sd {
                compatible = "broadcom,bcm2835-mbox-power";
            };

            reg_usbhcd: usbhcd {
                compatible = "broadcom,bcm2835-mbox-power";
            };

            display {
                compatible = "broadcom,bcm2835-mbox-fb";
            };
        };
    };
};

Does anyone have any comments/suggestions on this?
