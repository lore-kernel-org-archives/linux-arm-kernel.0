From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 11 Dec 2015 19:28:07 +0100
Subject: [PATCH v2 2/3] ehci-platform: Add support for controllers with
 multiple reset lines
In-Reply-To: <1449853984.3419.52.camel@pengutronix.de>
References: <1449848520-27379-1-git-send-email-hdegoede@redhat.com>
 <1449848520-27379-2-git-send-email-hdegoede@redhat.com>
 <1449853984.3419.52.camel@pengutronix.de>
Message-ID: <566B15B7.40703@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11-12-15 18:13, Philipp Zabel wrote:
> Am Freitag, den 11.12.2015, 16:41 +0100 schrieb Hans de Goede:
>> From: Reinder de Haan <patchesrdh@mveas.com>
>>
>> At least the EHCI/OHCI found on the Allwinnner H3 SoC needs multiple
>> reset lines, the controller will not initialize while the reset for
>> its companion is still asserted, which means we need to de-assert
>> 2 resets for the controller to work.
>>
>> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Use the new reset_control_[de]assert_shared reset-controller functions
>> ---
>>   Documentation/devicetree/bindings/usb/usb-ehci.txt |  2 +-
>>   drivers/usb/host/ehci-platform.c                   | 47 +++++++++++++---------
>>   2 files changed, 30 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index a12d601..0701812 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -18,7 +18,7 @@ Optional properties:
>>    - clocks : a list of phandle + clock specifier pairs
>>    - phys : phandle + phy specifier pair
>>    - phy-names : "usb"
>> - - resets : phandle + reset specifier pair
>> + - resets : a list of phandle + reset specifier pairs
>
> Are there documented names for these resets?

This binding is a generic ehci controller binding, so even if
the names are documented for the allwinner SoC we should
not use names, just like the binding is deliberately not
using names for the clocks either to keep it generic, so
that we can reuse the binding + driver with many different SoCs.

> Is the companion you
> mention the Port Control?

Sort of, with USB-2, USB-1 compatibility is handled via a mux on the
datalines (controlled by the EHCI controller Port Control) which muxes
the lines to an USB-1 controller (typically either UHCI or OHCI) when the
device does not connect after USB-2 highspeed handshaking.

This USB-1 controller (or controller_S_ in some case since the
USB-1 companions may have less root-ports per controller then the EHCI
has root-ports) is called the companion controller.

The 2 controllers are supposed to be 100% independent but on the H3
Allwinner has done something (not documented) which requires one to
deassert reset on both before you can talk to either one.

Regards,

Hans
