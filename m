From: robh@kernel.org (Rob Herring)
Date: Mon, 13 Nov 2017 11:53:21 -0600
Subject: [PATCH v2 1/3] dt-bindings: phy: Add Cygnus usb phy binding
In-Reply-To: <CAAFb_vqKLOixSROUvkRFR=hwOqQvnVyV4mu37=MrEBo-pZaF5w@mail.gmail.com>
References: <1510127203-5815-1-git-send-email-raveendra.padasalagi@broadcom.com>
 <1510127203-5815-2-git-send-email-raveendra.padasalagi@broadcom.com>
 <20171110214439.rlt5de2c6e6k246d@rob-hp-laptop>
 <CAAFb_vqKLOixSROUvkRFR=hwOqQvnVyV4mu37=MrEBo-pZaF5w@mail.gmail.com>
Message-ID: <CAL_JsqL+KaxAHb_u31U07-e+Nm2cW=Wi-oHyTP42B--hBiEyig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 12, 2017 at 10:23 PM, Raveendra Padasalagi
<raveendra.padasalagi@broadcom.com> wrote:
> Hi,
>
> On Sat, Nov 11, 2017 at 3:14 AM, Rob Herring <robh@kernel.org> wrote:
>> On Wed, Nov 08, 2017 at 01:16:41PM +0530, Raveendra Padasalagi wrote:
>>> Add devicetree binding document for broadcom's
>>> Cygnus SoC specific usb phy controller driver.
>>>
>>> Signed-off-by: Raveendra Padasalagi <raveendra.padasalagi@broadcom.com>
>>> ---
>>>  .../bindings/phy/brcm,cygnus-usb-phy.txt           | 106 +++++++++++++++++++++
>>>  1 file changed, 106 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>> new file mode 100644
>>> index 0000000..bbc4b94
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
>>> @@ -0,0 +1,106 @@
>>> +BROADCOM CYGNUS USB PHY
>>> +
>>> +Required Properties:
>>> +- compatible:  brcm,cygnus-usb-phy
>>> +- reg : the register start address and length for
>>> +        crmu_usbphy_aon_ctrl,
>>> +        cdru usb phy control,
>>> +        usb host idm registers,
>>> +        usb device idm registers.
>>> +- reg-names: a list of the names corresponding to the previous register ranges
>>> +  Should contain
>>> +        "crmu-usbphy-aon-ctrl",
>>> +        "cdru-usbphy",
>>> +        "usb2h-idm",
>>> +        "usb2d-idm".
>>> +- address-cells: should be 1
>>> +- size-cells: should be 0
>>> +
>>> +Sub-nodes:
>>> +  Each port's PHY should be represented as a sub-node.
>>> +
>>> +Sub-nodes required properties:
>>> +- reg: the PHY number
>>> +- #phy-cells must be 1
>>> +  The node that uses the phy must provide 1 integer argument specifying
>>> +  port number.
>>> +
>>> +Optional Properties:
>>> +- vbus-p#-supply : The regulator for vbus out control for the host
>>
>> Is this a literal # or something else?
>
> Yes, this is a literal. It's assumed # will replace numeric 0-2 for
> each of the ports.

I'm still confused. Which is valid? "vbus-p#-supply" or "vbus-p0-supply"

If the latter, you need to enumerate all valid options. But these are
in sub nodes for each port, so just "vbus-supply" should be
sufficient.

One more question, does Vbus actually supply power to the phy or you
are just associating the Vbus supply to a connector with a port? The
latter needs a connector node instead and Vbus should be part of that.
There's been some attempts at USB connectors, but we don't really have
one yet (the extcon binding is not it).

> In the example it's not shown as the regulators specified in vbus-p#-supply
> are board specific.

Please show in the example. Examples should be complete.

Rob
