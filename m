From: raveendra.padasalagi@broadcom.com (Raveendra Padasalagi)
Date: Fri, 27 Oct 2017 10:47:32 +0530
Subject: [PATCH 1/3] Documentation: DT: Add Cygnus usb phy binding
In-Reply-To: <20171027033943.nct3foht4grhdinb@rob-hp-laptop>
References: <1508819822-29956-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1508819822-29956-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20171027033943.nct3foht4grhdinb@rob-hp-laptop>
Message-ID: <CAAFb_vrQtuTtcxFvrHhFROi7ta-ttEb2qkihOSYnBYb6k7gmVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, Oct 27, 2017 at 9:09 AM, Rob Herring <robh@kernel.org> wrote:
> On Tue, Oct 24, 2017 at 10:07:00AM +0530, Raveendra Padasalagi wrote:
>> Add devicetree binding document for broadcom's
>> Cygnus SoC specific usb phy controller driver.
>
> "dt-bindings: phy: ..." for the subject please.

Ok. I will update it in the next patch set version.

>>
>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>> ---
>>  .../bindings/phy/brcm,cygnus-usb-phy.txt           | 101 +++++++++++++++++++++
>>  1 file changed, 101 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>
>> diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>> new file mode 100644
>> index 0000000..2d99fea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>> @@ -0,0 +1,101 @@
>> +BROADCOM CYGNUS USB PHY
>> +
>> +Required Properties:
>> +- compatible:  brcm,cygnus-usb-phy
>> +- reg : the register start address and length for crmu_usbphy_aon_ctrl,
>> +  cdru usb phy control and reset registers, usb host idm registers,
>> +  usb device idm registers.
>
> Make this list 1 per line.
Ok
>> +- reg-names: a list of the names corresponding to the previous register
>> +  ranges. Should contain "crmu-usbphy-aon-ctrl", "cdru-usbphy",
>> +  "usb2h-idm", "usb2d-idm".
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
>
> Either you need to move #phy-cells up a level or #phy-cells should be 0.
Ok
>> +
>> +Optional Properties:
>> +- vbus-p#-supply : The regulator for vbus out control for the host
>> +  functionality enabled ports.
>> +- vbus-gpios: vbus gpio binding
>
> Are you using these or extcon?
Yes, using extcon in phy driver to receive USB Device/Host connect/disconnect
notifications.

> Don't use extcon. It needs to be redesigned and I don't want to see new
> users.

Without extcon I need to duplicate the code in phy driver to implement
extcon functionality,
which is again bad. Once the extcon redesign is done may be we can
adopt the changes in
this driver at that time.

>> +  This is mandatory for port 2, as port 2 is used as dual role phy.
>> +  Based on the vbus and id values device or host role is determined
>> +  for phy 2.
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
>> +     usbphy: phy at 0301c028 {
>
> usb-phy at 301c028
>
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
>> +     and port 1 are host and port 2 is device */
>> +
>> +     ehci0: usb at 18048000 {
>> +             compatible = "generic-ehci";
>> +             reg = <0x18048000 0x100>;
>> +             interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
>> +             phys = <&usbphy0 0 &usbphy1 1 &usbphy2 2>;
>> +             phy-names = "usbp0","usbp1","usbp2";
>> +             status = "okay";
>> +     };
>> +
>> +     /* This node declares port 2 phy
>> +     and configures it for device */
>> +
>> +     usbd_udc_dwc1: usbd_udc_dwc at 1804c000 {
>
> usb at ...
Ok.
>> +             compatible = "iproc-udc";
>> +             reg = <0x1804c000 0x2000>;
>> +             interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>;
>> +             phys = <&usbphy2 2>;
>> +             phy-names = "usbdrd";
>> +     };
>> --
>> 1.9.1
>>
