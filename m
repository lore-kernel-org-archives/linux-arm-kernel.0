From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Mon, 13 Nov 2017 09:53:45 +0530
Subject: [PATCH v2 1/3] dt-bindings: phy: Add Cygnus usb phy binding
In-Reply-To: <20171110214439.rlt5de2c6e6k246d@rob-hp-laptop>
References: <1510127203-5815-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1510127203-5815-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20171110214439.rlt5de2c6e6k246d@rob-hp-laptop>
Message-ID: <CAAFb_vqKLOixSROUvkRFR=hwOqQvnVyV4mu37=MrEBo-pZaF5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Nov 11, 2017 at 3:14 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Nov 08, 2017 at 01:16:41PM +0530, Raveendra Padasalagi wrote:
>> Add devicetree binding document for broadcom's
>> Cygnus SoC specific usb phy controller driver.
>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> ---
>>  .../bindings/phy/brcm,cygnus-usb-phy.txt           | 106 +++++++++++++++++++++
>>  1 file changed, 106 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>> new file mode 100644
>> index 0000000..bbc4b94
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>> @@ -0,0 +1,106 @@
>> +BROADCOM CYGNUS USB PHY
>> +
>> +Required Properties:
>> +- compatible:  brcm,cygnus-usb-phy
>> +- reg : the register start address and length for
>> +        crmu_usbphy_aon_ctrl,
>> +        cdru usb phy control,
>> +        usb host idm registers,
>> +        usb device idm registers.
>> +- reg-names: a list of the names corresponding to the previous register ranges
>> +  Should contain
>> +        "crmu-usbphy-aon-ctrl",
>> +        "cdru-usbphy",
>> +        "usb2h-idm",
>> +        "usb2d-idm".
>> +- address-cells: should be 1
>> +- size-cells: should be 0
>> +
>> +Sub-nodes:
>> +  Each port's PHY should be represented as a sub-node.
>> +
>> +Sub-nodes required properties:
>> +- reg: the PHY number
>> +- #phy-cells must be 1
>> +  The node that uses the phy must provide 1 integer argument specifying
>> +  port number.
>> +
>> +Optional Properties:
>> +- vbus-p#-supply : The regulator for vbus out control for the host
>
> Is this a literal # or something else?

Yes, this is a literal. It's assumed # will replace numeric 0-2 for
each of the ports.
In the example it's not shown as the regulators specified in vbus-p#-supply
are board specific.

>> +  functionality enabled ports.
>> +- vbus-gpios: vbus gpio binding
>> +  This is mandatory for port 2, as port 2 is used as dual role phy.
>> +  Based on the vbus and id values device or host role is determined
>> +  for phy 2.
>
> These optional properties don't match with the example.
vbus-gpios is placed by mistake here in the documentation,
this is no more required. I will remove it in the next version of the patch.

>> +
>> +- extcon: extcon phandle
>> +  This is mandatory for port 2,  as port 2 is used as dual role phy.
>> +  extcon should be phandle to external usb gpio module which provide
>> +  device or host role notifications based on the ID and VBUS gpio's state.
>> +
>> +
>> +Refer to phy/phy-bindings.txt for the generic PHY binding properties
>> +
>> +NOTE: port 0 and port 1 are host only and port 2 is dual role port.
>> +
>> +Example of phy :
>> +     usbphy: usb-phy at 0301c028 {
>> +             compatible = "brcm,cygnus-usb-phy";
>> +             reg = <0x0301c028 0x4>,
>> +                   <0x0301d1b4 0x5c>,
>> +                   <0x18115000 0xa00>,
>> +                   <0x18111000 0xa00>;
>> +             reg-names = "crmu-usbphy-aon-ctrl", "cdru-usbphy",
>> +                         "usb2h-idm", "usb2d-idm";
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             usbphy0: usb-phy at 0 {
>> +                     reg = <0>;
>> +                     #phy-cells = <1>;
>> +             };
>> +
>> +             usbphy1: usb-phy at 1 {
>> +                     reg = <1>;
>> +                     #phy-cells = <1>;
>> +             };
>> +
>> +             usbphy2: usb-phy at 2 {
>> +                     reg = <2>;
>> +                     #phy-cells = <1>;
>> +                     extcon = <&extcon_usb>;
>> +             };
>> +     };
>> +
>> +     extcon_usb: extcon_usb {
>> +             compatible = "linux,extcon-usb-gpio";
>> +             vbus-gpio = <&gpio_asiu 121 0>;
>> +             id-gpio = <&gpio_asiu 122 0>;
>> +             status = "okay";
>> +     };
>> +
>> +
>> +Example of node using the phy:
>> +
>> +     /* This nodes declares all three ports, port 0
>> +     and port 1 are host and port 2 is device or host */
>> +
>> +     ehci0: usb at 18048000 {
>> +             compatible = "generic-ehci";
>> +             reg = <0x18048000 0x100>;
>> +             interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +             phys = <&usbphy0 0 &usbphy1 1 &usbphy2 2>;
>> +             phy-names = "usbp0","usbp1","usbp2";
>> +             status = "okay";
>
> Don't show status in examples.

Ok, Thanks. I will update it in the next version of the patch.

>> +     };
>> +
>> +     /* This node declares port 2 phy
>> +     and configures it for device */
>> +
>> +     usbd_udc_dwc1: usb at 1804c000 {
>> +             compatible = "iproc-udc";
>> +             reg = <0x1804c000 0x2000>;
>> +             interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>> +             phys = <&usbphy2 2>;
>> +             phy-names = "usbdrd";
>> +     };
>> --
>> 1.9.1
>>
