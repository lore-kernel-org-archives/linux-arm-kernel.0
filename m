From: P.Bruenn@beckhoff.com (=?iso-8859-1?Q?Patrick_Br=FCnn?=)
Date: Wed, 12 Jul 2017 11:46:02 +0000
Subject: [PATCH] ARM: dts: imx: add CX9020 Embedded PC device tree
In-Reply-To: <20170712094655.GC7472@leverpostej>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
 <20170712094655.GC7472@leverpostej>
Message-ID: <3BB206AB2B1BD448954845CE6FF69A8E0182B4BFC3@nt-mail04>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark,
Thanks, for the fast feedback.

>From: Mark Rutland [mailto:mark.rutland at arm.com]
>Sent: Mittwoch, 12. Juli 2017 11:47
>> +/ {
>> +    model = "Freescale i.MX53 based Beckhoff CX9020";
>> +    compatible = "fsl,imx53-qsb", "fsl,imx53";
>> +
>> +    chosen {
>> +            stdout-path = &uart2;
>
>No baud-rate or bits configuration?

The default config from imx53.dtsi works fine for us.

>> +    ccat {
>> +            compatible = "bhf,emi-ccat";
>> +    };
>> +
>> +    display0: display at di0 {
>
>This unit-address (the bit after the @) isn't valid, as that should
>match a reg or ranges, but this node has neither.
>
>Just call this display-0.
>
Okay, I will fix this

>> +            #address-cells =<1>;
>> +            #size-cells = <0>;
>> +            compatible = "fsl,imx-parallel-display";
>> +            interface-pix-fmt = "rgb24";
>> +            pinctrl-names = "default";
>> +            pinctrl-0 = <&pinctrl_ipu_disp0>;
>> +            status = "okay";
>> +
>> +            port at 0 {
>> +                    reg = <0>;
>> +                    display0_in: endpoint {
>> +                            remote-endpoint = <&ipu_di0_disp0>;
>> +                    };
>> +            };
>> +
>> +            port at 1 {
>> +                    reg = <1>;
>> +                    display0_out: endpoint {
>> +                            remote-endpoint = <&panel_in>;
>> +                    };
>> +            };
>> +    };
>> +
>> +    dvi_panel: display at 0 {
>
>Likewise you have no reg here, so the unit address isn't valid.
>
>Surely panel-0?
>
Okay, I will have a closer look, too.

>> +            #address-cells =<1>;
>> +            #size-cells = <0>;
>> +            compatible = "simple,ddc-only";
>
>I don't see that compatible string in my Linux tree, and it doesn't make
>sense to me -- "simple" isn't a vendor-prefix.
>
>Where has this come from?
>
Out-of-tree, sorry. Our device has a DVI connector bound to the imx
parallel interface. So my idea was to reuse the panel-simple driver and
add a very simple panel with only ddc options.
Unfortunately, I was too shy to post that upstream[1].
Is there a more elegant solution? Or should I remove all display related
nodes from imx53-cx9020.dts?

>> +            ddc-i2c-bus = <&i2c2>;
>> +
>> +            port {
>> +                    panel_in: endpoint {
>> +                            remote-endpoint = <&display0_out>;
>> +                    };
>> +            };
>> +    };
>
>[...]
>
>> +    regulators {
>> +            compatible = "simple-bus";
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            reg_3p2v: regulator at 0 {
>> +                    compatible = "regulator-fixed";
>> +                    reg = <0>;
>
>Meaningless reg entry.
>
Okay, I will remove this.
>> +                    regulator-name = "3P2V";
>> +                    regulator-min-microvolt = <3200000>;
>> +                    regulator-max-microvolt = <3200000>;
>> +                    regulator-always-on;
>> +            };
>> +
>> +            reg_usb_vbus: regulator at 1 {
>> +                    compatible = "regulator-fixed";
>> +                    reg = <1>;
>
>Likewise.
>
this, too.
>> +                    regulator-name = "usb_vbus";
>> +                    regulator-min-microvolt = <5000000>;
>> +                    regulator-max-microvolt = <5000000>;
>> +                    gpio = <&gpio7 8 0>;
>> +                    enable-active-high;
>> +            };
>> +    };
>
>There's no need for a simple-bus here. It doesn't represent HW, and you
>can nothing. You can put these directly under the root node, without a
>synthetic reg or unnecessary container:
>
>       reg_3p2v: regulator-3p2v {
>               compatible = "regulator-fixed";
>               regulator-name = "3P2V";
>               regulator-min-microvolt = <3200000>;
>               regulator-max-microvolt = <3200000>;
>               regulator-always-on;
>       };
>
>       reg_usb_vbus: regulator-usb-vbus {
>               compatible = "regulator-fixed";
>               regulator-name = "usb_vbus";
>               regulator-min-microvolt = <5000000>;
>               regulator-max-microvolt = <5000000>;
>               gpio = <&gpio7 8 0>;
>               enable-active-high;
>       }
>
Thanks, I will send a v2 with your simplified version. As soon as I get the display/
panel thing right.

>Otherwise, looks fine to me.
>
>Thanks,
>Mark.

[1] https://github.com/Beckhoff/CX9020/blob/master/kernel-patches/0003-drm-panel-simple-Add-support-for-ddc-only-panel.patch
Beckhoff Automation GmbH & Co. KG | Managing Director: Dipl. Phys. Hans Beckhoff
Registered office: Verl, Germany | Register court: Guetersloh HRA 7075
