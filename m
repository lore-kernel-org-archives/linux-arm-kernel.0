From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Aug 2016 20:26:00 +0200
Subject: [PATCH v3 6/7] phy-sun4i-usb: Add
 "allwinner,usb0-usb-a-connector" dt property
In-Reply-To: <20160823180016.GA28538@rob-hp-laptop>
References: <1471781799-10457-1-git-send-email-hdegoede@redhat.com>
 <1471781799-10457-6-git-send-email-hdegoede@redhat.com>
 <20160823180016.GA28538@rob-hp-laptop>
Message-ID: <4792e77e-e72e-10db-5469-4a1e6e64e75c@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/23/2016 08:00 PM, Rob Herring wrote:
> On Sun, Aug 21, 2016 at 02:16:38PM +0200, Hans de Goede wrote:
>> On some devices the musb otg controller can be used in both device and
>> host mode, but requires software mode switching since there is no id pin
>> connected. The usb0 phy code will default to device mode in this case.
>>
>> On some systems usb0 is connected to a female USB-A port. It can still
>> be used in device mode when using software mode switching and a USB
>> A to A cable. To configure the controller to support both modes we must
>> set its "dr_mode" dt property to "otg" (*). For these setups the device
>> mode default is wrong, for a female USB-A port the default should be
>> host mode.
>>
>> This commit adds support to the sun4i phy code for a new
>> "allwinner,usb0-usb-a-connector" dt property which can be used in dt
>> files to indicate this scenario and when present it changes the default
>> mode to host mode.
>>
>> *) dr_mode = "host" is used when device mode is _never_ used. E.g.
>> a wifi module soldered onto the PCB is connected to the musb controller.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -New patch in v2 of this patchset
>> Changes in v3:
>> -No changes
>> ---
>>  Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt | 2 ++
>>  drivers/phy/phy-sun4i-usb.c                             | 9 ++++++++-
>>  2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>> index 287150d..8646b53 100644
>> --- a/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>> +++ b/Documentation/devicetree/bindings/phy/sun4i-usb-phy.txt
>> @@ -35,6 +35,8 @@ Optional properties:
>>  - usb0_vbus-supply : regulator phandle for controller usb0 vbus
>>  - usb1_vbus-supply : regulator phandle for controller usb1 vbus
>>  - usb2_vbus-supply : regulator phandle for controller usb2 vbus
>> +- allwinner,usb0-usb-a-connector: usb0 is connected to an USB-A connector,
>> +                     rather then an USB-B connector as one would expect (bool)
>
> This seems like a pretty generic problem: a board has an A connector
> wired to an OTG controller.  So I think we should have a generic
> property.

OK, any suggestions for a name ? And which bindings .txt file should
this go in ?

> The only part is here that is not is you have 3 USB buses for
> the PHY. That probably should have been 3 child nodes for each PHY port.

Only one is an otg phy / bus though, so we can just use the generic
property and apply it to bus0 / the otg-bus if present.

Regards,

Hans
