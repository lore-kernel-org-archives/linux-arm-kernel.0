From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 8 Feb 2015 04:17:17 +0100 (CET)
Subject: Overlapping regions in DT
Message-ID: <488798996.225141.1423365437092.JavaMail.open-xchange@oxbaltgw06.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

currently i work on two DT capable drivers for a ARM9 processor. The former
driver mxs_power.c should trigger the population of the underlying power
management functions and the ladder take care of the on-chip regulators. In the
future more drivers
should be added as child nodes of the power driver. 

My problem is that some of the processor registers are not separated per
function. So
the drivers need access (mostly read) on the same registers.

Here are my questions:

How should define i the register space in the device?
Define the regions in the parent node and use offsets in the childs?
Which functions are recommend for such access?

I want to make use of of_platform_populate / of_platform_depopulate.
Is there anything i should take care of?

The relevant parts of the devicetree is at the end of the mail.

Best regards
Stefan

       power: power at 80044000 {
                compatible = "fsl,imx28-power"; /* handled by mxs_power.c */
                #address-cells = <1>;
                #size-cells = <1>;
                reg = <0x80044000 0x2000>;
                interrupts = <6>;
                ranges;

                reg_vddd: regulator at 80044040 {
                        reg = <0x80044040 0x10>,
                              <0x80044010 0x10>,
                              <0x800440c0 0x10>;
                        reg-names = "base-address",
                                    "v5ctrl-address",
                                    "status-address";
                        compatible = "fsl,imx28-vddd"; /* handled by
mxs-regulator.c */
                        regulator-name = "vddd";
                        regulator-min-microvolt = <1350000>;
                        regulator-max-microvolt = <1550000>;
                        vddd-supply = <&reg_vdda>;
                };

                reg_vdda: regulator at 80044050 {
                        reg = <0x80044050 0x10>,
                              <0x80044010 0x10>,
                              <0x800440c0 0x10>;
                        reg-names = "base-address",
                                    "v5ctrl-address",
                                    "status-address";
                        compatible = "fsl,imx28-vdda"; /* handled by
mxs-regulator.c */
                        regulator-name = "vdda";
                        regulator-min-microvolt = <1725000>;
                        regulator-max-microvolt = <1950000>;
                        vdda-supply = <&reg_vddio>;
                };

                reg_vddio: regulator at 80044060 {
                        reg = <0x80044060 0x10>,
                              <0x80044010 0x10>,
                              <0x800440c0 0x10>;
                        reg-names = "base-address",
                                    "v5ctrl-address",
                                    "status-address";
                        compatible = "fsl,imx28-vddio"; /* handled by
mxs-regulator.c */
                        regulator-name = "vddio";
                        regulator-min-microvolt = <3000000>;
                        regulator-max-microvolt = <3575000>;
                        regulator-microvolt-offset = <80000>;
                };
        };
