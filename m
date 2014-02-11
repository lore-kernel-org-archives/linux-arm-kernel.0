From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 11 Feb 2014 16:26:16 +0100
Subject: [PATCH 2/2] ehci-platform: Change compatible string from usb-ehci
 to ehci-platform
In-Reply-To: <52FA3B2B.7050906@ti.com>
References: <1392127826-31290-1-git-send-email-hdegoede@redhat.com>
 <1392127826-31290-3-git-send-email-hdegoede@redhat.com>
 <52FA3B2B.7050906@ti.com>
Message-ID: <52FA4118.2030100@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/11/2014 04:00 PM, Roger Quadros wrote:
> Hi Hans,
> 
> On 02/11/2014 04:10 PM, Hans de Goede wrote:
>> The initial versions of the devicetree enablement patches for ehci-platform
>> used "ehci-platform" as compatible string. However this was disliked by various
>> reviewers because the platform bus is a Linux invention and devicetree is
>> supposed to be OS agnostic. After much discussion I gave up, added a:
>> "depends on !PPC_OF" to Kconfig to avoid a known conflict with PPC-OF platforms
>> and went with the generic usb-ehci as requested.
>>
>> In retro-spect I should have stuck to my guns, because the dts files for many
>> existing boards already claim to be compatible with "usb-ehci", ie they have:
>>
>> 	compatible = "ti,ehci-omap", "usb-ehci";
>>
>> In theory this should not be a problem since the "ti,ehci-omap" entry takes
>> presedence, but in practice using a conflicting compatible string is an issue,
>> because it makes which driver gets used depent on driver registration order.
>>
>> This patch changes the compatible string claimed by ehci-platform (back) to
>> "ehci-platform", avoiding the driver registration / module loading ordering
>> problems, and removes the "depends on !PPC_OF" workaround.
>>
>> Note that there already is a precedent for using ?hci-platform, in the form
>> of xhci-platform.c using "xhci-platfrom" as compatible string.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  Documentation/devicetree/bindings/usb/usb-ehci.txt | 4 ++--
>>  drivers/usb/host/Kconfig                           | 1 -
>>  drivers/usb/host/ehci-platform.c                   | 2 +-
>>  3 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/usb-ehci.txt b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> index 2c1aeeb..46f428a 100644
>> --- a/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> +++ b/Documentation/devicetree/bindings/usb/usb-ehci.txt
>> @@ -1,7 +1,7 @@
>>  USB EHCI controllers
>>  
>>  Required properties:
>> -  - compatible : should be "usb-ehci".
>> +  - compatible : should be "ehci-platform".
> 
> Won't this break DT binding info for power PC?

The powerpc bindings have never been really properly documented, ie
they rely on both usb-ehci and ibm,usb-ehci-440epx strings being there,
which was never documented. Given the issues surrounding using usb-ehci
as a compatible string I think completely removing it from the bindings
docs is best.

> I'm even OK with removing "usb-ehci" and "usb-ohci" compatibles from all OMAP dts files
> since they aren't really compatible with the original PPC driver.

I don't think that is necessary, as your grep has shown there are a lot
of dts files using compatible = "foo", "usb-?hci"; and some may even have
the dts in firmware, so we should simply make sure not to break such dts.

Regards,

Hans
