From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 11 Jan 2014 01:02:21 +0300
Subject: [linux-sunxi] Re: [PATCH v3 1/2] ohci-platform: Add support for
 devicetree instantiation
In-Reply-To: <52CFC1A8.4010505@redhat.com>
References: <1389290226-6971-1-git-send-email-hdegoede@redhat.com>
 <1389290226-6971-2-git-send-email-hdegoede@redhat.com>
 <52CF0326.1090407@cogentembedded.com> <52CEFCFE.7080308@redhat.com>
 <52CF0FB1.1010109@cogentembedded.com> <52CFC1A8.4010505@redhat.com>
Message-ID: <52D06DED.1040409@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01/10/2014 12:47 PM, Hans de Goede wrote:

> Hi,

    I would like to know why you dropped me from the To: list when replying. I 
have hardly noticed your reply.

>>>>> Add support for ohci-platform instantiation from devicetree, including
>>>>> optionally getting clks and a phy from devicetree, and enabling / disabling
>>>>> those on power_on / off.

>>>>> This should allow using ohci-platform from devicetree in various cases.
>>>>> Specifically after this commit it can be used for the ohci controller found
>>>>> on Allwinner sunxi SoCs.

>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>>   .../devicetree/bindings/usb/mmio-ohci.txt          |  22 +++
>>>>>   drivers/usb/host/ohci-platform.c                   | 150
>>>>> ++++++++++++++++++---
>>>>>   2 files changed, 152 insertions(+), 20 deletions(-)
>>>>>   create mode 100644 Documentation/devicetree/bindings/usb/mmio-ohci.txt
>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/mmio-ohci.txt
>>>>> b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
>>>>> new file mode 100644
>>>>> index 0000000..9c776ed
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/usb/mmio-ohci.txt
>>>>> @@ -0,0 +1,22 @@
>>>>> +Generic MMIO OHCI controller

>>>>     OHCI controller always uses MMIO, and likewise EHCI. You don't need to
>>>> specifically mention it.

>>> Right, I'm only using it here because it is also used in the compatible
>>> string.

>>     Please drop it.

>>>>> +
>>>>> +Required properties:
>>>>> +- compatible : "mmio-ohci"

>>>>     Likewise, it's not a good name. Why not call it "platform-ohci"?

>>> Because, as you would have known had you read the entire thread, people
>>> objected
>>> against exactly that name because the "platform" bus thing is a Linux
>>> invention,
>>> and other operating systems don't use the platform nomenclature for non pci
>>> busses.

>>     I wonder where were all those people when "xhci-platform" compatible got
>> adopted in drivers/usb/host/xhci-plat.c? :-P

    I remember I suggested "usb-xhci" but the author didn't want to do it and 
I said that I have no strong opinion (along with Alan Stern, IIRC), so we have 
it now...

>>     Anyway, I want to suggest "usb-[eo]hci" of which "usb-ehci" binding has
>> even already documented in Documentation/devicetree/bindings/usb/usb-ehci.txt.
>> Both these "compatible" values are used as backups in the multiple described
>> bindings of the platform-specific [EO]HCI controllers. I really don't see
>> why you should invent anything new (and so poorly named).

> This too has already been discussed, again please read the entire thread
> including review of earlier versions of the patch.

    Sorry, I have been generally lacking the time to read linux-usb recently.
I only bumped into your patch randomly, despite me being interested in this 
matter for my own platform...

> We cannot usb usb-ehci, because the existing usb-ehci compatible string is not
> used for a generic usb controller, but
> for a ppc specific one  which needs model specific setup, see the driver
> currently implementing compatible = usb-ehci.

    Not true about it being entirely PPC specific: the driver actually looks 
for another "compatible" property to make it truly PPC specific (and apply 
some errata fixes for that specific PPC platform) and "usb-ehci" is used in 
many non-PPC binding examples as a backup still. Valentine Barshak's did his 
work on ehci-ppc-of.c when DT was used only on PPC and SPARC, so it was kind 
of a honest mistake on his part to name the driver so that people would think 
it's PPC specific (not only his, it seems, as the driver was based on the 
other two). This does not seem a fatal mistake, and we could limit the driver 
to match only on that IBM 440EPx platform it was designed for and tested on, 
making ehci-platform.c handle "usb-ehci". This is more work but I believe it's 
the Right Thing. The problem is that we'll have to do this atomically with 
ehci-platform.c change since 2 other PPC platforms use "usb-ehci" as a backup 
to their specific "compatible" props and don't have the platform-specific 
drivers for them, and we probably wouldn't want to break them.
I would like to help you here but the matter is not urgent for me, so cannot 
work on it right now... :-(
    Anyway, I'm strongly against such names as "mmio-[eo]hci". But I could 
live with just "[eo]hci" if you don't follow my advice and unravel the 
ehci-ppc-of.c knot...

> Regards,

> Hans

WBR, Sergei
